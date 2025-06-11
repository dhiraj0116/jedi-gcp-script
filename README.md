# Jedi GCP Scripts

This repository contains a collection of Bash scripts for managing Kubernetes pods and services in a GCP environment. These scripts streamline tasks such as building, deploying, debugging, and testing applications.

> **Note:** This project is developed and maintained during personal time, outside of regular work hours. There is no official support or ticketing system. Contributions are welcome—feel free to submit your pull requests!

## How to Start

To get started with the scripts, follow these steps:

1. Update the `PATH_TO_JEDI` environment variable in the profile file:
   ```bash
   export PATH_TO_JEDI=/path/to/your/jedi
   ```
   This can be done in the file located at:
   `/path/to/your/jedi-gcp-scripts/common/profiles/profile`.

2. Set the active profile using the `set_profile` script:
   ```bash
   set_profile <PROFILE_NAME>
   ```
   Replace `<PROFILE_NAME>` with the desired profile name (e.g., `jws-west1`).

3. Ensure the scripts are accessible:
   - Add the script directory to your `PATH`:
     ```bash
     export PATH=$PATH:/path/to/your/jedi-gcp-scripts
     ```
   - Alternatively, navigate to the script directory before invoking them:
     ```bash
     cd /path/to/your/jedi-gcp-scripts
     ```

---

## Global Options

The following global options are available across most scripts:

- `-h, --help`         Display the help message for the script.
- `--profile=<name>`   Specify the profile to use (default: from config or `default`).
- `--user-name=NAME`   Set the username to `NAME`.
- `--x`                Enable shell debugging (`set -x`).

## Pod Types

The scripts support the following pod types:

- `jws`    Web Service
- `qa`     QA Client
- `sync`   Sync Service
- `custom` Custom pod type (artifactId in `pom.xml` must match the directory name).

## Scripts Overview

### 1. `build`
Builds the application modules.
  
- **Usage**: `build [options] [build_type]`
- **Options**:
  - `-h, --help`             Display this help message.
  - `-et, --exclude-tests`   Skip tests during build.
  - `-sc, --skip-checkstyle` Skip checkstyle during build.
  - `-nr, --no-rpm`          Skip RPM assembly during build.
  - `-r=module, --resume-from=module` Resume build from specified module.
- **Examples**:
  - `build jws`              Build only the web service module.
  - `build full -et`         Build everything without tests.
  - `build -r=sync`          Resume build from the sync module.
  - `build full -sc`         Build everything skipping checkstyle.
  - `build full -nr`         Build everything skipping rpm assembly.

---

### 2. `change_context`
Changes the Kubernetes context to the configured cluster.

- **Usage**: `change_context [OPTIONS]`
- **Options**:
  - `--force`                Force context refresh, cleaning old context files.
  - `--help`                 Display help message.
- **Examples**:
  - `change_context`         Connect using the current profile settings.
  - `change_context --force` Force reconnection, deleting cached context.

---

### 3. `deploy`
Deploys the application to a specified pod type.

- **Usage**: `deploy [POD_TYPE] [OPTIONS]`
- **Options**:
  - `-l, --log-level LEVEL`  Set log level (`DEBUG|INFO|WARN|ERROR`).
  - `-c, --config-only`      Update configuration only, skip RPM installation.
  - `-h, --help`             Display help message.
- **Examples**:
  - `deploy qa --log-level INFO`
  - `deploy jws --config-only`

---

### 4. `forward_port`
Forwards local ports to remote pod services.

- **Usage**: `forward_port [POD_TYPE] [OPTIONS]`
- **Options**:
  - `-h, --help`             Display help message.
- **Examples**:
  - `forward_port qa`        Forward port 4081 from QA client pod.
  - `forward_port jws`       Forward port 4080 from JWS pod.

---

### 5. `get_pod_info`
Retrieves and displays pod information for the namespace.

- **Usage**: `get_pod_info [OPTIONS]`
- **Examples**:
  - `get_pod_info`           Display pod information for the default profile.
  - `get_pod_info --profile=dev` Display pod information for the `dev` profile.

---

### 6. `log_dump`
Dumps and collects logs from Kubernetes pods.

