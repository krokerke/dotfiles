" == Neovim Config ==
" ===================


" shell
set shell=/usr/bin/fish
set termguicolors " true color support

" neovim specific
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1 " toggle cursor for pipe/square for insert/non-insert
set inccommand=split

let g:terminal_color_0 = '#1e272f'
let g:terminal_color_8 = '#4d4d4c'
let g:terminal_color_1 = '#c82829'
let g:terminal_color_9 = '#c82829'
let g:terminal_color_2 = '#1a8a74'
let g:terminal_color_10 = '#1a8a74'
let g:terminal_color_3 = '#eab700'
let g:terminal_color_11 = '#eab700'
let g:terminal_color_4 = '#4271ae'
let g:terminal_color_12 = '#4271ae'
let g:terminal_color_5 = '#8959a8'
let g:terminal_color_13 = '#8959a8'
let g:terminal_color_6 = '#3e999f'
let g:terminal_color_14 = '#3e999f'
let g:terminal_color_7 = '#8e908c'
let g:terminal_color_15 = '#1d1f21'

" mapleader
let mapleader=' '      " using space
let maplocalleader=' ' " using space

" timeouts
set timeout        " activate timeouts
set ttimeoutlen=0  " time to use keycodes
set timeoutlen=250 " time to use key after leader

" colors
syntax enable     " enable syntax processing
set synmaxcol=200 " syntax highlight till col n; better performance
let base16colorspace=256
set background=dark
colorscheme tomorrow_dark

" file / buffer
filetype on           " enable filetype detection
filetype indent on    " load filetype-specific indent files
filetype plugin on    " load filetype-specific plugin files
set hidden            " save hidden buffers history (undo/marks/..)
set history=200       " length of command/search history
set scrolloff=3       " start moving viewport before cursor leaves it
set scrolljump=5      " lines to scroll when cursor leaves screen
set switchbuf=useopen " jump to first open window containing chosen buffer

" working directory to current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

" backup
set noswapfile                           " deactivate swap
set nobackup writebackup backupcopy=auto " backup only on writing

" spaces / tabs
set expandtab                                                 " tabs are spaces
set tabstop=2                                                 " number of visual spaces per TAB
set softtabstop=2                                             " number of spaces in tab when editing
set shiftwidth=2                                              " number of auto-indent spaces
set smarttab                                                  " use shiftwidth setting for inserting tabs
set autoindent                                                " match indent of new line with last line
set nolist                                                    " visible spaces and tabs
set list listchars=tab:❘-,trail:·,extends:»,precedes:«,nbsp:× " display indentations
set backspace=indent,eol,start                                " intuitive backspacing in insert mode"
runtime macros/matchit.vim                                    " extended % :: vim standard file for switch between matches

" UI
set title                      " set title for terminal
set number                     " show line numbers
set relativenumber             " show relative line numbers
set showcmd                    " show last command in bottom bar
set cursorline                 " hightlight current line
set visualbell                 " use visual bell (no beeping)
set ruler                      " show cursor position in statusline
set wildmenu                   " visual autocomplete for command menu
set wildmode=longest:list,full " 1st tab: show complete list, 2nd tab: complete and show select menu
set lazyredraw                 " redraw only when need to
set magic                      " special characters for regex

set splitright splitbelow " splits right-below instead of left-above

" searching
set showmatch  " highlight matching [{()}]
set incsearch  " search as characters are entered
set hlsearch   " highlight matches
set ignorecase " ignore case of search (using case only with smartcase)
set smartcase  " case-sensitive search only with capital letters

" folding
set foldenable        " enable folding
set foldlevelstart=10 " open most folds by default
set foldnestmax=10    " 10 nested fold max
set foldmethod=indent " fold based on indent level


" == Plugin Config ==
" ===================
" manages plugins: 'junegunn/vim-plug'
" list of plugins: http://vimawesome.com


