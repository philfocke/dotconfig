#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

eval "$(starship init bash)"

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

export PATH=$PATH:/home/phil/.spicetify
export PATH=$PATH:/home/$USER/chomper/bin
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$HOME/.emacs.d/bin:$PATH"

alias org="doom run -nw ~/obsidian/org/home.org "
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
