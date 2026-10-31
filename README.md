# Rok for Vim and Neovim

Rok language support for Vim and Neovim: syntax highlighting and filetype
settings for `.rok` and `.rokon`, plus (on Neovim) the rok language server
`rokls` wired up through the built-in LSP client.

## Install

Point your plugin manager at this repository:

```vim
" vim-plug
Plug 'rok-lang/rok.vim'
```

```lua
-- lazy.nvim
{ "rok-lang/rok.vim" }
```

Or add it to your runtimepath directly:

```vim
set runtimepath^=/path/to/rok.vim
```

## Language server (Neovim)

Install the toolchain so `rokls` is on your `PATH`
(<https://rok-lang.org/download.html>); `plugin/rok.lua` then starts the
server for every rok buffer automatically.

```lua
vim.g.rok_lsp = 0                 -- turn the server off (highlighting stays)
vim.g.rok_server = "/path/rokls"  -- override the command (string or table)
```

The server gives hover (`K`), go to definition, completion (`<C-x><C-o>`),
signature help (`<C-s>` in insert mode), rename (`grn`) and quick fixes
(`gra`), including `rok add` for a missing stone. The keys are Neovim 0.11's
defaults.

### Classic Vim, coc.nvim, vim-lsp

`rokls` speaks LSP over stdin/stdout, so point any client at it:

```jsonc
// coc-settings.json
{ "languageserver": { "rok": { "command": "rokls", "filetypes": ["rok"] } } }
```

```vim
" vim-lsp
if executable('rokls')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'rokls', 'cmd': {->['rokls']}, 'allowlist': ['rok'] })
endif
```

## License

Licensed under either of [MIT](LICENSE-MIT) or [Apache-2.0](LICENSE-APACHE), at your option.
