#!/usr/bin/env bash

#
# System
#
echo '### Change mirror servers ###'
sudo sed -i.bak -e "s%http://archive.ubuntu.com/ubuntu/%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list

echo '### Update system ###'
echo grub-pc hold | sudo dpkg --set-selections
echo ubuntu-release-upgrader-core hold | sudo dpkg --set-selections
sudo apt-get -y update
sudo apt-get -y upgrade
