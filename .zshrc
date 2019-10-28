# private parts
[ -r ~/.zshrc_private ] && source ~/.zshrc_private

alias ls="ls -G"
alias l="ls -la"
alias ..="cd .."
alias ...="cd ../.."
alias gupd="git add -A && git commit -m 'upd'"
alias vim=nvim
alias vi=nvim
alias ta='tmux a -t'

PATH=$PATH:~/go/bin:~/bin:/usr/local/go/bin
export PATH

# functions
rld() {
    echo "Re-load"
    source ~/.zshrc
}

gitupd() {
    git add -A
    git commit -m "upd"
    git push
}

dump_tmux_session() {
  local d=$'\t'
  tmux list-windows -a -F "#S${d}#W${d}#{pane_current_path}"
}

save_tmux_sessions() {
  dump_tmux_session > ~/.tmux-session
}

restore_tmux_sessions() {
  tmux start-server
  local count=0
  local dimensions="$(terminal_size)"

  while IFS=$'\t' read session_name window_name dir; do
    if [[ -d "$dir" && $window_name != "log" && $window_name != "man" ]]; then
      if session_exists "$session_name"; then
        add_window "$session_name" "$window_name" "$dir"
      else
        new_session "$session_name" "$window_name" "$dir" "$dimensions"
        count=$(( count + 1 ))
      fi
    fi
  done < ~/.tmux-session

  echo "restored $count sessions"
}

export NNN_TMPFILE="/tmp/nnn"

n() {
    nnn "$@"
    if [ -f $NNN_TMPFILE ]; then
        . $NNN_TMPFILE
        rm $NNN_TMPFILE
    fi
}

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

# prompt ###
autoload -U colors && colors
setopt promptsubst

PROMPT='%m %c $(git_prompt_info)%(?..%? )%{${fg_bold[red]}%}>%{${reset_color}%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{${fg[blue]}%}(%{${fg[blue]}%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}δ"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

# Outputs current branch info in prompt format
function git_prompt_info() {
  local ref
  if [[ "$(command git config --get customzsh.hide-status 2>/dev/null)" != "1" ]]; then
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

# Checks if working tree is dirty
function parse_git_dirty() {
  local STATUS=''
  local FLAGS
  FLAGS=('--porcelain')

  if [[ "$(command git config --get customzsh.hide-dirty)" != "1" ]]; then
    FLAGS+='--ignore-submodules=dirty'
    STATUS=$(command git status ${FLAGS} 2> /dev/null | tail -n1)
  fi

  if [[ -n $STATUS ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

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
#source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# brew install jump
# https://github.com/gsamokovarov/jump
eval "$(jump shell)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
