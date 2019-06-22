" my vim config
" this is heavily influenced by https://github.com/amix/vimrc but with
" different adaptions to better suit my workflow and likings
"
" (c) 2019 Daniel Fleischhacker <dev@dfleischhacker.de>
"

set nocompatible

" lines of history vim has to remember
set history=500

" enable filetype plugins
filetype plugin on
filetype indent on

" set leader to ,
let mapleader = ","

" :W sudo saves the file
command W w !sudo tee % > /dev/null

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Reload menu to avoid any garbled characters
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on wild menu and set up
set wildmenu
" Ignore vcs and compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
  set wildignore+=.git\*,.hg\*,.svn\*
else
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Always show current position
set ruler
set whichwrap+=<,>,h,l

" Show line numbers
set number

" Ignore case when searching but do not ignore when upper-case chars are
" searched
set ignorecase
set smartcase

" Highlight search results
set hlsearch

" Incremental search
set incsearch

" Enable magic for regex (interpret some chars literally e.g. () are not used
" for grouping)
set magic

" Highlight matching brackets when text indicator over them
set showmatch

" Disable sounds on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
if has("gui_macvim")
  autocmd GUIEnter * set vb t_vb=
endif

" show foldcolumn
set foldcolumn=1

""""""""""""""""""""""""""""""""""""
" Color and font stuff
""""""""""""""""""""""""""""""""""""
syntax enable

"set termguicolors
try
  " Highlight current line number
  set cursorline
  let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default.dark': {
  \       'override' : {
  \         'cursorlinenr_bg' : ['', '32'],
  \         'cursorlinenr_fg' : ['', '231']
  \       }
  \     }
  \   }
  \ }
  colorscheme papercolor
catch
endtry

set background=dark

" let airline populate font map
let g:airline_powerline_fonts = 1

" Remove toolbar when running in GUI
if has("gui_running")
  set guioptions-=T
  set guioptions-=e
  set t_Co=256
  set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding
set encoding=utf8

" Set Unix as default file type
set ffs=unix,dos,mac

" Try to set fonts depending on current OS
if has("mac") || has("macunix")
  set gfn=Inconsolate\ for\ Powerline:h15,Perplexed:h13,IBM\ Plex\ Mono:h13,Hack:h13,Source\ Code\ Pro:h14,Menlo:h14
elseif has("win16") || has("win32")
  set gfn=IBM\ Plex\ Mono:h14,Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
elseif has("gui_gtk2")
  set gfn=IBM\ Plex\ Mono:h14,:Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\   Mono\ 11
elseif has("linux")
  set gfn=IBM\ Plex\ Mono:h14,:Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\   Mono\ 11
elseif has("unix")
  set gfn=Monospace\ 11
endif

" Turn off backups
set nobackup
set nowb
set noswapfile

""""""""""""""""""""""""""""""""""""""""
" Text, tab, indent
""""""""""""""""""""""""""""""""""""""""
" Spaces instead of tabs, also when deleting
set expandtab
set smarttab

" 2 spaces = one tab
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

" Some indenting helps
set autoindent
set smartindent
set wrap

""""""""""""""""""""""""""""""""""""""""
" Movement
""""""""""""""""""""""""""""""""""""""""
" Additional tab navigation keys
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

" Opens a new tab with current buffer's path
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to dir of currently open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"""""""""""""""""""""""""""""""""""""""
" Some helpers
"""""""""""""""""""""""""""""""""""""""
" Remove Windows ^M
noremap <Leader>m mmHmt:%s/<C-V><cr>//gr<cr>'tzt'm

" Buffer for scribble
map <leader>q :e ~/buffer<cr>

" Markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode
map <leader>pp :setlocal paste!<cr>