- **Usage**: `log_dump [OPTIONS] [POD_NAMES...]`
- **Options**:
  - `--log-dir=PATH`         Specify custom log directory (default: `./log_dump/`).
  - `-h, --help`             Display help message.
- **Examples**:
  - `log_dump pod-name-1 pod-name-2`
  - `log_dump --log-dir=/tmp/my-logs pod-name-1`

---

### 7. `pod_connect`
Connects to a shell in the specified pod type.

- **Usage**: `pod_connect [POD_TYPE] [OPTIONS]`
- **Options**:
  - `--profile=<name>`       Specify profile to use (default: from config).
  - `-h, --help`             Display help message.
- **Examples**:
  - `pod_connect jws`        Connect to JWS pod shell.
  - `pod_connect qa`         Connect to QA client pod shell.

---

### 8. `run_test`
Runs integration tests on a QA client pod.

- **Usage**: `run_test [OPTIONS]`
- **Options**:
  - `--exec-id=<id>`         Set the execution ID for the test run (required).
  - `--test-package=<pkg>`   Specify test package to run (default: ALL).
  - `--suspend=<y/n>`        Enable debug in suspend mode.
  - `--port=<port>`          Specify debug port number.
  - `--clean-server-logs`    Clean server logs before running tests.
  - `--get-server-logs`      Retrieve server logs after running tests.
- **Examples**:
  - `run_test --exec-id=test123`
  - `run_test --exec-id=test123 --test-package=com.example.tests.MyTest`

---

### 9. `toggle_debug`
Toggles debug mode for a specified pod type.

- **Usage**: `toggle_debug POD_TYPE [OPTIONS]`
- **Options**:
  - `--on`                  Enable debug mode (default).
  - `--off`                 Disable debug mode (not supported for QA).
  - `--suspend=y|n`         Set suspend option.
  - `--port=NUMBER`         Set debug port number.
  - `--help`                Display help message.
- **Examples**:
  - `toggle_debug jws`      Enable debug on JWS pod.
  - `toggle_debug sync --off` Disable debug on Sync pod.

---

### 10. `set_profile`
Sets the active profile configuration.

- **Usage**: `set_profile PROFILE_NAME`
- **Options**:
  - `-h, --help`             Display this help message.
- **Description**:
  - Sets the specified profile as the active configuration.
  - The profile must exist in the `./common/profiles/` directory.
  - Changes the `kubectl` context based on the new profile.
- **Examples**:
  - `set_profile jws-west1`  Set `jws-west1` as the active profile.
  - `set_profile sync-east5` Set `sync-east5` as the active profile.

---

### Usage Examples

Below are some practical examples of how to use the scripts in this repository, based on the `tests.sh` file:

#### 1. Set Profile
Set the active profile to `sync-west1`:
```bash
set_profile sync-west1
```

#### 2. Build and Deploy
Build and deploy the `qa` and `sync` modules:
```bash
build qa
deploy qa
build sync
deploy sync
```

#### 3. Run Tests
Run specific tests with various configurations:
- Run a test for AOL folder deletion with execution ID `SYNC14`:
  ```bash
  run_test --suspend=n --clean-server-logs --test-package=com.yahoo.mail.qa.sync.aol.folder.SyncAolDeleteFoldersIT --exec-id=SYNC14
  ```
- Run the same test with execution ID `SYNC17`:
  ```bash
  run_test --suspend=n --clean-server-logs --test-package=com.yahoo.mail.qa.sync.aol.folder.SyncAolDeleteFoldersIT --exec-id=SYNC17
  ```
- Run a test for creating an IMAP account without a folder prefix, while setting the profile to `jws-west1`:
  ```bash
  run_test --suspend=y --gsl --test-package=com.yahoo.mail.qa.jws.test.v3.account.AccountCreate2IT.testCreateImapInAccountWithoutFolderPrefix --exec-id=JWS142 --set-profile=jws-west1
  ```

---

## Getting Help

This project is developed and maintained outside of regular work tasks. There is no official support, jira or ticketing system. However, contributions and questions are always welcome. Feel free to submit your pull requests or reach out in Slack:
- **Slack**: [#jedi-gcp-scripts](https://ouryahoo.enterprise.slack.com/archives/C08S00552DN)

## Contributing

Feel free to submit issues or pull requests for improvements or bug fixes.

