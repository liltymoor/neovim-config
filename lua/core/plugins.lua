local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

    {
        "nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            "s1n7ax/nvim-window-picker"
	}
    },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup()
    end
  },
{
  'navarasu/onedark.nvim',
  config = function()
    require('onedark').setup {
      style = 'darker',
      colors = {
        purple = '#a9a1e1', -- настраиваем пурпурный оттенок
        grey = '#3B4048'
      }
    }
    require('onedark').load()
  end
},
{
  'sakhnik/nvim-gdb',
  run = ':TSUpdate asm',
  ft = 'asm'
},
{
  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate',
  config = function()
    require'nvim-treesitter.configs'.setup {
      ensure_installed = { "html", "markdown", "markdown_inline", "asm", "make" }, -- Убедитесь, что markdown и другие языки установлены
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    }
  end
},
    {
      "OXY2DEV/markview.nvim",
      lazy = false,      -- Recommended
      -- ft = "markdown" -- If you decide to lazy-load anyway
  
      dependencies = {
          -- You will not need this if you installed the
          -- parsers manually
          -- Or if the parsers are in your $RUNTIMEPATH
          "nvim-treesitter/nvim-treesitter",
  
          "nvim-tree/nvim-web-devicons"
      }
    },
    
})



