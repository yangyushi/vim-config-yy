"general set for plugins

filetype on
let mapleader = " "

" plugins
call plug#begin('~/.vim/plugged')
Plug 'lervag/vimtex'
Plug 'dense-analysis/ale'
Plug 'wakatime/vim-wakatime'
Plug 'scrooloose/nerdtree'
Plug 'skywind3000/asyncrun.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'jacoborus/tender.vim'
call plug#end()
let g:keysound_enable = 1
let g:keysound_theme = 'default'

map <leader>t :NERDTree <CR>

let g:ale_linters = {'python': ['flake8']}
let g:ale_python_flake8_executable = '/home/yy17363/.local/bin/flake8'
let b:ale_python_flake8_use_global = 1
let g:ycm_path_to_python_interpreter='/usr/local/bin/python3'
let g:vimtex_mappings_enabled = 1

colorscheme tender

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
set incsearch

"others
set autochdir
set ruler
set showcmd
syntax on

"code folding type 'za' to fold or release the code"
set foldmethod=indent
set foldlevel=99

"easier navigation, ctrl is hard to touch
nmap <leader>v <C-w>v
nmap <leader>s <C-w>s
nmap <leader>h <C-w>h
nmap <leader>j <C-w>j
nmap <leader>k <C-w>k
nmap <leader>l <C-w>l
nmap <leader>] <C-]>
nmap <leader>[ <C-T>
nmap <leader>n :nohl<cr>
" quicker substitute
nmap <leader>r :%s/\<<C-r><C-w>\>/


nmap <D-i> <C-n>
nmap <leader>1 :b1<cr>
nmap <leader>2 :b2<cr>
nmap <leader>3 :b3<cr>
nmap <leader>4 :b4<cr>
nmap <leader>5 :b5<cr>
nmap <leader>6 :b6<cr>
nmap <leader>7 :b7<cr>
nmap <leader>8 :b8<cr>
nmap <leader>9 :b9<cr>

nmap <leader>w :bd<cr>

" for Chinese
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8

" copy with Ctrl+Shift+c
vnoremap <C-C> :w !xclip -i -sel c<CR><CR>
" auto run
nnoremap <C-r> :call <SID>compile_and_run()<CR>
nnoremap <F5>  :call <SID>compile_and_run()<CR>
nnoremap <F6>  :call <SID>run_test()       <CR>

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
    elseif &filetype == 'r'
        exec "!Rscript %"
    elseif &filetype == 'tex'
        exec "VimtexCompile"
        exec "VimtexView"
    endif
endfunction

function! s:run_test()
    exec 'w'
    if !empty(glob("../test/test.sh"))
       exec "AsyncRun! time bash ../test/test.sh"
    elseif !empty(glob("test/test.sh"))
       exec "AsyncRun! time bash test/test.sh"
    elseif !empty(glob("test.sh"))
       exec "AsyncRun! time bash test.sh"
    endif
endfunction

:au Syntax lst runtime! syntax/lst.vim

" Auto Save Unnamed file to ~/Desktop/playground/tmp
" au BufEnter * call AnonymousPy()
function! AnonymousPy()
    " no filename, no content, ignore 0 initial default buffer
    " todo: remove unnecessary buffer when editing a existing file
    let ignore_initial = 0
    if (@% == "") && (getline(1, '$') == ['']) && bufnr('$') > ignore_initial
        let current_time = strftime('%y%m%d-%H%M%S')
        let directory = "~/Desktop/playground/tmp/"
        let temp_fn = join([directory, current_time, ".py"], '')
        let temp_cmd = join([":e ", temp_fn], '')
        exec temp_cmd
        set filetype=python
    endif
endfunction

" hybrid line number
set number relativenumber
augroup number_toggle
    au!
    au BufEnter, FocusGained, InsertLeave * set relativenumber
    au BufLeave, FocusLost, InsertEnter * set norelativenumber
augroup END

silent! py3 pass

" use ctags to update tags
autocmd BufWritePost * call system("ctags *")

let macvim_skip_colorscheme=1
