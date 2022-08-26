" load plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'danielwe/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'posva/vim-vue'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'janko-m/vim-test'
Plug 'vim-scripts/matchit.zip'
Plug 'mattn/emmet-vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'machakann/vim-swap'
Plug 'ervandew/supertab'
Plug 'rust-lang/rust.vim'
Plug 'jvirtanen/vim-hcl'
Plug 'rodjek/vim-puppet'
call plug#end()

" ack.vim
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
 
" theme
" set background=dark
let g:airline#extensions#ale#enabled = 1

highlight ALEWarning ctermbg=53 guibg=plum4
highlight ALEError ctermbg=52 guibg=pink4

let g:ale_set_highlights = 1
let g:ale_sign_warning = 'W➤'
let g:ale_sign_error = 'E➤'

let g:airline_powerline_fonts = 1
let base16colorspace=256
set t_Co=256
set termguicolors
" let g:solarized_termcolors=256
" let g:hybrid_use_Xresources = 1
" let g:rehash256 = 1
colorscheme base16-tomorrow-night

" settings

set mouse=a                     " use mouse features i.e. scroll, select etc
set number                      " Show line numbers
set backspace=indent,eol,start  " Makes backspace key more powerful.
set showcmd                     " Show me what I'm typing
set showmode                    " Show current mode
set noswapfile                  " Don't use swapfile
set nobackup	    	        " Don't create annoying backup files
set nowritebackup
set splitright                  " Split vertical windows right to the current windows
set splitbelow                  " Split horizontal windows below to the current windows
set autowrite                   " Automatically save before :next, :make etc.
set autoread                    " Automatically reread changed files without asking me anything
set laststatus=2
set hidden

set tabstop=4		        	" tabs are at proper location
set expandtab			        " don't use actual tab character
set shiftwidth=2	        	" indenting is 4 spaces
set autoindent    		        " turns it on
set smartindent  	        	" does the right thing (mostly) in programs

set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not when search pattern contains upper case characters
set ttyfast
set lazyredraw          	    " Wait to redraw

" set leader keys
let mapleader      = ' '
let maplocalleader = ' '

" lkj redraws the screen and removes any search highlighting.
" disabled as introduces a delay with l
nnoremap <silent> <leader>lkj :nohl<CR><C-l>

" Copy and Paste into clipboard
noremap <leader>y "*y
noremap <leader>p "*p

" Buffer prev/next
" nnoremap <C-x> :bnext<CR>
" nnoremap <C-z> :bprev<CR>

" Better split switching
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Fast saving
nmap <leader>w :w!<cr>

" Center the screen - doesn't work with leader as space
" nnoremap <space> zz

" Move up and down on splitted lines (on small width screens)
map <Up> gk
map <Down> gj
map k gk
map j gj

" Disable arrow keys to avoid bad habits
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Just go out in insert mode
imap jk <ESC>l

" Omnicomplete as ctrl-space
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-x><C-o>

" ALELinting
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_rust_rls_toolchain = 'stable'
noremap <leader>d :ALEGoToDefinition<CR>
noremap <leader>f :ALEFix<CR>

set omnifunc=ale#completion#OmniFunc
let g:ale_completion_autoimport = 1
let g:ale_completion_max_suggestions = 10

" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

" vim-test mappings
nmap <silent> tn :TestNearest<CR>
nmap <silent> tf :TestFile<CR>
nmap <silent> ts :TestSuite<CR>
nmap <silent> tl :TestLast<CR>
nmap <silent> tg :TestVisit<CR>

" find and search file
nnoremap <silent> <Leader><Leader> :Files<CR>
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.6, 'border': 'sharp' } }
let g:fzf_preview_window = ['right:40%', 'ctrl-/']

" search for chars in files
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --auto-hybrid-regex --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = { 'options': ['--delimiter', ':', '--nth', '4..', '--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec, 'right:50%'), a:fullscreen)
endfunction

command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

nnoremap <Leader>s :Rg<CR>
nnoremap <Leader>* :Rg <C-R><C-W><CR><CR>

" subsitute word under cursor

nnoremap <Leader>a :%s/\<<C-r><C-w>\>//g<Left><Left>

" markdown folding
let g:vim_markdown_folding_disabled = 1

" vim-go settings
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_highlight_diagnostic_errors = 0
let g:go_highlight_diagnostic_warnings = 0

" emmet
let g:user_emmet_leader_key='<C-Z>'

augroup FiletypeGroup
    autocmd!
    au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END

" markdown-preview
"let g:instant_markdown_slow = 1
"let g:instant_markdown_autostart = 0
"let g:instant_markdown_open_to_the_world = 1
"let g:instant_markdown_allow_unsafe_content = 1
"let g:instant_markdown_allow_external_content = 0
"let g:instant_markdown_mathjax = 1
"let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
"let g:instant_markdown_autoscroll = 0
"let g:instant_markdown_port = 8888
"let g:instant_markdown_python = 1
