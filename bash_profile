export PATH="/usr/local/git/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH"
export EVENT_NOKQUEUE=1
export MANPATH=/usr/local/git/man:$MANPATH
export SVN_EDITOR="mate -w"
export HISTCONTROL=erasedups
export HISTFILESIZE=100000
export HISTSIZE=${HISTFILESIZE}
export GREP_OPTIONS="--color=auto"
export GREP_COLOR="4;33"
export CDPATH=.:~:~/Sites:~/Sites/github:/Library/Ruby/Gems/1.8/gems/

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
alias psgrep="ps aux | egrep"
alias showip="ifconfig | grep broadcast | sed 's/.*inet \(.*\) netmask.*/\1/'"
alias myip="curl http://www.whatismyip.com/automation/n09230945.asp"
alias lock="/System/Library/CoreServices/Menu\ Extras/user.menu/Contents/Resources/CGSession -suspend"
alias quicksilver="open /Applications/Quicksilver.app"
alias qs="quicksilver"

shopt -s cdspell
shopt -s nocaseglob
shopt -s checkwinsize
shopt -s dotglob
shopt -s extglob
shopt -s histverify
set -o ignoreeof
unset MAILCHECK

# reload source
reload() { source ~/.bash_profile; }

# list directory after cd
cd() { builtin cd "${@:-$HOME}" && ls; }

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

# github repository cloning
# usage: 
#    gh has_permalink       ~> will clone $USER repositories
#    gh username repository ~> will clone someone else's
github() {
    if [ $# = 1 ]; then
        builtin cd ~/Sites/github;
        git clone git@github.com:$USER/$1.git;
        builtin cd $1 && ls;
    elif [ $# = 2 ]; then
        builtin cd ~/Sites/github;
        git clone git://github.com/$1/$2.git;
        builtin cd $2 && ls;
    else
        echo "Usage:";
        echo "    github <repo>        ~> will clone $USER's <repo>";
        echo "    github <user> <repo> ~> will clone <user>'s <repo>";
    fi
}

git () {
    GIT=`which git` 
    
    if [ "$1" = "add" ]; then
        $GIT $@ && $GIT status
    else
        $GIT $@
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
    local DIVERGED="# Your branch and (.*) have diverged"
    
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
        else
            PROMPT_COLOR=$GREEN
            STATE=""
        fi
        
        if [[ "$STATUS" =~ "$UNTRACKED" ]]; then
            STATE="${STATE}${YELLOW}✷${NO_COLOR}"
        fi
        
        PS1="\n[${PROMPT_COLOR}${BRANCH}${NO_COLOR}${STATE}] ${YELLOW}\w\a${NO_COLOR}\n$ "
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