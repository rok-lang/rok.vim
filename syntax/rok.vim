" Vim syntax for Rok.
if exists("b:current_syntax")
  finish
endif

" BEGIN keywords: scripts/gen-syntax, from rok-syntax's grammars/keywords.rokon
syn keyword rokKeyword if else match while loop for in return break
syn keyword rokKeyword continue try throw yield await catch finally
syn keyword rokKeyword using
syn keyword rokStorage fn let struct enum trait impl mod type union
syn keyword rokStorage any
syn keyword rokModifier pub unsafe async ref const static extern mut
syn keyword rokOther use where throws rethrows
syn keyword rokOperatorWord as is
syn keyword rokBoolean true false
syn keyword rokNone none
syn keyword rokSelf self Self
syn keyword rokType i8 i16 i32 i64 i128 isize u8 u16 u32 u64 u128 usize
syn keyword rokType f32 f64 bool char str int float c_char
" END keywords

" pkg, sup and rok only before ::; pkg and sub only in pub( ).
syn match   rokPathRoot "\<\%(pkg\|sup\|rok\)\ze::"
syn match   rokModifier "\%(\<pub\s*(\s*\)\@<=\%(pkg\|sub\)\>"

syn match   rokUserType "\<\u\w*\>"

" r#name is an identifier, never a keyword; r#"..."# is a raw string.
syn match   rokRawIdent "\<r#\h\w*"
syn match   rokFunction "\<\%(r#\)\=\h\w*\>\ze\s*("
syn match   rokFuncDef "\%(\<fn\s\+\)\@<=\%(r#\)\=\h\w*"
" name!(..), dep::name!(..), use dep::name!; but not try! or !=.
syn match   rokMacro "\<\%(try!\)\@!\%(r#\)\=\h\w*!=\@!"

syn match   rokNumber "\<0x[0-9a-fA-F_]\+\%((i\|u)\%(8\|16\|32\|64\|128\|size\)\)\=\>"
syn match   rokNumber "\<0b[01_]\+\>"
syn match   rokNumber "\<0o[0-7_]\+\>"
" 1. is a float when no ., digit or name follows.
syn match   rokNumber "\<\d[0-9_]*\.\%([.0-9_]\|\h\)\@!"
syn match   rokNumber "\<\d[0-9_]*\%(\.\d[0-9_]*\)\=\%([eE][+-]\=\d\+\)\=\%(\%(i\|u\)\%(8\|16\|32\|64\|128\|size\)\|f32\|f64\)\=\>"

syn region  rokString start=+\%(\<b\)\="+ skip=+\\"+ end=+"+ contains=rokEscape
syn region  rokRawString start=+\<r\z(#*\)"+ end=+"\z1+
syn region  rokFString matchgroup=rokString start=+f"+ skip=+\\"+ end=+"+ contains=rokEscape,rokInterp
syn region  rokInterp matchgroup=rokInterpDelim start=+{+ end=+}+ contained contains=rokNumber,rokBoolean,rokNone,rokType,rokUserType,rokString,rokRawString,rokRawIdent,rokMacro
syn match   rokEscape "\\." contained
syn match   rokChar "'\%(\\.\|[^'\\]\)'"

syn match   rokComment "//.*$" contains=rokTodo
syn region  rokComment start="/\*" end="\*/" contains=rokTodo
syn keyword rokTodo TODO FIXME XXX NOTE SAFETY contained
syn region  rokAttribute start="#!\=\[" end="\]" contains=rokString

hi def link rokKeyword      Statement
hi def link rokStorage      Structure
hi def link rokModifier     StorageClass
hi def link rokOther        Keyword
hi def link rokOperatorWord Operator
hi def link rokPathRoot     Include
hi def link rokBoolean      Boolean
hi def link rokNone         Constant
hi def link rokSelf         Identifier
hi def link rokType         Type
hi def link rokUserType     Type
hi def link rokFunction     Function
hi def link rokFuncDef      Function
hi def link rokMacro        Macro
hi def link rokNumber       Number
hi def link rokString       String
hi def link rokRawString    String
hi def link rokFString      String
hi def link rokInterpDelim  Special
hi def link rokEscape       SpecialChar
hi def link rokChar         Character
hi def link rokComment      Comment
hi def link rokTodo         Todo
hi def link rokAttribute    PreProc

let b:current_syntax = "rok"
