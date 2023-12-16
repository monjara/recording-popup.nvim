vim.api.nvim_create_autocmd({ 'RecordingEnter' }, {
  callback = function()
    require('recording-popup').createPopup()
  end
})

vim.api.nvim_create_autocmd({ 'RecordingLeave' }, {
  callback = function()
    require('recording-popup').closePopup()
  end
})
