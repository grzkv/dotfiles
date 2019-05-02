#!/usr/bin/env bash

err () {
    printf "\\n>>> ERROR: %s\\n" "$@" >&2
}

apps=(zsh git wget curl glances nnn tmux net-tools zsh-syntax-highlighting tldr tig ripgrep shellcheck icdiff peco sxiv scrot vim neovim firefox thunderbird golang-go jq zathura)
add_ppas ()
{
    sudo -E apt-get -y install curl apt-transport-https ca-certificates gnupg-agent software-properties-common || { err "failed to install packs required to securely install PPAs"; return; }

    sudo -E add-apt-repository -y ppa:mozillateam/firefox-next || err "failed to add firefox PPA"
    sudo -E add-apt-repository -y ppa:neovim-ppa/unstable || err "failed to add neovim PPA"
    sudo -E add-apt-repository -y ppa:jonathonf/vim || err "failed to add vim PPA"
    if curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo -E apt-key add -
    then
        sudo -E add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" || err "failed to add docker PPA"
    fi

    sudo -E add-apt-repository -y ppa:longsleep/golang-backports || err "failed to add golang PPA"

    sudo -E apt-get -y --allow-unauthenticated update
}
add_ppas

install_apps () {
    for a in "${apps[@]}"; do
        sudo -E apt-get -y install "$a" || err "installing $a failed"
    done
    sudo -E apt-get -y install docker-ce docker-ce-cli containerd.io || err "Installing docker failed"
}
install_apps

install_fzf () {
    [ -d ~/.fzf ] || { git clone --depth 2 'https://github.com/junegunn/fzf.git' ~/.fzf || { err "cloning fzf repo failed"; return; } }
    ~/.fzf/install
}
install_fzf

install_jump ()
{
    tmpdir=$(mktemp -d)
    trap "rm -rf $tmpdir" EXIT
    wget -O "$tmpdir/jump.deb" 'https://github.com/gsamokovarov/jump/releases/download/v0.22.0/jump_0.22.0_amd64.deb' || { err "getting jump failed"; return; }
    sudo -E dpkg -i "$tmpdir/jump.deb" || err "installing jump failed"
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
    [ -d ~/dotfiles ] || { git clone https://github.com/grzkv/dotfiles ~/dotfiles || { err "while cloning dotfiles"; return; } }

    ln -sf ~/dotfiles/.vimrc ~/.vimrc || err "could not symlink vimrc"
    ln -sf ~/dotfiles/.zshrc ~/.zshrc || err "could not symlink zshrc"
    ln -sf ~/dotfiles/.gitconfig ~/.gitconfig || err "could not symlink gitconfig"
    ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf || err "could not symlink tmux.conf"
    mkdir -p ~/.config
    mkdir -p ~/.config/nvim
    ln -sf ~/dotfiles/.config/nvim/init.vim ~/.config/nvim/init.vim || err "could not symlink init.vim"
}
setup_dotfiles

# SWITCH SHELLS
chsh -s "$(command -v zsh)"

setup_zsh_highlighting () {
    if [ ! -d ~/.zsh/zsh-syntax-highlighting ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting || err "cloning zsh highlighting repo"
    fi
}

install_plug ()
{
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim || { err "getting vim-plug"; return; }
    vim +PlugInstall +qall || err "installing vim plugins"
}
install_plug
