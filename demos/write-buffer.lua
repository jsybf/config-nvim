local buf_id = vim.api.nvim_create_buf(false, true)

for i = 1, 50 do
  vim.api.nvim_buf_set_lines(buf_id, i - 1, i - 1, false, { string.rep('*', 100) })
end

-- stylua: ignore
vim.api.nvim_buf_set_lines( buf_id, 51 - 1, 100 , false,
  vim.iter(vim.fn.range(50)):map(function() return  string.rep('*', 100) end):totable()
)

for i = 1, 9 do
  vim.api.nvim_buf_set_text(buf_id, i - 1, i - 1, i - 1, i, { tostring(i) })
end
vim.api.nvim_buf_set_text(buf_id, 10 - 1, 10 - 1, 10 - 1, 10 - 1 + 9, { '123456789' })
vim.api.nvim_buf_set_text(buf_id, 11 - 1, 10 - 1, 11 - 1, 10 - 1 + 8, { '123456789' })
vim.api.nvim_buf_set_text(buf_id, 12 - 1, 10 - 1, 12 - 1, 10 - 1 + 10, { '123456789' })
vim.api.nvim_buf_set_text(buf_id, 13 - 1, 10 - 1, 13 - 1, 10 - 1 + 9, { string.rep(' ', 9) })
vim.api.nvim_buf_set_text(buf_id, 14 - 1, 10 - 1, 14 - 1, 10 - 1 + 9, { string.rep(' ', 9) })

vim.cmd 'split'
local splitted_win = vim.api.nvim_get_current_win()
vim.api.nvim_win_set_buf(splitted_win, buf_id)
