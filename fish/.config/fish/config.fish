# Start X at login
if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx -- -keeptty
    end
end

if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end

fundle plugin 'tuvistavie/fish-ssh-agent'

fundle init


set PATH ~/.npm-global/bin $PATH
set PATH ~/.gem/ruby/2.4.0/bin $PATH
set PATH ~/.cargo/bin $PATH

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
