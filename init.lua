-- Basic
require('core.plugins')

-- Cozy binds

vim.opt.number = true
vim.api.nvim_set_keymap('n', 'asm', ':w<CR>:!nasm -felf64 % -o %<.o && ld -o %< %<.o && chmod u+x %< && ./%< <CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-a>', '<esc>gg0VG<CR>', { noremap = true, silent = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = "asm",
    callback = function()
        vim.bo.tabstop = 4
        vim.bo.shiftwidth = 4
        vim.bo.expandtab = true
    end
})

-- Styles

return {
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme gruvbox]])
    end
  },

  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = {
          theme = 'gruvbox' -- Совместим со схемой gruvbox
        }
      }
    end
  },
}

