# get the prompt set up for git
function parse_git_branch {
  git branch 2>/dev/null | grep '^*' | colrm 1 2 | sed 's_\(.*\)_(\1)_'
}

function git_dirty {
  git diff --quiet HEAD &>/dev/null
  [ $? == 1 ] && echo "!"
}

GREEN="\[\033[01;32m\]"
BLUE="\[\033[01;34m\]"
RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GRAY="\[\033[1;30m\]"
LIGHT_GRAY="\[\033[0;37m\]"
NONE="\[\033[0m\]"

export PS1="$BLUE\w$GRAY \$(~/.rvm/bin/rvm-prompt i v g):$GREEN\$(parse_git_branch)$RED\$(git_dirty)$NONE\$ "

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Opens the github page for the current git repo/branch in your browser
function gh() {
  giturl=$(git config --get remote.origin.url)
  if [ "$giturl" == "" ]
    then
     echo "Not a git repository or no remote.origin.url set"
     exit 1;
  fi

  giturl=${giturl/git\@github\.com\:/https://github.com/}
  giturl=${giturl/\.git/\/tree/}
  branch="$(git symbolic-ref HEAD 2>/dev/null)" ||
  branch="(unnamed branch)"     # detached HEAD
  branch=${branch##refs/heads/}
  giturl=$giturl$branch
  open $giturl
}

alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs -nw"
export EDITOR="/Applications/Emacs.app/Contents/MacOS/Emacs -nw"

# deal with "Cannot find terminfo entry for 'eterm-color'"
# when running in emacs ansi-term
if [ "$TERM" = "eterm-color" ] ; then
 TERM="vt100"
fi
