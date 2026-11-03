-- Neovim: start rokls for rok buffers with the built-in LSP client.
-- Needs only this repo on the runtimepath.
--   vim.g.rok_lsp = 0           -- turn the server off (highlighting stays)
--   vim.g.rok_server = "rokls"  -- or a full path / { "rokls", "--flag" }
if vim.fn.has("nvim-0.8") == 0 then
  return
end

-- Default links for rok semantic tokens, for colorschemes that lack them.
if vim.fn.has("nvim-0.9") == 1 then
  vim.api.nvim_set_hl(0, "@lsp.type.macro.rok", { link = "Macro", default = true })
  vim.api.nvim_set_hl(0, "@lsp.type.decorator.rok", { link = "PreProc", default = true })
  vim.api.nvim_set_hl(0, "@lsp.type.keyword.rok", { link = "Keyword", default = true })
  vim.api.nvim_set_hl(0, "@lsp.type.operator.rok", { link = "Operator", default = true })
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
