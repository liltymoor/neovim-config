-- Basic
require('core.plugins')
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
