# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


# Some custom functions
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[33m\]$(parse_git_branch)\[\033[00m\] \n→  '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

setxkbmap -option ctrl:nocaps

function addRotas {
	sudo route add 10.76.84.15 gw 10.121.3.2
	sudo route add 10.76.84.31 gw 10.121.3.2
	sudo route add 10.76.84.48 gw 10.121.3.2
	sudo route add 10.76.84.20 gw 10.121.3.2
	sudo route add 10.76.68.213 gw 10.121.3.2
	sudo route add 10.76.69.40 gw 10.121.3.2
	sudo route add 10.76.69.41 gw 10.121.3.2
	sudo route add 10.76.69.19 gw 10.121.3.2
	sudo route add 10.76.84.92 gw 10.121.3.2
	sudo route add 10.76.69.37 gw 10.121.3.2
	sudo route add sdrive gw 10.121.3.2
	sudo route add tadeu gw 10.121.3.2
}


function scptosdrive {
	sshpass -p livetv123 scp -r ./$1 developer@sdrive:~/sustainingsdrive/$2
} 


function scptothales {
		scptosdrive $1 $2
		sshpass -p livetv123 ssh developer@sdrive 'echo "ltv3tv" | sudo -Sv && scp -r ~/sustainingsdrive/$1 thales.alcarva@ltv-cemp:~/$2'
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

setxkbmap -layout br

###################################################################
# COPY AND PAST 
##################################################################
PERSONAL_PATH="pinhata"
SDRIVE_SCP_PATH="~/sustainingsdrive/$PERSONAL_PATH"
CEMP_SCP_PATH="/home/thales.alcarva/$PERSONAL_PATH"
CSSC_SCP_PATH="/var/spool/ltv3/ltv4br/$PERSONAL_PATH"
MARCELO_SCP_PATH="/home/developer/$PERSONAL_PATH"
STVVM_BUILDER_PATH="/home/builder/$PERSONAL_PATH"
SILUSER_PATH="/home/siluser/$PERSONAL_PATH"
PC2_PATH="/home/thales/$PERSONAL_PATH"
CLAUDIO_PATH="/home/siluser/$PERSONAL_PATH"

# LiveTV functions
scp-to-cssccemp()
{
        sshpass -p livetv123 scp -r $1 developer@sdrive:$SDRIVE_SCP_PATH
        sshpass -p livetv123 ssh -t developer@sdrive "scp -r $SDRIVE_SCP_PATH/$1 thales.alcarva@ltv-cemp:$CEMP_SCP_PATH/ && rm $SDRIVE_SCP_PATH/$1"
        sshpass -p livetv123 ssh -t developer@sdrive ssh -t thales.alcarva@ltv-cemp sshpass -p ltv3tv scp  -r -P 48135 $CEMP_SCP_PATH/$1 root@10.0.0.1:$CSSC_SCP_PATH
}

scp-from-cssccemp()
{
        sshpass -p livetv123 ssh -t developer@sdrive ssh -t thales.alcarva@ltv-cemp sshpass -p ltv3tv scp -r -P 48135 root@10.0.0.1:$CSSC_SCP_PATH/$1 $CEMP_SCP_PATH/
        sshpass -p livetv123 ssh -t developer@sdrive scp -r thales.alcarva@ltv-cemp:$CEMP_SCP_PATH/$1 $SDRIVE_SCP_PATH/
        sshpass -p livetv123 scp -r developer@sdrive:$SDRIVE_SCP_PATH/$1 .
}

scp-to-cemp()
{
        sshpass -p livetv123 scp -r $1 developer@sdrive:$SDRIVE_SCP_PATH
        sshpass -p livetv123 ssh -t developer@sdrive "scp -r $SDRIVE_SCP_PATH/$1 thales.alcarva@ltv-cemp:$CEMP_SCP_PATH/ && rm $SDRIVE_SCP_PATH/$1"
}

scp-from-cemp()
{
        sshpass -p livetv123 ssh -t developer@sdrive scp -r thales.alcarva@ltv-cemp:$CEMP_SCP_PATH/$1 $SDRIVE_SCP_PATH/
        sshpass -p livetv123 scp -r developer@sdrive:$SDRIVE_SCP_PATH/$1 .
}


# LiveTV functions
scp-to-csscjb()
{
        sshpass -p livetv123 scp -r $1 developer@sdrive:$SDRIVE_SCP_PATH
        sshpass -p livetv123 ssh -t developer@sdrive "scp -r $SDRIVE_SCP_PATH/$1 thales.alcarva@ltv-jb:$CEMP_SCP_PATH/ && rm $SDRIVE_SCP_PATH/$1"
        sshpass -p livetv123 ssh -t developer@sdrive ssh -t thales.alcarva@ltv-jb sshpass -p ltv3tv scp  -r -P 48135 $CEMP_SCP_PATH/$1 root@10.0.0.1:$CSSC_SCP_PATH
}

scp-from-csscjb()
{
        sshpass -p livetv123 ssh -t developer@sdrive ssh -t thales.alcarva@ltv-jb sshpass -p ltv3tv scp -r -P 48135 root@10.0.0.1:$1/$2 $CEMP_SCP_PATH/
        sshpass -p livetv123 ssh -t developer@sdrive scp -r thales.alcarva@ltv-jb:$CEMP_SCP_PATH/$2 $SDRIVE_SCP_PATH/
        sshpass -p livetv123 scp -r developer@sdrive:$SDRIVE_SCP_PATH/$2 .
}

scp-to-jb()
{
        sshpass -p livetv123 scp -r $1 developer@sdrive:$SDRIVE_SCP_PATH
        sshpass -p livetv123 ssh -t developer@sdrive "scp -r $SDRIVE_SCP_PATH/$1 thales.alcarva@ltv-jb:$CEMP_SCP_PATH/ && rm $SDRIVE_SCP_PATH/$1"
}

scp-from-jb()
{
        sshpass -p livetv123 ssh -t developer@sdrive scp -r thales.alcarva@ltv-jb:$CEMP_SCP_PATH/$1 $SDRIVE_SCP_PATH/
        sshpass -p livetv123 scp -r developer@sdrive:$SDRIVE_SCP_PATH/$1 .
}

scp-from-stvvm-marcelo()
{
    sshpass -p livetv123 ssh -t developer@bob sshpass -p Thales01* ssh -t developer@marcelo sshpass -p builder scp -r builder@stvvm:$STVVM_BUILDER_PATH/$1 $MARCELO_SCP_PATH 
    sshpass -p livetv123 ssh -t developer@bob sshpass -p Thales01* scp -r developer@marcelo:$MARCELO_SCP_PATH/$1 $SDRIVE_SCP_PATH
    sshpass -p livetv123 scp -r developer@bob:$SDRIVE_SCP_PATH/$1 .
    
}

scp-from-stvbr()
{
    sshpass -p livetv123 ssh -t developer@bob sshpass -p livetv123 ssh -t siluser@int-mlb sshpass -p Thales01 ssh -t thales@10.121.3.144 sshpass -p livetv123 scp -r siluser@10.121.3.92:$SILUSER_PATH/$1 $PC2_PATH 
    sshpass -p livetv123 ssh -t developer@bob sshpass -p livetv123 ssh -t siluser@int-mlb sshpass -p Thales01 scp -r thales@10.121.3.144:$PC2_PATH/$1 $CLAUDIO_PATH 
    sshpass -p livetv123 ssh -t developer@bob sshpass -p livetv123 scp -r siluser@int-mlb:$CLAUDIO_PATH/$1 $SDRIVE_SCP_PATH
    sshpass -p livetv123 scp -r developer@bob:$SDRIVE_SCP_PATH/$1 .
}

scp-to-stvbr()
{
    sshpass -p livetv123 scp -r $1 developer@bob:$SDRIVE_SCP_PATH
    sshpass -p livetv123 ssh -t developer@bob sshpass -p livetv123 scp -r $SDRIVE_SCP_PATH/$1 siluser@int-mlb:$CLAUDIO_PATH 
    sshpass -p livetv123 ssh -t developer@bob sshpass -p livetv123 ssh -t siluser@int-mlb sshpass -p Thales01 scp -r $CLAUDIO_PATH/$1 thales@10.121.3.144:$PC2_PATH
    sshpass -p livetv123 ssh -t developer@bob sshpass -p livetv123 ssh -t siluser@int-mlb sshpass -p Thales01 ssh -t thales@10.121.3.144 sshpass -p livetv123 scp -r $PC2_PATH/$1 siluser@10.121.3.92:$SILUSER_PATH
}

function cd_up()
{
    cd $(printf "%0.s../" $(seq 1 $1 ));
}

scp-to-int1()
{
    sshpass -p livetv123 scp -r $1 developer@bob:$SDRIVE_SCP_PATH
    sshpass -p livetv123 ssh -t developer@bob sshpass -p livetv123 scp -r $SDRIVE_SCP_PATH/$1 siluser@int-mlb:$CLAUDIO_PATH 
    sshpass -p livetv123 ssh -t developer@bob sshpass -p livetv123 ssh -t siluser@int-mlb sshpass -p livetv123 scp -r $CLAUDIO_PATH/$1 siluser@172.16.36.122:$CLAUDIO_PATH
}
