" VIM setup:
" Neovim + python + Denite and other things
" Much of this config taken from:
" https://github.com/sodiumjoe/dotfiles/blob/master/vimrc

call plug#begin('~/.vimplugins')

Plug 'tpope/vim-sensible'
Plug 'Shougo/denite.nvim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'jpalardy/vim-slime'
Plug 'airblade/vim-gitgutter'
Plug 'easymotion/vim-easymotion'
Plug 'chemzqm/denite-extra'
Plug 'neoclide/denite-git'
Plug 'benizi/vim-automkdir'
Plug 'editorconfig/editorconfig-vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'haya14busa/incsearch.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
"Plug 'justinmk/vim-dirvish'
Plug 'matze/vim-move'
"Plug 'mhartington/nvim-typescript'
"Plug 'racer-rust/vim-racer'
"Plug 'sbdchd/neoformat'
"Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rails'
Plug 'dustinfarris/vim-htmlbars-inline-syntax'
"Plug 'trevordmiller/nova-vim'
"Plug 'vimwiki/vimwiki'
Plug 'w0rp/ale'
Plug 'farmergreg/vim-lastplace'
Plug 'mattn/emmet-vim'

call plug#end()

" basic vim behavior

set number
filetype plugin indent on " Enable filetype-specific indenting and plugins
set autoindent
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
set showmatch
set incsearch
set autowrite
set scrolloff=5
runtime! macros/matchit.vim
syntax on
syntax enable
scriptencoding utf8
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
set undofile
set undodir=~/.vim/undo
set noerrorbells
set splitbelow
set splitright
set noshowmode
" show the cursor position all the time
set ruler
set smartcase
set infercase
set diffopt=filler,vertical
set breakindent
" don't show intro message
set shortmess=aoOtI

map <space> <leader>
vnoremap // y/<C-R>"<CR>

augroup myfiletypes
 " Clear old autocmds in group
 autocmd!
 " autoindent with two spaces, always expand tabs
 autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et
augroup END

if has("gui_running")
  " hide toolbar in gui vim
  set guioptions=egmrt
endif

if has('mouse')
  set mouse=a
  if &term =~ "xterm" || &term =~ "screen"
    " for some reason, doing this directly with 'set ttymouse=xterm2'
    " doesn't work -- 'set ttymouse?' returns xterm2 but the mouse
    " makes tmux enter copy mode instead of selecting or scrolling
    " inside Vim -- but luckily, setting it up from within autocmds
    " works                   
    autocmd VimEnter * set ttymouse=xterm2
    autocmd FocusGained * set ttymouse=xterm2
    autocmd BufEnter * set ttymouse=xterm2
  endif
endif

" hidden characters / tabstops / EOLs

nmap <leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬
set nolist

" CTRL-P

nmap <C-P> :Denite file_rec<CR>

" vim tabs

map ,t <Esc>:tabnew<CR>
map ,[ <Esc>:tabp<CR>
map ,] <Esc>:tabn<CR>

" .slim

autocmd BufNewFile,BufRead *.slim set nowrap

" Ruby / Rails

let g:rubycomplete_rails = 1
au BufNewFile,BufRead Fastfile set filetype=ruby
au BufNewFile,BufRead Matchfile set filetype=ruby

" JSON

let g:vim_json_syntax_conceal = 0

fun! OpenCurrentDirInFinder()
  return system("open .")
endfun

nmap <leader>f. :call OpenCurrentDirInFinder()<CR>

" Split current tmux window, running `bundle open` on the
" argument-specified Gem name. Auto-completes from
command! -nargs=* -complete=custom,ListGems BundleOpen silent execute "!tmux splitw 'bundle open <args>'"

fun! ListGems(A,L,P)
  " Note that vim will filter for us... no need to do anything with A args.
  return system("grep -s '^ ' Gemfile.lock | sed 's/^ *//' | cut -d ' '  -f1 | sed 's/!//' | sort | uniq")
endfun

nmap <leader>o :BundleOpen

nnoremap <leader>e :lnext<CR>

let g:ctrlp_map = ''
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|tmp$\|bower_components\|node_modules\|dist$\|build',
  \ 'file': '\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.class$\|DS_Store\|\.o$\|\~$',
  \ }
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:30'

:hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
:hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
:nnoremap <Leader>c :set cursorline! <CR>

let g:syntastic_javascript_gjslint_conf = '--nojsdoc'
let g:syntastic_javascript_jshint_args = '--config ./.jshintrc'

let g:syntastic_javascript_checkers = ['eslint', 'jshint']

autocmd FileType c,cpp,python,ruby,java,javascript autocmd BufWritePre <buffer> :%s/\s\+$//e

au BufNewFile,BufRead *.es6 set filetype=javascript

command! JSONformat silent execute ":%!python -m json.tool"
command! CSVtojson silent execute ":%!csvtojson.rb"
command! CSVtojsonpipes silent execute ":%!csvtojson.rb \\|"

" set clipboard=unnamed

