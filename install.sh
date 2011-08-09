cp files/autotest ~/.autotest
cp files/bash_completion.sh ~/.bash_completion.sh
cp files/bash_profile ~/.bash_profile
cp files/bashrc ~/.bashrc
cp files/caprc ~/.caprc
cp files/gem_completion.sh ~/.gem_completion.sh
cp files/gemrc ~/.gemrc
cp files/git_completion.sh ~/.git_completion.sh
cp files/gitconfig ~/.gitconfig
cp files/gitignore ~/.gitignore
cp files/inputrc ~/.inputrc
cp files/irbrc ~/.irbrc
cp files/npmrc ~/.npmrc
cp files/rdebugrc ~/.rdebugrc
cp files/rvmrc ~/.rvmrc

mkdir ~/bin
cp files/{grabbit,lyrics} ~/bin
chmod +x ~/bin/grabbit
chmod +x ~/bin/lyrics

curl http://github.com/paulhammond/webkit2png/raw/master/webkit2png > ~/bin/webkit2png
chmod +x ~/bin/webkit2png

mkdir -p ~/.ssh
cp files/sshconfig ~/.ssh/config

sudo mkdir -p /etc/bash_completion

source ~/.bash_profile

defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES
defaults write -g PMPrintingExpandedStateForPrint -bool TRUE

open files/Terminal/IR_Black.terminal
