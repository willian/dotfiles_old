export PATH="~/.scripts:/usr/local/ruby/active/bin:$PATH"
export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH"
export PATH="/usr/local/erlang/bin:/usr/local/couchdb/bin:/usr/local/spidermonkey/bin:$PATH"
export PATH="/usr/local/erlang/lib/erlang/lib/rabbitmq_server-1.6.0/sbin:$PATH"
export PATH="/usr/local/prince/bin:/usr/local/redis/bin:/usr/local/rhino:$PATH"
export PATH="/usr/local/scala/bin/:/usr/local/php/pear/bin:/usr/local/activemq/bin:$PATH"
export PATH="/usr/local/sphinx/bin:/usr/local/homebrew/bin:$PATH"
export PATH="/usr/local/mongodb/bin:/usr/local/mtasc:/usr/local/haxe:/usr/local/flex/bin:$PATH"
export CLASSPATH="/usr/local/rhino:$CLASSPATH"
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

export GEM_SPACES="$HOME/.gem/spaces"
export GEM_HOME="$GEM_SPACES/active"
export GEM_BIN="$GEM_SPACES/active/bin"
export GEM_EDITOR="mate"
export PATH="$GEM_BIN:$PATH"

export LESS_TERMCAP_mb=$'\E[04;33m'
export LESS_TERMCAP_md=$'\E[04;33m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[00;32m'

# Amazon EC2
export EC2_HOME="/Users/fnando/.ec2"
export EC2_PRIVATE_KEY="$EC2_HOME/pk.pem"
export EC2_CERT="$EC2_HOME/cert.pem"
export EC2_AMI_HOME="$EC2_HOME/ec2-ami-tools"
export PATH="$EC2_HOME/bin:$EC2_AMI_HOME/bin:$PATH"
export JAVA_HOME="/Library/Java/Home"

# Colours
export BLUE="\[\033[0;34m\]"
export NO_COLOR="\[\e[0m\]"
export GRAY="\[\033[1;30m\]"
export GREEN="\[\033[0;32m\]"
export LIGHT_GRAY="\[\033[0;37m\]"
export LIGHT_GREEN="\[\033[1;32m\]"
export LIGHT_RED="\[\033[1;31m\]"
export RED="\[\033[0;31m\]"
export WHITE="\[\033[1;37m\]"
export YELLOW="\[\033[0;33m\]"

source ~/.git_completion.sh
source ~/.bash_completion.sh
source ~/.gem_completion.sh

alias js="java jline.ConsoleRunner org.mozilla.javascript.tools.shell.Main"
alias ls="ls -G"
alias ll="ls -Glahs"
alias psgrep="ps aux | egrep -v egrep | egrep"
alias showip="ifconfig | grep broadcast | sed 's/.*inet \(.*\) netmask.*/\1/'"
alias myip="curl http://www.whatismyip.com/automation/n09230945.asp"
alias lock="/System/Library/CoreServices/Menu\ Extras/user.menu/Contents/Resources/CGSession -suspend"
alias quicksilver="open /Applications/Quicksilver.app"
alias qs="quicksilver"
alias top="top -o cpu"
alias mysql="mysql --auto-rehash=TRUE"
alias ni="lsof -i -Pn"
alias make="make -j 2"
alias cleanup="sudo rm -rf /private/var/log/asl/*"
alias xmlget="curl -X GET -H 'Accept: application/xml'"
alias jsonget="curl -X GET -H 'Accept: application/json'"
alias xmlpost="curl -X POST -H 'Accept: application/xml'"
alias xmlput="curl -X PUT -H 'Accept: application/xml'"
alias xmldelete="curl -X DELETE -H 'Accept: application/xml'"
alias r="rails"
alias tunnel="sudo ssh -vND localhost:666 fnando@simplesideias.com.br"

shopt -s cdspell
shopt -s nocaseglob
shopt -s checkwinsize
shopt -s dotglob
shopt -s extglob
shopt -s progcomp
set -o ignoreeof
unset MAILCHECK

# Usage: f /some/path [grep options]
f() {
    local path="$1"
    shift
    find "$path" -follow -name '*' | xargs grep "$*"
}

# Create a new Rails app using my own template
railsapp() {
    clear
    cd ~/Sites
    gem space "$1"
    gem install rails
    rails -m http://gist.github.com/221073.txt "$1"
}

# reload source
reload() { source ~/.bash_profile; }

# list directory after cd; also save the last directory
# and open it when a new tab is created
cd() {
    builtin cd "${@:-$HOME}" && ls && pwd > $CDHISTORY;
}

if [ -f $CDHISTORY ]; then
    dir=$(cat $CDHISTORY)

    if [ -d "$dir" ]; then
        builtin cd "$dir" && clear
    fi
fi

