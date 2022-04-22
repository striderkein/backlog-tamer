# backlog_cli

## How to install
```
./init.sh
```

## How to use
### subcommands
- issue      echo backlog-url gen from current branch or ISSUE_NUMBER(if passed).
- commit     echo backlog-url gen from hash of HEAD or COMMIT_HASH(if passed).
- branch     echo branch name gen from ISSUE_URL or ISSUE_NUMBER with BRANCH_TYPE(e.g. fix, refactor).if BRANCH_TYPE not passed, append 'feature' prefix as default.
- rev        echo Markdown for Backlog gen from HEAD or your specific COMMIT_HASH(if passed).

#### issue
echo backlog-url gen from current branch or ISSUE_NUMBER(if passed).
```
balo issue  [ISSUE_NUMBER]
```
#### commit
echo backlog-url gen from hash of HEAD or COMMIT_HASH(if passed).
```
balo commit [COMMIT_HASH]
```
#### branch [ISSUE_URL | ISSUE_NUMBER] [BRANCH_TYPE]
echo branch name gen from ISSUE_URL or ISSUE_NUMBER with BRANCH_TYPE(e.g. fix, refactor).if BRANCH_TYPE not passed, append 'feature' prefix as default.
```
balo branch [ISSUE_URL | ISSUE_NUMBER] [BRANCH_TYPE]
```
#### rev [COMMIT_HASH]
echo Markdown for Backlog from HEAD or your specific COMMIT_HASH(if passed).
```
balo rev [COMMIT_HASH]
```
