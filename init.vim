"general set for plugins
filetype on
let mapleader = " "

" plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'nvie/vim-flake8'
Plug 'Valloric/YouCompleteMe'
Plug 'skywind3000/asyncrun.vim'
call plug#end()
let g:ycm_python_binary_path = '/usr/bin/python3'
map <buffer><leader>t :NERDTree <CR>
autocmd BufWritePost *.py call Flake8()

"format
set fileformat=unix
set background=dark

"The indent
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set smarttab
set hlsearch
set incsearch
set showmatch
set number
"others
set ruler
set showcmd
syntax on
colorscheme lucius
"code folding type 'za' to fold or release the code"
set foldmethod=indent
set foldlevel=99
"auto run
nnoremap <D-r> :call <SID>compile_and_run()<CR>

augroup SPACEVIM_ASYNCRUN
    autocmd!
    " Automatically open the quickfix window
    autocmd User AsyncRunStart call asyncrun#quickfix_toggle(15, 1)
augroup END

function! s:compile_and_run()
    exec 'w'
    if &filetype == 'c'
        exec "AsyncRun! gcc % -o %<; time ./%<"
    elseif &filetype == 'cpp'
       exec "AsyncRun! g++ -std=c++11 % -o %<; time ./%<"
    elseif &filetype == 'java'
       exec "AsyncRun! javac %; time java %<"
    elseif &filetype == 'sh'
       exec "AsyncRun! time bash %"
    elseif &filetype == 'python'
       exec "AsyncRun! time python3 %"
    endif
endfunction

:au Syntax lst runtime! syntax/lst.vim

"----2015-05-17---"
set hlsearch
set incsearch
"set cursorline
"set cursorcolumn
nmap <leader>v <C-w>v
nmap <leader>s <C-w>s
nmap <leader>h <C-w>h
nmap <leader>j <C-w>j
nmap <leader>k <C-w>k
nmap <leader>l <C-w>l
nmap <leader>w <C-w>w
nmap <leader>c <C-w>c
nmap <leader>o <C-w>o
"auto fill
:map <leader>{ a{}<Esc>i
:map <leader>[ a[]<Esc>i
:map <leader>( a()<Esc>i
"----for-Chinese-decode----"
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8

