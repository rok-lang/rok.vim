# Rok for Vim and Neovim

Rok language support for Vim and Neovim: syntax highlighting and filetype
settings for `.rok` and `.rokon`, tree-sitter highlighting on Neovim, plus
(on Neovim) the rok language server `rokls` wired up through the built-in
LSP client.

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

## Highlighting

Neovim highlights with tree-sitter when the `rok` and `rokon` parsers are
installed, and with the Vim syntax in `syntax/` otherwise. The parsers
are built from [rok-syntax](https://github.com/rok-lang/rok-syntax);
this plugin registers them with
[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
(`master` or `main` branch) and ships the queries, so:

```vim
:TSInstall rok rokon
```

Load nvim-treesitter before this plugin, or `:TSInstall` will not know
`rok`. Without nvim-treesitter, build the parsers from a rok-syntax
checkout with the tree-sitter CLI:

```sh
tree-sitter build -o ~/.local/share/nvim/site/parser/rok.so tree-sitter/rok
tree-sitter build -o ~/.local/share/nvim/site/parser/rokon.so tree-sitter/rokon
```

```lua
vim.g.rok_treesitter = 0   -- keep the Vim syntax on Neovim
```

Vim uses `syntax/rok.vim` and `syntax/rokon.vim`; their keyword lines
come from rok-syntax's keyword lists, and the ROKON syntax knows only
ROKON's values.

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

## Development

`queries/` and the keyword lines of `syntax/` (between `" BEGIN keywords`
and `" END keywords`) are copies of rok-syntax at the commit in
`rok-syntax.rev`. Change them there, then sync:

```sh
scripts/sync --from ../rok-syntax   # copy from a checkout, pin its HEAD
scripts/sync                        # fetch at the pinned commit
scripts/sync --check                # what CI runs
```

## License

Licensed under either of [MIT](LICENSE-MIT) or [Apache-2.0](LICENSE-APACHE), at your option.
