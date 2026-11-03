-- Neovim: tree-sitter highlighting when the rok/rokon parsers load,
-- syntax/ otherwise. Queries are rok-syntax's, copied into queries/.
--   vim.g.rok_treesitter = 0    -- keep the Vim syntax
-- `:TSInstall rok rokon` (nvim-treesitter) builds the parsers; any
-- parser/rok.so on the runtimepath works too.
if vim.fn.has("nvim-0.9") == 0 then
  return
end

local function install_info(lang)
  return {
    url = "https://github.com/rok-lang/rok-syntax",
    location = "tree-sitter/" .. lang,
    files = { "src/parser.c", "src/scanner.c" },
    branch = "main",
  }
end

-- nvim-treesitter master: configs behind get_parser_configs().
-- main: a plain table, rebuilt on `User TSUpdate`.
local function register()
  local ok, parsers = pcall(require, "nvim-treesitter.parsers")
  if not ok or type(parsers) ~= "table" then
    return
  end
  for _, lang in ipairs({ "rok", "rokon" }) do
    if type(parsers.get_parser_configs) == "function" then
      parsers.get_parser_configs()[lang] = { install_info = install_info(lang), filetype = lang }
    else
      local info = install_info(lang)
      info.files = nil
      parsers[lang] = { install_info = info, tier = 3 }
    end
  end
end

local group = vim.api.nvim_create_augroup("rok_treesitter", { clear = true })
register()
vim.api.nvim_create_autocmd("User", { pattern = "TSUpdate", group = group, callback = register })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "rok", "rokon" },
  group = group,
  callback = function(args)
    if vim.g.rok_treesitter == 0 then
      return
    end
    local lang = vim.bo[args.buf].filetype
    -- Without a parser, add() errors or returns nil depending on the
    -- Neovim version; inspect() always errors.
    pcall(vim.treesitter.language.add, lang)
    if not pcall(vim.treesitter.language.inspect, lang) then
      return
    end
    pcall(vim.treesitter.start, args.buf, lang)
  end,
})
