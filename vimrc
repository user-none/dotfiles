" Vundle
" $ git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

" be iMproved
set nocompatible
" required!
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Plugins
" let Vundle manage Vundle. required! 
Bundle 'gmarik/vundle'
Bundle 'mileszs/ack.vim'
Bundle 'vimspell'
Bundle 'ervandew/supertab'
Bundle 'godlygeek/tabular'
Bundle 'scrooloose/nerdtree'
Bundle 'majutsushi/tagbar'
" Syntax
Bundle 'plasticboy/vim-markdown'
Bundle 'msanders/cocoa.vim'
Bundle 'elzr/vim-json'
" Themes 
Bundle 'jellybeans.vim'

" required!
filetype plugin indent on

" My Config
syntax on
set hidden
set smartindent
set copyindent
set showcmd
set hlsearch incsearch
set smartcase
set cursorline
set colorcolumn=120
" This disables visual wrapping
set nowrap
" This turns off physical line wrapping (ie: automatic insertion of newlines)
set tw=0 wm=0
set ts=4
set sw=4
set et
set encoding=utf-8
set wildmenu wildmode=list:longest,full
set backspace=indent,eol,start
" always show statusline
set laststatus=2 
set nobackup
set scrolloff=4 sidescrolloff=4
set nu
set numberwidth=5

" Show relative line number when editing
au insertEnter * set nu!
au insertEnter * set rnu
au insertLeave * set rnu!
au insertLeave * set nu

if $TERM !~ "linux"
  set t_Co=256
endif

" Disable bell
set vb t_vb=".

set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

colorscheme jellybeans

highlight WSError ctermbg=red guibg=red
match Error /[\x7f-\xff]/

setlocal spell spelllang=en

" Tagbar
"let g:tagbar_left=1

" JSON syntax disable hiding quotes
let g:vim_json_syntax_conceal=0

" Force Lua files to expand tab properly
autocmd Filetype lua setlocal ts=4 sw=4 expandtab

" Custom functionality

" Close all buffers that aren't currently shown.
function! CloseHiddenBuffers()
    let visible = {}
    for t in range(1, tabpagenr('$'))
        for b in tabpagebuflist(t)
            let visible[b] = 1
        endfor
    endfor
    for b in range(1, bufnr('$'))
        if bufexists(b) && !has_key(visible, b)
            execute 'bwipeout' b
        endif
    endfor
endfun
command! -nargs=? Wipeout call CloseHiddenBuffers()

" Align items in a C struct.
function! DoAlignSArray() range
    silent! execute a:firstline . "," . a:lastline . 's/[ ]\+,/,/g'
    silent! execute a:firstline . "," . a:lastline . 'Tabularize /{'
    silent! execute a:firstline . "," . a:lastline . 'Tabularize /,\zs/l0l1'
    silent! execute a:firstline . "," . a:lastline . 'Tabularize /}/l1r0'
endfun
command! -range AlignSArray <line1>,<line2>call DoAlignSArray()

" Change between UPPER, lower and Title Case using ~.
function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv
