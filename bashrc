alias ll="ls -la"
alias ua="cd ~/src/ua"
alias m3="cd ~/src/m3"
alias api="cd ~/src/api"
alias mae="cd ~/src/mae"
alias cms="cd ~/src/cms"
alias sourceit="source ~/.bash_profile"
alias gpull="git pull && git submodule update"

alias uaserver="ua && bundle exec rails s -p3000"
alias m3server="m3 && bundle exec rails s -p3001"
alias apiserver="api && bundle exec rails s -p3003"
alias cmserver="cms && bundle exec rails s -p3002"

alias umae="bundle update maestro_activity_engine"

export M3_APP_PATH=~/src/m3

export PATH=/usr/local/bin:/usr/local/sbin:$HOME/.rvm/bin:$PATH

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
  giturl=$(git config --get remote.originh.url)
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

export EDITOR="/Applications/Emacs.app/Contents/MacOS/Emacs -nw"

