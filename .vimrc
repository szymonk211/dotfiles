" no esc - stupid method I'm using swap Caps/esc now
" inoremap jk <Esc>
" inoremap kj <Esc>
" " To have stuff from .bashrc in vim a
set mouse=a
set shellcmdflag=-ic
" " I'm not using vim's crappy buffers
set clipboard=unnamedplus
" show existing tab with 4 spaces width
set expandtab
set tabstop=4
set softtabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
set number
" set scrolloff=4
" Execute 'lnoremap x X' and 'lnoremap X x' for each letter a-z.
for c in range(char2nr('A'), char2nr('Z'))
  execute 'lnoremap ' . nr2char(c+32) . ' ' . nr2char(c)
  execute 'lnoremap ' . nr2char(c) . ' ' . nr2char(c+32)
endfor
" Kill the capslock when leaving insert mode.
autocmd InsertLeave * set iminsert=0
let mapleader = "'"
syntax on
set incsearch

" ctrl - s save
inoremap <C-s> <esc>:w<cr>                 " save files
nnoremap <C-s> :w<cr>
inoremap <C-q> <esc>:wq!<cr>               " save and exit
nnoremap <C-q> :wq!<cr>


" hybrid line numbers
" :set number relativenumber

" :augroup numbertoggle
" :  autocmd!
" :  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber

" below suppose to change to norelativenumber in right time - but is too slow
" :  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
" :augroup END
" ------------------

" let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
" nmap <SPACE> <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
" nmap <SPACE> <Plug>(easymotion-bd-w)

" Turn on case-insensitive feature
" let g:EasyMotion_smartcase = 1

" JK motions: Line motions
" map <Leader>j <Plug>(easymotion-j)
" map <Leader>k <Plug>(easymotion-k)
"
"
call plug#begin('~/.vim/plugged')
" Plug 'easymotion/vim-easymotion'
Plug 'doums/darcula'
" Plug 'morhetz/gruvbox'
" Plug 'ctrlpvim/ctrlp.vim'
call plug#end()
        
silent! colorscheme darcula

