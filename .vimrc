colorscheme darkblue
set nocp
set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/macros/matchit.vim

set rtp+=$GOROOT/misc/vim
filetype plugin indent on

"WTF... $GOROOT/misc/vim/ftdetect/go.vim is not working!
au BufRead,BufNewFile *.go set filetype=go




set fileencodings=ucs-bom,utf-8,cp936,shift_jis

if has("win32")
set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
endif


syntax on
set hls
set foldmethod=syntax

nnoremap <C-H> :tabprevious<CR>
nnoremap <C-L> :tabnext<CR>

nnoremap <F1> :tabn 1<CR>
nnoremap <F2> :tabn 2<CR>
nnoremap <F3> :tabn 3<CR>
nnoremap <F4> :tabn 4<CR>
nnoremap <F5> :tabn 5<CR>
nnoremap <F6> :tabn 6<CR>
nnoremap <F7> :tabn 7<CR>
nnoremap <F8> :tabn 8<CR>
nnoremap <F9> :tabn 9<CR>
nnoremap <F10> :tabn 10<CR>
nnoremap <F11> :tabn 11<CR>
nnoremap <F12> :tabn 12<CR>

nnoremap <C-X> :quit<CR>

nnoremap <C-N> :cnext<CR>
nnoremap <C-P> :cprevious<CR>
nnoremap <C-S> :wa<CR>
"nnoremap B :make BROWSER=IE MODE=dbg DEMO_VERSION=1<CR>
nnoremap B :make<CR>

nnoremap <C-]> g<C-]>

highlight DiffChange cterm=bold
highlight DiffAdd cterm=bold

"nnoremap <silent> S :execute ":vimgrep /\\<" . expand("<cword>") . "\\>/j **" <Bar> cw<CR>
nnoremap <silent> S :execute ":!ack "expand("<cword>") <Bar> cw<CR>

" fuzzyfinder.vim
let g:FuzzyFinderOptions = { 'Base':{}, 'Buffer':{}, 'File':{}, 'Dir':{}, 'MruFile':{}, 'MruCmd':{}, 'Bookmark':{}, 'Tag':{}, 'TaggedFile':{}}
let g:FuzzyFinderOptions.Base.ignore_case = 1
let g:FuzzyFinderOptions.Base.key_open_vsplit = '<C-v>'

let g:FuzzyFinderOptions.File.excluded_path = '\v\.svn|\~$|\.o$|\.exe$|\.bak$|\.swp$|((^|[/\\])\.[/\\]$)'
let g:FuzzyFinderOptions.Dir.excluded_path = '\v\.svn|((^|[/\\])\.{1,2}[/\\]$)'

nnoremap <silent> <SPACE>b :FufBuffer<CR>
nnoremap <silent> <SPACE>f :FufFile<CR>
nnoremap <silent> <SPACE>r :FufMruFile<CR>
nnoremap <silent> <SPACE>c :FufMruCmd<CR>
nnoremap <silent> <SPACE>d :FufDir<CR>
nnoremap <silent> <SPACE>A :FufAddBookmark<CR>
nnoremap <silent> <SPACE>B :FufBookmark<CR>
nnoremap <silent> <SPACE>E :FufEditInfo<CR>

"""cscope vim remap
"   's'   symbol: find all references to the token under cursor
"   'g'   global: find global definition(s) of the token under cursor
"   'c'   calls:  find all calls to the function name under cursor
"   'e'   egrep:  egrep search for the word under cursor
"   'd'   called: find functions that function under cursor calls

nnoremap <silent> <SPACE>S :sc find s <C-R>=expand("<cword>")<CR><CR>
nnoremap <silent> <SPACE>G :sc find g <C-R>=expand("<cword>")<CR><CR>
nnoremap <silent> <SPACE>v :sc find c <C-R>=expand("<cword>")<CR><CR>
nnoremap <silent> <SPACE>E :sc find e <C-R>=expand("<cword>")<CR><CR>
nnoremap <silent> <SPACE>V :sc find d <C-R>=expand("<cword>")<CR><CR>

nnoremap <silent> <SPACE>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nnoremap <silent> <SPACE>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nnoremap <silent> <SPACE>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nnoremap <silent> <SPACE>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nnoremap <silent> <SPACE>C :cs find d <C-R>=expand("<cword>")<CR><CR>


nnoremap <silent> <SPACE>t :tabnew<CR>

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove right-hand scroll bar
set guifont=DejaVu\ Sans\ Mono\ 11

let c_space_errors = 1

set expandtab
set tabstop=2
set shiftwidth=2
set clipboard=unnamed

if has("gui_running")
        set lines=99999 columns=99999
endif


let VCSCommandGitExec='git'

function! JavaScriptFold()
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen


let g:JSLintEnabled = 0
