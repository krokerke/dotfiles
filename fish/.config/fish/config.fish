# Start X at login
if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx -- -keeptty
    end
end


set normal (set_color normal)
set magenta (set_color magenta)
set yellow (set_color yellow)
set green (set_color green)
set red (set_color red)
set gray (set_color -o black)

set fish_greeting ""
set EDITOR nvim

# vi-Mode
fish_vi_key_bindings
fish_vi_cursor
set -g __fish_vi_mode 1

# Aliases
alias c="clear"
alias pacinstl="sudo pacman -S"
alias pacupd="sudo pacman -Syu"
alias sysupd="yaourt -Syua"
