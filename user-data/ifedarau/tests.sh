#!/bin/bash
set -e
#west1: SYNC14 SYNC17 SYNC22
#east5: SYNC3 SYNC20 SYNC25
set_profile sync-west1
#build qa -et -sc
#kubectl cp /Users/ifedarau/workspace_ifedarau/jedi/apps/qa/qa_sync/target/qa_sync.jar devuser-ifedarau-qaclient-f45785cdc-g4mbx:/opt/yahoo/jedi/ymail_xmas_qa/lib/qa_sync-1.1.23880.jar
#deploy qa
#build sync
#deploy sync
# Amit is working on figuring out the issue with auth
#run_test --suspend=n --csl --test-package=com.yahoo.mail.qa.sync.outlook.message.SyncOutlookCopyMessageSystemToUserFolderIT.testSystemCopyToUserFolderExternal --exec-id=SYNC14
#run_test --suspend=n --csl --test-package=com.yahoo.mail.qa.sync.outlook.message.SyncOutlookCopyMessageUserToSystemFolderIT.testUserCopyToSystemFolderExternal --exec-id=SYNC14

# works with patch https://gerrit.comms.corp.yahoo.com/c/mail-app-services/jedi/+/37675 Created April 1, 2024
#run_test --suspend=n --csl --test-package=com.yahoo.mail.qa.sync.migration.MessagesMoveMigrationIT.testMoveMessageMigration

# works
#run_test --suspend=n --csl --test-package=com.yahoo.mail.qa.sync.migration.InboxMessagesAppendDeleteFlagMigrationIT.testCopyMessageInInternalWithExpungeDeleted --exec-id=SYNC17
#run_test --suspend=n --csl --test-package=com.yahoo.mail.qa.sync.migration.InboxMessagesAppendDeleteFlagMigrationIT.testDuplicateMessagesMigration --exec-id=SYNC17
#run_test --suspend=n --csl --test-package=com.yahoo.mail.qa.sync.migration.InboxMessagesAppendDeleteFlagMigrationIT.testAppendFlagDeleteMigrationInbox --exec-id=SYNC17
#run_test --suspend=n --csl --test-package=com.yahoo.mail.qa.sync.migration.SpamMessagesAppendDeleteFlagMigrationIT.testAppendSameMessageInMultipleFolders --exec-id=SYNC17
#run_test --suspend=n --csl --test-package=com.yahoo.mail.qa.sync.migration.UserFolderMessagesAppendDeleteFlagMigrationIT.testAppendFlagDeleteMigrationUser --exec-id=SYNC17

#run_test --suspend=n --csl --test-package=com.yahoo.mail.qa.sync.migration.UserFolderMessagesAppendDeleteFlagMigrationIT.testDuplicateMessagesMigration

#change_context
#run_test --suspend=n --csl --test-package=com.yahoo.mail.qa.sync.message.SyncNowOauth2AuthIT.testOauth2NoTokenThenValidToken --exec-id=SYNC22
#run_test --suspend=n --test-package=com.yahoo.mail.qa.sync.migration.UserFolderMessagesAppendDeleteFlagMigrationIT.testAppendFlagDeleteMigrationUser --exec-id=SYNC14
#run_test --suspend=n --csl --test-package=com.yahoo.mail.qa.sync.outlook.message.SyncOutlookCopyMessageSystemToUserFolderIT.testSystemCopyToUserFolderExternal --exec-id=SYNC14
#run_test --suspend=n --csl --test-package=com.yahoo.mail.qa.sync.outlook.message.SyncOutlookCopyMessageUserToSystemFolderIT.testUserCopyToSystemFolderExternal --exec-id=SYNC14

#run_test --suspend=n --csl --test-package=com.yahoo.mail.qa.sync.gmail.message.SyncGmailMultiCopyInternalMessageI --exec-id=SYNC14
#run_test --suspend=n --csl --test-package=com.yahoo.mail.qa.sync.gmail.message.SyncGmailMultiCopyInternalMessageI --exec-id=SYNC14
#run_test --suspend=n --csl --test-package=com.yahoo.mail.qa.sync.gmail.message.SyncGmailMultiCopyInternalMessageI --exec-id=SYNC14
#run_test --suspend=n --csl --test-package=com.yahoo.mail.qa.sync.gmail.message.SyncGmailMultiCopyInternalMessageI --exec-id=SYNC14
#run_test --suspend=n --csl --test-package=com.yahoo.mail.qa.sync.gmail.message.SyncGmailMultiCopyInternalMessageI --exec-id=SYNC14
#run_test --suspend=n --csl --test-package=com.yahoo.mail.qa.sync.gmail.message.SyncAllMailMoveDeleteMessageIT --exec-id=SYNC14
#run_test --suspend=n --csl --test-package=com.yahoo.mail.qa.sync.gmail.message.SyncAllMailMoveDeleteMessageIT --exec-id=SYNC14
#run_test --suspend=n --csl --test-package=com.yahoo.mail.qa.sync.gmail.message.SyncAllMailMoveDeleteMessageIT --exec-id=SYNC14
#run_test --suspend=n --csl --test-package=com.yahoo.mail.qa.sync.gmail.message.SyncAllMailMoveDeleteMessageIT --exec-id=SYNC14
#run_test --suspend=n --csl --test-package=com.yahoo.mail.qa.sync.gmail.message.SyncAllMailMoveDeleteMessageIT --exec-id=SYNC14

#run_test --suspend=n --csl --test-package=com.yahoo.mail.qa.sync.aol.folder.SyncAolDeleteFoldersIT --exec-id=SYNC14
#run_test --suspend=n --csl --test-package=com.yahoo.mail.qa.sync.aol.folder.SyncAolDeleteFoldersIT --exec-id=SYNC17
run_test --suspend=n --test-package=com.yahoo.mail.qa.sync.aol.folder.SyncAolDeleteFoldersIT.testLinkAccountsYahooToAolEndPoint --exec-id=SYNC17
#run_test --suspend=n --test-package=com.yahoo.mail.qa.sync.aol.folder.SyncAolDeleteFoldersIT.testLinkAccountsYahooToAolEndPoint --exec-id=SYNC22
#run_test --suspend=y --gsl --test-package=com.yahoo.mail.qa.jws.test.v3.account.AccountCreate2IT.testCreateImapInAccountWithoutFolderPrefix --exec-id=JWS142  --set-profile=jws-west1