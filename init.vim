set nu
"set backspace=indent,eol,start
set autochdir
syntax on

set tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent fileformat=unix
au FileType python set textwidth=79

set cursorline
hi CursorLine term=bold cterm=bold guibg=Grey40
highlight LineNr ctermfg=grey

au FileType yaml setl ai ts=1 sts=1 sw=1

set runtimepath^=~/.vim/bundle/neobundle.vim/

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'tpope/vim-fugitive'
" NeoBundle 'klen/python-mode'
NeoBundle 'Lokaltog/powerline'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'ervandew/supertab'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'marijnh/tern_for_vim'
NeoBundle 'honza/vim-snippets'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'chase/vim-ansible-yaml'
NeoBundle 'nvie/vim-flake8'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tell-k/vim-autopep8'
NeoBundle 'robbles/logstash.vim'
NeoBundle 'fatih/vim-go'


NeoBundleLazy 'lambdalisue/vim-pyenv', {
    \ 'depends': ['davidhalter/jedi-vim'],
    \ 'autoload': {
    \   'filetypes': ['python', 'python3'],
    \ }}
call neobundle#end()

filetype plugin indent on

NeoBundleCheck

" python-mode setting off
let g:pymode_rope = 0

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pep8"
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0

let g:SupperTabDefaultCompletionType = 'context'

"let g:jedi#force_py_version=3

if jedi#init_python()
    function! s:jedi_auto_force_py_version() abort
        let major_version=pyenv#python#get_internal_major_version()
        call jedi#force_py_version(major_version)
    endfunction
    augroup vim-pyenv-custom-augroup
        autocmd! *
        autocmd User vim-pyenv-activate-post    call s:jedi_auto_force_py_version()
        autocmd User vim-pyenv-deactivate-post  call s:jedi_auto_force_py_version()
    augroup END
endif

let g:UltiSnipsExpandTrigger="<s-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsSnippetsDir="~/.vim/bundle/vim-snippets/UltiSnips"
let g:UltiSnipsEditSplit="vertical"

au FileType java let g:EclimCompletionMethod="omnifunc"

let g:python_host_prog = "/usr/bin/python2"
let g:python3_host_prog = "/usr/bin/python3"

" go setting
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

let g:go_bin_path = expand("~/.gotools")

let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

