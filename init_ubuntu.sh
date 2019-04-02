#!/bin/bash

sudo add-apt-repository ppa:mozillateam/firefox-next
sudo add-apt-repository ppa:neovim-ppa/stable
sudo add-apt-repository ppa:jonathonf/vim

sudo apt-get update

sudo apt-get install zsh git
sudo apt-get install wget curl glances nnn tmux net-tools zsh-syntax-highlighting
sudo apt-get install firefox

# FZF
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
$HOME/.fzf/install

# DOTFILES
git clone github.com/grzkv/dotfiles $HOME/dotfiles
cd $HOME/dotfiles
make

# ZSH

# VIM
sudo apt-get install vim
sudo apt-get install nvim

chsh -s $(which zsh)
