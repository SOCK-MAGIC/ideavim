-- 安装packer
local installPath = vim.fn.stdpath "data" ..
                        "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(installPath)) > 0 then
    vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " ..
                       installPath)
end

-- 下载插件
local use = require("packer").use
require("packer").startup(function()
    use "wbthomason/packer.nvim" -- packer.nvim 插件管理器
    use "jiangmiao/auto-pairs" -- 括号自动补全
    use "github/copilot.vim" -- github ai 结对编程助手
    use "mhinz/vim-startify" -- 启动页
    use "fatih/vim-go" -- vim-go
    use "buoto/gotests-vim" -- 自动生成go测试代码
    use "sbdchd/neoformat" -- 代码格式化
    use "kdheepak/lazygit.nvim" -- lazygit
    use "preservim/nerdcommenter" -- 快速注释
    use "tpope/vim-fugitive" -- 在vim中使用git
    use "voldikss/vim-translator" -- 翻译
    use "preservim/tagbar" -- 大纲式导航
    use "rakr/vim-one" -- 主题
    use "Pocco81/AutoSave.nvim" -- 自动保存
    use "skywind3000/vim-terminal-help" -- 方便的使用内置终端
    use "itchyny/lightline.vim" -- 让状态栏更好看
    use "neovim/nvim-lspconfig" -- lsp
    use "nvim-treesitter/nvim-treesitter-refactor"
    use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"} -- 语法高亮
    use {"akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons"} -- 标签页
    use {"kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons"} -- 文件管理器
    use { -- telescope 模糊搜索
        "nvim-telescope/telescope.nvim",
        requires = {{"nvim-lua/plenary.nvim"}}
    }
    use { -- 不用设置，就让 lsp 更好用
        'ray-x/navigator.lua',
        requires = {'ray-x/guihua.lua', run = 'cd lua/fzy && make'}
    }
    -- 以下都是代码补全
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline", "hrsh7th/cmp-vsnip", "hrsh7th/vim-vsnip",
            "rafamadriz/friendly-snippets", "onsails/lspkind-nvim",
            "hrsh7th/cmp-nvim-lua", "hrsh7th/cmp-calc", "hrsh7th/cmp-emoji"
        }
    }
end)

-- vim.o    general setting         通用设定
-- vim.g    global variables        全局变量
-- vim.env  environment variables   环境变量
-- vim.wo   window scoped options   窗口范围设定
-- vim.bo   buffer scoped options   buffer范围设定

