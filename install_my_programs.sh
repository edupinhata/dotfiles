#!/bin/bash

# This is a script to install all programs that I use to work

# apt programs
sudo apt install sshpass

# Git repositories
if [ ! -d ~/proj ]; then
    mkdir ~/proj
fi

cd ~/proj

if [ ! -d i3lock-fancy ]; then
    echo "Clonning i3lock-fancy"
    git clone https://github.com/meskarune/i3lock-fancy.git
fi
if [ -d i3lock-fancy ]; then
    echo "Installing i3lock-fancy"
    cd i3lock-fancy
    git checkout dualmonitors
    sudo make install
fi


# DPKG programs
# Download dpkg programs and install then
DPKG_PATH="/tmp/dpkg_installs"

mkdir -p $DPKG_PATH
cd $DPKG_PATH

wget https://remarkableapp.github.io/linux.html

for pack in *; do
    echo "Installing $pack..."
    sudo dpkg -i $pack
done
