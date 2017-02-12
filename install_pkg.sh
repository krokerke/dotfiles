#!/bin/bash

INSTALL='sudo pacman -S'
AUR='yaourt -S'

# Styling
$INSTALL \
  lxappearance \
  arc-themes-solid-maia \
  vertex-maia-icon-theme &&\
cd ~/dotfiles && stow gtk-theme \
\
# Browser
$INSTALL chromium firefox \
