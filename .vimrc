let mapleader = "\<Space>"

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" Plugins
Plugin 'gmarik/vundle'
Plugin 'tmhedberg/matchit'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'kchmck/vim-coffee-script'
Plugin 'vim-ruby/vim-ruby'
Plugin 'Lokaltog/vim-powerline'
Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-endwise'
Plugin 'rking/ag.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'kien/ctrlp.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'altercation/vim-colors-solarized'
Plugin 'pbrisbin/vim-mkdir'
Plugin 'pangloss/vim-javascript'
Plugin 'elzr/vim-json'
Plugin 'rizzatti/dash.vim'

" UltiSnips
Plugin 'ervandew/supertab'
Plugin 'Valloric/youCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" Ember
Plugin 'dsawardekar/ember.vim'
Plugin 'nono/vim-handlebars'
Plugin 'heartsentwined/vim-emblem'

" Use % to jump between start/end of methods
runtime macros/matchit.vim 

" Required for Vundle
filetype plugin indent on 

" Colours
syntax enable
syntax on
set background=dark
colorscheme solarized

" Powerline
let g:Powerline_symbols = 'fancy'

" CtrlP
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_height = 30
let g:ctrlp_match_window_reversed = 0

" Vim-Rspec using Dispatch
let g:rspec_command = "Dispatch bundle exec rspec {spec}"

" Make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" Better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Set the cursor on insert mode
if $TMUX != ""
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

set hlsearch
set t_Co=256
set encoding=utf-8
set history=750
set number
set relativenumber
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set incsearch
set noswapfile
set laststatus=2
set cursorline
set ignorecase
set smartcase
set backspace=2
set winwidth=84
set winheight=8
set winminheight=8
set winheight=999
set pastetoggle=<leader>mp

" When at 3 spaces and I hit >>, go to 4, not 5.
set shiftround 

" Say no to code folding
set nofoldenable 

" Disable vi-compatibility
set nocompatible 

" Remove delay when hitting esc in insert mode
set timeoutlen=1000 ttimeoutlen=0 

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respect .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Let's be reasonable
command! Q q
command! Qall qall
command! W w
command! Wa wall

" toggle spell check with <F5>
map <F5> :setlocal spell! spelllang=en_gb<cr>
imap <F5> <ESC>:setlocal spell! spelllang=en_gb<cr>

" Emacs-like beginning and end of line.
imap <c-e> <c-o>$
imap <c-a> <c-o>^

" Easy access to the start of the line
nnoremap 0 ^

" Navigate between alternate files quickly
nnoremap <leader><leader> <C-^>

"nnoremap Y y$
"nnoremap <Leader>y "*y
"nnoremap <Leader>p "*p
"nnoremap <Leader>P "*P

" Map arrow keys to void
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Leader-; to enter command mode. No more holding shift!
nnoremap <leader>; :
vnoremap <leader>; :

" map . in visual mode
vnoremap . :norm.<cr>

" Execute macro in q
map Q @q

" Navigation
map <Leader>f :CtrlP<cr>
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
map <Leader>gc :Gcommit<CR>
map <Leader>gd :Gdiff<CR>
map <Leader>gb :Gblame<CR>

" Dispatch git push and pull
nmap <leader>gp :exec ':Dispatch git push origin ' . fugitive#head()<CR>
nmap <leader>gu :exec ':Dispatch git pull origin ' . fugitive#head()<CR>

" Dispatch bundle mappings
map <leader>bi :Dispatch bundle install<CR>
map <leader>bu :Dispatch bundle update<CR>

" Silver Searcher mappings
map <leader>a :Ag!<space>
map <leader>A :Ag! "<C-r>=expand('<cword>')<CR>"<CR>

map <Leader>i mmgg=G`m<CR>
map <Leader>h :nohlsearch<cr>

map <leader>cn :tabe ~/code/notes/coding_notes.txt<CR>
map <Leader>dj :e ~/code/notes/debugging_journal.txt<cr>

map <leader>vi :tabe ~/.vimrc<CR>
map <leader>vs :source ~/.vimrc<CR>
map <leader>gf :e Gemfile<CR>
map <leader>rf :e config/routes.rb<CR>

" Vundle mappings
map <leader>vbi :PluginInstall<cr>
map <leader>vbu :PluginUpdate<cr>

" Open files in current directory of file
cnoremap <expr> %% expand('%:h').'/'
map <leader>e :edit %%

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

" Split test for current file(:AV does not support gems and libs)
function! SplitTestFile()
  let filename = expand('%:t:r')
  let spec_extension = '_spec.rb'
  let test_extension = '_test.rb'
  if !empty(glob('**/' . filename . spec_extension))
    exec ':vs **/' . filename . spec_extension
  elseif !empty(glob('**/' . filename . test_extension))
    exec ':vs **/' . filename . test_extension
  else
    echo 'No test found for this file.'
  endif
endfunction
map <leader>st :call SplitTestFile()<CR>

" Requires 'jq' (brew install jq)
" Set the filetype to json and pretty print
function! s:PrettyJSON()
  %!jq .
  set filetype=json
endfunction
map <leader>pj :call <sid>PrettyJSON()<CR>
