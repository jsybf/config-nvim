local buf_utils = require 'utils.buf-util'
local out_buf_id = buf_utils.create_scretch_buf()
buf_utils.split_set_buf(out_buf_id)


-- stylua: ignore
local term_buf_id = vim.iter(vim.api.nvim_tabpage_list_wins(0))
  :map(function(win_id) return vim.api.nvim_win_get_buf(win_id) end)
  :filter(function(buf_id) return vim.api.nvim_get_option_value('buftype', { buf = buf_id }) == 'terminal' end)
  :peek()

if term_buf_id == nil then
  error 'no terimal buffer in current tab'
end

local function send_key(win_id, key)
  if win_id == nil then
    error 'win_id is nil'
  end

  local cur_buf_id = vim.api.nvim_get_current_win()

  vim.api.nvim_set_current_win(win_id)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('G', true, false, true), 'n', false)

  -- vim.api.nvim_set_current_win(cur_buf_id)
end

local function scroll_down(win_id)
  local buf_id = vim.api.nvim_win_get_buf(win_id)
  local last_line = vim.api.nvim_buf_line_count(buf_id)
  vim.api.nvim_win_set_cursor(win_id, { last_line, 0 })
end

local function buf_to_win(buf_id)
  -- stylua: ignore
  return vim.iter(vim.api.nvim_list_wins())
  :filter(function(win_id) return vim.api.nvim_win_get_buf(win_id) == buf_id end)
  :peek()
end

scroll_down(buf_to_win(term_buf_id))

local cur_buf_id = vim.api.nvim_get_current_buf()
buf_utils.append_text_to_buf(out_buf_id, { string.format('current_buf_id: %d', cur_buf_id), '' })
buf_utils.append_text_to_buf(out_buf_id, { string.format('term_buf_id: %d', term_buf_id or -1) })
