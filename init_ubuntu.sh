#!/usr/bin/env bash

sudo add-apt-repository ppa:mozillateam/firefox-next
sudo add-apt-repository ppa:neovim-ppa/stable
sudo add-apt-repository ppa:jonathonf/vim

sudo apt-get update

sudo apt-get install zsh git
sudo apt-get install wget curl glances nnn tmux net-tools zsh-syntax-highlighting tldr tig ripgrep shellcheck
sudo apt-get install vim neovim
sudo apt-get install firefox

mkdir ~/init

# FZF
git clone --depth 1 'https://github.com/junegunn/fzf.git' ~/.fzf
~/.fzf/install

# JUMP
wget 'https://github.com/gsamokovarov/jump/releases/download/v0.22.0/jump_0.22.0_amd64.deb' -P ~/init
sudo dpkg -i "~/init/jump_0.22.0_amd64.deb"

# BUILD ST
# install_st() {
#     st="st-0.8.2"
#     wget "https://dl.suckless.org/st/$st.tar.gz"
#     tar -xzf "$st.tar.gz" -C "$st"
#     cd "$st" || return
#     stsolpatch="st-solarized-light-20190306-ed68fe7"
#     wget "https://st.suckless.org/patches/solarized/$stsolpatch.diff"
#     git apply "$stsolpatch.diff"
#     sudo make clean install
#     cd .. || exit 1
# }
# 
# install_st

# DOTFILES
git clone https://github.com/grzkv/dotfiles ~/dotfiles
cd ~/dotfiles || echo "could not go to dotfiles dir"

[ -f ~/.vimrc ] || ln -s ~/dotfiles/.vimrc ~/.vimrc
[ -f ~/.zshrc ] || ln -s ~/dotfiles/.zshrc ~/.zshrc
[ -f ~/.gitconfig ] || ln -s ~/dotfiles/.gitconfig ~/.gitconfig
[ -f ~/.tmux.conf ] || ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf

# SWITCH SHELLS
chsh -s "$(command -v zsh)"

# ZSH HIGHLIGHT
cd ~/init
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/init/zsh-syntax-highlighting
echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

