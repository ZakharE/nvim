
require("neodev").setup({
   library = { plugins = { "nvim-dap-ui" }, types = true }
})


vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup()


require('lualine').setup({
  sections = {
    lualine_x = {
      {
      }
    }
  }
})

vim.cmd.colorscheme "catppuccin"
