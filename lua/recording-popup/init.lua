local M = {}

M.win_id = 0

M.createPopup = function()
  local opts = {
    height = 1,
    width = 16,
    row = 0,
    col = vim.o.columns - 16,
    focusable = false,
    relative = 'editor',
    zindex = 45
  }
  local bufnr = vim.api.nvim_create_buf(false, true)
  local recording = vim.api.nvim_exec('echo reg_recording()', true)
  vim.api.nvim_buf_set_lines(bufnr, 0, 0, true, { ' Recording: ' .. recording })
  M.win_id = vim.api.nvim_open_win(bufnr, false, opts)

  local ns_id = vim.api.nvim_create_namespace('recording')
  vim.api.nvim_win_set_hl_ns(M.win_id, ns_id)
  vim.api.nvim_set_hl(ns_id, 'Normal', { fg = '#eb6ea5' })
end


M.closePopup = function()
  vim.api.nvim_win_hide(M.win_id)
end

M.exec = function()
  vim.api.nvim_create_augroup('monjara-recording-popup', {})

  vim.api.nvim_create_autocmd({ 'RecordingEnter' }, {
    group = 'monjara-recording-popup',
    callback = function()
      require('recording-popup').createPopup()
    end
  })

  vim.api.nvim_create_autocmd({ 'RecordingLeave' }, {
    group = 'monjara-recording-popup',
    callback = function()
      require('recording-popup').closePopup()
    end
  })
end

return M
