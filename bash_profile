export PATH="/usr/local/git/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH"
export EVENT_NOKQUEUE=1
export MANPATH=/usr/local/git/man:$MANPATH
export SVN_EDITOR="mate -w"
export HISTCONTROL=erasedups
export GREP_OPTIONS="--color=auto"
export GREP_COLOR="4;33"
export CDPATH=.:~:~/Sites:~/Sites/github:/Library/Ruby/Gems/1.8/gems/

source ~/.git_completion.sh
source ~/.bash_completion.sh

PS1='\n[\u] \[\033[1;33m\]\w\a\[\033[0m\]$(__git_ps1 " \[\033[1;32m\](%s)\[\033[0m\]")\n\$ '

alias ls="ls -G"
alias ll="ls -Glahs"
alias colors="sh ~/.colors.sh"
alias psgrep="ps aux | egrep"
alias showip="ifconfig | grep broadcast | sed 's/.*inet \(.*\) netmask.*/\1/'"
alias myip="curl http://www.whatismyip.com/automation/n09230945.asp"
alias lock="/System/Library/CoreServices/Menu\ Extras/user.menu/Contents/Resources/CGSession -suspend"

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

# PROMPT_COMMAND=prompt