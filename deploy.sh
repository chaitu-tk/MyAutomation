#!/bin/bash
set -eu
## for ubuntu
#. /etc/init.d/functions
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
cat > ~/.bashrc <<EOL
alias sc='ack -i --cc --cpp'
alias sci='ack --cc --cpp'
alias sp='ack -i --py'
alias spi='ack --py'
alias rsync_ssh='rsync -avz -e "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" --progress'
alias sai='sudo apt install'
alias sas='sudo apt search'
alias pins='pip install --user'
alias ide='ctags --sort=yes -R *; cscope -Rb'
alias run_checkpatch='git show | /lib/modules/`uname -r`/build/scripts/checkpatch.pl --strict --no-tree --no-signoff'
alias run_checkpatch_mn='git diff origin/master-bh2 | /lib/modules/`uname -r`/build/scripts/checkpatch.pl --strict --no-tree --no-signoff'
alias show_nm_logs="cat /var/log/syslog | grep -i networkmanager"
alias watch_nm_logs="tail -f /var/log/syslog | grep -i networkmanager"
alias watch_dmesg="tail -f /var/log/kern.log"
alias restart_nw="sudo service networking restart; sudo service network-manger restart"
alias watch_syslog="tail -f /var/log/syslog"
alias show_syslog="cat /var/log/syslog"
alias show_pkgs="dpkg-query -W --showformat=\'${Installed-Size;10}\t${Package}\n\' | sort -k1,1n"
alias myip='curl -4 https://ifconfig.co'
EOL
