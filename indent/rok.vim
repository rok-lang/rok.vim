" Simple brace-based indent for rok.
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GetRokIndent()
setlocal indentkeys=0{,0},0),0],!^F,o,O

if exists("*GetRokIndent")
  finish
endif

function! GetRokIndent() abort
  let prevlnum = prevnonblank(v:lnum - 1)
  if prevlnum == 0
    return 0
  endif
  let prev = getline(prevlnum)
  let ind = indent(prevlnum)
  " Indent after a line ending in an opener.
  if prev =~ '[{([]\s*$'
    let ind += shiftwidth()
  endif
  " Dedent a line that starts with a closer.
  if getline(v:lnum) =~ '^\s*[}\])]'
    let ind -= shiftwidth()
  endif
  return ind
endfunction