-- 设置主题
vim.o.termguicolors = true
vim.cmd [[colorscheme one]]
-- 设置编码，可以正确处理非 utf8 编码
vim.o.fileencodings = "utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1"
vim.g.encoding = "UTF-8"
vim.o.fencs = "utf8,gbk,gb2312,gb18030"
-- 上下移动光标时上下方保留4行
vim.o.scrolloff = 4
vim.o.sidescrolloff = 4
-- 使用gui时的字体
vim.opt.guifont = "FiraCode NF:h8"
-- 使用相对行号
vim.wo.number = true
vim.wo.relativenumber = true
-- 高亮所在行
vim.wo.cursorline = true
-- 设置代码折叠，zc折叠，zo展开
vim.o.foldlevel = 20
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
-- 显示左侧图标指示列
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"
-- 缩进4个空格等于一个Tab
vim.o.tabstop = 4
vim.bo.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftround = true
-- 新行对齐当前行，空格代替Tab
vim.o.expandtab = true
vim.bo.expandtab = true
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.smartindent = true
-- 左移右移长度
vim.o.shiftwidth = 4
vim.bo.shiftwidth = 4
-- 搜索大小写不敏感，除非包含大写
vim.o.ignorecase = true
vim.o.smartcase = true
-- 搜索高亮
vim.o.hlsearch = true
-- 边输入边搜索
vim.o.incsearch = true
-- 当文件被外部程序修改时，自动加载
vim.o.autoread = true
vim.bo.autoread = true
-- 禁止折行
-- vim.o.wrap = false
-- vim.wo.wrap = false
-- 太长时自动换行时保持相同缩进，必须允许折行才能看到效果
vim.o.breakindent = true
-- 支持鼠标
vim.o.mouse = "a"
-- 不要创建备份文件
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
-- 使用空格键作为 leader key
local keymap = vim.api.nvim_set_keymap
local opt = {noremap = true, silent = true}
keymap("", "<Space>", "Nop", opt) -- 先让空格什么都不干
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- fw 保存
keymap("n", "fw", ":w<CR>", opt)
-- fq 退出
keymap("n", "fq", ":q<CR>", opt)
-- fc 关闭当前缓冲区
keymap("n", "fc", ":bp|bd#<CR>", opt)
-- HL 跳到行首行尾
keymap("n", "L", "$", opt)
keymap("n", "H", "^", opt)
-- 复制到系统剪贴板，从系统剪贴板粘贴
keymap("n", ";y", "\"+y", opt)
keymap("n", ";p", "\"+p", opt)
-- 去掉上次搜索时的高亮
keymap("n", "<leader>/", ":nohls<CR>", opt)
-- 翻译
vim.g.translator_default_engines = {"haici", "bing"}
keymap("n", "<leader>t", ":TranslateW<CR>", opt)
-- 调用 lazygit
keymap("n", "<leader>gg", ":LazyGit<CR>", opt)
-- 调用 gotests 为选中代码生成测试
keymap("n", "<leader>tt", ":GoTests<CR>", opt)
-- 分屏
keymap("n", "sv", ":vsp<CR>", opt) -- 水平分屏
keymap("n", "sh", ":sp<CR>", opt) -- 垂直分屏
keymap("n", "sc", "<C-w>c", opt) -- 关闭
keymap("n", "so", "<C-w>o", opt) -- 关闭其他
-- 分屏比例控制
keymap("n", "<C-[>", ":vertical resize +10<CR>", opt)
keymap("n", "s=", "<C-w>=", opt) -- 恢复
-- 分屏窗口之间跳转
keymap("n", "<A-h>", "<C-w>h", opt)
keymap("n", "<A-j>", "<C-w>j", opt)
keymap("n", "<A-k>", "<C-w>k", opt)
keymap("n", "<A-l>", "<C-w>l", opt)
-- 打开 nvim-tree 文件管理器
keymap("n", "<A-e>", ":NvimTreeToggle<CR>", opt)
-- 打开tagbar
keymap("n", "<A-t>", ":TagbarToggle<CR>", opt)
-- 切换标签页
keymap("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
keymap("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)
-- 格式化
keymap("n", "<leader>fm", ":Neoformat<CR>", opt)

-- 状态栏的设置
vim.g.lightline = {
    colorscheme = "one",
    active = {
        left = {
            {"mode", "paste"}, {"gitbranch", "readonly", "filename", "modified"}
        }
    },
    component_function = {gitbranch = "fugitive#head"}
}
-- telescope 的设置
keymap("n", "<leader><space>",
       [[<cmd>lua require("telescope.builtin").buffers()<CR>]], opt)
keymap("n", "<leader>sf",
       [[<cmd>lua require("telescope.builtin").find_files({previewer = false})<CR>]],
       opt)
keymap("n", "<leader>sb",
       [[<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>]],
       opt)
keymap("n", "<leader>sh",
       [[<cmd>lua require("telescope.builtin").help_tags()<CR>]], opt)
keymap("n", "<leader>st", [[<cmd>lua require("telescope.builtin").tags()<CR>]],
       opt)
keymap("n", "<leader>sd",
       [[<cmd>lua require("telescope.builtin").grep_string()<CR>]], opt)
keymap("n", "<leader>sp",
       [[<cmd>lua require("telescope.builtin").live_grep()<CR>]], opt)
keymap("n", "<leader>so",
       [[<cmd>lua require("telescope.builtin").tags{ only_current_buffer = true }<CR>]],
       opt)
keymap("n", "<leader>?",
       [[<cmd>lua require("telescope.builtin").oldfiles()<CR>]], opt)
-- treesitter 的设置
require("nvim-treesitter.configs").setup {
    -- 安装语言解析器
    ensure_installed = {
        "html", "css", "vim", "lua", "javascript", "typescript", "c", "go",
        "rust", "cmake", "dockerfile", "fish", "gomod", "java", "json", "json5",
        "jsonc", "julia", "kotlin", "markdown", "python", "regex", "vue", "yaml"
    },
    -- 启用代码高亮
    highlight = {enable = true, additional_vim_regex_highlighting = false},
    -- 启用增量选择
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            scope_incremental = "<TAB>",
            node_decremental = "<BS>"
        }
    }
}

-- nvim-tree 文件管理器设置
require("nvim-tree").setup {}

-- navigator 的设置
require("navigator").setup({
    lsp = {
        format_on_save = false,
    }
})

-- bufferline 标题栏设置
require("bufferline").setup {
    options = {
        -- 使用 nvim 内置 lsp
        diagnostics = "nvim_lsp",
        -- 左侧让出 nvim-tree 的位置
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                Highlight = "Directory",
                text_align = "left"
            }
        }
    }
}

-- 代码补全设置
local cmp = require "cmp"
local lspkind = require "lspkind"
cmp.setup {
    snippet = {expand = function(args) vim.fn["vsnip#anonymous"](args.body) end},
    -- 来源
    sources = {
        {name = "nvim_lsp"}, {name = "vsnip"}, {name = "buffer"},
        {name = "path"}, {name = "cmdline"}, {name = "calc"}, {name = "spell"},
        {name = "emoji"}
    },
    -- 样式
    formatting = {
        format = lspkind.cmp_format({
            with_text = true,
            maxwidth = 50,
            before = function(entry, vim_item)
                vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
                return vim_item
            end
        })
    },
    -- 快捷键
    mapping = {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        },
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end
    }
}

-- 快速注释的设置
vim.g.NERDSpaceDelims = 1 -- 注释后加一个空格

-- 自动保存的设置
local autosave = require("autosave")
autosave.setup(
    {
        enabled = true,
        execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
        events = {"InsertLeave", "TextChanged"},
        conditions = {
            exists = true,
            filename_is_not = {},
            filetype_is_not = {},
            modifiable = true
        },
        write_all_buffers = false,
        on_off_commands = true,
        clean_command_line_interval = 0,
        debounce_delay = 135
    }
)

