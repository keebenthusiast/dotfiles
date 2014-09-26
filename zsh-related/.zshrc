# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/cak/.zshrc'

autoload -Uz compinit && autoload -U colors && colors
compinit
# End of lines added by compinstall

PROMPT="%{$fg[silver]%}%m %{$fg[green]%}%1~ %{$reset_color%}%# "
