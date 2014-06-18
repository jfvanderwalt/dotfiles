" Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Bundles
Bundle 'gmarik/vundle'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-rails'
Bundle 'vim-ruby/vim-ruby'
Bundle 'kien/ctrlp.vim'
Bundle 'ervandew/supertab'
Bundle 'tpope/vim-fugitive'
Bundle 'tomtom/tcomment_vim'
Bundle 'thoughtbot/vim-rspec'
Bundle 'Lokaltog/vim-powerline'
Bundle 'rking/ag.vim'
Bundle 'slim-template/vim-slim'
Bundle 'tpope/vim-endwise'

" Required for vundle
filetype plugin indent on 

" Colours
Bundle 'nanotech/jellybeans.vim'
colorscheme jellybeans

" Powerline
let g:Powerline_symbols = 'fancy'

" CtrlP
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_height = 30
let g:ctrlp_match_window_reversed = 0

if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

set t_Co=256
set encoding=utf-8
set nocompatible   " Disable vi-compatibility
set history=750
set number
set relativenumber
set tabstop=2
set shiftwidth=2    
set softtabstop=2
set expandtab   
set incsearch
set tw=80
set noswapfile
set laststatus=2
set cursorline
set ignorecase
set smartcase

set winwidth=84
set winheight=5
set winminheight=5
set winheight=999

" (Hopefully) removes the delay when hitting esc in insert mode
set noesckeys
set ttimeout
set ttimeoutlen=1

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
" Source: https://github.com/thoughtbot/dotfiles/blob/master/vimrc
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respect .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Bind commands
command! Q q
command! W w

" Map arrow keys to void
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

let mapleader = ","

" Navigation
map <Leader>p :CtrlP<cr>
map <Leader>m :Rmodel 

" vim-rspec mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" vim-fugitive mappings
map <Leader>gs :Gstatus<CR>
map <Leader>gac :Gcommit -a -m ""<LEFT>
map <Leader>gc :Gcommit -m ""<LEFT>
map <Leader>gd :Gdiff<CR>
map <Leader>gb :Gblame<CR>
nmap <leader>gp :exec ':Git push origin ' . fugitive#head()<CR>
nmap <leader>gu :exec ':Git pull origin ' . fugitive#head()<CR>

" Silver Searcher mappings
map <leader>a :Ag!<space>
map <leader>A :Ag! "<C-r>=expand('<cword>')<CR>"

map <Leader>i mmgg=G`m<CR>
map <Leader>h :nohlsearch<cr> 

map <leader>vi :tabe ~/.vimrc<CR>
map <leader>vs :source ~/.vimrc<CR>

" Emacs-like beginning and end of line.
imap <c-e> <c-o>$
imap <c-a> <c-o>^