call plug#begin("~/.config/nvim/plugged")

  " == Plugins EDITOR ==
    Plug 'Shougo/vimproc.vim', {'do' : 'make'}
      " vimproc: async execution library
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
      " vim-airline: better status line
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
    Plug 'tpope/vim-eunuch'
      " vim-eunuch: UNIX shell commands for vim (e.g. :Move, :Mkdir, ...)
    Plug 'tpope/vim-repeat'
      " vim-repeat: repeat via '.' for plugins
    Plug 'myusuf3/numbers.vim'
      " numbers: intelligent line numbers; absolute in insert-mode, relative in every else
    Plug 'francoiscabrol/ranger.vim'
    Plug 'rbgrouleff/bclose.vim'
    map <leader>f :RangerWorkingDirectory<CR>.
    " Plug 'tpope/vim-vinegar'
    " Plug 'scrooloose/nerdtree'
      " nerdtree: file explorer
      " let NERDTreeHijackNetrw=1 " using as split explorer, not project drawer
    Plug 'moll/vim-bbye'
      " vim-bbye: buffer close
    Plug 'hecal3/vim-leader-guide'
      " vim-leader-guide: open help buffer for leader keymaps
    Plug 'pelodelfuego/vim-swoop'
      " vim-swoop: find/replace across buffers
    Plug 'haya14busa/incsearch.vim'
      " incsearch: incsearch all patterns
      map /  <plug>(incsearch-forward)
      map ?  <plug>(incsearch-backward)
      map g/ <plug>(incsearch-stay)
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
      " fzf: fuzzy finder
      let g:fzf_nvim_statusline = 0 " disable statusline overwriting
      nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>
      nnoremap <silent> K :call SearchWordWithAg()<CR>
      vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>

      imap <C-x><C-f> <plug>(fzf-complete-file-ag)
      imap <C-x><C-l> <plug>(fzf-complete-line)

      function! SearchWordWithAg()
        execute 'Ag' expand('<cword>')
      endfunction

      function! SearchVisualSelectionWithAg() range
        let old_reg = getreg('"')
        let old_regtype = getregtype('"')
        let old_clipboard = &clipboard
        set clipboard&
        normal! ""gvy
        let selection = getreg('"')
        call setreg('"', old_reg, old_regtype)
        let &clipboard = old_clipboard
        execute 'Ag' selection
      endfunction
    Plug 'tpope/vim-fugitive'
      " vim-fugitive: git integration
    Plug 'airblade/vim-gitgutter'
      " vim-gitgutter: git gutter in file
      " disable realtime update (lag)
      let g:gitgutter_realtime = 0
      let g:gitgutter_eager = 0
      " switch between line and symbol marks
      let g:gitgutter_enabled = 1
      let g:gitgutter_highlight_lines = 0
    Plug 'mbbill/undotree'
      " undotree: visual undotree
      nnoremap <leader>u :UndotreeToggle<cr>
      set undodir=~/.local/share/nvim/undo/
      set undofile
      let g:undotree_WindowLayout = 4
      Plug 'majutsushi/tagbar'
        " tagbar: ctags based tag viewer
        nmap <leader>t :TagbarToggle<CR>
        let g:tagbar_type_typescript = {
          \ 'ctagstype': 'typescript',
          \ 'kinds': [
            \ 'c:classes',
            \ 'n:modules',
            \ 'f:functions',
            \ 'v:variables',
            \ 'v:varlambdas',
            \ 'm:members',
            \ 'i:interfaces',
            \ 'e:enums',
          \ ]
        \ }
    Plug 'ervandew/supertab'
      " supertab: autocompletions via tab
      let g:SuperTabDefaultCompletionType = "<c-n>"
    Plug 'vim-signature'
      " vim-signature: show marks on number col
    Plug 'benekastah/neomake'
      " neomake: async make
    Plug 'bronson/vim-trailing-whitespace'
      " vim-trailing-whitespace: trailing whitespaces fix (:FixWhitespace)
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
      " deoplete: autocompletion
      let g:deoplete#enable_at_startup = 1
      Plug 'mhartington/nvim-typescript'
      Plug 'fishbullet/deoplete-ruby'
      Plug 'php-vim/phpcd.vim'
      Plug 'sebastianmarkow/deoplete-rust'


  " == Plugins BUFFER ==
    Plug 'tpope/vim-commentary'
      " vim-commentary: commenting tool
    "Plug 'Yggdroot/indentLine'
      " indentLine: show indent guides
    Plug 'tpope/vim-speeddating'
      " vim-speeddating: better CTRL+A/X for incrementing number
    Plug 'junegunn/vim-easy-align'
      " vim-easy-align: alignment tool
      " Start interactive EasyAlign in visual mode (e.g. vipga)
      xmap <leader>ga <Plug>(EasyAlign)
      " Start interactive EasyAlign for a motion/text object (e.g. gaip)
      nmap <leader>ga <Plug>(EasyAlign)
    Plug 'tpope/vim-surround'
      " vim-surround: change surrounding brackets
    Plug 'tpope/vim-abolish'
      " vim-abolish: Subvert search/replace
    Plug 'terryma/vim-multiple-cursors'
      " vim-multiple-cursors: sublime like multi cursors
    Plug 'Valloric/MatchTagAlways'
      " matchTagAlways: highlight enclosing tags
    Plug 'gorodinskiy/vim-coloresque'
      " vim-coloresque: show colors in css/html/less/sass
    Plug 'mattn/emmet-vim'
      " emmet-vim: emmet for vim
    Plug 'jiangmiao/auto-pairs'
      " auto-pairs: insert or delete brackes, quotes, etc.


  " == Plugins LANGS ==
    Plug 'sheerun/vim-polyglot'
      " vim-polyglot: language support pack
    Plug 'Quramy/tsuquyomi'
      " tsuquyomi: typescript; additional completion, symbollinks, ...


call plug#end()


" == Keymap Config ==
" ===================

" jk is escape
inoremap <silent> jk <Esc>
vnoremap <silent> jk <Esc>
" turn of search highlight
nnoremap <silent> <leader>n :nohlsearch<CR>
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
"
"open current buffer in new tab
noremap tt :tab split<CR>

" quit terminal-mode with ESC (or like inoremap <silent> jk)
tnoremap <leader><Esc> <C-\><C-n>
tnoremap <leader>jk <C-\><C-n>

" leaderguide mapping
let g:lmap = {}

let g:lmap.g = {
      \'name': 'Menu: Git',
      \'s': [':Gstatus', 'Status'],
      \'c': [':Gcommit', 'Commit'],
      \'m': [':Gmerge', 'Merge'],
      \'u': [':Gpull', 'Pull'],
      \'p': [':Gstatus', 'Push'],
      \'w': [':Gwrite', 'Write'],
      \}

let g:lmap.s = {
      \'name': 'Menu: Search',
      \'f': [':Files', 'Files'],
      \'b': [':Buffers', 'Buffers'],
      \'w': [':Windows', 'Windows'],
      \'m': [':Marks', 'Marks'],
      \'t': [':Tags', 'Tags'],
      \'l': [':Lines', 'Lines'],
      \'c': [':Commits', 'Commits'],
      \}

" starts leaderguide in pressing leader
call leaderGuide#register_prefix_descriptions("<Space>", "g:lmap")
nnoremap <silent> <leader> :<c-u>LeaderGuide '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>LeaderGuideVisual '<Space>'<CR>

