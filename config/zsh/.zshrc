export LANG=en_US.UTF-8
export EDITOR='vim'
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='vim'
# fi

source ~/.dotfiles/.dotfiles_env
source ~/.rubyrc
source ~/.gorc

# Correct spelling for commands
setopt correct

# Disable nomatch option
setopt +o nomatch

# load zgen
source "$HOME/.zgen/zgen.zsh"

# load oh-my-zsh and plugins
zgen oh-my-zsh
zgen oh-my-zsh plugins/autojump
zgen oh-my-zsh plugins/aws
zgen oh-my-zsh plugins/colored-man-pages
zgen oh-my-zsh plugins/docker
zgen oh-my-zsh plugins/docker-compose
zgen oh-my-zsh plugins/git
zgen oh-my-zsh plugins/gitignore
zgen oh-my-zsh plugins/jsontools
zgen oh-my-zsh plugins/sudo

# theme
zgen load romkatv/powerlevel10k powerlevel10k

# extra zsh plugins
zgen load djui/alias-tips
zgen load zsh-users/zsh-syntax-highlighting
zgen load zsh-users/zsh-history-substring-search
zgen load zsh-users/zsh-autosuggestions

# set some history options
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify
setopt INC_APPEND_HISTORY
unsetopt HIST_BEEP

# Share your history across all your terminal windows
setopt share_history

zstyle :omz:plugins:ssh-agent agent-forwarding on

# zstyle -s ':completion:*:hosts' hosts _ssh_config
# [[ -r ~/.ssh/config ]] && _ssh_config+=($(cat ~/.ssh/config | sed -ne 's/Host[=\t ]//p'))
# zstyle ':completion:*:hosts' hosts $_ssh_config

ssh_hosts=()
if [[ -r ~/.ssh/config ]]; then
  ssh_hosts=($ssh_hosts ${${${(@M)${(f)"$(cat ~/.ssh/config)"}:#Host *}#Host }:#*[*?]*})
fi
if [[ -r ~/.ssh/known_hosts ]]; then
  ssh_hosts=($ssh_hosts ${${${(f)"$(cat ~/.ssh/known_hosts{,2} || true)"}%%\ *}%%,*}) 2>/dev/null
fi
if [[ $#ssh_hosts -gt 0 ]]; then
  zstyle ':completion:*:ssh:*' hosts $ssh_hosts
  zstyle ':completion:*:scp:*' hosts $ssh_hosts
  zstyle ':completion:*:slogin:*' hosts $ssh_hosts
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Load custom aliases
source ~/.zsh-aliases

# Load ssh helpers
source ~/.ssh-helper.sh

# Load work related rc file
test -f ~/.neatrc && source ~/.neatrc
