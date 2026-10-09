" rok filetype settings.
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setlocal commentstring=//\ %s
setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://
setlocal expandtab
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal textwidth=0

let b:undo_ftplugin = "setlocal commentstring< comments< expandtab< shiftwidth< softtabstop< textwidth<"
