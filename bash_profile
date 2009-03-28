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

alias bbs="cd ~/Sites/blogblogs"
alias spesa="cd ~/Sites/spesa"
alias ls="ls -G"
alias colors="sh ~/.colors.sh"
alias psgrep="ps aux | egrep"
alias showip="ifconfig | grep broadcast | sed 's/.*inet \(.*\) netmask.*/\1/'"
alias myip="curl http://www.whatismyip.com/automation/n09230945.asp"