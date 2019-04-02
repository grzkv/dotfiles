#!/bin/bash

sudo add-apt-repository ppa:mozillateam/firefox-next
sudo add-apt-repository ppa:neovim-ppa/stable
udo add-apt-repository ppa:jonathonf/vim

sudo apt-get update

sudo apt-get install zsh
sudo apt-get install wget curl glances nnn
sudo apt-get install firefox

# VIM
sudo apt-get install vim
sudo apt-get install nvim

chsh -s $(which zsh)
