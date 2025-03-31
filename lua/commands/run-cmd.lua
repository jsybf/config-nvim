local buf_util = require 'utils.buf-util'
local M = {}

function M.run_cmd(opts)
  local command = opts.args
  local output = vim.fn.systemlist(command)

  local output_buf_id = buf_util.create_scretch_buf()
  buf_util.append_text_to_buf(output_buf_id, output)
  buf_util.split_set_buf(output_buf_id)
end

return M
