export PATH="/usr/local/git/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH"
export EVENT_NOKQUEUE=1
export MANPATH=/usr/local/git/man:$MANPATH
export SVN_EDITOR="mate -w"
export HISTCONTROL=erasedups

source ~/.git-completion.sh
PS1='\n[\u] \[\033[1;33m\]\w\a\[\033[0m\]$(__git_ps1 " \[\033[1;32m\](%s)\[\033[0m\]")\n\$ '

alias bbs="cd ~/Sites/blogblogs"
alias spesa="cd ~/Sites/spesa"
alias ls="ls -G"