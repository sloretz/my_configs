" Fancy colors in the terminal
set termguicolors

" In terminal modeting escape goes to the command mode
tnoremap <Esc> <C-\><C-N>

" Navigate windows with ALT+{h,j,k,l} from any mode
" terminal mode
:tnoremap <A-h> <C-\><C-N><C-w>h
:tnoremap <A-j> <C-\><C-N><C-w>j
:tnoremap <A-k> <C-\><C-N><C-w>k
:tnoremap <A-l> <C-\><C-N><C-w>l
" Insert mode
:inoremap <A-h> <C-\><C-N><C-w>h
:inoremap <A-j> <C-\><C-N><C-w>j
:inoremap <A-k> <C-\><C-N><C-w>k
:inoremap <A-l> <C-\><C-N><C-w>l
" Normal mode
:nnoremap <A-h> <C-w>h
:nnoremap <A-j> <C-w>j
:nnoremap <A-k> <C-w>k
:nnoremap <A-l> <C-w>l

" Show line numbers
set number

" Highlight screen line of the cursor
set cursorline
" Color columns at 80 and 100 chars so I know when I've written too much
set colorcolumn=80,100

" Tabs spaces and stuff
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab

set virtualedit=onemore

set autochdir

"Searching settings
set ignorecase
set smartcase
set hlsearch
set incsearch

"Indent options
set nocindent
set nosmartindent
set autoindent

" Shift Y yanks to end of line, just like Shift D deletes
map Y y$

" EmPy highlighting
"syn include @python syntax/python.vim
function! EmPy(lang)
  if exists("b:current_syntax")
    unlet b:current_syntax
  endif
  execute "runtime! syntax/". a:lang. ".vim"

  syn keyword EmPy_Keywords False None True and as assert async await break class continue def del elif else except finally for from global if import in is lambda nonlocal not or pass raise return try while with yield end contained
  syn keyword EmPy_Builtins ArithmeticError AssertionError AttributeError BaseException BlockingIOError BrokenPipeError BufferError BytesWarning ChildProcessError ConnectionAbortedError ConnectionError ConnectionRefusedError ConnectionResetError DeprecationWarning EOFError Ellipsis EnvironmentError Exception False FileExistsError FileNotFoundError FloatingPointError FutureWarning GeneratorExit IOError ImportError ImportWarning IndentationError IndexError InterruptedError IsADirectoryError KeyError KeyboardInterrupt LookupError MemoryError ModuleNotFoundError NameError None NotADirectoryError NotImplemented NotImplementedError OSError OverflowError PendingDeprecationWarning PermissionError ProcessLookupError RecursionError ReferenceError ResourceWarning RuntimeError RuntimeWarning StopAsyncIteration StopIteration SyntaxError SyntaxWarning SystemError SystemExit TabError TimeoutError True TypeError UnboundLocalError UnicodeDecodeError UnicodeEncodeError UnicodeError UnicodeTranslateError UnicodeWarning UserWarning ValueError Warning ZeroDivisionError  abs all any ascii bin bool breakpoint bytearray bytes callable chr classmethod compile complex copyright credits delattr dict dir divmod enumerate eval exec exit filter float format frozenset getattr globals hasattr hash help hex id input int isinstance issubclass iter len license list locals map max memoryview min next object oct open ord pow print property quit range repr reversed round set setattr slice sorted staticmethod str sum super tuple type vars zip contained
  " TODO(sloretz) why this is matching all strings after an open parenthesis?, not just ones in EmPy_Line
  syn region EmPy_String start=/\z(['"]\)/ skip="\\\\\|\\\z1" end="\z1" contained keepend
  syn cluster EmPy_Python contains=EmPy_Keywords,EmPy_Builtins,EmPy_String

  syn region EmPy_Multiline matchgroup=EmPy_Operators start="@{" end="}@" contains=@EmPy_Python
  syn region EmPy_Singleline matchgroup=EmPy_Operators start="@\[" end="]@" contains=@EmPy_Python oneline
  syn region EmPy_Inline matchgroup=EmPy_Operators start="@(" end=")" skip="(.\{-})" contains=@EmPy_Python
  syn cluster EmPy_Line contains=EmPy_Multiline,EmPy_Singleline,EmPy_Inline
  syn match EmPy_Comment "@#.*$"
  syn match EmPy_NoNewline "@$" containedin=ALLBUT,@EmPy_Line,EmPy_Comment
  hi EmPy_Operators guibg=#e9e9e9 gui=bold guifg=#965a6d
  hi EmPy_Keywords guibg=#e9e9e9 gui=bold
  hi EmPy_Builtins guibg=#e9e9e9 guifg=#00a60e
  hi EmPy_String guibg=#e9e9e9 guifg=#a6007e
  hi EmPy_Comment guibg=#e9e9e9 guifg=#0095a6
  hi EmPy_Multiline guibg=#e9e9e9
  hi EmPy_Singleline guibg=#e9e9e9
  hi EmPy_Inline guibg=#e9e9e9
  hi EmPy_NoNewline guibg=#e9e9e9 gui=bold guifg=#965a6d
endfunction

" Background colors for active vs inactive windows
" https://gist.github.com/ctaylo21/c3620a945cee6fc3eb3cb0d7f57faf00
hi ActiveWindow guibg=#ffffff
hi InactiveWindow guibg=#eeeeee

" Call method on window enter
augroup WindowManagement
  autocmd!
  autocmd WinEnter * call Handle_Win_Enter()
augroup END

" Change highlight group of active/inactive windows
function! Handle_Win_Enter()
  setlocal winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
endfunction

" Don't show line numbers in :term windows
autocmd TermOpen * setlocal nonumber norelativenumber

" Kepp current directory and browsing directory sync'd
let g:netrw_keepdir = 0
" 32 columns wide
let g:netrw_winsize = -32
" Suppress the banner
let g:netrw_banner = 0
" Use the previous window to open a file
let g:netrw_browse_split = 4

" Enable mouse support
set mouse=a
