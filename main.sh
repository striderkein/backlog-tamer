#!/bin/bash

script_name=$(basename $0)

# helpを作成
# below is template
# -a VALUE    A explanation for arg called a
# -b          this option not take arg
usage() {
  cat <<EOM
Usage: $script_name
[OPTIONS]...
  -h | --help                                        Display help
[SUBCOMMANDS]...
  issue  [ISSUE_NUMBER]                              echo backlog-url gen from current branch or ISSUE_NUMBER(if passed).
  commit [COMMIT_HASH]                               echo backlog-url gen from hash of HEAD or COMMIT_HASH(if passed).
  branch [ISSUE_URL | ISSUE_NUMBER] [BRANCH_TYPE]    echo branch name gen from ISSUE_URL or ISSUE_NUMBER with BRANCH_TYPE(e.g. fix, refactor).if BRANCH_TYPE not passed, append 'feature' prefix as default.
  rev [COMMIT_HASH]                                  echo Markdown for Backlog gen from HEAD or your specific COMMIT_HASH(if passed).
  tree [BRANCH_NAME]                                 echo backlog-url gen from current branch or BRANCH_NAME(if passed).
EOM

  exit 2
}

not_git_repo() {
  # if not Git repository, end with error.
  exit 2
}

# example of get arg
# sub_hoge(){
#   echo "Running 'hoge' command."
#   echo "First arg is '$1'."
#   echo "Second arg is '$2'."
# }

sub_issue(){
  view=/view/
  issue=$1
  if [ -z $issue ]; then
    current_branch_name=$(git rev-parse --abbrev-ref HEAD)
    if [ $(echo $?) != 0 ]; then
      not_git_repo
    fi
    # xxx/<ISSUE_NUMBER> の 'xxx/' を削除して '<ISSUE_NUMBER>' を取得したい
    issue=`echo $current_branch_name | sed -e "s/.*\///g"`
  elif [[ $issue =~ ^[[:digit:]]+$ ]]; then
    # 数値文字列のみを渡された場合は add prefix して「<PROJECT_NAME>-<ISSUE_NUMBER>」の形式に整形する
    issue="FIRST-$issue"
  fi
  echo $backlog_url$view$issue
}

sub_commit(){
  commit=/git/FIRST/art-lesson/commit/
  arg=$1
  hash=''
  if [ -z $arg ]; then
    hash=$(git rev-parse HEAD)
    if [ $(echo $?) != 0 ]; then
      not_git_repo
    fi
    echo $backlog_url$commit$hash
  elif [[ $arg =~ .*eysdevpro2\.backlog\.jp\/git\/FIRST\/art-lesson\/commit\/ ]]; then
    # arg から URL を除去する処理
    hash=`echo $arg | sed -e "s|$backlog_url$commit||g"`
    # URL 含めて渡された場合はハッシュのみを返却
    echo $hash
  else
    # ハッシュのみが渡された場合は URL を返却
    hash=$arg
    echo $backlog_url$commit$hash
  fi
}

sub_branch(){
  issue=$1
  type=$2
  branch=''
  if [ -z $type ]; then
    type=feature
  fi
  if [ -z $issue ]; then
    # '|' 以降の意味: '* master' を 'master' に加工する（行頭の '* ' を削除）
    branch=$(git branch --contains | cut -d " " -f 2)
  else
    # URL から 'view/' 以前を削除, '#comment' 以降を削除
    issue=`echo $issue | sed -e "s|$backlog_url/view/||g" | sed -e "s/#.*$//g"`
  fi
  if [ -z $branch ]; then
    branch=$type/$issue
  fi
  echo $branch
}

sub_rev(){
  app=art-lesson
  hash=$1
  if [ -z $hash ]; then
    hash=$(git rev-parse HEAD)
    if [ $(echo $?) != 0 ]; then
      not_git_repo
    fi
  fi
  echo "#rev($app:$hash)"
}

sub_tree(){
  branch=$1
  # 引数がなければ branch に current branch をセットする
  if [ -z $branch ]; then
    # '|' 以降の意味: '* master' を 'master' に加工する（行頭の '* ' を削除）
    branch=$(git branch --contains | cut -d " " -f 2)
  fi
  # ex. of URL: https://eysdevpro2.backlog.jp/git/FIRST/art-lesson/tree/feature%2FFIRST-10758
  tree=$backlog_url/git/FIRST/art-lesson/tree/$branch
  echo $tree
}
subcommand=$1
backlog_url=https://eysdevpro2.backlog.jp

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

