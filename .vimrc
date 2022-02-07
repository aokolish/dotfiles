let mapleader=","

set t_Co=256

" make it possible to get to system clipboard with *
set clipboard=unnamed

set mouse=a

set spell spelllang=en_us

" set number
set ruler
syntax on

" would python be good enough? maybe I don't need that plugin...
autocmd BufNewFile,BufRead *.tilt set syntax=starlark

set undofile
set undodir=~/.vim/undodir

" Set encoding
set encoding=utf-8

" Whitespace stuff
set winwidth=80
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" remove trailing whitespace
nnoremap <leader><Space> :%s/\s\+$//e<CR>
nnoremap <leader>w :w<CR>
" Can't be bothered to understand ESC vs <c-c> in insert mode
" this is helpful since the escape key is not a physical key on my
" current laptop
imap <c-c> <esc>

augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType haml setlocal nowrap

  "for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType ruby,haml,eruby,yaml,html,sass,cucumber set ai sw=2 sts=2 et

  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

set nowrap

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
" show count when using *
map * *<C-O>:%s///gn<CR>

" automatically reload files that have changed outside of vim
" e.g. when switching branches or stashing changes
set autoread

" Use the old vim regex engine (version 1, as opposed to version 2, which was
" introduced in Vim 7.3.969). The Ruby syntax highlighting is significantly
" slower with the new regex engine.
set re=1

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*,tmp

" Status bar - always show
set laststatus=2

filetype off    "required by Vundle

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'altercation/vim-colors-solarized'
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'mileszs/ack.vim'
Plugin 'vim-scripts/scratch.vim'
Plugin 'tpope/vim-rhubarb'
Plugin 'tpope/vim-endwise'
Plugin 'cappyzawa/starlark.vim'
Plugin 'solarnz/thrift.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

map <Leader>g :.GBrowse<CR>
nnoremap <Leader>n :noh<CR>

" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    let selection = system(a:choice_command . " | selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction

" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
let find_command = "find . -not \( -path './*tmp' -prune \) -not \( -path './*git' -prune \) -type f -and -not -iname '*.jpg' -and -not -iname '*.png' -and -not -iname '*.svg' -and -not -iname '*.keep' -and -not -iname '*.ds_store' | cut -c 3- "
nnoremap <leader>t :call SelectaCommand(escape(find_command, "()"), "", ":e")<cr>

let g:github_enterprise_urls = ['https://github.snooguts.net']

" CTags
" consider remapping this to something else
" because it is causing my <leader>r mapping to be slow (rename a file)
" not sure what I would map this to
" map <Leader>rt :Dispatch bundle show --paths \| xargs ctags -f \.tags -R && ctags --extra=+f -R -a *<CR><CR>
map <Leader>ct :Dispatch ctags --extra=+f -R -a *<CR><CR>
map <c-b> :tprevious<CR>
map <c-n> :tnext<CR>
map tt <c-]>
" using custom tag filename
"set tags=tags
set tags^=./.git/tags;

" highlight the 80th column
"set colorcolumn=80

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru,*.watchr,Guardfile,*.thor,*.rabl}    set ft=ruby
au BufRead,BufNewFile *.scss.erb    set ft=scss
" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

au BufNewFile,BufRead *.handlebars set ft=mustache

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Use modeline overrides
set modeline
set modelines=10

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" Turn off jslint errors by default
let g:JSLintHighlightErrorLine = 0

" % to bounce from do to end etc.
runtime! macros/matchit.vim

" Show (partial) command in the status line
set showcmd

" I don't like folds
set nofoldenable

set background=dark
color solarized

nnoremap <leader><leader> <c-^>

" Don't beep
set visualbell

" Maps to make handling windows a bit easier
noremap <silent> ,h :wincmd h<CR>
noremap <silent> ,j :wincmd j<CR>
noremap <silent> ,k :wincmd k<CR>
noremap <silent> ,l :wincmd l<CR>

