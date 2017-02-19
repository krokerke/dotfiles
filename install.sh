#!/bin/bash

INSTALL="sudo pacman -S"
PIP="sudo pip install"
AUR="yaourt -S"

# update system
sudo pacman -Syyu

# install base system for X11
$INSTALL base-devel git i3-gaps termite rofi stow ttf-hack chromium fish feh compton python python-pip zenity &&\
$PIP i3ipc fontawesome
$AUR ttf-font-awesome
git clone https://github.com/krokerke/dotfiles &&\
cd ~/dotfiles &&\
stow xinit &&\
stow bash &&\
stow termite &&\
stow rofi &&\
stow compton &&\
stow i3 &&\
chsh -s /usr/bin/fish &&\

# i3blocks
$INSTALL acpi openvpn sysstat lm_sensors
$AUR playerctl i3blocks
cd ~/dotfiles &&\
stow i3blocks &&\
cd ~/.config/i3blocks &&\
git clone https://github.com/vivien/i3blocks-contrib blocklets

# theming
$INSTALL lxappearance arc-themes-maia arc-maia-icon-theme breeze-snow-cursor-theme &&\
stow gtk-theme

# install editor
$INSTALL neovim fzf xsel 
$PIP neovim
cd ~/dotfiles &&\
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim &&\
stow nvim &&\
nvim '+:PlugInstall'

# install basic dev tools
$INSTALL tig
