#!/usb/bin/env bash

sudo add-apt-repository ppa:mozillateam/firefox-next
sudo add-apt-repository ppa:neovim-ppa/stable
sudo add-apt-repository ppa:jonathonf/vim

sudo apt-get update

sudo apt-get install zsh git
sudo apt-get install wget curl glances nnn tmux net-tools zsh-syntax-highlighting tldr tig ripgrep shellcheck
sudo apt-get install vim nvim
sudo apt-get install firefox

# FZF
git clone --depth 1 'https://github.com/junegunn/fzf.git' .fzf
.fzf/install

# JUMP
wget 'https://github.com/gsamokovarov/jump/releases/download/v0.22.0/jump_0.22.0_amd64.deb'
sudo dpkg -i 'jump_0.22.0_amd64.deb'

# BUILD ST
install_st() {
    st="st-0.8.2"
    wget "https://dl.suckless.org/st/$st.tar.gz"
    tar -xzf "$st.tar.gz" -C "$st"
    cd "$st" || return
    stsolpatch="st-solarized-light-20190306-ed68fe7"
    wget "https://st.suckless.org/patches/solarized/$stsolpatch.diff"
    git apply "$stsolpatch.diff"
    sudo make clean install
    cd .. || exit 1
}

install_st

# DOTFILES
git clone github.com/grzkv/dotfiles dotfiles
cd dotfiles || echo "could not go to dotfiles dir"
make

# SWITCH SHELLS
chsh -s "$(command -v zsh)"

