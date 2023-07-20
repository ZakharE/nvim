local debug_grp = vim.api.nvim_create_augroup("GoDebugGroup", { clear = true })
vim.api.nvim_create_autocmd("ExitPre", {
  pattern = "*.go",
  command = "GoBreakSave",
  group = debug_grp
})

--vim.api.nvim_create_autocmd("BufReadPost", {
--  pattern = "*.go",
  -- callback = function()
  --   local dap = utils.load_plugin('nvim-dap', 'dap')
  --   if not dap then
  --     return
  --   end
  --   print('lol')
  -- end,
  -- once = true,
  -- group = debug_grp
--})
--ExitPre
--UIEnter
