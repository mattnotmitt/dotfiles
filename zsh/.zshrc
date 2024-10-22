source $HOME/.profile

# oh-my-zsh {{{
export ZSH=$HOME/.oh-my-zsh
plugins=(
  git
)
source $ZSH/oh-my-zsh.sh
# }}}

# zsh options {{{
setopt no_histverify
#}}}

# zplug {{{ 
source $ZPLUG_HOME/init.zsh
# Python venv
zplug "MichaelAquilina/zsh-autoswitch-virtualenv", from:github
zplug "zsh-users/zsh-syntax-highlighting", from:github
zplug "zsh-users/zsh-autosuggestions", from:github
zplug "zsh-users/zsh-completions", from:github
zplug "zsh-users/zsh-syntax-highlighting", from:github
zplug load
# }}}

# Env/Alias {{{
export EDITOR=$(which vim)
export SUDO_EDITOR=$(which vim)
export VISUAL=$(which vim)
# ls
alias eza='eza --icons'
alias ls='eza'
alias ll='eza -l'
alias lll='eza -l | less'
alias lla='eza -la'
alias llt='eza -T'
alias llfu='eza -bghHliS --git'
# }}}

# starship prompt {{{
# }}}

# tmux {{{
alias work="tmux attach -t work"
alias play="tmux attach -t play"
alias swork="tmux switch -t work"
alias splay="tmux switch -t play"
# }}}

# shell init {{{
neofetch

# fnm
eval "$(fnm env --use-on-cd --shell zsh)"

eval "$(starship init zsh)"
# }}}
