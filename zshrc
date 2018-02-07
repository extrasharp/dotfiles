# TODO
#   from here down to prompt is a mess
#   better case insensitivity on completions

# == modules ==

autoload -Uz compinit promptinit colors
compinit
promptinit
colors

# == completion ==

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# == options ==

# setopt correct
setopt no_check_jobs
setopt csh_junkie_quotes
setopt hist_ignore_dups
setopt hist_find_no_dups

setopt no_beep
setopt append_history
setopt inc_append_history

setopt auto_pushd

SAVEHIST=250
HISTFILE=~/.zsh_history

# == keys ==

# emacs keys
bindkey -e

# bksp del
bindkey '^?'    backward-delete-char
bindkey '^[[3~' delete-char

# alt-l alt-r
bindkey '^[^[[D' beginning-of-line
bindkey '^[^[[C' end-of-line

# up down
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey '^P'   up-line-or-search
bindkey '^N'   down-line-or-search

# ctrl-l ctrl-r
bindkey '^[Oc' forward-word
bindkey '^[Od' backward-word

bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# == prompt ==

export PROMPT="%(?.oo%)/.%B%{%F{red}%}%?%)/%{%f%}%b) %B%{%F{black}%}>%{%f%}%b %{%F{magenta}%}%2~%{%f%} %B%{%F{black}%}>%{%f%}%b "

# == aliases ==

# pacman
alias inst='sudo pacman -S'
alias uninst='sudo pacman -Rs'
alias update='sudo pacman -Syu'

# X11
alias sx1='startx ~/dotfiles/_sessions/monsterwm'
alias sx2='startx ~/dotfiles/_sessions/openbox'
alias xresc='xrdb ~/.Xresources'
alias split='(urxvt &)'
alias coffee='systemd-inhibit --what=handle-lid-switch cat'
alias -g 'xeph'='-- /usr/bin/Xephyr :3' # make sure to follow with a display number

# sys
alias rm='rm -I'
alias top='htop'
alias mount='sudo mount'
alias umount='sudo umount'
alias _ls='ls -1NLv --group-directories-first --color=always'
alias ls='echo -en "\e[7m\e[32m\e[1m"; pwd; echo -en "\e[0m"; _ls'
alias ks='ls'
alias sl='ls'

alias r='ranger'
alias am='alsamixer'
alias conn='sudo netctl stop-all; sudo netctl start'

alias clrram='sudo zsh -c "free -h && sync && echo 3 > /proc/sys/vm/drop_caches && free -h"'
alias clrtmp='for i in /tmp/* ; do sudo rm -r "$i" ; done'
alias clrcoredumps='sudo rm /var/lib/systemd/coredump/*'
alias clrall='clrram; clrtmp; clrcoredumps'

alias hddsleep='sudo hdparm -Y'
alias hds='hddsleep /dev/sdb'

# chicken
alias csi='rlwrap csi -q'
alias chicken-install='sudo chicken-install'
alias chicken-uninstall='sudo chicken-uninstall'

# goto
alias @wm='cd ~/dotfiles/_wm'
alias @miri='cd ~/documents/programming/c/miri7/src'
alias @regu='cd ~/documents/programming/c/libregu/src'
alias @hive='cd ~/documents/programming/hive/desktop/src'
alias @smake='cd ~/documents/programming/scheme/smake'

# other
alias sxiv='sxiv -a'
alias umpv='~/dotfiles/_wm/scripts/umpv.py'
alias youtube-dl='youtube-dl --no-playlist'
alias mpcclip='mpc -f "%artist% %title%" | head -1 | xclip -i -selection clipboard'
alias batt='cat /sys/class/power_supply/BAT1/capacity'

# == functions ==

function screen-timeout() {
  xset -dpms
  xset s $1
}

# mkdir and cd
function md() {
  mkdir -p "$1" && cd "$1"
}

function nc-wait() {
  sudo ip addr add 192.168.10.10/16 dev enp1s0f1
  nc -l -q 1 -p 33333 | tar xvz
}

function nc-send() {
  sudo ip addr add 192.168.10.12/16 dev enp5s0
  tar cvz "$1" | nc -q 1 192.168.10.10 33333
}
