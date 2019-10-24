#!/bin/bash

#usually called systemanalysis.sh

# Basic system analysis script
# Installs missing tools:
# neofetch, iptables,fail2ban
# works on Arch Linux

D="-----------------------------"
D2="------"

PACKAGE=cut -d " " -f 1 # get package name not version
# package existence
NEOFETCH=sudo pacman -Q | grep neofetch | ${PACKAGE}
FAIL2BAN=sudo pacman -Q | grep fail2ban | ${PACKAGE}
IPTABLES=sudo pacman -Q | grep iptables | ${PACKAGE}
JAILS=sudo fail2ban-client status # get jail status

echo 'Basic system analysis start'
echo "$D"

# run neofetch or install then run neofetch
if [ NEOFETCH == "neofetch" ]; then
  neofetch
  echo "$D"
else
  sudo pacman -S neofetch --noconfirm
  neofetch
  echo "$D"
fi

# echo home dir
echo 'current user home directory'
echo "$HOME"

# echo uptime
echo 'uptime with statistics:'
uptime

# check boot time
echo 'system startup analysis:'
sudo systemd-analyze
echo "$D"

# free space on disk
echo 'free disk space:'
sudo df -h 
echo "$D"

# check iptables status
echo 'iptabes(ipv4) status:'
if [ IPTABLES == "iptables" ]; then
  systemctl status iptables | grep active
  echo "$D"
else
  sudo pacman -S iptables --noconfirm
  echo "enabling iptables"
  sudo systemctl start iptables
  sudo systemctl enable iptables
  sudo systemctl start ip6tables
  sudo systemctl enable ip6tables
  systemctl status iptables | grep active
  echo "$D"
fi

# check ip6tables status
echo 'ip6tables(ipv6) status'
systemctl status ip6tables | grep active
echo "$D"

# check fail2ban service and jail count or install
# then prompt user to configure
echo "checking for fail2ban service"
if [ FAIL2BAN == "fail2ban" ]; then
  sudo systemctl status fail2ban
  echo "$D"
else
  sudo pacman -S fail2ban --noconfirm
  echo "please configure fail2ban"
  echo "$D"
fi

# ping google for connectivity
echo "pinging google server"
ping -c 5 8.8.8.8
echo "$D"
