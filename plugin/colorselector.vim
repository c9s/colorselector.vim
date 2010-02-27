
" ColorScheme Selector
" Author: Cornelius  林佑安 (Yo-An Lin) <cornelius.howl@gmail.com>
" ScriptType: plugin
fun! g:SetColor()
  let name = getline('.')
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
  for file in files
    let name = matchstr( file , '\w\+\(\.vim\)\@=' )
    if strlen(name) > 0
      put=name
    endif
  endfor
  normal ggdd
  setlocal nomodifiable
  setlocal cursorline
  hi CursorLine gui=reverse
  nmap <buffer>  <Enter>  :cal g:SetColor()<CR>
  nmap <buffer>  <C-q>    :q<CR>   
  nmap <buffer>  e        :exec 'tabe ~/.vim/colors/' . getline('.') . '.vim'<CR>
endf
com! SelectColorS   :cal s:SelectColorS()
com! EditCurrentColorS :exec printf('tabe ~/.vim/colors/%s.vim',colors_name)
