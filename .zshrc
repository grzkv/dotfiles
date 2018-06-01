source ~/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle pip
antigen bundle command-not-found
antigen bundle rupa/z
antigen bundle direnv/direnv

antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme refined

antigen apply
