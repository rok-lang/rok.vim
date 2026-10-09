-- Neovim: start rokls for rok buffers with the built-in LSP client.
-- Put this repo on the runtimepath (any plugin manager, or
-- `set rtp+=/path/to/editors/vim`). No extra plugin is needed.
--   vim.g.rok_lsp = 0           -- turn the server off (highlighting stays)
--   vim.g.rok_server = "rokls"  -- or a full path / { "rokls", "--flag" }
if vim.fn.has("nvim-0.8") == 0 then
  return
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
