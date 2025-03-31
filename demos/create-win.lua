local buf_id = vim.api.nvim_create_buf(false, true)
vim.api.nvim_buf_set_lines(buf_id, 0, 0, false, { 'this is scratch buffer' })
vim.api.nvim_open_win(buf_id, false, { split = 'below', win = 0 })
vim.api.nvim_open_win(buf_id, false, { split = 'right', win = 0 })
