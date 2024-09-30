# VygVim - сustom assembly NVIM for vygush

## Старт
Для начала сделайте бэкап текущего конфига:
```bash
mv ~/.config/nvim{,.bak}
```
Дополнительно:
```bash
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
```

Склонируйте VygVim сборку:
```bash
git clone https://github.com/VYGUSH/vygvim ~/.config/nvim
```

Чтобы после добавить сборку в свой репозиторий:
```bash
rm -rf ~/.config/nvim/.git
```

Запускайте!
```bash
nvim
```

## Состав
- Пакетный менеджер - `Lazy`
- Управление файловой системой - `NeoTree`
- Работа с файлами Markdown (Режим просмотра/редактора) - `Markview`


## Инфо как это собиралось
### Первичная настройка

1. Установка (Mac OS)
```bash
brew install nvim
```

2. Создаем директорию для конфигов `nvim`
```bash
mkdir ~/.config/nvim
```

3. Создаем `init.lua`
```bash
touch ~/.config/nvim/init.lua
```

4. Создаем структуру директорий, где будут располагаться плагины
    1. Папка `lua`, чтобы `nvim` принял `lua` модули
        ```bash
        mkdir ~/.config/nvim/lua
        ```
    2. Папка `core`, здесь будут корневое подключение плагинов, цвета, конфигурации, маппинги и прочее
        ```bash
        mkdir ~/.config/nvim/lua/core
        ```
    3. Папка `plugins`, здесь будут конфигурации самих плагинов
        ```bash
        mkdir ~/.config/nvim/lua/plugins
        ```

5. В папке `core` создаем `plugins.lua`, здесь будет подключаться плагинный менеджер и добавляться доп плагины
```bash
touch ~/.config/nvim/lua/core/plugins.lua
```

6. Устанавливаем плагин менеджер lazy (https://github.com/folke/lazy.nvim). В `plugins.lua` прописываем загрузчик и ниже вызов (установщик)
```bash
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

})
```

7. Далее в `init.lua` прописываем базовую конфигурацию и плагин. В базовую прописываем все, что находистя в `plugins` 
```bash
-- Basic
require('core.plugins')
```

8. После можно запустить `nvim`, пакетный менеджер можно открыть командой 
```nvim
:Lazy
```


### Плагины
1. **NeoTree** (https://github.com/nvim-neo-tree/neo-tree.nvim) в `plugins.lua`
```bash
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
```

Чтобы подключить этот плагин и инициализировать, создаем `neotree.lua` с содержимым
```bash
nvim ~/.config/nvim/lua/plugins/neotree.lua
```

```bash
vim.fn.sign_define("DiagnosticSignError",
    {text = " ", texthl = "DiagnosticSignError"})
vim.fn.sign_define("DiagnosticSignWarn",
    {text = " ", texthl = "DiagnosticSignWarn"})
vim.fn.sign_define("DiagnosticSignInfo",
    {text = " ", texthl = "DiagnosticSignInfo"})
vim.fn.sign_define("DiagnosticSignHint",
    {text = "󰌵", texthl = "DiagnosticSignHint"})

require("neo-tree").setup({})
```

Далее можно открывать по команде в `nvim`
```nvim
:NeoTree
```
`Shift + H` - показать все файлы/папки

2. **Markview** (https://github.com/OXY2DEV/markview.nvim) в `plugins.lua`
```bash
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
```

Потребуется открыть **lazy** `:Lazy`для проверки работоспособности плагина

Может возникнуит исколючение по недостающему модулю, необходимо догрузить:
>В командной строке **nvim**: `:TSInstall html`

