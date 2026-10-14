# rok for Vim and Neovim

Syntax highlighting and filetype settings for `.rok` and `.rokon`, and —
on Neovim — the rok language server (`rokls`) wired up with the built-in
LSP client for completion, hover, go-to-definition, references, rename,
symbols, formatting, and (Neovim 0.9+) semantic highlighting of user-defined macros, literal
suffixes, keywords, operators, derives and attributes.

## Install

Point your plugin manager at this repository, or copy its files onto your
runtimepath.

```vim
" vim-plug
Plug 'rok-lang/rok.vim'
```

```lua
-- lazy.nvim
{ "rok-lang/rok.vim" }
```

Or, without a manager:

```vim
set runtimepath^=/path/to/rok.vim
```

## Language server (Neovim)

With the toolchain installed (so `rokls` is on your `PATH`;
<https://rok-lang.org/download.html>), `plugin/rok.lua` starts the server
for every rok buffer — no configuration needed. Then the usual LSP
mappings work (`vim.lsp.buf.hover`, `definition`, `completion`, ...).

Options:

```lua
vim.g.rok_lsp = 0                 -- turn the server off (highlighting stays)
vim.g.rok_server = "/path/rokls"  -- override the command (string or table)
```

### Classic Vim, coc.nvim, vim-lsp

The server is any LSP over stdin/stdout, so point your client at `rokls`:

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
