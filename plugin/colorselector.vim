" ColorScheme Selector
" Author: Cornelius  林佑安 (Yo-An Lin) <cornelius.howl@gmail.com>
" Script Type: plugin
fun! g:SetColor()
  let name = getline('.')
  if name =~ '^=='
    return
  endif

  exec 'colors ' . name
  normal j
  redraw
  echo "Current colorscheme: " . name
endf
fun! s:SelectColorS()
  50vnew
  setlocal bufhidden=wipe buftype=nofile nonu fdc=0
  file ColorSchemeSelector
  let files = split(glob(expand('~/.vim/colors/').'*'))
  let runtime_files = split(glob(expand('$VIMRUNTIME/colors/').'*'))

  let idx = 1
  cal setline(idx,"== From Vim Runtime ==")
  let idx+=1
  for file in runtime_files
    let name = matchstr( file , '\w\+\(\.vim\)\@=' )
    if strlen(name) > 0
      cal setline(idx,name)
      let idx+=1
    endif
  endfor

  cal setline(idx,"== From User Vim Runtime ==")
  let idx+=1
  for file in files
    let name = matchstr( file , '\w\+\(\.vim\)\@=' )
    if strlen(name) > 0
      cal setline(idx,name)
      let idx+=1
    endif
  endfor
  setlocal nomodifiable
  setlocal cursorline

  syn match ColorName +^\w\+$+
  syn match Header    +^==.*+
  if exists( 'g:colors_name' )
    cal search( g:colors_name )
    exec 'syn match CurrentColor +' . g:colors_name . '+'
  endif
  normal zz

  hi CursorLine gui=reverse
  hi CursorName guifg=green
  hi CurrentColor guifg=black guibg=red
  hi link Header Function

  nmap <buffer>  <Enter>  :cal g:SetColor()<CR>
  nmap <buffer>  <C-q>    :q<CR>   
  nmap <buffer>  e        :exec 'tabe ~/.vim/colors/' . getline('.') . '.vim'<CR>
endf
com! SelectColorS   :cal s:SelectColorS()
com! EditCurrentColorS :exec printf('tabe ~/.vim/colors/%s.vim',colors_name)
