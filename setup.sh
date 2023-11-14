# exa is a modern `ls` replacement, check https://the.exa.website/ for more info
echo "install exa, a modern ls replacement"
switch (uname)
  case Darwin
    brew install exa
  case Linux
    apt install exa

alias ls='exa --grid --color auto --icons --sort=type'
alias ll='exa --long --color always --icons --sort=type'
alias la='exa --grid --all --color auto --icons --sort=type'
alias lla='exa --long --all --color auto --icons --sort=type'

echo "install bottom, prettier htop"
brew install bottom


