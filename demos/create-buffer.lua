local buf_utils = require 'utils.buf-util'
local output_buf = buf_utils.create_scretch_buf()
buf_utils.split_set_buf(output_buf)

---@param buf_id number
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

local buf_id = vim.api.nvim_create_buf(false, false)

buf_utils.append_text_to_buf(output_buf, vim.inspect(vim.fn.getbufinfo(buf_id)[1]))
buf_utils.append_text_to_buf(output_buf, vim.inspect(get_buf_info(buf_id)))
