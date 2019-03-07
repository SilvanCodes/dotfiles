# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle :compinstall filename '/home/silvan/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
bindkey -v
# End of lines configured by zsh-newuser-install

alias ls='ls --color=auto'
PS1='[%n%#%m %~] '
source /usr/share/nvm/init-nvm.sh
# sublime text 3
alias subl=subl3
# autojump
alias j=autojump
# dotfile repo
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
# aura install
alias sauras='sudo aura -S'
alias saurar='sudo aura -Rs'