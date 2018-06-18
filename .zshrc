alias l="ls -la"
alias ..="cd .."
alias ...="cd ../.."

path+=('/Users/grzkv/go/bin')
export PATH
GOPATH='/Users/grzkv/go'
export GOPATH

if [ -z "$HISTFILE" ]; then
    HISTFILE=$HOME/.zsh_history
fi
HISTSIZE=1000000
SAVEHIST=1000000
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history

PROMPT="%~ Δ "

autoload -Uz compinit
compinit

zmodload -i zsh/complist

WORDCHARS=''

unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu         # show completion menu on successive tab press
setopt complete_in_word
setopt always_to_end

# autocompletion with an arrow-key driven interface
zstyle ':completion:*:*:*:*:*' menu select

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"

zstyle '*' single-ignored show

# Automatically update PATH entries
zstyle ':completion:*' rehash true
# Keep directories and files separated
zstyle ':completion:*' list-dirs-first true

### 3rd party ###
# brew install zsh-autosuggestions
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# brew install jump
# https://github.com/gsamokovarov/jump
eval "$(jump shell)"
# brew install direnv
# https://github.com/direnv/direnv
eval "$(direnv hook zsh)"
