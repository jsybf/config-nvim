local function lang_keymap(lang, mode, key, cmd, desc)
  vim.api.nvim_create_autocmd('FileType', {
    pattern = lang,
    callback = function()
      vim.keymap.set('n', key, cmd, { buffer = true, desc = desc })
    end,
  })
end

local telescope_builtin_status, telescope_builtin = pcall(require, 'telescope.builtin')
local bookmark_picker_status, bookmark_picker = pcall(require, 'telescope-conf.folder-bookmark-picker')
local select_exec_term_status, select_exec_term = pcall(require, 'commands.terminal')

-- basic keymap
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
-- switch between tabs
vim.api.nvim_set_keymap('n', '<leader>h', ':tabprevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>l', ':tabnext<CR>', { noremap = true, silent = true })
-- terminal keymap
vim.keymap.set('n', '<leader>t', ':tab term<CR>', { noremap = true, silent = true })
vim.keymap.set('t', 'jk', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
lang_keymap('lua', 'n', '<leader>rr', ':w | source % <CR>', 'save and execute nvim lua script')

if telescope_builtin_status then
  vim.keymap.set('n', '<leader>sh', telescope_builtin.help_tags, { desc = '[S]earch [H]elp' })
  vim.keymap.set('n', '<leader>sk', telescope_builtin.keymaps, { desc = '[S]earch [K]eymaps' })
  vim.keymap.set('n', '<leader>sf', telescope_builtin.find_files, { desc = '[S]earch [F]iles' })
  vim.keymap.set('n', '<leader>ss', telescope_builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
  vim.keymap.set('n', '<leader>sw', telescope_builtin.grep_string, { desc = '[S]earch current [W]ord' })
  vim.keymap.set('n', '<leader>sg', telescope_builtin.live_grep, { desc = '[S]earch by [G]rep' })
  vim.keymap.set('n', '<leader>sd', telescope_builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  vim.keymap.set('n', '<leader>sr', telescope_builtin.resume, { desc = '[S]earch [R]esume' })
  vim.keymap.set('n', '<leader>s.', telescope_builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
  vim.keymap.set('n', '<leader>sl', telescope_builtin.lsp_dynamic_workspace_symbols, { desc = '[S]earch [L]sp workspace symbolsl ' })
  vim.keymap.set('n', '<leader>sc', telescope_builtin.current_buffer_fuzzy_find)
  vim.keymap.set('n', '<leader>sb', telescope_builtin.buffers)
end

if bookmark_picker_status then
  vim.keymap.set('n', '<leader>bf', bookmark_picker.folder_bookmark_picker)
end

if select_exec_term_status then
  vim.keymap.set('v', '<leader>r', select_exec_term.execute_selected_in_terminal, {})
  vim.keymap.set('n', '<leader>u', function()
    return select_exec_term.paste_shell_history(100, 2000)
  end, { desc = 'Load previous Zsh commands one by one' })
end
