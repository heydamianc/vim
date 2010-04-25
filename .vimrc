" Filename:      vimrc
" Description:   Vim configuration file


" Misc --------------------------------------------------------------------{{{1

filetype plugin indent on

set cpoptions+=>  " Items in register separated by newline
set history=1000  " Size of command/search history
set hidden        " Allow changing buffers without saving

set spell         " Enables spell check



" Files, Backup -----------------------------------------------------------{{{1

set viminfo='1000,<1000,s100,h
"           |     |     |    |
"           |     |     |    +-- Don't restore hlsearch on startup
"           |     |     +------- Exclude registers greater than N Kb
"           |     +------------- Keep N lines for each register
"           +------------------- Keep marks for N files

set modeline modelines=5  " Use modelines within first/last 5 lines

" Get rid of filename.txt~
set nobackup
" Where to store swap files
set directory=~/.vim_backup



" Text-Formatting, Identing, Tabbing --------------------------------------{{{1

set autoindent     " Use indent from previous line
set smarttab       " Smart handling of the tab key
set expandtab      " Use spaces for tabs
set shiftround     " Round indent to multiple of shiftwidth
set shiftwidth=2   " Number of spaces for each indent
set softtabstop=2  " Number of spaces for tab key
set number         " Line numbers on
set textwidth=80   " Column width

set formatoptions-=t  " Don't auto-wrap text
set formatoptions+=corqn
"                  |||||
"                  ||||+-- Recognize numbered lists
"                  |||+--- Allow formatting of comments with 'gq'
"                  ||+---- Insert comment leader after <Enter>
"                  |+----- Insert comment leader after o/O
"                  +------ Auto-wrap comments

set backspace=indent,eol,start  " Allow backspacing over these

set nowrap     " Do not wrap lines
" set linebreak  " Break lines at a sensible place

set foldmethod=marker

" Non-text and special key characters
set listchars=tab:▸\ ,eol:¬,trail:·,extends:›,precedes:‹
let &sbr = nr2char(8618).' '  " Show ↪ at the beginning of wrapped lines
set list


" Searching, Substituting -------------------------------------------------{{{1

set incsearch    " Show search matches as you type
set ignorecase   " Ignore case when searching
set smartcase    " Override 'ignorecase' when needed
set hlsearch     " Highlight search results
set showmatch    " Show matching bracket
set matchtime=2  " (for only .2 seconds)



" Menus, Completion -------------------------------------------------------{{{1

set infercase  " Try to adjust insert completions for case
set completeopt=longest,menu,menuone
"               |       |    |
"               |       |    +-- Show popup even with one match
"               |       +------- Use popup menu with completions
"               +--------------- Insert longest completion match

set wildmenu  " Enable wildmenu for completion
set wildmode=longest:full,list:full
"            |            |
"            |            +-- List matches, complete first match
"            +--------------- Complete longest prefix, use wildmenu



" Windows, Tabs -----------------------------------------------------------{{{1

set mouse=a           " Enable the mouse for all modes
set mousehide         " Hide mouse while typing
set mousemodel=popup  " Use popup menu for right mouse button

set splitright  " When splitting vertically, split to the right
set splitbelow  " When splitting horizontally, split below

set tabpagemax=128  " Maximum number of tabs open



" Display, Messages, Terminal ---------------------------------------------{{{1

set numberwidth=1     " Make line number column as narrow as possible
set lazyredraw        " Don't redraw while executing macros
set ttyfast           " Indicates a fast terminal connection
set noerrorbells      " Error bells are annoying
set vb t_vb=0         " Very annoying, takes a couple times to tell no
set title             " Set descriptive window/terminal title
set report=0          " Always report the number of lines changed
set display=lastline  " Show as much of the last line as possible

set printoptions=paper:letter

set shortmess=aTItoO
"             ||||||
"             |||||+- Message for reading file overwrites previous
"             ||||+-- Don't prompt to overwrite file
"             |||+--- Truncate file at start if too long
"             ||+---- Disable intro message
"             |+----- Truncate messages in the middle if too long
"             +------ Shortcut for various status line options



" Statusline, Messages ----------------------------------------------------{{{1

set showcmd       " Display the command in the last line
set showmode      " Display the current mode in the last line
set ruler         " Display info on current position
set laststatus=2  " Always show status line

