# oh-my-zsh {{{
export ZSH=/home/matt/.oh-my-zsh
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
# }}}

# spaceship prompt {{{
export SPACESHIP_CHAR_SYMBOL="$"
export SPACESHIP_CHAR_SUFFIX=" "
export SPACESHIP_PROMPT_DEFAULT_SUFFIX=""
export SPACESHIP_PACKAGE_SYMBOL=" "
export SPACESHIP_NODE_SYMBOL=" "
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

# Configure Things {{{
# added by travis gem
[ -f /home/matt/.travis/travis.sh ] && source /home/matt/.travis/travis.sh

# opam configuration
test -r /home/matt/.opam/opam-init/init.zsh && . /home/matt/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# fnm
export PATH=$HOME/.fnm:$PATH
eval `fnm env`
# colorls
source $(dirname $(gem which colorls))/tab_complete.sh
#}}}
