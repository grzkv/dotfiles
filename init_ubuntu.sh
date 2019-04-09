#!/usr/bin/env bash

err () {
    printf "\\n>>> ERROR: %s\\n" "$@" >&2
}

add_ppas ()
{
    sudo -E add-apt-repository -y ppa:mozillateam/firefox-next || err "failed to add firefox PPA"
    sudo -E add-apt-repository -y ppa:neovim-ppa/stable || err "failed to add neovim PPA"
    sudo -E add-apt-repository -y ppa:jonathonf/vim || err "failed to add vim PPA"
    # sudo -E apt-get install apt-transport-https ca-certificates gnupg-agent software-properties-common
    # curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo -E apt-key add -
    sudo -E add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" || err "failed to add docker PPA"
    sudo -E add-apt-repository -y ppa:longsleep/golang-backports || err "failed to add golang PPA"

    sudo -E apt-get -y update
}
add_ppas

sudo -E apt-get -y install zsh git wget curl glances nnn tmux net-tools zsh-syntax-highlighting tldr tig ripgrep shellcheck icdiff peco fpp vim neovim firefox thunderbird || err "installing packages failed"
sudo -E apt-get -y install golang-go || err "while installing dev tools"
sudo -E apt-get -y install docker-ce docker-ce-cli containerd.io || err "Installing docker failed"

install_fzf ()
{
    git clone --depth 1 'https://github.com/junegunn/fzf.git' ~/.fzf || { err "cloning fzf repo failed"; return; }
    ~/.fzf/install
}
install_fzf

tmpdir=$(mktemp -d)
trap rm -rf "$tmpdir"

install_jump ()
{
    wget 'https://github.com/gsamokovarov/jump/releases/download/v0.22.0/jump_0.22.0_amd64.deb' -P "$tmpdir" || { err "getting jump failed"; return; }
    sudo -E dpkg -i "$tmpdir/jump_0.22.0_amd64.deb" || err "installing jump failed"
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
#     sudo -E make clean install
#     cd .. || exit 1
# }
# 
# install_st

setup_dotfiles ()
{
    git clone https://github.com/grzkv/dotfiles ~/dotfiles || { err "while cloning dotfiles"; return; }

    ln -s ~/dotfiles/.vimrc ~/.vimrc || err "could not symlink vimrc"
    ln -s ~/dotfiles/.zshrc ~/.zshrc || err "could not symlink zshrc"
    ln -s ~/dotfiles/.gitconfig ~/.gitconfig || err "could not symlink gitconfig"
    ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf || err "could not symlink tmux.conf"
}
setup_dotfiles

# SWITCH SHELLS
chsh -s "$(command -v zsh)"

# ZSH HIGHLIGHT
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

install_plug ()
{
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim || { err "getting vim-plug"; return; }
    vim +PlugInstall +qall || err "installing vim plugins"
}
install_plug
