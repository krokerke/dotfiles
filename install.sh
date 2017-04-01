#!/bin/bash

INSTALL="sudo pacman -S"
PIP="sudo pip install"
NPM="npm i -g"
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
stow fish
chsh -s /usr/bin/fish

# polybar
$AUR polybar cower-git playerctl-git spotify twmn-git
cd ~/dotfiles &&\
stow polybar
stow twmn

# theming
$INSTALL lxappearance arc-themes-maia arc-maia-icon-theme breeze-snow-cursor-theme
stow gtk-theme

# install editor
$INSTALL neovim fzf xsel highlight
$PIP neovim
cd ~/dotfiles &&\
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim &&\
stow nvim &&\
nvim '+:PlugInstall'

# install basic dev tools
$INSTALL tig
# javascript
$INSTALL nodejs npm &&\
# npm global packages in home
mkdir ~/.npm-global &&\
npm config set prefix '~/.npm-global' &&\
# set PATH temp (fixed in fish config)
set PATH ~/.npm-global/bin $PATH &&\
$NPM tern
# typescript
$NPM typescript
# haskell
$INSTALL stack ghc hoogle
# purescript
$NPM purescript pulp
# rust
$INSTALL rustup
# ruby
$INSTALL ruby

 install packages
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
