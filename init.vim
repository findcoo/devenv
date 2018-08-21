" neobundle

if &compatible
    set nocompatible
endif

" Plug
call plug#begin('~/.vim/plugged')
if has('nvim')
      Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
      Plug 'Shougo/deoplete.nvim'
      Plug 'roxma/nvim-yarp'
      Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1
    " node
    Plug 'moll/vim-node'
    " python
    Plug 'nvie/vim-flake8'
    Plug 'tell-k/vim-autopep8'
    " go
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    " java
    Plug 'artur-shaik/vim-javacomplete2'
    " javascript
    Plug 'mattn/emmet-vim'
    Plug 'pangloss/vim-javascript'
    Plug 'mxw/vim-jsx'
    Plug 'godlygeek/tabular'
    Plug 'othree/jspc.vim'
    Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
    Plug 'wokalski/autocomplete-flow'
    " deoplete plugins
    Plug 'zchee/deoplete-jedi'
    " common tools
    Plug 'Shougo/vimproc.vim', { 'do': 'make' }
    Plug 'neomake/neomake'
    Plug 'mtth/scratch.vim'
    Plug 'Lokaltog/powerline'
    Plug 'ervandew/supertab'
    Plug 'Shougo/neosnippet'
    Plug 'Shougo/neosnippet-snippets'
    Plug 'chase/vim-ansible-yaml'
    Plug 'robbles/logstash.vim'
    Plug 'wakatime/vim-wakatime'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'haya14busa/incsearch.vim'
    Plug 'haya14busa/incsearch-fuzzy.vim'
    Plug 'haya14busa/incsearch-easymotion.vim'
    Plug 'easymotion/vim-easymotion'
    Plug 'junegunn/vim-emoji'
    Plug 'mzlogin/vim-markdown-toc'
    Plug 'aklt/plantuml-syntax'
    Plug 'plasticboy/vim-markdown'
    Plug '0x84/vim-coderunner'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'dhruvasagar/vim-table-mode'
    Plug 'scrooloose/nerdtree'
    Plug 'airblade/vim-rooter'
    " git
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
call plug#end()
filetype plugin indent on
syntax enable

" text editing
set nu
set autochdir
syntax on

set tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent fileformat=unix
au FileType go set tabstop=2 softtabstop=2 shiftwidth=2 expandtab autoindent
au FileType javascript set tabstop=2 softtabstop=2 shiftwidth=2 expandtab autoindent
au FileType python set textwidth=79

set cursorline
hi CursorLine term=bold cterm=bold guibg=Grey40
highlight LineNr ctermfg=grey

au FileType yaml setl ai ts=1 sts=1 sw=1

" java
au FileType java setl omnifunc=javacomplete#Complete
let g:JavaComplete_JavaviLogfileDirectory = '~/.javacomplete2/'

" Jedi
let g:python_host_prog = "/Users/kakaopay/.pyenv/shims/python"
let g:python3_host_prog = "/Users/kakaopay/.pyenv/shims/python3"

" neosnippet
let g:neosippet#enable_completed_startup = 1
let g:neosnippet#snippets_directory='~/.vim/plugged/neosnippet-snippets/neosnippets'

" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" golang
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>d <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>g <Plug>(go-doc-vertical)

au FileType go nmap <Leader>gb <Plug>(go-doc-browser)

au FileType go nmap <leader>rt <Plug>(go-run-tab)
au FileType go nmap <Leader>rs <Plug>(go-run-split)
au FileType go nmap <Leader>r <Plug>(go-run-vertical)

au FileType go nmap <Leader>c :GoCallstack<ENTER>
"
"let g:go_fmt_command = "goimports"
"
"let g:go_metalinter_enabled = ['golint', 'errcheck']
"let g:go_metalinter_autosave = 1
"let g:go_metalinter_autosave_enabled = ['golint']
"set autowrite
"let g:go_list_type = "quickfix"
"
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
"
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
"
"autocmd FileType go nmap <Leader>i <Plug>(go-info)
"let g:go_auto_type_info = 1
"set updatetime=50
"let g:go_auto_sameids = 1
"let g:go_bin_path = expand("~/.gotools")
"
"let g:syntastic_go_checkers = ['golint', 'errcheck']
"let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" supertab
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabClosePreviewOnPopupClose = 1

" java
au FileType java nmap <Leader>d :JavaSearch -a edit<ENTER>
au FileType java nmap <Leader>s :JavaSearch -a vsplit<ENTER>

" Jenkinsfile
au BufNewFile,BufRead Jenkinsfile setf groovy

" javascript
autocmd FileType javascript setlocal omnifunc=tern#Complete
let g:jsx_ext_required = 0
let g:tern_map_keys = 1

"easymotion
" You can use other keymappings like <C-l> instead of <CR> if you want to
" use these mappings as default search and somtimes want to move cursor with
" EasyMotion.
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

function! s:incsearch_config(...) abort
  return incsearch#util#deepextend(deepcopy({
  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
  \   'keymap': {
  \     "\<CR>": '<Over>(easymotion)'
  \   },
  \   'is_expr': 0
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> /  incsearch#go(<SID>incsearch_config())
noremap <silent><expr> ?  incsearch#go(<SID>incsearch_config({'command': '?'}))
noremap <silent><expr> g/ incsearch#go(<SID>incsearch_config({'is_stay': 1}))

function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
  \   'converters': [incsearch#config#fuzzyword#converter()],
  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
  \   'keymap': {"\<CR>": '<Over>(easymotion)'},
  \   'is_expr': 0,
  \   'is_stay': 1
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())

set guicursor=

let s:jar_path = "~/.vim/bundle/vim-slumloard/plantuml.jar"

" markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_conceal = 0
augroup emoji_complete
    autocmd!
    autocmd FileType markdown setlocal completefunc=emoji#complete
augroup END

" scratch
let g:scratch_autohide = 1

" neomake
let g:neomake_java_enabled_makers = ['gradle']
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_javascript_eslint_exe = system('PATH=$(npm bin):$PATH && which eslint | tr -d "\n"')
" When writing a buffer (no delay).
call neomake#configure#automake('w')
" When writing a buffer (no delay), and on normal mode changes (after 750ms).
call neomake#configure#automake('nw', 750)
" When reading a buffer (after 1s), and when writing (no delay).
call neomake#configure#automake('rw', 1000)
" Full config: when writing or reading a buffer, and on changes in insert and
" normal mode (after 1s; no delay when writing).
call neomake#configure#automake('nrwi', 500)

" NerdTree
map <C-n> :NERDTreeToggle<CR>

" FZF
nmap <C-p> :FZF<CR>
