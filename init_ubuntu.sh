#!/bin/bash

sudo add-apt-repository ppa:mozillateam/firefox-next
sudo add-apt-repository ppa:neovim-ppa/stable
sudo add-apt-repository ppa:jonathonf/vim

sudo apt-get update

sudo apt-get install zsh git
sudo apt-get install wget curl glances nnn tmux net-tools zsh-syntax-highlighting tldr tig ripgrep
sudo apt-get install vim nvim
sudo apt-get install firefox

# FZF
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
$HOME/.fzf/install

# JUMP
wget https://github.com/gsamokovarov/jump/releases/download/v0.22.0/jump_0.22.0_amd64.deb
sudo dpkg -i jump_0.22.0_amd64.deb

# BUILD ST
install_st() {
    st='st-0.8.2'
    mkdir /tmp/st
    wget "https://dl.suckless.org/st/$st.tar.gz" /tmp/st
    tar -xzf "/tmp/st/$st.tar.gz" -C "/tmp/st/$st"
    cd "/tmp/st/$st"
    stsolpatch=st-solarized-light-20190306-ed68fe7
    wget "https://st.suckless.org/patches/solarized/$stsolpatch.diff"
    git apply $stsolpatch.diff
    sudo make clean install
    cd ~
}

install_st

# DOTFILES
git clone github.com/grzkv/dotfiles $HOME/dotfiles
cd $HOME/dotfiles
make

# SWITCH SELLS
chsh -s $(which zsh)
