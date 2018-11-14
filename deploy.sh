#!/bin/bash
## for ubuntu
#. /etc/init.d/functions
#set -e 
myexec() {
    tput init
    echo "Executing $@"
    "$@" 2>&1 > /dev/null
    status=$?
    if [ $status -ne 0 ]; then
        echo -e "\e[31merror with \e[1m$1" >&2
	exit $status
    fi
    return $status
}

## Install Necessary packages
myexec sudo apt-get install -y vim
myexec sudo apt-get install -y vim-gtk
myexec sudo apt-get install -y exuberant-ctags
myexec sudo apt-get install -y cscope
myexec sudo apt-get install -y ack-grep
myexec sudo apt-get install -y git
myexec sudo apt-get install -y openssh-server
myexec sudo apt-get install -y vlc
myexec sudo apt-get install -y wireshark

myexec yes | sudo add-apt-repository ppa:danielrichter2007/grub-customizer
myexec sudo apt-get update
myexec sudo apt-get install grub-customizer


#setup init files
## configure vimrc
## configure alias-es in bashrc
