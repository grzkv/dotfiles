#!/usr/bin/env bash

add_ppas ()
{
    sudo add-apt-repository -y ppa:mozillateam/firefox-next || printf "ERROR: failed to add firefox PPA"
    sudo add-apt-repository -y ppa:neovim-ppa/stable || printf "ERROR: failed to add neovim PPA"
    sudo add-apt-repository -y ppa:jonathonf/vim || printf "ERROR: failed to add vim PPA"
    # sudo apt-get install apt-transport-https ca-certificates gnupg-agent software-properties-common
    # curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" || printf "ERROR: failed to add docker PPA"

    sudo apt-get -y update
}
add_ppas

sudo apt-get -y install zsh git wget curl glances nnn tmux net-tools zsh-syntax-highlighting tldr tig ripgrep shellcheck icdiff peco fpp vim neovim firefox thunderbird || printf "ERROR: installing packages failed"
sudo apt-get -y install docker-ce docker-ce-cli containerd.io || printf "ERROR: Installing docker failed"

install_fzf ()
{
    git clone --depth 1 'https://github.com/junegunn/fzf.git' ~/.fzf || { printf "ERROR: cloning fzf repo failed"; return; }
    ~/.fzf/install
}
install_fzf

tmpdir=$(mktemp -d)
trap rm -rf "$tmpdir"

install_jump ()
{
    wget 'https://github.com/gsamokovarov/jump/releases/download/v0.22.0/jump_0.22.0_amd64.deb' -P "$tmpdir" || { printf "ERROR: getting jump failed"; return; }
    sudo dpkg -i "$tmpdir/jump_0.22.0_amd64.deb" || printf "ERROR: installing jump failed"
}
install_jump

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

setup_dotfiles ()
{
    git clone https://github.com/grzkv/dotfiles ~/dotfiles || { printf "ERROR while cloning dotfiles"; return; }

    ln -s ~/dotfiles/.vimrc ~/.vimrc || printf "ERROR: could not symlink vimrc"
    ln -s ~/dotfiles/.zshrc ~/.zshrc || printf "ERROR: could not symlink zshrc"
    ln -s ~/dotfiles/.gitconfig ~/.gitconfig || printf "ERROR: could not symlink gitconfig"
    ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf || printf "ERROR: could not symlink tmux.conf"
}
setup_dotfiles

# SWITCH SHELLS
chsh -s "$(command -v zsh)"

# ZSH HIGHLIGHT
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

install_plug ()
{
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim || { printf "ERROR getting vim-plug"; return; }
    vim +PlugInstall +qall || printf "ERROR installing vim plugins"
}
install_plug
