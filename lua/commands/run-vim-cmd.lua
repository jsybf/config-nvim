local logger = require('logging'):new(nil)
local buf_util = require 'utils.buf-util'

local M = {}

function M.run_vim_cmd(args)
  local cmd = ':' .. args['args']

  local success, cmd_output = pcall(vim.api.nvim_exec2, cmd, { output = true })
  if success then
    logger:info('executed vim command: ' .. cmd)
  else
    logger:error('failed to executed vim command: ' .. cmd)
    return
  end

  local output_buf_id = buf_util.create_scretch_buf()
  buf_util.append_text_to_buf(output_buf_id, cmd_output)
  buf_util.split_set_buf(output_buf_id)
end

function M.run_vim_lua_cmd_inpsect(args)
  local cmd = string.format(':lua= vim.inspect(%s)', args['args'])

  local success, cmd_output = pcall(vim.api.nvim_exec2, cmd, { output = true })
  if success then
    logger:info('executed vim command: ' .. cmd)
  else
    logger:error('failed to executed vim command: ' .. cmd)
    return
  end

  local output_buf_id = buf_util.create_scretch_buf()
  buf_util.append_text_to_buf(output_buf_id, cmd_output)
  buf_util.split_set_buf(output_buf_id)
end

return M
