""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              Plugin Management                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Check if vim-plug is installed.
if !filereadable(expand("~/.vim/autoload/plug.vim"))
  echo "vim-plug not installed"
  if confirm("Install?", "&Yes\n&No", 2) == 1
    echo "Installing vim-plug ..."
    execute "! curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  else
    echo "Skipping installation of vim-plug. You won't be able to use plugins."
  endif
endif

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'bronson/vim-trailing-whitespace' " Highlights trailing whitespace in red and provides :FixWhitespace to fix it.
Plug 'chriskempson/base16-vim' " Base16 for vim.
Plug 'christoomey/vim-tmux-navigator' " Seamless navigation between tmux panes and vim splits.
Plug 'ctrlpvim/ctrlp.vim' " Fuzzy file, buffer, mru, tag, etc finder.
Plug 'easymotion/vim-easymotion' " Vim motions on speed.
Plug 'haya14busa/incsearch-easymotion.vim' " Integration between incsearch.vim and vim-easymotion.
Plug 'haya14busa/incsearch.vim' " Improved incremental searching for vim.
Plug 'jiangmiao/auto-pairs' " Insert or delete brackets, parens, quotes in pair.
Plug 'junegunn/goyo.vim', { 'for': ['markdown', 'text'] } " Distraction-free writing.
Plug 'junegunn/rainbow_parentheses.vim', { 'on': 'RainbowParentheses' } " Simpler rainbow parentheses.
Plug 'mhinz/vim-signify' " Show a diff using Vim its sign column.
Plug 'mhinz/vim-startify' " The fancy start screen for vim.
Plug 'scrooloose/nerdcommenter' " Intensely orgasmic commenting.
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } " A tree explorer plugin for vim.
Plug 'sickill/vim-pasta' " Context-aware pasting.
Plug 'tpope/vim-sleuth' " Detect indent style (tabs vs. spaces).
Plug 'tpope/vim-speeddating' " Use CTRL-A/CTRL-X to increment dates, times, and more.
Plug 'tpope/vim-surround' " Quoting/parenthesizing made simple.
Plug 'tpope/vim-unimpaired' " Pairs of handy bracket mappings.
Plug 'vim-airline/vim-airline' " Lean & mean status/tabline that's light as air.
Plug 'vim-airline/vim-airline-themes' " Collection of themes for vim-airline.
Plug 'Xuyuanp/nerdtree-git-plugin' " A plugin of NERDTree showing git status.
Plug 'Yggdroot/indentLine' " Display the indention levels with thin vertical lines.

" Initialize plugin system
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 Vim Settings                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible " use vim mode, not compatible with vi
set incsearch " show match for partly typed search command
set ignorecase " ignore case when using a search pattern
set smartcase " override 'ignorecase' when pattern has upper case characters
set list " highlight whitespace chars
set listchars=tab:\|\ ,eol:¬,trail:⋅,extends:❯,precedes:❮ " highlight whitespace chars
set number " show line numbers
set lazyredraw " don't redraw while executing macros
set linebreak " set soft wrapping
set showbreak=\ \ \ ↪  " show indented arrow at beginning of soft-wrapped line
"set cursorline " highlight the screen line of the cursor
"set cursorcolumn " highlight the screen column of the cursor
"set colorcolumn=80 " highlight column 80
filetype indent on " load filetype-specific indent files
syntax enable " enable syntax highlighting
set synmaxcol=160 " speed up editing of files with long lines
set hlsearch " highlight all matches for the last used search pattern
set spelllang=en " set spellcheck language
set laststatus=2 " always show a status line
set hidden " hide buffers instead of closing them (no need to save)
set splitbelow " a new window is put below the current one
set splitright " a new window is put right of the current one
set title " show info in the terminal window title
set ttyfast " indicates a fast terminal connection to make redrawing smoother
set ruler " show cursor position below each window
set showcmd " show incomplete commands in status line
set showmode " display the current mode in the status line
set confirm " start a dialog when a command fails
set undolevels=1000 " mucho mucho undo
set showmatch " highlight matching [{()}]
set backspace=indent,eol,start " allow backspace over everything in insert mode
set tabstop=4 " number of visual spaces per tab
set softtabstop=4 " number of spaces in a tab when editing
set shiftwidth=4 " number of spaces used for each step of (auto)indent
set expandtab " use spaces instead of tabs
set smarttab " a <Tab> in an indent inserts 'shiftwidth' spaces
set autoindent " automatically set the indent of a new line
set smartindent " do clever autoindenting
set foldenable " enable folding
set foldmethod=syntax " fold based on syntax
set foldlevel=10 " folds with a level higher than this number will be closed
set history=1000 " mucho mucho command history
set wildmenu " command-line completion shows a list of matches

