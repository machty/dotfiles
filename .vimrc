" VIM setup:
" Neovim + python + Denite and other things
" Much of this config taken from:
" https://github.com/sodiumjoe/dotfiles/blob/master/vimrc

call plug#begin('~/.vimetc/plugins')

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
Plug 'scrooloose/nerdtree'
"Plug 'justinmk/vim-dirvish'
Plug 'matze/vim-move'
"Plug 'sbdchd/neoformat'
"Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rhubarb'
Plug 'trevordmiller/nova-vim'
"Plug 'vimwiki/vimwiki'
Plug 'w0rp/ale'
Plug 'farmergreg/vim-lastplace'
Plug 'mattn/emmet-vim'
Plug 'lfv89/vim-interestingwords'
Plug 'terryma/vim-multiple-cursors'
Plug 'vim-airline/vim-airline'
Plug 'rakr/vim-one'

call plug#end()

" vim-one color scheme
" ====================

set termguicolors
colorscheme one
set background=dark
let g:airline_theme='one'

" basic vim behavior
" ==================

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
set backupdir=~/.vimetc/backups
set directory=~/.vimetc/swaps
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

" vimrc
" =====

nnoremap <leader>fed :e ~/.dotfiles/.vimrc<CR>
nnoremap <leader>feR :source ~/.dotfiles/.vimrc<CR>

" vim tabs
" ========

map ,t <Esc>:tabnew<CR>
map ,[ <Esc>:tabp<CR>
map ,] <Esc>:tabn<CR>

" .slim
" =====

autocmd BufNewFile,BufRead *.slim set nowrap

" Ruby / Rails
" ============

let g:rubycomplete_rails = 1
au BufNewFile,BufRead Fastfile set filetype=ruby
au BufNewFile,BufRead Matchfile set filetype=ruby

" JSON
" ====

let g:vim_json_syntax_conceal = 0
command! JSONformat silent execute ":%!python -m json.tool"
command! CSVtojson silent execute ":%!csvtojson.rb"
command! CSVtojsonpipes silent execute ":%!csvtojson.rb \\|"

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

" set clipboard=unnamed

:nnoremap <Leader>dg :diffget <CR>
:nnoremap <Leader>dp :diffput <CR>

set rtp+=/usr/local/opt/fzf

function! ClipboardYank()
  call system('pbcopy', @@)
endfunction
function! ClipboardPaste()
  let @@ = system('pbpaste')
endfunction

vnoremap <silent> y y:call ClipboardYank()<cr>
vnoremap <silent> d d:call ClipboardYank()<cr>

" vim-fugitive
" ============

let g:gist_post_private = 1

" zoom windows
" ============

"zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
"<leader>= to balance defined in Janus section

" movement
" ========

nnoremap j gj
nnoremap k gk

" search
" ======

set ignorecase

" vim-move
" ========

" Move lines up and down with C-J/K
let g:move_key_modifier = 'C'

" statusline
" ==========

hi StatusLine guifg=#7FC1CA guibg=#556873
hi StatusLineNC guifg=#3C4C55 guibg=#556873
hi StatusLineError guifg=#DF8C8C guibg=#556873

function! Git_branch()
  let l:branch = fugitive#head()
  return empty(l:branch)?'':'['.l:branch.']'
endfunction

" Janus conventions
" =================

set statusline=%f\ %m\ %r
set statusline+=%{Git_branch()}
set statusline+=\ "
set statusline+=Line:%l/%L[%p%%]
set statusline+=Col:%v
set statusline+=Buf:#%n
set statusline+=[%b][0x%B]
set statusline+=%=
set statusline+=%#StatusLineError#
set statusline+=%{ALEGetStatusLine()}
set statusline+=%#StatusLine#
set statusline+=\ "
" Toggle hlsearch with <leader>hs
nmap <leader>hs :set hlsearch! hlsearch?<CR>
" Adjust viewports to the same size
map <Leader>= <C-w>=
" Some helpers to edit mode
" http://vimcasts.org/e/14
nmap <leader>ew :e <C-R>=expand('%:h').'/'<cr>
nmap <leader>es :sp <C-R>=expand('%:h').'/'<cr>
nmap <leader>ev :vsp <C-R>=expand('%:h').'/'<cr>
nmap <leader>et :tabe <C-R>=expand('%:h').'/'<cr>
" Toggle paste mode
nmap <silent> <F4> :set invpaste<CR>:set paste?<CR>
imap <silent> <F4> <ESC>:set invpaste<CR>:set paste?<CR>

" denite
" ======

nmap <leader>sa [denite]
" Replace CTRL-P to search buffers followed by recursive file search
nmap <C-P> :Denite buffer file_rec<CR>
nmap [denite]p :Denite grep:::!<CR>
nmap [denite]P :DeniteCursorWord grep<CR>
nmap [denite]b :Denite buffer<CR>
nmap [denite]o :Denite outline<CR>
nmap [denite]t :Denite tag<CR>
nmap [denite]T :DeniteCursorWord tag<CR>

call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

call denite#custom#var('outline', 'command', ['ripper-tags'])
call denite#custom#var('outline', 'file_opt', '-f')
call denite#custom#var('outline', 'options', [])

" ESC in Denite goes into normal mode. ESC again no-ops.
call denite#custom#map('insert', '<Esc>', '<denite:enter_mode:normal>', 'noremap')
call denite#custom#map('normal', '<Esc>', '<NOP>', 'noremap')
" Ctrl-V in denite opens file in vsplit
call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplit>', 'noremap')
call denite#custom#map('insert', '<C-s>', '<denite:do_action:split>', 'noremap')
call denite#custom#map('normal', '<C-v>', '<denite:do_action:vsplit>', 'noremap')
call denite#custom#map('normal', '<C-s>', '<denite:do_action:split>', 'noremap')
call denite#custom#map('normal', 'dw', '<denite:delete_word_after_caret>', 'noremap')

" When searching with Denite, Ctrl-j/k moves up and down, similar to Emacs helm.
" Also added this for Ctrl-n/p since autocomplete uses that
call denite#custom#map( 'insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map( 'insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map( 'insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map( 'insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')

" deoplete
" ========

call deoplete#enable()

" incsearch
" =========

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

" vim-commentary
" ==============

vmap <leader>/ <Plug>Commentary
nmap <leader>/ <Plug>CommentaryLine

" vim-multiple-cursors
" ====================

" Prevent clobbering w deoplete
function! Multiple_cursors_before()
  if exists('g:deoplete#disable_auto_complete') 
    let g:deoplete#disable_auto_complete = 1
  endif
endfunction
function! Multiple_cursors_after()
  if exists('g:deoplete#disable_auto_complete')
    let g:deoplete#disable_auto_complete = 0
  endif
endfunction

