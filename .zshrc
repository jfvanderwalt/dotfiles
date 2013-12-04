
# Save a ton of history
HISTSIZE=20000
HISTFILE=~/.zsh_history
SAVEHIST=20000

# Disable flow control commands (keeps C-s from freezing everything)
stty start undef
stty stop undef

# Show contents of directory after cd-ing into it
chpwd() {
  ls -lrthG
}

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
