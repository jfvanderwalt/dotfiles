# Show contents of directory after cd-ing into it
chpwd() {
  ls -lrthG
}

setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' stagedstr 'M' 
zstyle ':vcs_info:*' unstagedstr 'M' 
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' actionformats '%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats \
    '%F{5}[%F{2}%b%F{5}] %F{2}%c%F{3}%u%f'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
zstyle ':vcs_info:*' enable git 
+vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
      hook_com[unstaged]+='%F{1}??%f'
        fi  
      }

      precmd () { vcs_info }
      PROMPT='%F{5}[%F{2}%n%F{5}] %F{3}%3~ ${vcs_info_msg_0_} %f%# '

# Save a ton of history
HISTSIZE=20000
HISTFILE=~/.zsh_history
SAVEHIST=20000

# Enable completion
autoload -U compinit
compinit

# Handy keybindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^W" forward-word

# awesome cd movements from zshkit
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=5

# Disable flow control commands (keeps C-s from freezing everything)
stty start undef
stty stop undef

# RVM 
[[ -s "/Users/ben/.rvm/scripts/rvm" ]] && source "/Users/ben/.rvm/scripts/rvm"

# Sourcing of other files
source $HOME/.dotfiles/zsh/aliases
source $HOME/.dotfiles/zsh/functions

export PATH=$PATH:bin:~/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/git/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.rvm/bin
