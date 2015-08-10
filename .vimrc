" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" Bundles
Plugin 'gmarik/vundle'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-rails'
Plugin 'vim-ruby/vim-ruby'
Plugin 'kien/ctrlp.vim'
Plugin 'ervandew/supertab'
Plugin 'tpope/vim-fugitive'
Plugin 'tomtom/tcomment_vim'
Plugin 'thoughtbot/vim-rspec'
Plugin 'jgdavey/tslime.vim'
Plugin 'Lokaltog/vim-powerline'
Plugin 'rking/ag.vim'
Plugin 'slim-template/vim-slim'
Plugin 'tpope/vim-endwise'
Plugin 'Raimondi/delimitMate'
Plugin 'tpope/vim-surround'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'gorodinskiy/vim-coloresque'
Plugin 'marcweber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'pangloss/vim-javascript'
Plugin 'elzr/vim-json'

" Ember
Plugin 'dsawardekar/ember.vim'
Plugin 'nono/vim-handlebars'
Plugin 'heartsentwined/vim-emblem'

" Required for vundle
filetype plugin indent on

" Colours
Plugin 'altercation/vim-colors-solarized'
syntax enable
set background=dark
colorscheme solarized

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
"set tw=80
set noswapfile
set laststatus=2
set cursorline
set ignorecase
set smartcase
set backspace=2
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
command! Qall qall
command! W w
command! Wa wall

" Map arrow keys to void
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

let mapleader = ","
let g:rspec_command = 'call Send_to_Tmux("bundle exec rspec {spec}\n")'

" Navigation
map <Leader>p :CtrlP<cr>
map <Leader>m :Rmodel<cr>
map <Leader>av :AV<cr>

" vim-rspec mappings
map <Leader>c :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>t :call RunAllSpecs()<CR>

" vim-fugitive mappings
map <Leader>gs :Gstatus<CR>
map <Leader>gw :Gwrite<CR>
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

map <leader>gf :e Gemfile<CR>
map <leader>rf :e config/routes.rb<CR>

map  <leader>bi :!bundle install<space>
map  <leader>bu :!bundle update<space>
nmap <leader>zx :!zeus<space>
map <leader>vbi :PluginInstall<cr>
map <leader>vbu :PluginUpdate<cr>

map <leader>cts /[a-z][A-Z]/<CR>a_<ESC>l~

" Emacs-like beginning and end of line.
imap <c-e> <c-o>$
imap <c-a> <c-o>^

inoremap <c-s> <esc>:w<cr>

" Macros
let @b = 'Obinding.pry'

" Open files in current directory of file
cnoremap <expr> %% expand('%:h').'/'
map <leader>e :edit %%
map <leader>v :view %%

" Rename current file
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'))
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>n :call RenameFile()<cr>

" Requires 'jq' (brew install jq)
" Set the filetype to json and pretty print
function! s:PrettyJSON()
  %!jq .
  set filetype=json
endfunction
map <leader>pj :call <sid>PrettyJSON()<CR>

command! FindConditionals :normal /\<if\>\|\<unless\>\|\<and\>\|\<or\>\|||\|&&<cr>
autocmd BufWritePre * :%s/\s\+$//e

" Hint to keep lines short
if exists('+colorcolumn')
  set colorcolumn=80
endif