" commands to enter blank lines and stay in normal mode
nnoremap - o<esc>k
nnoremap _ O<esc>j

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col
        return "\<tab>"
    endif

    let char = getline('.')[col - 1]
    if char =~ '\k'
        " There's an identifier before the cursor, so complete the identifier.
        return "\<c-p>"
    else
        return "\<tab>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PROMOTE VARIABLE TO RSPEC LET
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! PromoteToLet()
  :normal! dd
  " :exec '?^\s*it\>'
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
:map <leader>p :PromoteToLet<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS
"
" Test running here is contextual in two different ways:
"
" 1. It will guess at how to run the tests. E.g., if there's a Gemfile
"    present, it will `bundle exec rspec` so the gems are respected.
"
" 2. It remembers which tests have been run. E.g., if I'm editing user_spec.rb
"    and hit enter, it will run rspec on user_spec.rb. If I then navigate to a
"    non-test file, like routes.rb, and hit return again, it will re-run
"    user_spec.rb. It will continue using user_spec.rb as my 'default' test
"    until I hit enter in some other test file, at which point that test file
"    is run immediately and becomes the default. This is complex to describe
"    fully, but simple to use in practice: always hit enter to run tests. It
"    will run either the test file you're in or the last test file you hit
"    enter in.
"
" 3. Sometimes you want to run just one test. For that, there's <leader>T,
"    which passes the current line number to the test runner. RSpec knows what
"    to do with this (it will run the first test it finds at or below the
"    given line number). It probably won't work with other test runners.
"    'Focusing' on a single test in this way will be remembered if you hit
"    enter from non-test files, as described above.
"
" 4. Sometimes you don't want contextual test running. In that case, there's
"    <leader>T, which runs everything.
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! MapCR()
  nnoremap <cr> :call RunTestFile()<cr>
endfunction
call MapCR()
nnoremap <leader>S :call RunNearestTest()<cr>
nnoremap <leader>T :call RunTests('')<cr>

" nnoremap <cr> :w \| !clear && ruby %<cr>

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Are we in a test file?
    let in_test_file = match(expand("%"), '\(_spec.rb\|_test.rb\|test_.*\.py\|_test.py\)$') != -1

    " Run the tests for the previously-marked file (or the current file if
    " it's a test).
    if in_test_file
        call SetTestFile(command_suffix)
    elseif !exists("t:aeo_test_file")
        return
    end

    call RunTests(t:aeo_test_file)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number)
endfunction

function! SetTestFile(command_suffix)
    " Set the spec file that tests will be run for.
    let t:aeo_test_file=@% . a:command_suffix
endfunction

function! RunTests(filename)
    " Write the file and run tests for the given filename
    if expand("%") != ""
      :w
    end

    if filereadable("bin/test")
      exec ":!bin/test " . a:filename
    " Fall back
    else
      exec ":!py.test -v " . a:filename
    end
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SWITCH BETWEEN TEST AND PRODUCTION CODE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction
function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_test = match(current_file, '^tests/') != -1
  let going_to_test = !in_test
  if going_to_test
    let new_file = substitute(new_file, expand('%:t'), 'test_' . expand('%:t'), '')
    let new_file = 'tests/' . new_file
  else
    let new_file = substitute(new_file, 'test_', '', '')
    let new_file = substitute(new_file, '^tests/', '', '')
  endif
  return new_file
endfunction
nnoremap <leader>. :call OpenTestAlternate()<cr>

let g:ackprg = "rg --vimgrep --no-heading --hidden -g '!*git' -T pdf -T svg"
map <leader>a :Ack!<space>

" wrapping just used for markdown
function s:setupWrapping()
  set wrap
  set wrapmargin=2
  set textwidth=80
endfunction

function s:setupMarkup()
  call s:setupWrapping()
endfunction
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>r :call RenameFile()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FIND AND REPLACE ACROSS FILES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! FindAndReplace()
    let find_this = input('Replace : ')
    let replace_with = input('Replace "'. find_this .'" with: ')

    :exec "args `" . 'rg -l ' . find_this . "`"
    " eventignore-=Syntax enables syntax highlighting w/argdo
    :exec "argdo set eventignore-=Syntax \| %s/" . find_this ."/" . replace_with . "/gc " . "\| w"
endfunction
"map <leader>f :call FindAndReplace()<cr>
map <leader>f :!flog %<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SHORTCUT TO REFERENCE CURRENT FILE'S PATH IN COMMAND LINE MODE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap <expr> %% expand('%:h').'/'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FindConditionals COMMAND
" Start a search for conditional branches, both implicit and explicit
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! FindConditionals :normal /\<if\>\|\<unless\>\|\<and\>\|\<or\>\|||\|&&<cr>
