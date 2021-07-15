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
source ~/.zplug/init.zsh
# Python venv
zplug "MichaelAquilina/zsh-autoswitch-virtualenv", from:github
source =virtualenvwrapper.sh
zplug "zsh-users/zsh-syntax-highlighting", from:github
#zplug "mafredri/zsh-async", from:github
#zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
#zplug "eendroroy/alien-minimal", from:github
zplug "zsh-users/zsh-autosuggestions", from:github
zplug "zsh-users/zsh-completions", from:github
zplug "zsh-users/zsh-syntax-highlighting", from:github
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
zplug load
# }}}

# Env/Alias {{{
export EDITOR=$(which vim)
export SUDO_EDITOR=$(which vim)
export VISUAL=$(which vim)
alias reboot="graceful-shutdown --mine < ~/.config/graceful-shutdown/browsers; reboot"
alias shutdown="graceful-shutdown --mine < ~/.config/graceful-shutdown/browsers; systemctl poweroff"
# ls
alias exa='exa --icons'
alias ls='exa'
alias ll='exa -l'
alias lll='exa -l | less'
alias lla='exa -la'
alias llt='exa -T'
alias llfu='exa -bghHliS --git'
# }}}

# spaceship prompt {{{
export SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  package       # Package version
  node          # Node.js section
  ruby          # Ruby section
  elixir        # Elixir section
  xcode         # Xcode section
  swift         # Swift section
  golang        # Go section
  php           # PHP section
  rust          # Rust section
  haskell       # Haskell Stack section
  julia         # Julia section
  docker        # Docker section
  aws           # Amazon Web Services section
  venv          # virtualenv section
  conda         # conda virtualenv section
  pyenv         # Pyenv section
  dotnet        # .NET section
  ember         # Ember.js section
#  kubecontext   # Kubectl context section
  line_sep      # Line break
  battery       # Battery level and status
  vi_mode       # Vi-mode indicator
  char          # Prompt character
)
export SPACESHIP_RPROMPT_ORDER=(
  exit_code
  exec_time
  jobs
)
export SPACESHIP_CHAR_SYMBOL="$"
export SPACESHIP_CHAR_SUFFIX=" "
export SPACESHIP_PROMPT_DEFAULT_SUFFIX=" "
export SPACESHIP_PACKAGE_SYMBOL=" "
export SPACESHIP_NODE_SYMBOL=" "
export SPACESHIP_GOLANG_SYMBOL="ﳑ "
# }}}

# tmux {{{
alias work="tmux attach -t work"
alias play="tmux attach -t play"
alias swork="tmux switch -t work"
alias splay="tmux switch -t play"
# }}}

# shell init {{{
neofetch
#}}}

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

export PATH=$PATH:$HOME/.fnm
eval "$(fnm env --use-on-cd --shell=zsh)"

