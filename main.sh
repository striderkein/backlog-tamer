#!/bin/bash
# helpを作成
# below is template
# -a VALUE    A explanation for arg called a
# -b          this option not take arg
function usage {
  cat <<EOM
Usage: $(basename "$0") [OPTION]...
  -u VALUE    gen url from current branch(ex.for commit comment)
  -h          Display help
EOM

  exit 2
}

# issue=$1
backlog_url=https://eysdevpro2.backlog.jp/

# 引数別の処理定義
while getopts "u:h" optKey; do
  case "$optKey" in
    u)
      if [ ${OPTARG} = 'issue' ]; then
        view=view/
        current_branch_name=$(git rev-parse --abbrev-ref HEAD)
        # xxx/<ISSUE_NUMBER> の 'xxx/' を削除して '<ISSUE_NUMBER>' を取得したい
        issue=`echo $current_branch_name | sed -e "s/.*\///g"`
        echo $backlog_url$view$issue
        exit 0
      elif [ ${OPTARG} = 'commit' ]; then
        commit=git/FIRST/art-lesson/commit/
        hash=$(git rev-parse HEAD)
        echo $backlog_url$commit$hash
        exit 0
      fi
      ;;
    '-h'|'--help'|* )
      usage
      ;;
  esac
done

