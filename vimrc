" load plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'chrisbra/csv.vim'
Plug 'posva/vim-vue'
call plug#end()

" theme
" set background=dark
let g:airline#extensions#ale#enabled = 1

highlight ALEWarning ctermbg=53 guibg=plum4
highlight ALEError ctermbg=52 guibg=pink4 
let g:ale_set_highlights = 1

let g:airline_powerline_fonts = 1
let base16colorspace=256
set t_Co=256
set termguicolors
" let g:solarized_termcolors=256
" let g:hybrid_use_Xresources = 1
" let g:rehash256 = 1
colorscheme base16-tomorrow-night 

" settings

set number                      " Show line numbers
set backspace=indent,eol,start  " Makes backspace key more powerful.
set showcmd                     " Show me what I'm typing
set showmode                    " Show current mode
set noswapfile                  " Don't use swapfile
set nobackup		        " Don't create annoying backup files
set nowritebackup
set splitright                  " Split vertical windows right to the current windows
set splitbelow                  " Split horizontal windows below to the current windows
set autowrite                   " Automatically save before :next, :make etc.
set autoread                    " Automatically reread changed files without asking me anything
set laststatus=2
set hidden

set tabstop=4			" tabs are at proper location
set expandtab			" don't use actual tab character
set shiftwidth=2		" indenting is 4 spaces
set autoindent    		" turns it on
set smartindent  		" does the right thing (mostly) in programs

set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not when search pattern contains upper case characters
set ttyfast
set lazyredraw          	" Wait to redraw

" lkj redraws the screen and removes any search highlighting.
nnoremap <silent> lkj :nohl<CR><C-l>

" Buffer prev/next
nnoremap <C-x> :bnext<CR>
nnoremap <C-z> :bprev<CR>

" Better split switching
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Fast saving
nmap <leader>w :w!<cr>

" Center the screen
nnoremap <space> zz

" Move up and down on splitted lines (on small width screens)
map <Up> gk
map <Down> gj
map k gk
map j gj

" Just go out in insert mode
imap jk <ESC>l

" Omnicomplete as ctrl-space
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-x><C-o>

" ALELinting
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
