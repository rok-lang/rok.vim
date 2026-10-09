" Vim syntax for rok.
if exists("b:current_syntax")
  finish
endif

syn keyword rokKeyword if else match while loop for return break continue
syn keyword rokKeyword try throw async await yield catch finally in where
syn keyword rokKeyword throws rethrows using
syn keyword rokStorage fn let struct enum trait impl type const static mod union
syn keyword rokModifier pub unsafe ref mut extern
syn keyword rokUse use as is
syn keyword rokBoolean true false none
syn keyword rokSelf self Self pkg any

syn keyword rokType i8 i16 i32 i64 i128 isize u8 u16 u32 u64 u128 usize
syn keyword rokType f32 f64 bool char str int float
syn match   rokUserType "\<\u\w*\>"

syn match   rokFunction "\<\h\w*\>\ze\s*(" 
syn match   rokFuncDef "\<fn\>\s\+\zs\h\w*" 

syn match   rokNumber "\<0x[0-9a-fA-F_]\+\%((i\|u)\%(8\|16\|32\|64\|128\|size\)\)\=\>"
syn match   rokNumber "\<0b[01_]\+\>"
syn match   rokNumber "\<\d[0-9_]*\%(\.\d[0-9_]*\)\=\%([eE][+-]\=\d\+\)\=\%(\%(i\|u\)\%(8\|16\|32\|64\|128\|size\)\|f32\|f64\)\=\>"

syn region  rokString start=+"+ skip=+\\"+ end=+"+ contains=rokEscape
syn region  rokFString matchgroup=rokString start=+f"+ skip=+\\"+ end=+"+ contains=rokEscape,rokInterp
syn region  rokInterp matchgroup=rokInterpDelim start=+{+ end=+}+ contained contains=rokNumber,rokBoolean,rokType,rokUserType,rokString
syn match   rokEscape "\\." contained
syn match   rokChar "'\%(\\.\|[^'\\]\)'"

syn match   rokComment "//.*$" contains=rokTodo
syn region  rokComment start="/\*" end="\*/" contains=rokTodo
syn keyword rokTodo TODO FIXME XXX NOTE SAFETY contained
syn region  rokAttribute start="#!\=\[" end="\]" contains=rokString

hi def link rokKeyword      Statement
hi def link rokStorage      Structure
hi def link rokModifier     StorageClass
hi def link rokUse          Include
hi def link rokBoolean      Boolean
hi def link rokSelf         Identifier
hi def link rokType         Type
hi def link rokUserType     Type
hi def link rokFunction     Function
hi def link rokFuncDef      Function
hi def link rokNumber       Number
hi def link rokString       String
hi def link rokFString      String
hi def link rokInterpDelim  Special
hi def link rokEscape       SpecialChar
hi def link rokChar         Character
hi def link rokComment      Comment
hi def link rokTodo         Todo
hi def link rokAttribute    PreProc

let b:current_syntax = "rokon"
