export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export EVENT_NOKQUEUE=1
export MANPATH=/usr/local/git/man:$MANPATH
export EDITOR="vim"
export SVN_EDITOR="$EDITOR"
export HISTCONTROL=erasedups
export HISTFILESIZE=100000
export HISTSIZE=${HISTFILESIZE}
export GREP_OPTIONS="--color=auto"
export GREP_COLOR="4;33"
export CLICOLOR="auto"
export CDPATH=.:~:~/Sites/rails_app:~/Sites:~/GitHub

export GEM_EDITOR="$EDITOR"

export LESS_TERMCAP_mb=$'\E[04;33m'
export LESS_TERMCAP_md=$'\E[04;33m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[00;32m'

# Ruby on Rails
# export RAILS_ENV='development'

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

alias ls="ls -G"
alias ll="ls -Glahs"
alias psgrep="ps aux | egrep -v egrep | egrep"
alias showip="ifconfig | grep broadcast | sed 's/.*inet \(.*\) netmask.*/\1/'"
alias myip="curl http://www.whatismyip.com/automation/n09230945.asp"
alias top="top -o cpu"
alias mysql="mysql --auto-rehash=TRUE"
alias ni="lsof -i -Pn"
alias make="make -j 2"
alias spec_rcov="rake spec:rcov && open coverage/index.html"
alias pg_start="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias pg_stop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"
alias gvim='mvim -go'
alias rvim='mvim --remote'
alias tvim='mvim --remote-tab'
alias rails_db_reset="rake db:drop && rake db:create && rake db:migrate"

shopt -s cdspell
shopt -s nocaseglob
shopt -s checkwinsize
shopt -s dotglob
shopt -s extglob
shopt -s progcomp
unset MAILCHECK

# Load RVM scripts
if [[ -s $HOME/.rvm/scripts/rvm ]] ; then source $HOME/.rvm/scripts/rvm ; fi

# Usage: railsapp my_app
#        railsapp my_app cucumber
railsapp() {
  if [ $# = 1 ]; then
    rails new $1 -J -T -m http://github.com/willian/rails3-app/raw/master/app.rb
  elif [ $# = 2 ]; then
    if [ "$2" = "cucumber" ]; then
      rails new $1 -J -T -m http://github.com/willian/rails3-app/raw/master/cuke.rb
    else
      echo "Usage:";
      echo "    railsapp <app_name>           ~> will create a rails 3 app without cucumber";
      echo "    railsapp <app_name> cucumber  ~> will create a rails 3 app with cucumber";
    fi
  else
    echo "Usage:";
    echo "    railsapp <app_name>           ~> will create a rails 3 app without cucumber";
    echo "    railsapp <app_name> cucumber  ~> will create a rails 3 app with cucumber";
  fi
}

# Usage: f /some/path [grep options]
f() {
  local path="$1"
  shift
  find "$path" -follow -name '*' | xargs grep "$*"
}

# reload source
reload() { source ~/.bash_profile; }

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

_gemopencomplete() {
  local cmd=${COMP_WORDS[0]}
  local subcmd=${COMP_WORDS[1]}
  local cur=${COMP_WORDS[COMP_CWORD]}

  case "$subcmd" in
    open)
      words=`ruby -rubygems -e 'puts Dir["{#{Gem::SourceIndex.installed_spec_directories.join(",")}}/*.gemspec"].collect {|s| File.basename(s).gsub(/\.gemspec$/, "")}'`
      ;;
    *)
      return
      ;;
  esac

  COMPREPLY=($(compgen -W "$words" -- $cur))
  return 0
}
complete -o default -F _gemopencomplete gem

# github repository cloning
# usage:
#    github textmate_bundles    ~> will clone $USER repositories
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
  local RUBY_VERSION=`ruby -e "puts RUBY_VERSION"`

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

    PS1="\n[\u@\h] ${YELLOW}\w\a${NO_COLOR} (${PROMPT_COLOR}${BRANCH}${NO_COLOR}${STATE}) (${YELLOW}${RUBY_VERSION}${NO_COLOR})\n$ "
  else
    PS1="\n[\u@\h] ${YELLOW}\w\a${NO_COLOR} (${YELLOW}${RUBY_VERSION}${NO_COLOR})\n\$ "
  fi
}

git-merge () {
  local BRANCH=`git branch 2> /dev/null | grep \* | sed 's/* //'`
  if [ $# = 1 ]; then
    git co $1 && git pull && git co $BRANCH && git merge $1 && git push
  else
    echo "Usage:";
    echo "    git-merge <branch_with_changes>";
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
