# dotfiles

This folder contains all the dotfiles that I use in my daily routine.

## Currently files

- vim: used as editor to program, make notes, open files, etc.
- tmux: used as a terminal multiplexer. The configurations are based on gpakosz[https://github.com/gpakosz/.tmux]
- i3: used as windows manager.

## To be added

- emacs: want to give a try and change from vim to emacs. Add vim bindings to it and try the power of emacs.


## Load and Backup

The script dotfiles.sh will allow to quickly load of the repo dotfiles, or to get the dotfiles that were changed in local machine.

### Usage

./dotfiles.sh [load|backup]

**load**

    Will take the repo dotfiles and copy it to each destination.

**backup**

    Will take the current dotfiles and copy it to each directory in the repo.
