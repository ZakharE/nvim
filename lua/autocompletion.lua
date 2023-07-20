require('mini.surround').setup()

require 'nvim-treesitter.configs'.setup {
  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,
  ensure_installed = { "lua", "go", "html" },
  highlight = {
    enable = true
  },
  autotag = {
    enable = true
  }
}

--LSP
local lspconfig = require "lspconfig"
local util = require "lspconfig/util"
-- Since we installed lspconfig and imported it, we can reach
-- gopls by lspconfig.gopls
-- we can then set it up using the setup and insert the needed configurations
lspconfig.html.setup {}
lspconfig.docker_compose_language_service.setup {}
lspconfig.dockerls.setup {}
lspconfig.lua_ls.setup {}
lspconfig.yamlls.setup {}
lspconfig.clangd.setup {}

require 'go'.setup({
  goimport = 'gopls', -- if set to 'gopls' will use golsp format
  gofmt = 'gopls',    -- if set to gopls will use golsp format
  max_line_len = 120,
  tag_transform = false,
  test_dir = '',
  comment_placeholder = '   ',
  lsp_cfg = true,       -- false: use your own lspconfig
  lsp_keymaps = false,
  lsp_gofumpt = true,   -- true: set default gofmt in gopls format to gofumpt
  lsp_on_attach = true, -- use on_attach from go.nvim
  dap_debug = true,
  test_efm = true
})


-- Floating terminal
local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require('go.format').goimport()
  end,
  group = format_sync_grp,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require 'lspconfig'.html.setup {
  capabilities = capabilities,
}


vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert', 'preview' }
vim.opt.shortmess = vim.opt.shortmess + { c = true }


local cmp = require 'cmp'
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      --vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  mapping = {
    -- Shift+TAB to go to the Previous Suggested item
    ['<C-K>'] = cmp.mapping.select_prev_item(),
    -- Tab to go to the next suggestion
    ['<C-J>'] = cmp.mapping.select_next_item(),
    -- CTRL+SHIFT+f to scroll backwards in description
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    -- CTRL+F to scroll forwards in the description
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    -- CTRL+SPACE to bring up completion at current Cursor location
    ['<C-Space>'] = cmp.mapping.complete(),
    -- CTRL+e to exit suggestion and close it
    ['<C-e>'] = cmp.mapping.close(),
    -- CR (enter or return) to CONFIRM the currently selection suggestion
    -- We set the ConfirmBehavior to insert the Selected suggestion
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- sources are the installed sources that can be used for code suggestions
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp',               keyword_length = 1 },
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lua',               keyword_length = 1 },
    { name = 'buffer',                 keyword_length = 1 },
    { name = 'luasnip',                keyword_length = 1 },
  }
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
