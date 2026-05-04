# Alternative commands
alias rm="rm -f"
alias rmdir="rm -rf"
alias cp="cp -rip"
alias mv='mv -i'
alias ls="ls --color=auto"
alias ll="ls --AFlo --color=auto"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep -i --color=auto"
alias editor="emacs -nw"

# alias j=jobs
# alias m="$PAGER"

# Network Manager
alias wifi-list="nmcli device wifi list"
alias wifi-connect="nmcli device wifi connect"
alias wifi-disconnect="nmcli connection down"
alias wifi-off="nmcli radio wifi off"

# Discos
alias mount="udisksctl mount -b"
alias unmount="udisksctl unmount -b"
alias eject="udisksctl power-off -b"
alias mount-iso="udisksctl loop-setup -r -f"
alias unmount-iso="udisksctl loop-delete -b"

# Programas
#alias vifm="vifmrun"
