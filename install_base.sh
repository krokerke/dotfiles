#!/bin/bash

UPDATE='sudo pacman -Syu'
INSTALL='sudo pacman -S'
AUR='yaourt -S'

$INSTALL lightdm lightdm-gtk-greeter termite i3-wm neovim fish &&\
	sudo nvim '+%s/\#greeter-session=\(.*\)/greeter-session=lightdm-gtk-greeter/gc' /etc/lightdm/lightdm.conf &&\
$INSTALL stow git tig fzf &&\
git clone https://github.com/krokerke/dotfiles &&\
\
sudo systemctl enable lightdm.service &&\
\
$INSTALL python python-pip xorg-xprop zenity &&\
sudo pip install fontawesome neovim i3ipc &&\
$AUR ttf-font-awesome i3blocks unclutter-xfixes-git &&\
\
cd ~/dotfiles &&\
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim &&\
stow nvim &&\
nvim '+:PlugInstall' &&\
\
stow i3 &&\
cd ~/.config/i3 &&\
wget https://gist.githubusercontent.com/justbuchanan/70fdae0d5182f6039aa8383c06a3f4ad/raw/aa82891e850dce96172135802c382caa171c2d44/util.py &&\
wget https://gist.githubusercontent.com/justbuchanan/70fdae0d5182f6039aa8383c06a3f4ad/raw/aa82891e850dce96172135802c382caa171c2d44/i3-rename-workspace.py &&\
wget wget https://gist.githubusercontent.com/justbuchanan/70fdae0d5182f6039aa8383c06a3f4ad/raw/aa82891e850dce96172135802c382caa171c2d44/i3-autoname-workspaces.py &&\
chmod +x i3-* && chmod +x util.py &&\
echo "Base System installed, please proceed: $ reboot"