# Specify which ruby version to use
# Here's how my ruby is installed:
#
#   /usr/local/ruby/1.9.2-rc2
#   /usr/local/ruby/1.9.2-preview3
#   /usr/local/ruby/1.9.1-p429
#   /usr/local/ruby/1.9.1-p243
#   /usr/local/ruby/1.9.1-p376
#   /usr/local/ruby/1.8.7-p249
#   /usr/local/ruby/1.8.7-p299
#   /usr/local/ruby/1.8.7-p174
#   /usr/local/ruby/1.8.6-p383
#   /usr/local/ruby/ree-2010.02
#   /usr/local/ruby/active
#
# The active directory is a symlink to the active
# ruby version. This is also on the $PATH.
#
#   export PATH="/usr/local/ruby/active/ruby:$PATH"
use_ruby() {
	local root="/usr/local/ruby"
	local version="invalid"

	if [ "$1" = "192" ]; then
		version="1.9.2-rc2"
	elif [ "$1" = "191" ]; then
		version="1.9.1-p429"
	elif [ "$1" = "187" ]; then
		version="1.8.7-p299"
	elif [ "$1" = "186" ]; then
		version="1.8.6-p383"
	elif [ "$1" = "ree" ]; then
		version="ree-2010.02"
	fi

	local rubydir="$root/$version"

	if [ -d $rubydir ]; then
		echo "Activating Ruby $version"
		sudo rm $root/active && sudo ln -s $root/$version $root/active
		gem space base
	else
		echo "Specify a Ruby version: 186, 187, 191, 192, ree"
		exit 1
	fi
}

gzipped() {
    local r=`curl --write-out "%{size_download}" --output /dev/null --silent $1`
    local g=`curl -H "Accept-Encoding: gzip,deflate" --write-out "%{size_download}" --output /dev/null --silent $1`
    local message

    local rs=`expr ${r} / 1024`
    local gs=`expr ${g} / 1024`

    if [[ "$r" =  "$g" ]]; then
        message="Regular: ${rs}KB\n\033[31m → Gzip: ${gs}KB\033[0m"
    else
        message="Regular: ${rs}KB\n\033[32m → Gzip: ${gs}KB\033[0m"
    fi

    echo -e $message
    return 0
}

# enter a recently created directory
mkdir() { /bin/mkdir $@ && eval cd "\$$#"; }

# get the tinyurl
tinyurl () {
    local tmp=/tmp/tinyurl
    rm $tmp > /dev/null 2>&1
    wget "http://tinyurl.com/api-create.php?url=${1}" -O $tmp > /dev/null 2>&1
    cat $tmp | pbcopy
}

# retrieve all rake tasks
_rakecomplete() {
    COMP_WORDBREAKS=${COMP_WORDBREAKS/\:/}
    local words=`rake -T | grep rake | sed 's/rake \([^ ]*\).*/\1/'`
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=($(compgen -W "$words" -- $cur))
    return 0
}

complete -o default -F _rakecomplete rake

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

custom_prompt () {
    local BRANCH=`git branch 2> /dev/null | grep \* | sed 's/* //'`

    if [[ "$BRANCH" = "" ]]; then
        BRANCH=`git status 2> /dev/null | grep "On branch" | sed 's/# On branch //'`
    fi

    local RUBY_VERSION=`ruby -e "puts RUBY_VERSION"`
    local GEM_SPACE=`gem space 2> /dev/null | grep \* | sed 's/* //'`
    local RAILS_VERSION=`rails -v 2> /dev/null | sed 's/Rails //'`
    local RAILS_PROMPT=""
    local RUBY_PROMPT=""
    local STATUS=`git status 2>/dev/null`
    local PROMPT_COLOR=$GREEN
    local STATE=" "
    local NOTHING_TO_COMMIT="# Initial commit"
    local BEHIND="# Your branch is behind"
    local AHEAD="# Your branch is ahead"
    local UNTRACKED="# Untracked files"
    local DIVERGED="have diverged"
    local CHANGED="# Changed but not updated"
    local TO_BE_COMMITED="# Changes to be committed"
    local LOG=`git log -1 2> /dev/null`

    if [[ "$RAILS_VERSION" != "" ]]; then
        RAILS_PROMPT="${RAILS_VERSION}@"
    fi

    if [[ "$GEM_SPACE" != "" ]]; then
        RUBY_PROMPT="${GRAY}[${RAILS_PROMPT}${GEM_SPACE}#${RUBY_VERSION}]${NO_COLOR} "
    else
        RUBY_PROMPT="${GRAY}[${RAILS_PROMPT}${RUBY_VERSION}]${NO_COLOR} "
    fi

    if [ "$STATUS" != "" ]; then
        if [[ "$STATUS" =~ "$NOTHING_TO_COMMIT" ]]; then
            PROMPT_COLOR=$RED
            STATE=""
        elif [[ "$STATUS" =~ "$DIVERGED" ]]; then
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

        PS1="\n${RUBY_PROMPT}${YELLOW}\w\a${NO_COLOR} (${PROMPT_COLOR}${BRANCH}${NO_COLOR}${STATE}${NO_COLOR})\n\$ "
    else
        PS1="\n${RUBY_PROMPT}${YELLOW}\w\a${NO_COLOR}\n\$ "
    fi
}

# taken from http://github.com/bryanl/zshkit/
git-track () {
    local BRANCH=`git branch 2> /dev/null | grep \* | sed 's/* //'`
	git config branch.$BRANCH.remote origin
	git config branch.$BRANCH.merge refs/heads/$BRANCH
	echo "tracking origin/$BRANCH"
}
github-url () { git config remote.origin.url | sed -En 's/git(@|:\/\/)github.com(:|\/)(.+)\/(.+).git/https:\/\/github.com\/\3\/\4/p'; }
github-go () { open $(github-url); }
git-scoreboard () { git log | grep '^Author' | sort | uniq -ci | sort -r; }
manp () { man -t $* | ps2pdf - - | open -f -a Preview; }

PROMPT_COMMAND=custom_prompt
