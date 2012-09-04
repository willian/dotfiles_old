CURRENT_PATH=`pwd`

ln -sf $CURRENT_PATH/files/bash_profile $HOME/.bash_profile
ln -sf $CURRENT_PATH/files/caprc $HOME/.caprc
ln -sf $CURRENT_PATH/files/gitconfig $HOME/.gitconfig
ln -sf $CURRENT_PATH/files/irbrc $HOME/.irbrc
ln -sf $CURRENT_PATH/files/inputrc $HOME/.inputrc
ln -sf $CURRENT_PATH/files/gemrc $HOME/.gemrc
ln -sf $CURRENT_PATH/files/npmrc $HOME/.npmrc
ln -sf $CURRENT_PATH/files/pryrc $HOME/.pryrc
ln -sf $CURRENT_PATH/files/gitignore $HOME/.gitignore

mkdir -p $HOME/bin

curl https://raw.github.com/paulhammond/webkit2png/master/webkit2png > $HOME/.bash/bin/webkit2png
chmod +x $HOME/.bash/bin/webkit2png

mkdir -p $HOME/.ssh
cp files/sshconfig $HOME/.ssh/config

sudo mkdir -p /etc/bash_completion

source $HOME/.bash_profile

defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES
defaults write -g PMPrintingExpandedStateForPrint -bool TRUE

open files/IR_Black.terminal

