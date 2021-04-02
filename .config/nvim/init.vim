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
