" Vim syntax for ROKON, Rok's data format: values, no Rok keywords.
if exists("b:current_syntax")
  finish
endif

" BEGIN keywords: scripts/gen-syntax, from rok-syntax's grammars/keywords.rokon
syn keyword rokonBoolean true false
syn keyword rokonNone none
" END keywords

syn match   rokonType "\<\u\w*\>"
syn match   rokonPath "\<\h\w*\ze::"
" A name before a single `:` is a field; true, false and none stay values.
syn match   rokonField "\<\%(r#\)\=\h\w*\ze\s*:\%(:\)\@!"

syn match   rokonNumber "\<0x[0-9a-fA-F_]\+\>"
syn match   rokonNumber "\<0b[01_]\+\>"
syn match   rokonNumber "\<0o[0-7_]\+\>"
syn match   rokonNumber "\<\d[0-9_]*\%(\.\d[0-9_]*\)\=\%([eE][+-]\=\d\+\)\=\>"

syn region  rokonString start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=rokonEscape
syn region  rokonRawString start=+\<r\z(#*\)"+ end=+"\z1+
syn match   rokonEscape "\\\%(u{[0-9a-fA-F_]*}\|x\x\x\|.\)" contained
syn match   rokonChar "'\%(\\\%(u{[0-9a-fA-F_]*}\|x\x\x\|.\)\|[^'\\]\)'" contains=rokonEscape

syn match   rokonComment "//.*$" contains=rokonTodo
syn region  rokonComment start="/\*" end="\*/" contains=rokonComment,rokonTodo
syn keyword rokonTodo TODO FIXME XXX NOTE contained

hi def link rokonBoolean    Boolean
hi def link rokonNone       Constant
hi def link rokonType       Type
hi def link rokonPath       Include
hi def link rokonField      Identifier
hi def link rokonNumber     Number
hi def link rokonString     String
hi def link rokonRawString  String
hi def link rokonEscape     SpecialChar
hi def link rokonChar       Character
hi def link rokonComment    Comment
hi def link rokonTodo       Todo

let b:current_syntax = "rokon"
