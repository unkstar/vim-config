function! s:JSLint(args) range
  cexpr [] " Create empty quickfix list

  " Detect range
  if a:firstline == a:lastline
    let b:firstline = 1
    let b:lastline = '$'
  else 
    let b:firstline = a:firstline
    let b:lastline = a:lastline
  endif

  " Set up command and parameters
  let s:plugin_path = '"' . expand("~/") . '"'
  if has("win32")
    let s:cmd = 'cscript /NoLogo '
    let s:plugin_path = expand("$VIM") . "/" . "vimfiles"
    let s:runjslint_ext = 'wsf'
  else
    if has("gui_macvim") && filereadable('/System/Library/Frameworks/JavaScriptCore.framework/Resources/jsc')
      let s:cmd = '/System/Library/Frameworks/JavaScriptCore.framework/Resources/jsc'
    else
      let s:cmd = 'js'
    endif
    let s:plugin_path = s:plugin_path . ".vim"
    let s:runjslint_ext = 'js'
  endif
  let s:plugin_path = s:plugin_path . "/plugin/jslint/"
  let s:cmd = "cd " . s:plugin_path . " && " . s:cmd . " " . s:plugin_path 
               \ . "runjslint." . s:runjslint_ext
  let s:jslintrc_file = expand('~/.jslintrc')
  if filereadable(s:jslintrc_file)
    let s:jslintrc = readfile(s:jslintrc_file)
  else
    let s:jslintrc = []
  end
  let b:jslint_output = system(s:cmd, join(s:jslintrc + getline(b:firstline, b:lastline),
              \ "\n") . "\n")

  for error in split(b:jslint_output, "\n")
    " Match {line}:{char}:{message}
    let b:parts = matchlist(error, "\\(\\d\\+\\):\\(\\d\\+\\):\\(.*\\)")
    if !empty(b:parts)
      let l:line = b:parts[1] + (b:firstline - 1 - len(s:jslintrc)) " Get line relative to selection

      " Add to quickfix
      caddexpr expand("%") . ":" . l:line . ":" . b:parts[2] . ":" . b:parts[3]
    endif
  endfor
endfunction

" Highlight errors and echo error under cursor
command! -range JSLintLight <line1>,<line2>call s:JSLint("echo")
" Highlight errors and open quick fix window
command! -range JSLint <line1>,<line2>call s:JSLint("qf")

