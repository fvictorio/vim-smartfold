if exists("g:loaded_SmartFold") || &cp
  finish
endif
let g:loaded_SmartFold = 1
let s:keepcpo = &cpo
set cpo&vim

function! s:ContainsIgnoreCase(list, x)
  return index(a:list, a:x, 0, 1) != -1
endfunction

function! s:SmartFoldFn()
  let l:filetype = split(&filetype, '\.')[0]

  if s:ContainsIgnoreCase(['javascript', 'json', 'solidity', 'vue'], l:filetype)
    execute "normal! zfaB"
  elseif l:filetype ==# 'html'
    execute "normal! zfat"
  elseif l:filetype ==# 'scss'
    execute "normal! zfaB"
  elseif l:filetype ==# 'elixir'
    execute "normal zfar"
  elseif l:filetype ==# 'vim'
    if exists('g:loaded_textobj_function')
      execute "normal zfaf"
    endif
  elseif l:filetype ==# 'diff'
    execute "normal zfadf"
  else
    execute "normal! zfaB"
  endif
endfunction

noremap <silent> <unique> <script> <Plug>SmartFold :call <SID>SmartFoldFn()<CR>
\:call repeat#set("\<Plug>SmartFold", v:count)<CR>

nmap zff <Plug>SmartFold

let &cpo= s:keepcpo
unlet s:keepcpo
