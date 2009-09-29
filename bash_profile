export PATH="/usr/local/ruby/active/bin:$PATH"
export PATH="/usr/local/git/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH"
export PATH="/usr/local/erlang/bin:/usr/local/couchdb/bin:/usr/local/spidermonkey/bin:/usr/local/erlang/lib/erlang/lib/rabbitmq_server-1.6.0/sbin:$PATH"
export PATH="/usr/local/prince/bin:$PATH"
export EVENT_NOKQUEUE=1
export MANPATH=/usr/local/git/man:$MANPATH
export EDITOR="/usr/bin/mate -wl1"
export SVN_EDITOR="/usr/bin/mate -wl1"
export HISTCONTROL=erasedups
export HISTFILESIZE=100000
export HISTSIZE=${HISTFILESIZE}
export GREP_OPTIONS="--color=auto"
export GREP_COLOR="4;33"
export CDPATH=.:~:~/Sites:~/Sites/github
export CDHISTORY="/tmp/cd-${USER}"

# Amazon EC2
export EC2_HOME="/Users/fnando/.ec2"
export EC2_PRIVATE_KEY="$EC2_HOME/pk.pem"
export EC2_CERT="$EC2_HOME/cert.pem"
export EC2_AMI_HOME="$EC2_HOME/ec2-ami-tools"
export PATH="$EC2_HOME/bin:$EC2_AMI_HOME/bin:$PATH"
export JAVA_HOME="/Library/Java/Home"

# Colours
BLUE="\[\033[0;34m\]"
NO_COLOR="\[\e[0m\]"
GRAY="\[\033[1;30m\]"
GREEN="\[\033[0;32m\]"
LIGHT_GRAY="\[\033[0;37m\]"
LIGHT_GREEN="\[\033[1;32m\]"
LIGHT_RED="\[\033[1;31m\]"
RED="\[\033[0;31m\]"
WHITE="\[\033[1;37m\]"
YELLOW="\[\033[0;33m\]"

source ~/.git_completion.sh
source ~/.bash_completion.sh

alias ls="ls -G"
alias ll="ls -Glahs"
alias colors="sh ~/.colors.sh"
alias psgrep="ps aux | egrep -v egrep | egrep"
alias showip="ifconfig | grep broadcast | sed 's/.*inet \(.*\) netmask.*/\1/'"
alias myip="curl http://www.whatismyip.com/automation/n09230945.asp"
alias lock="/System/Library/CoreServices/Menu\ Extras/user.menu/Contents/Resources/CGSession -suspend"
alias quicksilver="open /Applications/Quicksilver.app"
alias qs="quicksilver"
alias top="top -o cpu"
alias irb="irb --readline --prompt-mode simple"
alias mysql="mysql --auto-rehash=TRUE"

shopt -s cdspell
shopt -s nocaseglob
shopt -s checkwinsize
shopt -s dotglob
shopt -s extglob
set -o ignoreeof
unset MAILCHECK

# start apache from mamp
mamp() {
    /Applications/MAMP/Library/bin/apachectl start
    ln /tmp/mysql.sock /Applications/MAMP/tmp/mysql/mysql.sock
}

# reload source
reload() { source ~/.bash_profile; }

# list directory after cd; also save the last directory
# and open it when a new tab is created
cd() { 
    builtin cd "${@:-$HOME}" && ls && pwd > $CDHISTORY;
}

if [ -f $CDHISTORY ]; then
    if [ -d `cat $CDHISTORY` ]; then
        builtin cd `cat $CDHISTORY` && clear
    fi
fi

# Specify which ruby version to use
# Here's how my ruby is installed:
#
#   /usr/local/ruby/1.9.1-p243
#   /usr/local/ruby/1.8.7-p174
#   /usr/local/ruby/1.8.6-p383
#   /usr/local/ruby/active
#
# The active directory is a symlink to the active
# ruby version. This is also on the $PATH.
#
#   export PATH="/usr/local/ruby/active/ruby:$PATH"
use_ruby() {
  local root="/usr/local/ruby"
  local version="invalid"
  
  if [ "$1" = "191" ]; then
    version="1.9.1-p243"
  elif [ "$1" = "187" ]; then
    version="1.8.7-p174"
  elif [ "$1" = "186" ]; then
    version="1.8.6-p383"
  fi
  
  local rubydir="$root/$version"
  
  if [ -d $rubydir ]; then
    echo "Activating Ruby $version"
    sudo rm $root/active && sudo ln -s $root/$version $root/active
    ruby -v
  else
    echo "Specify a Ruby version: 186, 187, 191"
  fi
}

