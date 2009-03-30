cp autotest ~/.autotest
cp bash_completion.sh ~/.bash_completion.sh
cp bash_profile ~/.bash_profile
cp colors.sh ~/.colors.sh
cp git_completion.sh ~/.git_completion.sh
cp gitconfig ~/.gitconfig
cp irbc ~/.irbc
cp pezrc ~/.pezrc
cp rake_completion.rb ~/.rake_completion.rb

chmod 755 ~/.rake_completion.rb

sudo mkdir -p /etc/bash_completion

source ~/.bash_profile