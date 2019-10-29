#!/bin/bash
# This script is meant to make the backup or load my dotfiles.


backup(){
    cp -r ~/.tmux* ./tmux/
    cp -r ~/.vimrc ./vim/
    cp -r ~/.config/i3/config ./i3/
}

load(){
    cp -r ./tmux/* ~/
    cp -r ./vim/* ~/
    cp -r ./i3/* ~/.config/i3/
}

USAGE="Usage: dotfiles [load|backup]"

if [ "$#" -ne "1" ]
then
    echo $USAGE
else
    if [ "$1" == "load" ]
    then
        load 
    elif [ "$1" == "backup" ]
    then
        backup
    else
        echo $USAGE
    fi
fi 
