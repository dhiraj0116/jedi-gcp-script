#!/bin/bash

    # Check if directory parameter is provided
    if [ $# -ne 1 ]; then
        echo "Usage: $0 <directory_path>"
        exit 1
    fi

    ROOT_DIR="$1"
    OUTPUT_FILE="module_mappings.json"

    # Check if directory exists
    if [ ! -d "$ROOT_DIR" ]; then
        echo "Error: Directory $ROOT_DIR does not exist"
        exit 1
    fi

    # Start with empty array to collect all entries
    declare -a entries

    # Find all pom.xml files
    while IFS= read -r pom_file; do
        # Extract the artifactId, trimming whitespace
        artifactId=$(awk '/<artifactId>/ && !p {print; next} /<parent>/ {p=1} /<\/parent>/ {p=0}' "$pom_file" |
                     head -1 | sed 's/<artifactId>\(.*\)<\/artifactId>/\1/' | xargs)

        # Skip if artifactId is empty
        if [ -z "$artifactId" ]; then
            continue
        fi

        # Get directory relative to root directory
        dir_path=$(dirname "$pom_file")
        relative_path="${dir_path#$ROOT_DIR/}"

        # Generate alias from the BUILD_TYPE (artifactId) instead of LOCAL_DIR
        # Remove prefixes like ymail_xmas_, jedi_, etc. and replace underscores with dashes
        module_name=$(echo "$artifactId" | sed -E 's/(ymail_xmas_|jedi_|yjava_ymail_)//g' | sed 's/_/-/g')

        # Create entry in the new format
        entry="  {
        \"aliases\": [\"$artifactId\"],
        \"BUILD_TYPE\": \"$artifactId\",
        \"LOCAL_DIR\": \"$relative_path\"
      }"

        entries+=("$entry")

    done < <(find "$ROOT_DIR" -name "pom.xml")

    # Write to output file with proper JSON formatting
    {
        echo "["
        for i in "${!entries[@]}"; do
            echo "${entries[$i]}"
            # Add comma after all but the last entry
            if [ $i -lt $((${#entries[@]} - 1)) ]; then
                echo ","
            fi
        done
        echo "]"
    } > "$OUTPUT_FILE"

    echo "Module mappings have been written to $OUTPUT_FILE"