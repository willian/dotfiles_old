cp autotest ~/.autotest
cp bash_completion.sh ~/.bash_completion.sh
cp rake_completion.rb ~/.rake_completion.rb
cp bashrc ~/.bashrc
cp bash_profile ~/.bash_profile
cp colors.sh ~/.colors.sh
cp git_completion.sh ~/.git_completion.sh
cp gem_completion.sh ~/.gem_completion.sh
cp gitconfig ~/.gitconfig
cp irbrc ~/.irbrc
cp inputrc ~/.inputrc
cp pezrc ~/.pezrc
cp gemrc ~/.gemrc
cp gitignore ~/.gitignore
cp caprc ~/.caprc

sudo cp grabbit /usr/local/bin
sudo chmod +x /usr/local/bin/grabbit

mkdir -p ~/.ssh
cp sshconfig ~/.ssh/config

chmod 755 ~/.rake_completion.rb

sudo mkdir -p /etc/bash_completion

sudo wget -O /usr/local/bin/rvm-completion.rb http://github.com/colszowka/rvm-completion/raw/master/lib/rvm-completion.rb
sudo chmod +x /usr/local/bin/rvm-completion.rb

source ~/.bash_profile