if has('mouse')
  set mouse=a " enable mouse support
endif

if has('clipboard')
  set clipboard=unnamed " yank to system clipboard
  if has('unnamedplus') " X11 support
    set clipboard+=unnamedplus
  endif
endif

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

if has('gui_running')
  if has('gui_gtk2') " GNU/Linux
    set guifont=Ubuntu Mono 12
  else " macOS
    set guifont=Monaco:h12
  endif
endif

" Use ; as the leader key.
let mapleader = ';'

" Saves the current cursor position, removes all trailing whitespace, and returns to the saved cursor position.
fun! <SID>StripTrailingWhitespace()
  " Do not strip whitespace if the b:noStripWhitespace variable is set.
  if exists('b:noStripWhitespace')
    return
  endif
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun

" Easy way do disable removal of trailing whitespace.
command! NoStripTrailingWhitespace let b:noStripWhitespace=1
command! StripTrailingWhitespace let b:noStripWhitespace=0

" Automatically remove trailing whitespace on write.
autocmd BufWritePre * :call <SID>StripTrailingWhitespace()

" Make the default filetype for every new file 'text'.
autocmd BufEnter * if &filetype == "" | setlocal ft=text | endif

" Do not strip trailing whitespace in plain text files.
autocmd FileType text,markdown,tex,plaintex,context let b:noStripWhitespace=1

" Automatically activate spell checking for certain file types.
autocmd FileType text,markdown,tex,plaintex,context setlocal spell spelllang=en_us

" Type w!! if you forgot to sudo.
cmap w!! w !sudo tee % >/dev/null

" Navigate by virtual lines, not physical lines.
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$
" Navigate by physical lines when used with a count, otherwise use virtual lines.
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Clear highlighted search.
noremap <space> :set hlsearch! hlsearch?<cr>

" Avoid ESC and use any 'jk' combination as a "smash escape" instead.
inoremap jk <Esc>
inoremap JK <Esc>
inoremap Jk <Esc>
inoremap jK <Esc>
inoremap kj <Esc>
inoremap KJ <Esc>
inoremap Kj <Esc>
inoremap kJ <Esc>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Plugin Settings                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim-airline
"let g:airline_theme = 'base16'
"let g:airline_powerline_fonts = 1 " Attention: Requires powerline fonts!
let g:airline#extensions#tabline#enabled = 1 " show buffers at the top if only one tab is open
let g:airline#extensions#tabline#buffer_nr_show = 1 " show buffer numbers
"let g:airline#extensions#tagbar#enabled = 0 " disable tagbar extension because of conditional loading of plugin
"let g:airline#extensions#wordcount#enabled = 1

" EasyMotion
map <Leader> <Plug>(easymotion-prefix)
let g:EasyMotion_smartcase = 1 " smartcase mode

" indentLine
let g:indentLine_char = '│'

" incsearch.vim
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" incsearch-easymotion.vim
map z/ <Plug>(incsearch-easymotion-/)
map z? <Plug>(incsearch-easymotion-?)
map zg/ <Plug>(incsearch-easymotion-stay)

" NERDTree
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeShowHidden=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" CtrlP
let g:ctrlp_show_hidden = 1
