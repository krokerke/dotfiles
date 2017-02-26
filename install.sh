#!/bin/bash

INSTALL="sudo pacman -S"
PIP="sudo pip install"
AUR="yaourt -S"

# update system
sudo pacman -Syyu

# install base system for X11
$INSTALL base-devel git i3-gaps termite rofi stow ttf-hack chromium fish feh compton python python-pip zenity
$PIP i3ipc fontawesome
$AUR ttf-font-awesome
cd ~/dotfiles &&\
stow xinit
stow bash
stow termite
stow rofi
stow compton
stow i3
chsh -s /usr/bin/fish

# polybar
$AUR polybar cower-git
cd ~/dotfiles &&\
stow polybar

# theming
$INSTALL lxappearance arc-themes-maia arc-maia-icon-theme breeze-snow-cursor-theme
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

# install packages
$INSTALL \
  openssh
$INSTALL \
  ranger \
  parted \
  apvlv \
  feh \
  mpv \
  cmus \
  imagemagick \
\
# gui
$INSTALL \
  nemo \
  gparted \
  evince \
  gthumb \
  totem \
  rhythmbox \
  inkscape \
  gimp &&\
gsettings set org.nemo.desktop show-desktop-icons false &&\
$AUR \
  aseprite
