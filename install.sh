cp files/autotest ~/.autotest
cp files/bash_completion.sh ~/.bash_completion.sh
cp files/bash_profile ~/.bash_profile
cp files/caprc ~/.caprc
cp files/finder-path.applescript ~/.finder-path.applescript
cp files/gem_completion.sh ~/.gem_completion.sh
cp files/git_completion.sh ~/.git_completion.sh
cp files/gitconfig ~/.gitconfig
cp files/irbrc ~/.irbrc
cp files/inputrc ~/.inputrc
cp files/pezrc ~/.pezrc
cp files/gemrc ~/.gemrc
cp files/npmrc ~/.npmrc
cp files/gitignore ~/.gitignore

mkdir ~/.bin
cp files/grabbit ~/.bin
chmod +x ~/.bin/grabbit

curl http://github.com/paulhammond/webkit2png/raw/master/webkit2png > ~/.bin/webkit2png
chmod +x ~/.bin/webkit2png

mkdir -p ~/.ssh
cp files/sshconfig ~/.ssh/config

sudo mkdir -p /etc/bash_completion

source ~/.bash_profile

defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES
defaults write -g PMPrintingExpandedStateForPrint -bool TRUE

open files/IR_Black.terminal