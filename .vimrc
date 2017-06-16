set encoding=utf-8
set t_Co=256 "256 colors in terminal

"Visuals
"colorscheme slate
set bg=light
highlight Normal ctermbg=15 guibg=#ffffff ctermfg=0 guifg=black
highlight Cursor guifg=white ctermfg=15 guibg=black ctermbg=0
highlight Function ctermfg=37 guifg=#00afaf
highlight String ctermfg=13 guifg=#ff00ff
highlight pythonOperator term=bold cterm=bold gui=bold ctermfg=88 guifg=#870000
highlight pythonExceptions term=bold cterm=bold gui=bold ctermfg=34 guifg=#00af00
highlight link pythonException pythonOperator

"Highlights
highlight _Spaces ctermbg=251 guibg=#c6c6c6
highlight _Tabs ctermbg=167 guibg=#d75f5f
highlight _to_do term=standout guibg=#ffff00
highlight _xxx ctermbg=Red guibg=#ff0000 guifg=#000000
"highlight _yyy ctermbg=46 guibg=#00ff00 ctermfg=0 guifg=#000000
highlight _yyy ctermbg=Green guibg=#00ff00 guifg=#000000
highlight _operators term=bold ctermfg=16 guifg=#000000
highlight cursorline ctermbg=123 guibg=#afffff
highlight Folded guibg=grey guifg=blue
autocmd BufWinEnter * syn match _Spaces /^ \+\| \+$/
autocmd BufWinEnter * syn match _Tabs /\t/
autocmd BufWinEnter * syn match _to_do /\c^.*TODO.*$/
autocmd BufWinEnter * syn match _xxx /\c^.*XXX.*$/
autocmd BufWinEnter * syn match _yyy /\c^.*YYY.*$/
"autocmd Syntax * call matchadd('_operators','\+|\\|\=')
set cursorline

"Tab options
function! SetSpaces(num)
    let &l:tabstop=a:num
    let &l:shiftwidth=a:num
    let &l:softtabstop=a:num
endfunction

command! Rosc call SetSpaces(2)

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab

"Misc options
set virtualedit=onemore
filetype plugin indent on
filetype on
filetype plugin on
set autochdir
set timeoutlen=4000

"Gui options
set showtabline=2
set guitablabel=%m\ %t
set number

"Searching settings
set ignorecase
set smartcase
set hlsearch
set incsearch

"Indent options
set nocindent

"plugin stuff
filetype plugin indent on
filetype on
filetype plugin on
set nosmartindent
set autoindent

"Mappings
map Y y$
nnoremap gp `[v`]<left>
vnoremap <leader>64e c<esc>:set paste<cr>a<c-r>=system('base64 --wrap=0', @")<cr><esc>:set nopaste<cr>`[v`]<left>
vnoremap <leader>64d c<esc>:set paste<cr>a<c-r>=system('base64 --decode --wrap=0', @")<cr><esc>:set nopaste<cr>`[v`]<left>
vnoremap <leader>xml c<esc>:set paste<cr>a<c-r>=system('xmllint --format -', @")<cr><bs><esc>:set nopaste<cr>`[v`]<left>

function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()

silent! call pathogen#infect()
