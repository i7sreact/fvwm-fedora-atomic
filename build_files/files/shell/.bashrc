#
# .bashrc - bourne shell startup file 
#

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# History File config
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
alias history='fc -l'

# Set prompt
PS1='\[\e[38;5;196m\][ \u@\h ] \[\e[38;5;69m\]{\w$(parse_git_branch)} \e[m| \[\e[38;5;226m\]\t \e[m|\n 󱞩 \[\e[38;5;40m\]\$\[\e[m\] '

# Set bashrc extras
if [ '-f ~/.bash_aliases || -f ~/.bash_functions' ]; then
  . ~/.bash_aliases
  . ~/.bash_functions
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