set statusline=%!GetStatusLine()  " Set statusline from a function



" Functions ---------------------------------------------------------------{{{1

" Places the cursor at the last position for a file
function! JumpToLastPosition()
    if line("'\"") > 0 && line("'\"") <= line("$")
        normal! g`"
    endif
endfunction

" Returns the indent level of the current line
function! GetIndent()
    return indent('.')/&sw
endfunction

" Returns the string used for the status line
function! GetStatusLine()
    let line = ''
    let line .= '%5*[%n]%* '       " Buffer number
    let line .= '%<%4*%f%*'        " Filename
    let line .= '%7*%4m%*'         " Modified flag
    let line .= '%3*%5r%*'         " Readonly flag
    let line .= '%3*%10w%* '       " Preview flag
    let line .= '%9*[%{&ff}]%* '   " File format
    let line .= "%9*[%{(&fenc!=''?&fenc:&enc)}]%* " " File encoding
    let line .= '%6*%y%* '         " File type
    let line .= '%='               " Left/right separator
    let line .= '%1*[%o] '         " Byte number
    let line .= '+%{GetIndent()} ' " Indent level
    let line .= '%l,%c%V/%L%* '    " Position line,column/total
    let line .= '%3*%P%*'          " Percentage through file
    return line
endfunction



" Plugin Settings ---------------------------------------------------------{{{1

let timestamp_format = '%a %Y-%m-%d %H:%M:%S (%z)'

" ToHTML settings
let html_use_css = 1
let html_use_encoding = 'utf-8'

let autodate_keyword_pre = 'Last Modified: '
let autodate_keyword_post = '$'
let autodate_format = timestamp_format
let autodate_lines = 10

let NERDSpaceDelims = 1
let NERDShutUp = 1

let Tlist_Exit_OnlyWindow = 1 "Think this is suppose to Exist like below
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Inc_Winwidth = 0
let Tlist_Show_One_File = 1
let Tlist_Auto_Highlight_Tag = 1
let Tlist_Auto_Update = 1
let Tlist_Highlight_Tag_On_BufEnter = 1
let Tlist_Auto_Open = 0 " let the tag list open automagically
let Tlist_Compact_Format = 1 " show small menu
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags' " location of ctags
let Tlist_Enable_Fold_Column = 0 " do show folding tree
let Tlist_Exist_OnlyWindow = 1 " if you are the last, kill yourself
let Tlist_File_Fold_Auto_Close = 1 " fold closed other trees
"let Tlist_Sort_Type = "name" " order by
let Tlist_Use_Right_Window = 1 " split to the right side of the scree

let g:netrw_dirhistmax = 0

let g:snips_author = $USER_FULLNAME

let g:showmarks_enable = 0
let g:showmarks_textlower = "\t"
let g:showmarks_textupper = "\t"
let g:showmarks_textother = "\t"

let g:GPGPreferArmor = 1
let g:GPGDefaultRecipients = [$GPG_DEFAULT_ID]

let g:utl_cfg_hdl_scm_http = 'silent !xdg-open %u'
let g:utl_cfg_hdl_scm_mailto = g:utl_cfg_hdl_scm_http
let g:utl_cfg_hdl_mt_handler = 'silent !xdg-open %p'

let g:toggle_words_dict = {'*': [
    \ ['mon', 'tues', 'wed', 'thurs', 'fri', 'sat', 'sun'],
    \ ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'],
    \ ]}

let g:SuperTabDefaultCompletionType = "<C-X><C-O>" " Pressng tab calls ctrl+X ctrl+O instead of default (ctrl+N ?)



" Autocommands ------------------------------------------------------------{{{1

augroup misc
    autocmd!
    autocmd BufReadPost * call JumpToLastPosition()
    autocmd FileChangedShell * call WarningMsg("File changed outside of vim")
augroup end

" Register module and install files as PHP for Drupal development
augroup module
    autocmd BufRead,BufNewFile *.module set filetype=php
    autocmd BufRead,BufNewFile *.install set filetype=php
augroup END

" autocmd VimEnter * exe 'NERDTree' | wincmd l "Start NERDTree on load



" Highlighting, Colors ----------------------------------------------------{{{1

syntax on  " Enable syntax highlighting

colorscheme zenburn



