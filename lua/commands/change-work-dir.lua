local M = {}

function M.set_cwd_to_buf_dir()
  local buf_dir_path = vim.fn.expand '%:p:h'
  vim.api.nvim_set_current_dir(buf_dir_path)
end

return M
