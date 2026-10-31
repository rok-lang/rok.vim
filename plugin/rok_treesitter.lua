-- Neovim: highlight rok and ROKON with tree-sitter when the parsers are
-- installed, with the Vim syntax in syntax/ otherwise. The queries are in
-- queries/rok/ and queries/rokon/ (copies of rok-syntax's).
--   vim.g.rok_treesitter = 0    -- keep the Vim syntax
-- With nvim-treesitter, `:TSInstall rok rokon` builds the parsers from
-- rok-syntax; any `parser/rok.so` on the runtimepath works too.
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

-- nvim-treesitter's `master` branch keeps parser configs behind
-- get_parser_configs(); its `main` branch is a plain table it rebuilds,
-- announcing that with `User TSUpdate`.
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
    -- language.add() errors or returns nil without a parser, by
    -- version; inspect() errors unless the parser loaded.
    pcall(vim.treesitter.language.add, lang)
    if not pcall(vim.treesitter.language.inspect, lang) then
      return
    end
    pcall(vim.treesitter.start, args.buf, lang)
  end,
})
