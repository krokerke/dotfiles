set modelines=1 " use local filesettings (settings at end of file for fold-based sections)

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

let mapleader=' '      " using space as leader
let maplocalleader='ö' " using space as localleader


" OPTIONS
" basic {{{
set shell=/usr/bin/fish " set correct shell
set timeout             " activate timeouts
set ttimeoutlen=0       " time to use keycodes
set timeoutlen=250      " time to use key after leader
" }}}
" colors/ syntax {{{
syntax enable            " enable syntax highlighting
set termguicolors        " true color support
set synmaxcol=200        " syntax highlighting till col N for better performance of singlelines (min.js,..)
set background=dark      " prefer dark background compatible colors
let base16colorspace=256 " using 256color for base16 themes
colorscheme base16-arc-maia-dark

let g:terminal_color_0  = '#202631'
let g:terminal_color_1  = '#c82829'
let g:terminal_color_2  = '#1a8a74'
let g:terminal_color_3  = '#eab700'
let g:terminal_color_4  = '#4271ae'
let g:terminal_color_5  = '#89589a'
let g:terminal_color_6  = '#718c00'
let g:terminal_color_7  = '#cdd3de'
let g:terminal_color_8  = '#c82829'
let g:terminal_color_9  = '#707880'
let g:terminal_color_10 = '#1a8a74'
let g:terminal_color_11 = '#eab700'
let g:terminal_color_12 = '#4271ae'
let g:terminal_color_13 = '#89589a'
let g:terminal_color_14 = '#718c00'
let g:terminal_color_15 = '#ffffff'
" }}}
" file / buffer {{{
filetype plugin indent on " enable filetype detection with indent and plugin
set hidden                " save hidden buffers history (undo/marks/..)
set history=200           " length of command/search history
set scrolloff=2           " start moving viewport before cursor leaves it
set scrolljump=2          " lines to scroll when cursor leaves screen
set splitright splitbelow " splits right-below instead of left-above
" }}}
" backup {{{
set noswapfile                           " deactivate swap
set nobackup writebackup backupcopy=auto " backup only on writing
set backup                               " using backup..
set backupdir=~/.config/nvim/.backup     " ..to external directory
set backupskip=~/.config/nvim/.backup/*  " check if backup exist in directory
set writebackup                          " write backup
" }}}

" working directory to current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h
" }}}
" spaces / tabs {{{
set expandtab                  " tabs are spaces
set tabstop=2                  " number of visual spaces per TAB
set softtabstop=2              " number of spaces in tab when editing
set shiftwidth=2               " number of auto-indent spaces
set smarttab                   " use shiftwidth setting for inserting tabs
set autoindent                 " match indent of new line with last line
set list                       " visible spaces and tabs
set listchars=tab:▸\ ,trail:·,eol:¬,extends:❯,precedes:❮,nbsp:·
set backspace=indent,eol,start " intuitive backspacing in insert mode"
" }}}
" ui {{{
set title                      " set title for terminal
set number relativenumber      " show hybrid line numbers
" switch between relative and normal
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber
autocmd BufNewFile  * :set relativenumber
autocmd BufReadPost * :set relativenumber
autocmd FocusLost   * :set norelativenumber
autocmd FocusGained * :set relativenumber
autocmd WinEnter    * :set relativenumber
autocmd WinLeave    * :set norelativenumber

set showcmd                    " show last command in bottom bar
set cursorline                 " hightlight current line
set visualbell                 " use visual bell (no beeping)
set ruler                      " show cursor position in statusline
set wildmenu                   " visual autocomplete for command menu
set wildmode=longest:list,full " 1st tab: show complete list, 2nd tab: complete and show select menu
set lazyredraw                 " redraw only when need to
set magic                      " special characters for regex
" }}}
" searching {{{
set showmatch              " highlight matching [{()}]
set incsearch              " search as characters are entered
set hlsearch               " highlight matches
set ignorecase             " ignore case of search (using case only with smartcase)
set smartcase              " case-sensitive search only with capital letters
runtime macros/matchit.vim " extended % :: vim standard file for switch between matches
set inccommand=split       " interactive search/replace
" }}}
" folding {{{
set foldenable        " enable folding
set foldlevelstart=10 " open most folds by default
set foldnestmax=10    " 10 nested fold max
set foldmethod=indent " fold based on indent level
" }}}
" mouse {{{
if has('mouse')
  set mouse=a
  set mousemodel=popup_setpos
  set mousehide
endif
" }}}

" PLUGINS
" manages plugins: 'junegunn/vim-plug'
call plug#begin("~/.config/nvim/plugged")

" ui {{{
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes' " vim-airline: better status line
  set laststatus=2
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_theme = 'tomorrow'
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#hunks#enabled=0
  let g:airline#extensions#branch#enabled=1
  let g:airline_symbols = {}
  let g:airline_symbols.space = "\ua0"

Plug 'vim-signature'           " vim-signature: show marks on number col
Plug 'junegunn/vim-peekaboo'   " show register in split
Plug 'Valloric/MatchTagAlways' " matchTagAlways: highlight enclosing tags
Plug 'ap/vim-css-color'        " vim-css-color: show colors in css/html/less/sass
Plug 'airblade/vim-gitgutter'  " vim-gitgutter: git gutter in file
  let g:gitgutter_map_keys = 0 " disable default mappings
  " disable realtime update (lag)
  let g:gitgutter_realtime = 0
  let g:gitgutter_eager = 0
  " switch between line and symbol marks
  let g:gitgutter_enabled = 1
  let g:gitgutter_highlight_lines = 0

Plug 'scrooloose/nerdtree'
  let g:NERDTreeHijackNetrw = 1
Plug 'hecal3/vim-leader-guide' " open help buffer for leader keymaps
Plug 'terryma/vim-smooth-scroll' " scroll smooth
  noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
  noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
  noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
  noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>
" }}}
" addons (seamless integration with existing features) {{{
Plug 'benekastah/neomake'       " async make
" BROKEN with newest neovim
" Plug 'haya14busa/incsearch.vim' " incsearch all patterns
"   map /  <plug>(incsearch-forward)
"   map ?  <plug>(incsearch-backward)
"   map g/ <plug>(incsearch-stay)
"   " :h g:incsearch#auto_nohlsearch
"   set hlsearch
"   let g:incsearch#auto_nohlsearch = 1
"   map n  <Plug>(incsearch-nohl-n)
"   map N  <Plug>(incsearch-nohl-N)
"   map *  <Plug>(incsearch-nohl-*)
"   map #  <Plug>(incsearch-nohl-#)
"   map g* <Plug>(incsearch-nohl-g*)
"   map g# <Plug>(incsearch-nohl-g#)

Plug 'rhysd/clever-f.vim' " better f/F search with highlighting and repeat with f/F
  let g:clever_f_show_prompt=1
  let g:clever_f_across_no_line = 1
Plug 'tpope/vim-abolish'  " Subvert search/replace
Plug 'tpope/vim-repeat'   " repeat via '.' for plugins
Plug 'ervandew/supertab'  " autocompletions via tab
Plug 'jiangmiao/auto-pairs' " auto-pairs: insert or delete brackes, quotes, etc.
  let g:SuperTabDefaultCompletionType = "<c-n>"
" }}}
" new features {{{
Plug 'tpope/vim-commentary'            " commenting tool
Plug 'tpope/vim-surround'              " change surrounding brackets
Plug 'tpope/vim-sleuth'                " automatically set 'shiftwidth' and 'expandtab'
Plug 'tpope/vim-eunuch'                " UNIX shell commands for vim (e.g. :Move, :Mkdir, ...)
Plug 'moll/vim-bbye'                   " buffer close
Plug 'bronson/vim-trailing-whitespace' " trailing whitespaces fix (:FixWhitespace)
" Plug 'easymotion/vim-easymotion'       " better visible motions
Plug 'junegunn/vim-easy-align'
  " vim-easy-align: alignment tool
  " Start interactive EasyAlign in visual mode (e.g. vipga)
  xmap <localleader>a <Plug>(EasyAlign)
  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap <localleader>a <Plug>(EasyAlign)
Plug 'AndrewRadev/splitjoin.vim' " oneliner to multiliner and vice versa
Plug 'mattn/emmet-vim' " emmet-vim: emmet for vim
Plug 'tpope/vim-fugitive'
" }}}
" fzf fuzzyfinder {{{
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
  " This is the default extra key bindings
  let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }
  let g:fzf_layout = { 'down': '~50%' }
  " Customize fzf colors to match your color scheme
  let g:fzf_colors =
  \ { 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }
  " file preview
  let g:fzf_files_options =
    \ '--preview "highlight -O ansi {} 2> /dev/null | head -$LINES {}"'

  let g:fzf_nvim_statusline = 0 " disable statusline overwriting

" }}}

call plug#end()


" KEYBINDINGS
" jk is escape
inoremap <silent> jk <Esc>
vnoremap <silent> jk <Esc>

" quit terminal-mode with ESC (or like inoremap <silent> jk)
tnoremap <leader><Esc> <C-\><C-n>
tnoremap <leader>jk <C-\><C-n>

" highlight last inserted text
nnoremap gV `[v`]

" Visual mode pressing * searches for the current selection forwards
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" Visual mode pressing # searches for the current selection backwards
vnoremap <silent> # :call VisualSelection('b')<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" indenting without leaving visual mode
vnoremap < <gv
vnoremap > >gv

"open current buffer in new tab
noremap tt :tab split<CR>
"

" LEADERGUIDE (see 'PLUGINS/ui')
let g:lmap = {
  \' ': ['Files', 'Files'],
  \}
let g:llmap = {}

let g:lmap.1 = {
  \'name': 'Menu: Search',
  \'f': ['Files', 'Files'],
  \'g': ['GFiles', 'GitFiles'],
  \'b': ['Buffers', 'Buffers'],
  \'w': ['Windows', 'Windows'],
  \'m': ['Marks', 'Marks'],
  \'t': ['Tags', 'Tags'],
  \'l': ['Lines', 'Lines'],
  \'c': ['Commits', 'Commits'],
  \}

let g:lmap.2 = {
  \'name': 'Menu: Git',
  \'s': ['Gstatus', 'Status'],
  \'c': ['Gcommit', 'Commit'],
  \'m': ['Gmerge', 'Merge'],
  \'u': ['Gpull', 'Pull'],
  \'p': ['Gstatus', 'Push'],
  \'w': ['Gwrite', 'Write'],
  \}


" starts leaderguide in pressing leader
call leaderGuide#register_prefix_descriptions("<Space>", "g:lmap")
nnoremap <silent> <leader> :<c-u>LeaderGuide '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>LeaderGuideVisual '<Space>'<CR>

" config for fold-based sections
" vim:foldmethod=marker:foldlevel=0
