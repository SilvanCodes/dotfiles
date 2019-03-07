#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
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