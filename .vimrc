" Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Bundles
Bundle 'gmarik/vundle'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-rails'
Bundle 'vim-ruby/vim-ruby'
Bundle 'wincent/Command-T'
Bundle 'ervandew/supertab'
Bundle 'tpope/vim-surround'
Bundle 'tomtom/tcomment_vim'

" Snipmate
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle 'honza/vim-snippets'
Bundle "garbas/vim-snipmate"

" Required for vundle
filetype plugin indent on 

"set t_Co=256
colorscheme github

syntax on

set history=750
set relativenumber
set tabstop=2
set shiftwidth=2    
set softtabstop=2
set expandtab   
set hlsearch
set incsearch
set tw=80
set noswapfile

" Bind commands
command! Q q
command! W w

" Map arrow keys to void
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Test-running stuff via @r00k

function! RunCurrentTest()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFile()

    if match(expand('%'), '\.feature$') != -1
      call SetTestRunner("!zeus cucumber")
      exec g:bjo_test_runner g:bjo_test_file
    elseif match(expand('%'), '_spec\.rb$') != -1
      call SetTestRunner("!zeus rspec")
      exec g:bjo_test_runner g:bjo_test_file
    else
      call SetTestRunner("!ruby -Itest")
      exec g:bjo_test_runner g:bjo_test_file
    endif
  else
    exec g:bjo_test_runner g:bjo_test_file
  endif
endfunction

function! SetTestRunner(runner)
  let g:bjo_test_runner=a:runner
endfunction

function! RunCurrentLineInTest()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFileWithLine()
  end

  exec "!zeus rspec" g:bjo_test_file . ":" . g:bjo_test_file_line
endfunction

function! SetTestFile()
  let g:bjo_test_file=@%
endfunction

function! SetTestFileWithLine()
  let g:bjo_test_file=@%
  let g:bjo_test_file_line=line(".")
endfunction

" End Test-running stuff

let mapleader = ","
map <Leader>p :set paste <CR>o<esc>"]p:set nopaste<cr>
map <Leader>i mmgg=G`m<CR>
map <leader>rt :call RunCurrentTest()<CR>
map <leader>rl :call RunCurrentLineInTest()<CR>
map <Leader>h :nohlsearch<cr> 
map <Leader>gs :Gstatus<CR>
map <Leader>m :Rmodel 
