" Setup
" mkdir ~/.vim/undodir

" Vundle
" $ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugins
Plugin 'mileszs/ack.vim'
Plugin 'vimspell'
Plugin 'ervandew/supertab'
Plugin 'godlygeek/tabular'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'

" Syntax
Plugin 'preservim/vim-markdown'
Plugin 'msanders/cocoa.vim'
Plugin 'elzr/vim-json'
" Themes 
Plugin 'jellybeans.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

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
" Don't put two spaces after periods
set nojoinspaces
" Don't fold anything
set nofoldenable
set encoding=utf-8
set wildmenu wildmode=list:longest,full
set backspace=indent,eol,start
" always show statusline
set laststatus=2 
set nobackup
set scrolloff=4 sidescrolloff=4
set nu
set numberwidth=5

" Keep undo history between sessions
set undofile
set undodir=~/.vim/undodir

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

" Bold line numbers only
highlight CursorLineNr cterm=bold term=bold gui=bold

setlocal spell spelllang=en

" Tagbar
"let g:tagbar_left=1

" Markdown
let g:vim_markdown_toc_autofit=1
let g:vim_markdown_conceal=0
let g:vim_markdown_conceal_code_blocks=0

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
