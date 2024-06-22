"general set for plugins

filetype on
let mapleader = " "

" allow project specific vimrc file
set exrc
set secure

" plugins
call plug#begin('~/.vim/plugged')
Plug 'dense-analysis/ale'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/tagbar'
call plug#end()

nnoremap <leader>t :NERDTree <CR>
nnoremap <leader>e :TagbarToggle <CR>
nnoremap <leader>f :Files <CR>
nnoremap <leader>H :History <CR>

let g:ale_linters = {'python': ['flake8']}
let g:ale_python_flake8_executable = 'flake8'
let b:ale_python_flake8_use_global = 1

colorscheme wal

"format
set fileformat=unix
set background=dark

"The indent
set autoindent
set expandtab
set smarttab
set tabstop=4
set shiftwidth=4
set softtabstop=4

"The folding
set foldmethod=syntax

"serach match
set hlsearch
set showmatch
set noincsearch

"highlight without moving cursor
nnoremap * *``
nnoremap # #``
augroup CursorPosition
  autocmd!
  autocmd BufLeave * let b:winview = winsaveview()
  autocmd BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif
augroup END

"others
set autochdir
set ruler
set showcmd
syntax on

"code folding type 'za' to fold or release the code"
set foldmethod=indent
set foldlevel=99

"easier navigation, ctrl is hard to touch
nnoremap <leader>v <C-w>v
nnoremap <leader>s <C-w>s
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l
nnoremap <leader>] <C-]>
nnoremap <leader>[ <C-T>
nnoremap <leader>n :nohl<cr>

" quicker substitute
nnoremap <leader>r :%s/\<<C-r><C-w>\>/

nnoremap <D-i> <C-n>

" quicker switching between buffers
nnoremap <leader>1 :b1<cr>
nnoremap <leader>2 :b2<cr>
nnoremap <leader>3 :b3<cr>
nnoremap <leader>4 :b4<cr>
nnoremap <leader>5 :b5<cr>
nnoremap <leader>6 :b6<cr>
nnoremap <leader>7 :b7<cr>
nnoremap <leader>8 :b8<cr>
nnoremap <leader>9 :b9<cr>
nnoremap <leader>w :bd<cr>

" for Chinese
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8

" copy with Ctrl+Shift+c in ubuntu or Ctrl+c in macOS
if has("unix")
    vnoremap <C-C> :w !xclip -i -sel c<CR><CR>
endif
if has("macunix")
    vnoremap <C-c> :w !pbcopy<CR><CR>
endif

" auto run
nnoremap <D-r> :call <SID>compile_and_run()<CR>
nnoremap <C-r> :call <SID>compile_and_run()<CR>
nnoremap <F5>  :call <SID>compile_and_run()<CR>


function! s:compile_and_run()
    exec 'w'
    if &filetype == 'c'
       exec "!echo \"[Using $(which gcc)]\"; gcc % -o %<; time ./%<"
    elseif &filetype == 'cpp'
       exec "!echo \"[Using $(which g++)]\"; g++ -g -std=c++20 % -o %<; time ./%<"
    elseif &filetype == 'cuda'
       exec "!echo \"[Using $(which nvcc)]\"; nvcc % -o %<; time ./%<"
    elseif &filetype == 'java'
       exec "! javac %; time java %<"
    elseif &filetype == 'sh'
       exec "! time bash %"
    elseif &filetype == 'python'
       exec ":! time python3 %"
    elseif &filetype == 'dot'
       exec ":! xdot %"
    elseif &filetype == 'r'
        exec "!Rscript %"
    endif
endfunction

" to create .tags automatically by ctags and use it for navigation
function! CallCtags()
    if &filetype == 'python'
       exec ":silent !ctags -f .tags *.py"
    endif
endfunction
set tags=.tags

" hybrid line number
set number relativenumber
augroup number_toggle
    au!
    au BufEnter, FocusGained, InsertLeave * set relativenumber
    au BufLeave, FocusLost, InsertEnter * set norelativenumber
augroup END


" use ctags to update tags
autocmd BufWritePost * call CallCtags()

" always search forwards
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]

" to have the background transparent with the Terminal
hi Normal ctermbg=none
hi NonText ctermbg=none

" to make the staus bar showing the current function hierarchy
set statusline=%f\ \(%l,%c%V\)\:\ %{tagbar#currenttag('[%s]\ ','','f','scoped-stl')}
