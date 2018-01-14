# dtfls
Experimental dotfiles repo.

Does not install any binaries, simply downloads dotfiles to `~/.dotfiles` and symlinks them.

All plugin managers like `[vim-plug](https://github.com/junegunn/vim-plug)`, `[zplug](https://github.com/zplug/zplug)`, and `[tpm](https://github.com/tmux-plugins/tpm)` are self-installing (i.e. simply start `vim`, `zsh`, or `tmux` and they will install on first run).

Dependencies are `curl` and `git`.

Install with:

    bash -c "$(curl -fsSL https://raw.githubusercontent.com/christian-titze/dtfls/master/install2.sh)"
