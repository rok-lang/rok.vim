-- Neovim: start rokls for rok buffers with the built-in LSP client.
-- Put this repo on the runtimepath (any plugin manager, or
-- `set rtp+=/path/to/editors/vim`). No extra plugin is needed.
--   vim.g.rok_lsp = 0           -- turn the server off (highlighting stays)
--   vim.g.rok_server = "rokls"  -- or a full path / { "rokls", "--flag" }
if vim.fn.has("nvim-0.8") == 0 then
  return
end

-- Neovim 0.9+ applies the server's semantic tokens automatically; link the
-- rok ones (macro calls, user-defined literal suffixes) to sensible groups
-- as a default, so they are coloured even when a colorscheme omits them.
if vim.fn.has("nvim-0.9") == 1 then
  vim.api.nvim_set_hl(0, "@lsp.type.macro.rok", { link = "Macro", default = true })
  vim.api.nvim_set_hl(0, "@lsp.type.decorator.rok", { link = "PreProc", default = true })
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "rok",
  group = vim.api.nvim_create_augroup("rok_lsp", { clear = true }),
  callback = function(args)
    if vim.g.rok_lsp == 0 then
      return
    end
    local cmd = vim.g.rok_server or "rokls"
    local exe = type(cmd) == "table" and cmd[1] or cmd
    if vim.fn.executable(exe) == 0 then
      return
    end
    local root
    if vim.fs and vim.fs.root then
      root = vim.fs.root(args.buf, { "rok.rokon", "rok.lock", ".git" })
    end
    vim.lsp.start({
      name = "rokls",
      cmd = type(cmd) == "table" and cmd or { cmd },
      root_dir = root or vim.fn.getcwd(),
    })
  end,
})
