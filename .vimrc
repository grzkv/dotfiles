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
" let g:airline_powerline_fonts = 1
" let g:airline#extensions#tabline#enabled = 1
" let g:airline_theme='bubblegum'
" let g:airline#extensions#tabline#left_sep = ''
" let g:airline#extensions#tabline#left_alt_sep = ''
" let g:airline#extensions#tabline#right_sep = ''
" let g:airline#extensions#tabline#right_alt_sep = ''
" let g:airline_left_sep=''
" let g:airline_right_sep=''
" let g:airline_section_y=''
" let g:airline_section_z='㏑%l/%L'
" let g:airline#extensions#whitespace#enabled = 0

" already displayed by link
set noshowmode
let g:lightline = { 'colorscheme': 'default', }

" do not change working directory when opening file (e.g. from FZF)
set noautochdir
" allow switching to a different buffer even if the current one is changed
set hidden

" clipboard
set clipboard=unnamed

" natural split position
set splitbelow
set splitright

" shortcuts
let mapleader = ","

nnoremap <Leader>x :Bdelete<CR>
nnoremap <Leader>q :q<CR>
" buffer cycle
" nnoremap <Leader>n :bnext<CR>

" netrw
nnoremap <Leader>e :Exp<CR>

" settings edit
nnoremap <Leader>s :e ~/.vimrc<CR>

" window switching
nnoremap <Tab> <C-w>w

" simple pane nav
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <Leader>i :GoInfo<CR>
nnoremap <Leader>d :GoDoc<CR>
nnoremap <Leader>b :GoBuild<CR>

let g:ctrlp_map = ''

" start file search with FZF
nnoremap <C-p> :FZF<CR>

" looks
syntax enable
set conceallevel=2
set background=light
let g:one_allow_italics = 1
" display ruler
set colorcolumn=101

" CtrlP setup
let g:ctrlp_show_hidden = 1

" Syntastic setups
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_check_on_wq = 0
let g:syntastic_check_on_open = 0
let g:syntastic_mode_map = { "mode": "passive",
    \ "active_filetypes": [],
    \ "passive_filetypes": [] }

" Go setups
let g:go_auto_sameids = 0
let g:go_snippet_engine = ""
let g:go_fmt_experimental = 1
let g:go_fmt_options = {
  \ 'gofmt': '-s',
  \ }
" let g:go_info_mode = 'gopls'

" Don't open scratch window on omnicomplete
set completeopt-=preview
" Required for gocode to work
filetype plugin on

" No autosave for the session plugin
let g:session_autosave = 'no'
let g:session_autoload = 'no'
setlocal omnifunc=go#complete#Complete

"____________plugins__________________
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'kien/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' " turn fzf on for vim
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-eunuch'
Plug 'godlygeek/tabular'
Plug 'vim-syntastic/syntastic'
Plug 'beloglazov/vim-online-thesaurus'
Plug 'vim-scripts/grep.vim'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'tpope/vim-unimpaired'
Plug 'xolox/vim-misc' " Required by vim-session
Plug 'xolox/vim-session'
Plug 'cespare/vim-toml'
Plug 'justinmk/vim-sneak'
Plug 'itchyny/lightline.vim'
Plug 'rakr/vim-one'
Plug 'fatih/vim-go'
Plug 'moll/vim-bbye'
" if has('nvim')
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"   Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
" endif
" Plug 'tpope/vim-repeat'
" Plug 'tmux-plugins/vim-tmux', {'for': 'tmux'}

call plug#end()
"____________plugins__________________

colorscheme one

" let g:deoplete#enable_at_startup = 1
" call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })
