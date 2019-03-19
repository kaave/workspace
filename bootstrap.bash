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

#
# install packages
#
echo '### Install dev tools ###'
sudo apt-get -y install \
  build-essential git apt-utils coreutils unzip bison \
  libssl-dev openssl zlib1g-dev openssh-server net-tools wget curl \
  inetutils-ping inetutils-telnet inotify-tools mercurial gettext \
  libncurses5-dev libperl-dev python-dev python3-dev ruby-dev \
  lua5.2 liblua5.2-dev luajit libluajit-5.1-dev libbz2-dev \
  libffi-dev libjpeg-dev libpng-dev libgif-dev libwebp-dev ffmpeg

echo '### Install Docker ###'
sudo apt-get install -y apt-transport-https ca-certificates gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose
# alternative: install specific version
# INSTALL_DOCKER_VERSION=$(apt-cache madison docker-ce | awk '{print $3}' | head -n 1)
# sudo apt-get install docker-ce=$INSTALL_DOCKER_VERSION docker-ce-cli=$INSTALL_DOCKER_VERSION containerd.io

# set permission for vagrant user
sudo gpasswd -a vagrant docker
sudo chgrp docker /var/run/docker.sock

echo '### Install utilities ###'
sudo apt-get -y install \
  bash zsh fish tree tmux figlet jq \
  tig htop direnv vim vim-gnome \
  neovim python-neovim python3-neovim

echo '### Install bat ###'
sudo curl https://github.com/sharkdp/bat/releases/download/v0.10.0/bat_0.10.0_amd64.deb \
  -o /usr/local/src/bat_0.10.0_amd64.deb -L && \
  sudo dpkg -i /usr/local/src/bat_0.10.0_amd64.deb

echo '### Install exa ###'
sudo curl https://sh.rustup.rs -sSf | sh -s -- -y
sudo curl https://github.com/ogham/exa/releases/download/v0.8.0/exa-linux-x86_64-0.8.0.zip \
  -L -o /usr/local/src/exa-linux-x86_64-0.8.0.zip && \
  sudo unzip /usr/local/src/exa-linux-x86_64-0.8.0.zip -d /usr/local/src/ && \
  sudo mv /usr/local/src/exa-linux-x86_64 /usr/local/bin/exa

echo '### Install fzf ###'
sudo curl https://github.com/junegunn/fzf-bin/releases/download/0.17.5/fzf-0.17.5-linux_amd64.tgz \
  -L -o /usr/local/src/fzf-0.17.5-linux_amd64.tgz && \
  sudo tar xfvz /usr/local/src/fzf-0.17.5-linux_amd64.tgz -C /usr/local/bin

#
# setup account configs
#
echo '### setup dotfiles ###'
git clone https://github.com/kaave/dotfiles.git
python3 ~/dotfiles/_setup.py
sudo chsh -s $(which fish) vagrant
