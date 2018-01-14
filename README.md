# dtfls
Experimental dotfiles repo.

Does not install any binaries, simply downloads dotfiles to `~/.dotfiles` and symlinks them.

All plugin managers like `vim-plug`, `zplug`, and `tpm` are self-installing (i.e. just run `vim`, `zsh`, or `tmux` and they will install on first run).

Dependencies are `curl` and `git`.

Install with:

    bash -c "$(curl -fsSL https://raw.githubusercontent.com/christian-titze/dtfls/master/install2.sh)"
