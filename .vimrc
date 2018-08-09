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

" for airline
set laststatus=2
let g:airline_powerline_fonts = 1
set term=xterm-256color
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='jellybeans'
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_section_y=''
let g:airline_section_z='㏑%l/%L'

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
" start search via ctrlp
nnoremap <Leader>o :CtrlP<CR>
" start file search with FZF
nnoremap <Leader>s :FZF<CR>
" buffer cycle
nnoremap <Leader>n :bnext<CR>

" NERDTree
nnoremap <Leader>t :NERDTreeToggle<CR>

" settings edit
nnoremap <Leader>s :e ~/.vimrc<CR>

" window switching
nnoremap <Tab> <C-w>w

" looks
syntax enable
set conceallevel=2
set background=dark

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
let g:go_auto_sameids = 1

" Vimwiki setup
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
"____________plugins__________________
call plug#begin('~/.vim/plugged')

Plug 'pangloss/vim-javascript'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kien/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' " turn fzf on for vim
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-eunuch'
" Plug 'tpope/vim-repeat'
Plug 'fatih/vim-go'
Plug 'godlygeek/tabular'
Plug 'junegunn/goyo.vim'
Plug 'takac/vim-hardtime'
Plug 'robertmeta/nofrils'
Plug 'vim-syntastic/syntastic'
Plug 'beloglazov/vim-online-thesaurus'
Plug 'vimwiki/vimwiki'
Plug 'flazz/vim-colorschemes'
" Plug 'scrooloose/nerdtree'
" Plug 'tpope/vim-unimpaired'
" Plug 'tmux-plugins/vim-tmux', {'for': 'tmux'}

call plug#end()
"____________plugins__________________

" colo nofrils-dark
colo jellybeans 
