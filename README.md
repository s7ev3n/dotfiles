# dotfiles and tools

[TOC]

## 1.tmux
I follow [Tmux has forever changed the way I write code](https://www.youtube.com/watch?v=DzNmUNvnB04&t=94s) video to init the tmux config, and put the `tmux.conf` at `~/.config/tmux`, NOT usually at `~/.tmux.conf`.
The video highlights the tmux-plugins manager which easily install a tmux theme.

If you would like to learn more or forget some tmux bindings, check this blog [Tmux使用手册](http://louiszhai.github.io/2017/09/30/tmux/#%E4%BC%9A%E8%AF%9D).

## 2.neovim

## 3.ghq
`ghq` is a tool to manage local clones of github remote repos, see its [webpage](https://github.com/x-motemen/ghq).
If you want to easily navigate to the clones, put below into `.zshrc` file:
```bash
ghq-cd () {
    if [ -n "$1" ]; then
        dir="$(ghq list --full-path --exact "$1")"
        if [ -z "$dir" ]; then
            echo "no directories found for '$1'"
            return 1
        fi
        cd "$dir"
        return
    fi
    echo 'usage: ghq-cd $repo'
    return 1
}
```

## 4.zoxide
`zoxide` is a smarter `cd` command. 
For macOS, install by `brew install zoxide`, for ubuntu, use the install script `curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | zsh`.

After installation, setup zoxide by adding `eval "$(zoxide init zsh)` into `~/.zshrc`. Then you could use `z` to jump to recent directory.