# enter a recently created directory
mkdir() { /bin/mkdir $@ && eval cd "\$$#"; }

# get the tinyurl
tinyurl () {
    local tmp=/tmp/tinyurl
    rm $tmp 2>1 /dev/null
    wget "http://tinyurl.com/api-create.php?url=${1}" -O $tmp 2>1 /dev/null
    cat $tmp | pbcopy
}

# complete rake tasks
complete -C ~/.rake_completion.rb -o default rake

# complete renv envs
_renvcomplete() {
  COMPREPLY=($(compgen -W "`NAME=${COMP_WORDS[COMP_CWORD]} renv complete`"))
  return 0
}

complete -o default -o nospace -F _renvcomplete renv

# github repository cloning
# usage: 
#    github has_permalink       ~> will clone $USER repositories
#    github username repository ~> will clone someone else's
github() {
    if [ $# = 1 ]; then
        git clone git@github.com:$USER/$1.git;
        builtin cd $1 && ls;
    elif [ $# = 2 ]; then
        git clone git://github.com/$1/$2.git;
        builtin cd $2 && ls;
    else
        echo "Usage:";
        echo "    github <repo>        ~> will clone $USER's <repo>";
        echo "    github <user> <repo> ~> will clone <user>'s <repo>";
    fi
}

git-prompt () {
    local BRANCH=`git branch 2> /dev/null | grep \* | sed 's/* //'`
    local STATUS=`git status 2>/dev/null`
    local PROMPT_COLOR=$GREEN
    local STATE=" "
    local BEHIND="# Your branch is behind"
    local AHEAD="# Your branch is ahead"
    local UNTRACKED="# Untracked files"
    local DIVERGED="have diverged"
    local CHANGED="# Changed but not updated"
    local TO_BE_COMMITED="# Changes to be committed"
    
    if [ "$BRANCH" != "" ]; then
        if [[ "$STATUS" =~ "$DIVERGED" ]]; then
            PROMPT_COLOR=$RED
            STATE="${STATE}${RED}↕${NO_COLOR}"
        elif [[ "$STATUS" =~ "$BEHIND" ]]; then
            PROMPT_COLOR=$RED
            STATE="${STATE}${RED}↓${NO_COLOR}"
        elif [[ "$STATUS" =~ "$AHEAD" ]]; then
            PROMPT_COLOR=$RED
            STATE="${STATE}${RED}↑${NO_COLOR}"
        elif [[ "$STATUS" =~ "$CHANGED" ]]; then
            PROMPT_COLOR=$RED
            STATE=""
        elif [[ "$STATUS" =~ "$TO_BE_COMMITED" ]]; then
            PROMPT_COLOR=$RED
            STATE=""
        else
            PROMPT_COLOR=$GREEN
            STATE=""
        fi
        
        if [[ "$STATUS" =~ "$UNTRACKED" ]]; then
            STATE="${STATE}${YELLOW}*${NO_COLOR}"
        fi
        
        PS1="\n[\u] ${YELLOW}\w\a${NO_COLOR} (${PROMPT_COLOR}${BRANCH}${NO_COLOR}${STATE})\n$ "
    else
        PS1="\n[\u] ${YELLOW}\w\a${NO_COLOR}\n\$ "
    fi
}

# taken from http://github.com/bryanl/zshkit/
github-url () { git config remote.origin.url | sed -En 's/git(@|:\/\/)github.com(:|\/)(.+)\/(.+).git/https:\/\/github.com\/\3\/\4/p'; }
github-go () { open $(github-url); }
git-scoreboard () { git log | grep '^Author' | sort | uniq -ci | sort -r; }
manp () { man -t $* | ps2pdf - - | open -f -a Preview; }

export LESS_TERMCAP_mb=$'\E[04;33m'
export LESS_TERMCAP_md=$'\E[04;33m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[00;32m'

PROMPT_COMMAND=git-prompt

export RENVDIR="$HOME/.renv"
export PATH="$RENVDIR/active/bin:$PATH"
export GEM_PATH="$RENVDIR/active/lib"