" Open markdown files with Chrome.
autocmd BufEnter *.md exe 'noremap <F5> :!open -a "Google Chrome.app" %:p<CR>'

:nnoremap <Leader>dg :diffget <CR>
:nnoremap <Leader>dp :diffput <CR>

nmap <buffer> <Leader>q <Plug>(seeing-is-believing-run)
xmap <buffer> <Leader>q <Plug>(seeing-is-believing-run)
imap <buffer> <Leader>q <Plug>(seeing-is-believing-run)

xmap <buffer> <Leader>rr <Plug>(seeing-is-believing-mark)
nmap <buffer> <Leader>rr <Plug>(seeing-is-believing-mark)
imap <buffer> <Leader>rr <Plug>(seeing-is-believing-mark)


set rtp+=/usr/local/opt/fzf

:tnoremap <A-h> <C-\><C-n><C-w>h
:tnoremap <A-j> <C-\><C-n><C-w>j
:tnoremap <A-k> <C-\><C-n><C-w>k
:tnoremap <A-l> <C-\><C-n><C-w>l
:nnoremap <A-h> <C-w>h
:nnoremap <A-j> <C-w>j
:nnoremap <A-k> <C-w>k
:nnoremap <A-l> <C-w>l

function! ClipboardYank()
  call system('pbcopy', @@)
endfunction
function! ClipboardPaste()
  let @@ = system('pbpaste')
endfunction

vnoremap <silent> y y:call ClipboardYank()<cr>
vnoremap <silent> d d:call ClipboardYank()<cr>

" <C-\><C-n> is how you get out of terminal mode

" leave this commented out. to paste from osx clipboard do "+p
"nnoremap <silent> p :call ClipboardPaste()<cr>p


nmap <leader>ee <Plug>(seeing-is-believing-mark) " - add mark (# =>) to the line.
nmap <leader>er <Plug>(seeing-is-believing-run)  " - run all marked lines.

autocmd BufRead,BufNewFile *.js HighlightInlineHbs

" Fugitive
let g:gist_post_private = 1

" Use ag silver surfer instead of ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" call janus#add_mapping('ack', 'map', '<leader>f', ':Ack<space>')

"zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>

let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" movement
" ========

nnoremap j gj
nnoremap k gk

" search
" ======

" vim-move
" ====

" Move lines up and down with C-J/K
let g:move_key_modifier = 'C'

set ignorecase

" statusline
" ==========

hi StatusLine guifg=#7FC1CA guibg=#556873
hi StatusLineNC guifg=#3C4C55 guibg=#556873
hi StatusLineError guifg=#DF8C8C guibg=#556873

function! Git_branch()
  let l:branch = fugitive#head()
  return empty(l:branch)?'':'['.l:branch.']'
endfunction

set statusline+=%{Git_branch()}
set statusline+=\ "
" filename
set statusline+=%<%f
set statusline+=\ "
" help/modified/readonly
set statusline+=%h%m%r
" alignment group
set statusline+=%=
" start error highlight group
set statusline+=%#StatusLineError#
" errors from w0rp/ale
set statusline+=%{ALEGetStatusLine()}
" reset highlight group
set statusline+=%#StatusLine#
set statusline+=\ "
" line,column,virtual column
set statusline+=%-14.(%l,%c%V%)
set statusline+=\ "
" percentge through file of displayed window
set statusline+=%P

" Use deoplete.
call deoplete#enable()

" denite

"call denite#custom#var('grep', 'recursive_opts', [])
"call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
"call denite#custom#var('grep', 'separator', ['--'])
"call denite#custom#var('grep', 'final_opts', [])

" ESC in Denite goes into normal mode. ESC again no-ops.
call denite#custom#map('insert', '<Esc>', '<denite:enter_mode:normal>', 'noremap')
call denite#custom#map('normal', '<Esc>', '<NOP>', 'noremap')
" Ctrl-V in denite opens file in vsplit
call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplit>', 'noremap')
call denite#custom#map('normal', '<C-v>', '<denite:do_action:vsplit>', 'noremap')
call denite#custom#map('normal', 'dw', '<denite:delete_word_after_caret>', 'noremap')

" When searching with Denite, Ctrl-J/K moves up and down, similar to Emacs helm.
call denite#custom#map( 'insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map( 'insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')

" incsearch.vim x fuzzy x vim-easymotion

function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
  \   'converters': [incsearch#config#fuzzy#converter()],
  \   'modules': [incsearch#config#easymotion#module()],
  \   'keymap': {"\<CR>": '<Over>(easymotion)'},
  \   'is_expr': 0,
  \   'is_stay': 1
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())

"nnoremap /  <Plug>(incsearch-forward)
"nnoremap ?  <Plug>(incsearch-backward)
"nnoremap g/ <Plug>(incsearch-stay)

" NERD Tree
" =========

nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>N :NERDTreeFind<CR>

" ALE (Async Lint Engine)
" =======================

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'html': ['tidy'],
\}

