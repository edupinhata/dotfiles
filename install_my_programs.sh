#!/bin/bash

# This is a script to install all programs that I use to work

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


