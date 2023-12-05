# dotfiles and tools

[TOC]

## 1.tmux
I follow [Tmux has forever changed the way I write code](https://www.youtube.com/watch?v=DzNmUNvnB04&t=94s) video to init the tmux config. The video highlights the tmux-plugins manager which easily install a tmux theme.

First, you need to install `tpm` (Tmux Plugin Manager):
Install by `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm` and put below into `~/.tmux.conf` or `~/.config/tmux/.tmux.conf` file:

```
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
```

Then, reload by `tmux source ~/.tmux.conf` or `tmux source ~/.config/tmux/.tmux.conf`
Once you installed `tpm`, you are going to install some plugins:
1. Add new plugin to `.tmux.conf` with `set -g @plugin '...'`
2. Press **prefix + I** (capital i, as in Install) to fetch the plugin.

PS: Usually, `.tmux.conf` will locate at `~`, but it is also ok to put into `~/.config/tmux/.tmux.conf` which is easy manage in one `.config` directory.

PPS: If you would like to learn more or forget some tmux bindings, check this blog [Tmux使用手册](http://louiszhai.github.io/2017/09/30/tmux/#%E4%BC%9A%E8%AF%9D).

## 2.neovim
`neovim` is a modern vim. 

Follow [here](https://github.com/neovim/neovim/wiki/Installing-Neovim#appimage-universal-linux-package) to install on Ubuntu:

```
curl -L -o ~/.local/bin/nvim.appimage https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && sudo chmod u+x ~/.local/bin/nvim.appimage

ln -s ~/.local/bin/nvim ~/.local/bin/nvim.appimage

echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
```

After installtion, you could start configing `neovim`, there are many out-of-the-box configs. 

But let us first install fonts, because all the configs require [Nerd Font](https://www.nerdfonts.com/font-downloads). Choose one you like, I often use `FiraCode` and download it. Extract it and copy all the `*ttf` font file to `/usr/local/share/fonts/` to install the fonts. 

Then, I choose [AstroNvim](https://astronvim.com/), you could follow its official installation to install it. 

## 3.ghq
`ghq` is a tool to manage local clones of github remote repos, see its [webpage](https://github.com/x-motemen/ghq).
If you want to easily navigate to the clones, put below into `.zshrc` file:
```bash
gcd () {
    if [ -n "$1" ]; then
        dir="$(ghq list --full-path --exact "$1")"
        if [ -z "$dir" ]; then
            echo "no directories found for '$1'"
            return 1
        fi
        cd "$dir"
        return
    fi
    echo 'usage: gcd $repo'
    return 1
}
```

## 4.zoxide
`zoxide` is a smarter `cd` command. 
For macOS, install by `brew install zoxide`, for ubuntu, use the install script `curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | zsh`.

After installation, setup zoxide by adding `eval "$(zoxide init zsh)` into `~/.zshrc`. Then you could use `z` to jump to recent directory.
