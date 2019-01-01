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
    " javascript
    Plug 'mattn/emmet-vim'
    Plug 'pangloss/vim-javascript'
    Plug 'mxw/vim-jsx'
    Plug 'othree/jspc.vim'
    Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
    Plug 'wokalski/autocomplete-flow'
    " deoplete plugins
    Plug 'zchee/deoplete-jedi'
    " common tools
    Plug 'Shougo/vimproc.vim', { 'do': 'make' }
    Plug 'alcesleo/vim-uppercase-sql'
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
    Plug 'vim-scripts/SQLUtilities'
    Plug 'junegunn/vim-easy-align'
    Plug 'tpope/vim-surround'
    Plug 'w0rp/ale'
    " git
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
call plug#end()
filetype plugin indent on
syntax enable

" text editing
set nu
set autochdir
set cursorline
set synmaxcol=128
set re=1
syntax on

set tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent fileformat=unix smartindent
au FileType python set textwidth=79

hi CursorLine term=bold cterm=bold guibg=Grey40
highlight LineNr ctermfg=grey

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

" supertab
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabClosePreviewOnPopupClose = 1
au FileTYpe javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
set completeopt-=preview

" Jenkinsfile
au BufNewFile,BufRead Jenkinsfile setf groovy

" javascript
autocmd FileType javascript setlocal omnifunc=tern#Complete
let g:jsx_ext_required = 0
let g:tern_map_keys = 1
au FileType javascript nmap <silent>gd :TernDef<CR>
au FileType javascript nmap <silent>gp :TernDefPreview<CR>

" plantuml
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

" SQLUtilities
au FileType sql vmap <silent>sf        <Plug>SQLU_Formatter<CR>
au FileType sql nmap <silent>scl       <Plug>SQLU_CreateColumnList<CR>
au FileType sql nmap <silent>scd       <Plug>SQLU_GetColumnDef<CR>
au FileType sql nmap <silent>scdt      <Plug>SQLU_GetColumnDataType<CR>
au FileType sql nmap <silent>scp       <Plug>SQLU_CreateProcedure<CR>

" airline
let g:airline#extensions#ale#enabled = 1

" golang
let g:go_auto_sameids = 1
let g:go_fmt_command = "goimports"
" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
let g:go_addtags_transform = "snakecase"
let g:go_snippet_engine = "neosnippet"
