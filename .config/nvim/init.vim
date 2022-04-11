" syntax highlighting
syntax on

" tabs are 4 spaces, and become spaces if needed
set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4

" looks
set showcmd
set nocursorline
set wildmenu
set showmatch

"folding
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent

"serch options 
set incsearch
set nohlsearch
set ignorecase

" disable backups
set nobackup
set nowb
set noswapfile

set encoding=utf-8

" for airline
set laststatus=2
set termguicolors

" already displayed by link
set noshowmode
let g:lightline = {
    \ 'colorscheme': 'default',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'readonly', 'filename', 'modified', 'gitbranch' ] ],
    \ 'right': [ [ 'lineinfo' ],
    \            [ 'percent' ],
    \            [ 'filetype'] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head'
    \ },
    \ }

" do not change working directory when opening file (e.g. from FZF)
set noautochdir
" allow switching to a different buffer even if the current one is changed
set hidden

" clipboard
set clipboard=unnamed

" natural split position
set splitbelow
set splitright

" check if file was changed on disk after cursor moved and left still for 4
" sec
autocmd CursorHold * checktime

" shortcuts
let mapleader = ","

" leader shorts
nnoremap <Leader>x :Bdelete<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>e :Exp<CR>
nnoremap <Leader>s :e ~/.vimrc<CR>
nnoremap <Leader>h :CtrlPMRUFiles<CR>

nnoremap <Leader>i :GoInfo<CR>
nnoremap <Leader>d :GoDoc<CR>
nnoremap <Leader>b :GoBuild<CR>
nnoremap <Leader>r :GoReferrers<CR>
" nnoremap <Leader>n :bnext<CR>

" simple pane nav
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

let g:ctrlp_map = ''

" start file search with FZF
nnoremap <C-p> :FZF<CR>
nnoremap <Leader>g :Rg<CR>

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

" looks
syntax enable
set conceallevel=2
set background=light
let g:one_allow_italics = 1
" display ruler
" set colorcolumn=101

" CtrlP setup
let g:ctrlp_show_hidden = 1

" Syntastic setups
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_sh_checkers = ['ShellCheck']
let g:syntastic_check_on_wq = 0
let g:syntastic_check_on_open = 0
let g:syntastic_mode_map = { "mode": "passive",
    \ "active_filetypes": ['sh'],
    \ "passive_filetypes": [] }

" Don't open scratch window on omnicomplete
set completeopt-=preview
" Required for gocode to work
filetype plugin on

" impacts gitgutter among other things
set updatetime=500

"____________plugins__________________
call plug#begin()

Plug 'airblade/vim-gitgutter'
Plug 'kien/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' " turn fzf on for vim
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'godlygeek/tabular'
Plug 'vim-syntastic/syntastic'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'cespare/vim-toml'
Plug 'itchyny/lightline.vim'
Plug 'rakr/vim-one'
Plug 'moll/vim-bbye'
Plug 'brooth/far.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-obsession'
Plug 'mcchrish/nnn.vim'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'subnut/nvim-ghost.nvim', {'do': ':call nvim_ghost#installer#install()'}

call plug#end()
"____________plugins__________________

colorscheme one

