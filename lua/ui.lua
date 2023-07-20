-- require("noice").setup({
--   lsp = {
--     -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
--     override = {
--       ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
--       ["vim.lsp.util.stylize_markdown"] = true,
--       ["cmp.entry.get_documentation"] = true,
--     },
--   },
--
--  presets = {
--     -- you can enable a preset by setting it to true, or a table that will override the preset config
--     -- you can also add custom presets that you can enable/disable with enabled=true
--     bottom_search = false, -- use a classic bottom cmdline for search
--     command_palette = false, -- position the cmdline and popupmenu together
--     long_message_to_split = true, -- long messages will be sent to a split
--     inc_rename = false, -- enables an input dialog for inc-rename.nvim
--     lsp_doc_border = false, -- add a border to hover docs and signature help
--   },
-- })

--require("telescope").load_extension("noice")

require("neodev").setup({
   library = { plugins = { "nvim-dap-ui" }, types = true }
})

require('nvim-cursorline').setup {
  cursorline = {
    enable = true,
    timeout = 100,
    number = false,
  },
  cursorword = {
    enable = true,
    min_length = 2,
    hl = { underline = true },
  }
}

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup()


require('lualine').setup({
  sections = {
    lualine_x = {
      {
        -- require("noice").api.statusline.mode.get,
        -- cond = require("noice").api.statusline.mode.has,
        -- color = { fg = "#ff9e64" },
      }
    }
  }
})

vim.cmd.colorscheme "catppuccin"
