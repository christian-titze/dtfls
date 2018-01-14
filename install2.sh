#!/usr/bin/env bash

DOTFILES="${HOME}/.dotfiles"
REPO="https://github.com/christian-titze/dtfls"

# Check if git is installed.
if [ ! -x $(which git)]; then
  echo -e "The program 'git' is currently not installed, but is required to continue.\nPlease install 'git' and run this script again."
  exit 1
fi

# Check if dotfiles dir already exists.
if [[ -d "${DOTFILES}" ]]; then
  read -p "Directory ${DOTFILES} already exists, but is required to continue. Overwrite? [y/N] " -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo
    rm -rf ${DOTFILES}
  else
    echo -e "\nInstallation aborted." >&2
    exit 1
  fi
fi

# Clone into dotfiles repo.
git clone ${REPO} ${DOTFILES}

# Symlink all configuration files.
ln -isv ${DOTFILES}/vimrc ${HOME}/.vim/vimrc
ln -isv ${DOTFILES}/zshrc ${HOME}/.zshrc
ln -isv ${DOTFILES}/tmux.conf ${HOME}/.tmux.conf

# Symlink vim configuration files for new neovim dir structure.
mkdir -p ${HOME}/.config/nvim/
mkdir -p ${HOME}/.local/share/nvim/site/autoload/
mkdir -p ${HOME}/.local/share/nvim/plugged
ln -isv ${HOME}/.vim/vimrc ${HOME}/.config/nvim/init.vim
ln -isv ${HOME}/.vim/autoload/plug.vim ${HOME}/.local/share/nvim/site/autoload/plug.vim
ln -isv ${HOME}/.vim/plugged ${HOME}/.local/share/nvim/plugged
