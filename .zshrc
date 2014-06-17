# Show contents of directory after cd-ing into it
chpwd() {
  ls -lrthG
}

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
[[ -s "/Users/jeanvanderwalt/.rvm/scripts/rvm" ]] && source "/Users/jeanvanderwalt/.rvm/scripts/rvm"

# Sourcing of other files
source $HOME/.dotfiles/zsh/aliases
source $HOME/.dotfiles/zsh/functions
source $HOME/.dotfiles/zsh/prompt

export PATH=$PATH:bin:~/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/git/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.rvm/bin
