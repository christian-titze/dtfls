#!/usr/bin/env bash

DOTFILES="${HOME}/.dotfiles"
REPO="https://github.com/christian-titze/dtfls"

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

# Install vim-plug.
if [ ! -f "${HOME}/.vim/autoload/plug.vim" ]; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
  echo "vim-plug is already installed."
fi

# Symlink all configuration files.
ln -isv ${DOTFILES}/vimrc ${HOME}/.vim/vimrc
ln -isv ${DOTFILES}/zshrc ${HOME}/.zshrc
ln -isv ${DOTFILES}/tmux.conf ${HOME}/.tmux.conf

# Symlink vim configuration files for neovim.
mkdir -p ${HOME}/.config/nvim/
mkdir -p ${HOME}/.local/share/nvim/site/autoload/
mkdir -p ${HOME}/.local/share/nvim/plugged
ln -isv ${HOME}/.vim/vimrc ${HOME}/.config/nvim/init.vim
ln -isv ${HOME}/.vim/autoload/plug.vim ${HOME}/.local/share/nvim/site/autoload/plug.vim
ln -isv ${HOME}/.vim/plugged ${HOME}/.local/share/nvim/plugged

# Install vim plugins automatically.
echo "Installing vim plugins ..."
vim +PlugInstall +qall
