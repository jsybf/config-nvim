local buf_utils = require 'utils.buf-util'
local output_buf = buf_utils.create_scretch_buf()
buf_utils.split_set_buf(output_buf)

---@param object any
local function output_inspect(object)
  buf_utils.append_text_to_buf(output_buf, vim.inspect(object))
end

---@param texts string
local function output_text(texts)
  buf_utils.append_text_to_buf(output_buf, texts)
end

local function get_buf_info(buf_id)
  return {
    id = buf_id,
    name = vim.api.nvim_buf_get_name(buf_id),
    buftype = vim.api.nvim_get_option_value('buftype', { buf = buf_id }),
    bufhidden = vim.api.nvim_get_option_value('bufhidden', { buf = buf_id }),
    if_hidden = vim.fn.getbufinfo(buf_id)[1].hidden,
    loaded = vim.api.nvim_buf_is_loaded(buf_id),
  }
end

-- stylua: ignore
vim.iter(vim.api.nvim_list_bufs())
  :map(function(buf_id) return get_buf_info(buf_id) end)
  :each(function(buf_info) output_inspect(buf_info) end)

output_text 'get buffer of windows'
-- stylua: ignore
vim.iter(vim.api.nvim_list_wins())
  :map(function(win_id) return vim.api.nvim_win_get_buf(win_id) end)
  :map(function(buf_id) return get_buf_info(buf_id) end)
  :each(function(buf_info) output_inspect(buf_info) end)

output_text 'get buffer of current tab window'
-- stylua: ignore
vim.iter(vim.api.nvim_tabpage_list_wins(0))
  :map(function(win_id) return vim.api.nvim_win_get_buf(win_id) end)
  :map(function(buf_id) return get_buf_info(buf_id) end)
  :each(function(buf_info) output_inspect(buf_info) end)
