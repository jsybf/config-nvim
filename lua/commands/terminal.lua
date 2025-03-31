-- <leader> u 를 누르면 zsh의 최근 커맨드를 현제 버퍼에 붙여넣는다.
-- 누를 때마다 그 이전 최근 커맨드를 붙여넣음
-- 3 초가 지나면 다시 최근 커맨드를 가르킨다.

local M = {}

local logger = require('logging'):new(nil)
local hist_idx = 0
local hist = {}
local reset_timer = nil

local function imap(tbl, f)
  local t = {}
  for idx, v in ipairs(tbl) do
    t[idx] = f(v)
  end
  return t
end

local function load_shell_history(hist_size)
  local hist_path = vim.fn.expand '~/.zsh_history'
  local raw_hist = vim.fn.readfile(hist_path)

  local start_idx = math.max(1, #raw_hist - hist_size)

  local last_cmds = imap({ unpack(raw_hist, start_idx, #raw_hist) }, function(raw_line)
    return string.match(raw_line, '.*;(.+)')
  end)

  return last_cmds
end

local function get_selected_text()
  local mode = vim.api.nvim_get_mode().mode
  if mode ~= 'v' and mode ~= 'V' and mode ~= '\22' then
    logger:error 'this function should be called in visual mode'
  end
  -- vim.api.nvim_input '<esc>'

  local lines = vim.fn.getregion(vim.fn.getpos 'v', vim.fn.getpos '.', { type = mode })
  local selected_text = table.concat(lines, '\n')
  print(selected_text)
  return selected_text
end

local function scroll_down(win_id)
  local buf_id = vim.api.nvim_win_get_buf(win_id)
  local last_line = vim.api.nvim_buf_line_count(buf_id)
  vim.api.nvim_win_set_cursor(win_id, { last_line, 0 })
end

local function find_term_win()
  --stylua: ignore
  return vim.iter(vim.api.nvim_tabpage_list_wins(0))
    :filter(function(win_id) return vim.api.nvim_get_option_value('buftype', { buf = vim.api.nvim_win_get_buf(win_id)}) == 'terminal' end)
    :peek()
end

function M.execute_selected_in_terminal()
  local selected_text = get_selected_text()

  local term_win = find_term_win()
 --stylua: ignore
  if term_win == nil then error "can't find terminal buffer in current window" end
  local term_buf = vim.api.nvim_win_get_buf(term_win)

  -- send and execute command
  local term_job_id = vim.bo[term_buf].channel
  vim.fn.chansend(term_job_id, selected_text .. '\r')
  logger:info('executed in terminal: ' .. selected_text)

  scroll_down(term_win)
end

function M.paste_shell_history(hist_size, reset_time)
  print('hist_idx:' .. hist_idx)
  if #hist == 0 then
    hist = load_shell_history(hist_size)
    hist_idx = hist_size
  end

  if reset_timer then
    vim.fn.timer_stop(reset_timer)
  end
  reset_timer = vim.fn.timer_start(reset_time, function()
    hist = {}
    hist_idx = 0
  end)

  if hist_idx and 0 < hist_idx then
    local last_cmd = hist[hist_idx]
    hist_idx = hist_idx - 1
    local line, _ = unpack(vim.api.nvim_win_get_cursor(0))
    vim.api.nvim_buf_set_text(0, line - 1, 0, line - 1, -1, { last_cmd })
  end
end

return M
