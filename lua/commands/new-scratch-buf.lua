local buf_util = require 'utils.buf-util'
local M = {}

function M.vsplit_buf()
  local buf_id = buf_util.create_scretch_buf()
  vim.api.nvim_open_win(buf_id, true, { split = 'right', win = 0 })
end

function M.split_buf()
  local buf_id = buf_util.create_scretch_buf()
  vim.api.nvim_open_win(buf_id, true, { split = 'below', win = 0 })
end

return M
