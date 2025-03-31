local M = {}
function M.create_scretch_buf()
  local scretch_buf = vim.api.nvim_create_buf(false, false)
  vim.bo[scretch_buf].bufhidden = 'wipe'
  vim.bo[scretch_buf].buftype = 'nofile'
  vim.bo[scretch_buf].swapfile = false
  vim.bo[scretch_buf].buflisted = false

  return scretch_buf
end

function M.split_set_buf(buf)
  vim.cmd 'split'
  local splitted_win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(splitted_win, buf)
end

function M.vsplit_set_buf(buf)
  vim.cmd 'split'
  local splitted_win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(splitted_win, buf)
end

function M.append_lines_to_buf(buf_id, lines)
  local line = vim.api.nvim_buf_line_count(buf_id)
  if line == 1 then
    vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
  else
    vim.api.nvim_buf_set_lines(buf_id, line, -1, false, lines)
  end
end

function M.append_text_to_buf(buf_id, texts)
  local line = vim.api.nvim_buf_line_count(buf_id)

  if line == 1 then
    vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, vim.split(texts, '\n'))
  else
    vim.api.nvim_buf_set_lines(buf_id, line, -1, false, vim.split(texts, '\n'))
  end
end

return M
