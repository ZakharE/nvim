local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  "folke/which-key.nvim",
  { "nvim-treesitter/nvim-treesitter" },
  { 'neovim/nvim-lspconfig' },
  {
    "ray-x/go.nvim",
    dependencies = {   -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    -- config = function()
    --   require("go").setup()
    -- end,
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
    build = ':lua require("go.install").update_all_sync()'   -- if you need to install/update all binaries
  },
  { "folke/neoconf.nvim",                 cmd = "Neoconf" },
  "folke/neodev.nvim",
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate"   -- :MasonUpdate updates registry contents
  },
  {
    'ray-x/navigator.lua',
    requires = {
      { 'ray-x/guihua.lua',     run = 'cd lua/fzy && make' },
      { 'neovim/nvim-lspconfig' },
    },
  },
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-nvim-lua' },
  { 'hrsh7th/cmp-nvim-lsp-signature-help' },
  { 'hrsh7th/cmp-vsnip' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/vim-vsnip' },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({})
    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } }
  },
  {
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup {
        -- your config goes here
        -- or just leave it empty :)
      }
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    requires = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  },
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "1.*",   -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp"
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },
  { 'rcarriga/nvim-notify' },
  -- {
  --   "folke/noice.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     -- add any options here
  --   },
  --   dependencies = {
  --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --     "MunifTanjim/nui.nvim",
  --     -- OPTIONAL:
  --     --   `nvim-notify` is only needed, if you want to use the notification view.
  --     --   If not available, we use `mini` as the fallback
  --     "rcarriga/nvim-notify",
  --   }
  -- },
  { 'mfussenegger/nvim-dap' },
  { "rcarriga/nvim-dap-ui",             requires = { "mfussenegger/nvim-dap" } },
  { 'theHamsta/nvim-dap-virtual-text' },
  { 'nvim-telescope/telescope-dap.nvim' },
  { 'yamatsum/nvim-cursorline' },
  {
    'tanvirtin/vgit.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  },
  { 'mg979/vim-visual-multi' },
  { 'nvim-tree/nvim-tree.lua' },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  },
  { 'echasnovski/mini.surround', version = '*' },
  {
    'goolord/alpha-nvim',
    requires = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require 'alpha'.setup(require 'alpha.themes.startify'.config)
    end
  },
  { 'yorickpeterse/nvim-window' },
  { "catppuccin/nvim",           name = "catppuccin", priority = 1000 },
  { "nvim-neotest/neotest-go" },
  {
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-go",
    },
    config = function()
      -- get neotest namespace (api call creates or returns namespace)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message =
                diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)
      require("neotest").setup({
        -- your neotest config here
        adapters = {
          require("neotest-go"),
        },
      })
    end,
  },
  { "shortcuts/no-neck-pain.nvim" },
  { "ellisonleao/dotenv.nvim"}
}
)
