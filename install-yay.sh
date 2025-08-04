#!/bin/bash

sudo pacman -S --needed --noconfirm base-devel

if ! command -v yay &>/dev/null; then
  cd /tmp
  git clone https://aur.archlinux.org/yay-bin.git
  cd yay-bin
  makepkg -si --noconfirm
  cd -
  rm -rf yay-bin
  cd ~
fi

yay -S claude-code opencode-bin
