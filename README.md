# backlog-tamer
## What's this?
backlog の URL は（GitHub と違って）やや煩雑な形式になっている。  
例えば  
issue の URL: `/view/<PROJECT_NAME>-<ISSUE_NUMBER>` （なんだ `view` って）  
特定のコミットの URL: `/git/<PROJECT_NAME>/<REPOSITORY>/commit/<HASH>` （なんだ `git` って）  
といった具合である。

backlog-tamer は、推測しにくく使いにくいこいつらをなんとかてなづける（= tame）ためのツールである

なお、backlog 公式からも backlog-cli （とかなんとか）が出ているが、なんかエラーが出て使えなかったのでムシャクシャして作った。後悔はしていない。

## How to install
```
cp .env.example .env
./init.sh
```

## How to use
### subcommands
- `issue`:      echo backlog-url gen from current branch or ISSUE_NUMBER(if passed).
- `commit`:     echo backlog-url gen from hash of HEAD or COMMIT_HASH(if passed).
- `branch`:     echo branch name gen from ISSUE_URL or ISSUE_NUMBER with BRANCH_TYPE(e.g. fix, refactor).if BRANCH_TYPE not passed, append 'feature' prefix as default.
- `rev`:        echo Markdown for Backlog gen from HEAD or your specific COMMIT_HASH(if passed).

#### issue
echo backlog-url gen from current branch or ISSUE_NUMBER(if passed).
```
balo issue  [ISSUE_NUMBER]
```

**使用例-1**
「いま作業中のブランチに紐付いてるイシューが見たいやで… せや！」
```
open $(balo issue)
# ブラウザで Backlog の関連イシューのページが開く
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
