#!/bin/bash

#install apps
#-y option
echo 'Installing apps'

apt-get update
APPS = 'curl git yakuake node npm'
apt-get install APPS -y > provision-install.log

npm=$HOME/npm
#configure npm to install global packages for user (safe)
if [! -d $npm]; then
  echo 'Creating npm folder for user globals.'
  mkdir $npm
fi

npm config set prefix $npm
NPMBIN="$npm/bin"

if ! grep -q "PATH=.*$npm/bin" $HOME/.bashrc; then
  echo "Adding $NPMBIN to PATH"
  echo 'PATH=$PATH:'"$NPMBIN" >> $HOME/.bashrc
fi

#reload bashrc to install globals
source ~/.bashrc

#install npm modules
echo "Getting latest version of node" 
sudo -u $SUDO_USER npm install -g n
n stable
node -v
