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


function current_branch { 
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

export UPDATE_ZSH_DAYS=7

COMPLETION_WAITING_DOTS="true"

HIST_STAMPS="dd.mm.yyyy"

# Handy keybindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^W" forward-word

plugins=(git brew bundler postgres mysql ruby zeus vi-mode wd colored-man emoji-clock nyan)

#############################################
### User configuration

export PATH="/usr/local/share/npm/bin":$PATH
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin":$PATH
export PATH="$HOME/.rbenv/bin":$PATH
export PATH="$HOME/.rbenv/shims":$PATH
export PATH="/usr/local/heroku/bin":$PATH
export PATH="/usr/local/narwhal/bin":$PATH
export MANPATH="/usr/local/man:$MANPATH"
export PATH="/Users/jean/Develop/pebble/PebbleSDK-2.4.1/bin:$PATH"
export PATH="./bin":$PATH

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim' # export EDITOR='mvim'
fi

# Preferred key bindings (vi instead of emacs)
bindkey -v
bindkey "^R" history-incremental-search-backward
# Kill the lag
export KEYTIMEOUT=1

# Remove beep from autocomplete
setopt no_beep
# cd into directory if command is the same as a directory name
setopt auto_cd

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# rbenv
eval "$(rbenv init -)"


######################################
### ALIASES

# be nice to windows users
alias dir='ls'
alias c='clear'
alias cls='clear'
# personal aliases
alias md='mkdir -p'
alias rd='rmdir'
alias l='ls -la'
alias la='ls -al'
alias ll='ls -l'
alias ls='ls -CFG'
alias lsa='ls -lah'
alias pls='sudo'
alias please='sudo'
alias touche='touch'
alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'

# dev aliases
alias v='vim'
alias b='bundle'
alias gg='git add -A .; git commit -m'
alias sync='git pull && git push'
alias gf='git fetch'
alias rk='bundle exec rake'
alias rb='bundle exec ruby'
alias rt='bundle exec rspec'
alias rg='bundle exec rake routes | grep'

# project aliases
alias anz='cd ~/code/work/anz-merchant-portal/'
alias anza='cd ~/code/work/anz-admin/'
alias anzbox='ssh jean@202.167.246.11'
alias pair='export PAIRING=1'
alias dotfiles='cd ~/code/dotfiles/'

# tmux aliases
alias ta='tmux attach -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tm='tmux show-messages'
alias tk='tmux kill-session -t'

# command aggregation aliases
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
# .*rc file changes
alias zrc="vim ~/.zshrc"
alias vrc="vim ~/.vimrc"
alias trc="vim ~/.tmux.conf"

alias delswp="find . | grep .swp | xargs rm"
alias delds="find . | grep .DS_Store | xargs rm"
alias eclock="emoji-clock"

alias cl='clear'

######################################
### Custom Shell Features

# C-z to close and open vim
foreground-vi() {
  fg %vi
}
zle -N foreground-vi
bindkey '^Z' foreground-vi

# open github for current repo
function gh {
  repo=`git remote -v | head -1 | sed "s/git@github.com://" | cut -c8-999 | sed "s/\.git .*//"`
  echo Opening Github for $repo

  open "https://github.com/$repo"
}

# push origin current_branch
function gpoc {
  echo Pushing $(current_branch)
  git push origin $(current_branch)
}

# git difftool
function gd {
  git difftool
}

# git status
function gs {
  git status
}

# pull origin current_branch
function gloc {
  echo Pulling $(current_branch)
  git pull origin $(current_branch)
}

# pull checkout branch
function gc {
  echo Checking out from $(current_branch)
  git checkout $1
}

# pull checkout new branch
function gcb {
  echo Checking out from $(current_branch)
  git checkout -b $1
}

# fetch origin current_branch
function gfoc {
echo Fetching origin/$(current_branch)
  git fetch origin $(current_branch)
}

# merge origin current_branch
function gmoc {
echo Merging origin/$(current_branch) into $(current_branch)
  git merge origin/$(current_branch)
}

# create pull request into specified branch (develop if none specified)
function gpr {
  echo Opening pull request for $(current_branch)
  repo=`git remote -v | head -1 | sed "s/git@github.com://" | cut -c8-999 | sed "s/\.git .*//"`
  branch=""
  if [ $1 ]; then
    branch="$1...$(current_branch)"
  else
    branch="develop...$(current_branch)"
  fi

  open "https://github.com/$repo/compare/$branch?expand=1"
}

# list pull requests for repo
function gprl {
  repo=`git remote -v | head -1 | sed "s/git@github.com://" | cut -c8-999 | sed "s/\.git .*//"`
  echo Opening list of pull requests for $repo
  open "https://github.com/$repo/pulls"
}

function service {
  if [ $1 ]; then
    case $1 in
      mysql)
        case $2 in
          start)
            mysql.server start
            ;;
          stop)
            mysql.server stop
            ;;
          *)
            echo "Command $2 not supported for service $1"
            exit 1
            ;;
        esac
        ;;
      postgres)
        case $2 in
          start)
            pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start
            ;;
          stop)
            pg_ctl -D /usr/local/var/postgres stop -s -m fast
            ;;
          *)
            echo "Command $2 not supported for service $1"
            exit 1
            ;;
        esac
        ;;
      redis)
        case $2 in
          start)
            redis-server /usr/local/etc/redis.conf
            ;;
          *)
            echo "Command $2 not supported for service $1"
            exit 1
            ;;
        esac
        ;;
      *)
        echo "Service $1 not supported"
        exit 1
        ;;
    esac
  else
    echo "Usage: $0 SERVICE_NAME [start|stop|restart]"
  fi
}

function sync_dotfiles {
  cp ~/.vimrc ~/code/dotfiles/
  cp ~/.tmux.conf ~/code/dotfiles/
  cp ~/.zshrc ~/code/dotfiles/
  cp ~/.gitconfig ~/code/dotfiles/
  cp ~/.gitignore ~/code/dotfiles/
  cp ~/.gitignore_global ~/code/dotfiles/
}

######################################
### ENVIRONMENT VARIABLES

# rails devise default user for railsapps composer
export ADMIN_NAME="Admin Guy"
export ADMIN_EMAIL="admin@example.com"
export ADMIN_PASSWORD="password123"

# env variables
export NODE_PATH=/usr/local/lib/node
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export GOPATH="$HOME/.goenv/bin"
export NARWHAL_ENGINE=jsc
export CAPP_BUILD=$HOME/.cappbuild
export SSL_CERT_FILE=/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt

# fish like shell highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
