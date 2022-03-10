#!/bin/bash

script_name=$(basename $0)

# helpを作成
# below is template
# -a VALUE    A explanation for arg called a
# -b          this option not take arg
usage() {
  cat <<EOM
Usage: $(basename "$0") [OPTION]...
  -u VALUE    gen url from current branch(ex.for commit comment)
  -h          Display help
EOM

  exit 2
}

# example of get arg
# sub_hoge(){
#   echo "Running 'hoge' command."
#   echo "First arg is '$1'."
#   echo "Second arg is '$2'."
# }

sub_issue(){
  view=view/
  issue=$1
  if [ -z $issue ]; then
    current_branch_name=$(git rev-parse --abbrev-ref HEAD)
    # xxx/<ISSUE_NUMBER> の 'xxx/' を削除して '<ISSUE_NUMBER>' を取得したい
    issue=`echo $current_branch_name | sed -e "s/.*\///g"`
  fi
  echo $backlog_url$view$issue
  exit 0
}

sub_commit(){
  commit=git/FIRST/art-lesson/commit/
  hash=$1
  if [ -z $hash ]; then
    hash=$(git rev-parse HEAD)
  fi
  echo $backlog_url$commit$hash
  exit 0
}

subcommand=$1
backlog_url=https://eysdevpro2.backlog.jp/

# 引数別の処理定義
case $subcommand in
  "" | "-h" | "--help")
      usage
      ;;
  *)
      shift
      sub_${subcommand} $@
      if [ $? = 127 ]; then
        echo "Error: '$subcommand' is not a konwn subcommand.">&2
        echo "       Run '$script_name --help' for a list of known subcommands.">&2
        exit 1
      fi
      ;;
esac

