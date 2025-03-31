local logger = require('logging'):new(nil)

local M = {}

function M.copy_buffer_file_path(opts)
  -- https://neovim.io/doc/user/builtin.html
  local file_path = vim.fn.expand '%:p'
  vim.fn.system('pbcopy', file_path)
  logger:info('Copied to clipboard: ' .. file_path)
end

return M
