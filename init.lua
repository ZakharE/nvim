require("plugins")
require("autocompletion")
require("ui")
require('neoclipboard')
require("git")
--require("autocmds")
require("mason").setup()
require('telescope').load_extension('neoclip')






vim.o.termguicolors = true
vim.o.syntax = 'on'
vim.o.errorbells = false
vim.o.smartcase = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.showmode = false
vim.bo.swapfile = false
vim.o.backup = false
vim.o.undodir = vim.fn.stdpath('config') .. '/undodir'
vim.o.undofile = true
vim.o.incsearch = true
vim.o.hidden = true
vim.o.completeopt = 'menuone,noinsert,noselect'
vim.bo.autoindent = true
vim.bo.smartindent = true
vim.o.smartcase = true
vim.o.igonrecase = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = 'yes'
vim.wo.wrap = false
vim.o.clipboard='unnamed'



vim.g.mapleader = ' '
local key_mapper = function(mode, key, result)
  vim.api.nvim_set_keymap(
    mode,
    key,
    result,
    { noremap = true, silent = true }
  )
end


key_mapper('i', 'jk', '<ESC>')
key_mapper('n', '<leader>h', ':nohl<CR>')
key_mapper('n', '<leader>s', ':w<CR>')

local wk = require('which-key')
wk.register({
  ['<leader>f'] = { name = "+Find" },
  ['<leader>ff'] = { '<cmd>Telescope find_files<cr>', 'Find file' },
  ['<leader>fg'] = { '<cmd>Telescope live_grep<cr>', 'Grep file' },
  ['<leader>fb'] = { '<cmd>Telescope buffers<cr>', 'Find buffer' },
  ['<leader>fh'] = { '<cmd>Telescope help_tags<cr>', 'Find in help tags' },
  ['<leader>fy'] = { '<cmd>Telescope neoclip<cr>', "Find in yanked list" },
  ['<leader>fa'] = { '<cmd>Telescope lsp_workspace_symbols<cr>', "Find in workspace symbols" }
})

local keymap = vim.keymap.set


-- Lazygit
wk.register({
  ["<Leader>gg"] = { "<cmd>LazyGit<CR>", "Call Lazygit" }
})


keymap({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")
-- Lua

wk.register(
  {
    ["<leader>t"] = { name = "+File tree" },
    ["<leader>tf"] = { "<cmd>:NvimTreeFindFile<CR>", "focus on current file" },
    ["<leader>tt"] = { "<cmd>:NvimTreeToggle<CR>", "Toggle tree" }
  }
)

-- Diagnostic jump with filters such as only jumping to an error
-- keymap("n", "[E", function()
--   require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
-- end)
-- keymap("n", "]E", function()
--   require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
-- end)




wk.register({
  ["<leader>xx"] = { "<cmd>TroubleToggle<cr>", "Toggle trouble lit" },
  ["<leader>xw"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Toggle workspace diagnostics" },
  ["<leader>xd"] = { "<cmd>TroubleToggle document_diagnostics<cr>", "Toggle doc diagnostics" },
  ["<leader>xl"] = { "<cmd>TroubleToggle loclist<cr>", "Add to quickfix list" },
  ["<leader>xq"] = { "<cmd>TroubleToggle quickfix<cr>", "Toggle quickfix" },
  ["gR"] = { "<cmd>TroubleToggle lsp_references<cr>", "Toggle refs" }
})

wk.register({
  ['<C-k>'] = { function() require('vgit').hunk_up() end, "Hunk up" },
  ['<C-j>'] = { function() require('vgit').hunk_down() end, "Hunk down" },
  ['<leader>gs'] = { function() require('vgit').buffer_hunk_stage() end, "Hunk stage" },
  ['<leader>gr'] = { function() require('vgit').buffer_hunk_reset() end, "Hunk reset" },
  ['<leader>gp'] = { function() require('vgit').buffer_hunk_preview() end, "Hunk preview" },
  ['<leader>gd'] = { function() require('vgit').project_diff_preview() end, "Diff preview" },
  ['<leader>gf'] = { function() require('vgit').buffer_diff_preview() end, "Buffer diff" }
})

wk.register({
  ["qq"] = {"<cmd>q<cr>", "Close buffer"},
	["<leader>w"]= {function () require('nvim-window').pick() end, "Pick window"}
})

-- Debug
wk.register({
  ["<leader>,d"] = {"<cmd>GoDebug<cr>", "Start debug"},
  ["<leader>,s"] = {"<cmd>GoDbgStop<cr>", "Stop debug"},
  ["<leader>,b"] = {"<cmd>GoBreakToggle<cr>", "Toggle breakpoint"},
  ["<leader>,u"] = {"<cmd>lua require('dapui').open()<cr>", "Open UI"}
})
--java specific
wk.register({
  ["<leader>jt"] = {"<cmd>lua require'jdtls'.test_nearest_method()<cr>"},
  ["<leader>jc"] = {"<cmd>lua require'jdtls'.test_class()<cr>"}
})

vim.cmd("autocmd FileType guihua lua require('cmp').setup.buffer { enabled = false }")
vim.cmd("autocmd FileType guihua_rust lua require('cmp').setup.buffer { enabled = false }")
--require('dotenv').setup()

