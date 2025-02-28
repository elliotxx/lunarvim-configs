local M = {}

M.config = function()
    -- Additional Plugins
    lvim.plugins = {
        -- trouble.nvim
        -- diagnostics, references, telescope results, quickfix and location lists
        {
            "folke/trouble.nvim",
            cmd = "TroubleToggle",
        },

        -- auto-save.nvim is a lua plugin for automatically saving your changed buffers in Neovim
        -- Forked from auto-save.nvim as active development has stopped
        {
            "okuuva/auto-save.nvim",
            -- cmd = "ASToggle", -- optional for lazy loading on command
            -- event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
            opts = {
                -- your config goes here
                -- or just leave it empty :)
                -- enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
                trigger_events = {                                 -- See :h events
                    immediate_save = { "BufLeave", "FocusLost" },  -- vim events that trigger an immediate save
                    defer_save = { "InsertLeave", "TextChanged" }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
                    cancel_deferred_save = { "InsertEnter" },      -- vim events that cancel a pending deferred save
                },
                -- function that takes the buffer handle and determines whether to save the current buffer or not
                -- return true: if buffer is ok to be saved
                -- return false: if it's not ok to be saved
                -- if set to `nil` then no specific condition is applied
                condition = nil,
                write_all_buffers = false, -- write all buffers when the current one meets `condition`
                noautocmd = false,         -- do not execute autocmds when saving
                debounce_delay = 1000,     -- delay after which a pending save is executed
                -- log debug messages to 'auto-save.log' file in neovim cache directory, set to `true` to enable
                debug = false,
            },
        },

        -- symbols-outline.nvim
        {
            "simrat39/symbols-outline.nvim",
            opts = {},
        },

        -- markdown-preview.nvim
        {
            "iamcco/markdown-preview.nvim",
            build = "cd app && npm install",
            ft = "markdown",
            lazy = true,
            config = function()
                vim.g.mkdp_auto_close = true
                vim.g.mkdp_open_to_the_world = false
                vim.g.mkdp_open_ip = "127.0.0.1"
                vim.g.mkdp_port = "8888"
                vim.g.mkdp_browser = ""
                vim.g.mkdp_echo_preview_url = true
                vim.g.mkdp_page_title = "${name}"
            end,
        },

        -- diffview.nvim
        {
            "sindrets/diffview.nvim",
            event = "BufRead",
            config = function()
                require("diffview").setup {
                    keymaps = {
                        disable_defaults = false, -- Disable the default keymaps
                        view = {
                            -- Disable the default normal mode mapping
                            ["<leader>e"] = false,
                            ["<leader>b"] = false,
                        },
                        file_panel = {
                            { "n", "<cr>", require("diffview.actions").goto_file_tab,
                                { desc = "Open the file in a new tabpage" } },
                            { "n", "o", require("diffview.actions").goto_file_tab,
                                { desc = "Open the file in a new tabpage" } },
                        }
                    }
                }
            end
        },

        -- nvim-spectre for replace
        {
            "windwp/nvim-spectre",
            event = "BufRead",
            config = function()
                require("spectre").setup()
            end,
        },

        -- fzf for search
        {
            "junegunn/fzf",
            commit = "3ee1fc203406debab432dbf3cb67f37ea7cb3d30",
            build = ":call fzf#install()"
        },
        {
            "junegunn/fzf.vim",
            commit = "0a80e43f9027ec64213d602dbb0b22d65a072ca8",
        },

        -- Colorschemes
        {
            "Mofiqul/dracula.nvim",
            opts = {
                -- use transparent background
                transparent_bg = true,        -- default false
                -- set custom lualine background color
                lualine_bg_color = "#44475a", -- default nil
                -- set italic comment
                italic_comment = true,        -- default false
            },
        },
        { "catppuccin/nvim",       name = "catppuccin", priority = 1000 },

        -- glepnir/lspsaga.nvim
        -- Improves the Neovim built-in LSP experience.
        {
            "nvimdev/lspsaga.nvim",
            config = function()
                require("lspsaga").setup({})
            end,
            dependencies = {
                'nvim-treesitter/nvim-treesitter', -- optional
                'nvim-tree/nvim-web-devicons',     -- optional
            }
        },

        -- -- j-hui/fidget.nvim. Standalone UI for nvim-lsp progress.
        -- {
        --     "j-hui/fidget.nvim",
        --     tag = "v1.0.0",
        --     opts = {
        --         progress = {
        --             display = {
        --                 format_message = function(msg)
        --                     if string.find(msg.title, "Indexing") then
        --                         return nil -- Ignore "Indexing..." progress messages
        --                     end
        --                     if msg.message then
        --                         return msg.message
        --                     else
        --                         return msg.done and "Completed" or "In progress..."
        --                     end
        --                 end,
        --             },
        --         },

        --         notification = {
        --             view = {
        --                 stack_upwards = false, -- Display notification items from bottom to top
        --             },

        --             window = {
        --                 relative = "editor",
        --                 winblend = 0,
        --             },
        --         },
        --     },
        -- },

        -- ThePrimeagen/refactoring.nvim
        -- Support for various common refactoring operations
        {
            "ThePrimeagen/refactoring.nvim",
            config = function()
                require('refactoring').setup({
                    prompt_func_return_type = {
                        go = true,
                        java = false,

                        cpp = false,
                        c = false,
                        h = false,
                        hpp = false,
                        cxx = false,
                    },
                    prompt_func_param_type = {
                        go = true,
                        java = false,

                        cpp = false,
                        c = false,
                        h = false,
                        hpp = false,
                        cxx = false,
                    },
                    printf_statements = {},
                    print_var_statements = {},
                })
            end,
            dependencies = {
                { "nvim-lua/plenary.nvim" },
                { "nvim-treesitter/nvim-treesitter" }
            },
        },

        -- stevearc/dressing.nvim
        -- Neovim plugin to improve the default vim.ui interfaces
        { "stevearc/dressing.nvim" },

        -- text-case.nvim
        -- Enter `ga` to jump to which-key
        {
            "johmsalas/text-case.nvim",
            config = function()
                require('textcase').setup {}
            end
        },

        -- folke/todo-comments.nvim
        -- todo-comments is a lua plugin for Neovim 0.5 to highlight and search for todo comments like TODO, HACK, BUG in your code base.
        {
            "folke/todo-comments.nvim",
            opts = {},
            dependencies = {
                { "nvim-lua/plenary.nvim" },
            },
        },

        -- The goal of nvim-ufo is to make Neovim's fold look modern and keep high performance.
        {
            "kevinhwang91/nvim-ufo",
            dependencies = "kevinhwang91/promise-async"
        },

        -- folke/flash.nvim
        -- flash.nvim lets you navigate your code with search labels, enhanced character motions, and Treesitter integration.
        {
            "folke/flash.nvim",
            event = "VeryLazy",
            opts = {},
            keys = {
                {
                    "s",
                    mode = { "n", "x", "o" },
                    function() require("flash").jump() end,
                    desc = "Flash"
                },
                {
                    "S",
                    mode = { "n", "o", "x" },
                    function() require("flash").treesitter() end,
                    desc = "Flash Treesitter"
                },
                {
                    "r",
                    mode = "o",
                    function() require("flash").remote() end,
                    desc = "Remote Flash"
                },
                {
                    "R",
                    mode = { "o", "x" },
                    function() require("flash").treesitter_search() end,
                    desc = "Treesitter Search"
                },
                {
                    "<c-s>",
                    mode = { "c" },
                    function() require("flash").toggle() end,
                    desc = "Toggle Flash Search"
                },
            },
        },

        { "soulis-1256/hoverhints.nvim" },

        -- A simple word switch plugin with neovim
        -- Keymappings:
        -- The default mapping is gs to switch the word.
        { "tandy1229/wordswitch.nvim" },

        -- Library of 35+ independent Lua modules improving overall
        -- Neovim (version 0.7 and higher) experience with minimal effort.
        -- https://github.com/echasnovski/mini.nvim
        {
            "echasnovski/mini.nvim",
            version = '*',
            config = function()
                -- Show notifications
                -- require('mini.notify').setup {}
                -- Extend and create a/i textobjects
                require('mini.ai').setup {}
                -- Navigate and manipulate file system
                -- Keymappings:
                -- Toggle = '<leader>E'
                require('mini.files').setup {
                    -- General options
                    options = {
                        -- Whether to use for editing directories
                        use_as_default_explorer = false,
                    },
                    -- Customization of explorer windows
                    windows = {
                        -- Whether to show preview of file/directory under cursor
                        preview = true,
                        -- Width of preview window
                        width_preview = 40,
                    },
                }
                -- Move any selection in any direction
                -- Keymappings:
                -- -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
                -- left = '<M-h>',
                -- right = '<M-l>',
                -- down = '<M-j>',
                -- up = '<M-k>',
                require('mini.move').setup {}
                -- Split and join arguments
                -- Keymappings:
                -- toggle = 'gS', -- Split if arguments are on single line, join
                -- otherwise.
                require('mini.splitjoin').setup {}
                -- Fast and feature-rich surround actions
                require('mini.surround').setup {
                    -- Module mappings. Use `''` (empty string) to disable one.
                    mappings = {
                        add = 'qa',            -- Add surrounding in Normal and Visual modes
                        delete = 'qd',         -- Delete surrounding
                        find = 'qf',           -- Find surrounding (to the right)
                        find_left = 'qF',      -- Find surrounding (to the left)
                        highlight = 'qh',      -- Highlight surrounding
                        replace = 'qr',        -- Replace surrounding
                        update_n_lines = 'qn', -- Update `n_lines`

                        suffix_last = 'l',     -- Suffix to search with "prev" method
                        suffix_next = 'n',     -- Suffix to search with "next" method
                    }, }
            end,
        },

        -- Use treesitter to auto close and auto rename html tag
        { "windwp/nvim-ts-autotag" },

        -- -- LSP signature hint as you type
        -- {
        --     "ray-x/lsp_signature.nvim",
        --     event = "VeryLazy",
        --     opts = {},
        --     config = function(_, opts) require 'lsp_signature'.setup(opts) end
        -- },

        -- Neovim plugin to manage the file system and other tree like structures.
        {
            "nvim-neo-tree/neo-tree.nvim",
            branch = "v3.x",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
                "MunifTanjim/nui.nvim",
                "3rd/image.nvim",              -- Optional image support in preview window: See `# Preview Mode` for more information
            },
            opts = {
                commands = {
                    -- Reference: https://github.com/nvim-neo-tree/neo-tree.nvim/discussions/370#discussioncomment-6679447
                    copy_selector = function(state)
                        -- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
                        -- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
                        local node = state.tree:get_node()
                        local filepath = node:get_id()
                        local filename = node.name
                        local modify = vim.fn.fnamemodify

                        local results = {
                            filepath,
                            modify(filepath, ':.'),
                            modify(filepath, ':~'),
                            filename,
                            modify(filename, ':r'),
                            modify(filename, ':e'),
                        }

                        vim.ui.select({
                            '1. Absolute path: ' .. results[1],
                            '2. Path relative to CWD: ' .. results[2],
                            '3. Path relative to HOME: ' .. results[3],
                            '4. Filename: ' .. results[4],
                            '5. Filename without extension: ' .. results[5],
                            '6. Extension of the filename: ' .. results[6],
                        }, { prompt = 'Choose to copy to clipboard:' }, function(choice)
                            local i = tonumber(choice:sub(1, 1))
                            local result = results[i]
                            vim.fn.setreg("+", result)
                            vim.notify('Copied: ' .. result)
                        end)
                    end,
                    image_wezterm = function(state)
                        local node = state.tree:get_node()
                        if node.type == "file" then
                            require("image_preview").PreviewImage(node.path)
                        end
                    end,
                },
                filesystem = {
                    filtered_items = {
                        hide_dotfiles = false,
                        hide_gitignored = false,
                        never_show = {
                            ".DS_Store",
                            "thumbs.db"
                        },
                        hide_by_name = {
                            "__pycache__",
                            ".git",
                            ".DS_Store",
                            "node_modules"
                        },
                    },
                    follow_current_file = {
                        -- This will find and focus the file in the active buffer every time
                        -- the current file is changed while the tree is open.
                        enabled = true,
                    },
                    window = {
                        mappings = {
                            ['Y'] = "copy_selector",
                            ["<tab>"] = "open",
                            ["o"] = "open",
                            ["O"] = "show_help",
                            ["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
                            ["<leader>p"] = "image_wezterm", -- " or another map
                        },
                    },
                },
            },
        },

        -- Plugin in the attempt ⬇️
        -- Find And Replace plugin for neovim
        {
            'MagicDuck/grug-far.nvim',
            config = function()
                require('grug-far').setup {}
            end
        },

        -- 💥 Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
        -- https://github.com/folke/noice.nvim
        {
            "folke/noice.nvim",
            event = "VeryLazy",
            opts = {
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = true,         -- use a classic bottom cmdline for search
                    command_palette = true,       -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false,       -- add a border to hover docs and signature help
                },
            },
            dependencies = {
                -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
                "MunifTanjim/nui.nvim",
            },
        },

        -- Free, ultrafast Copilot alternative for Vim and Neovim
        -- https://github.com/Exafunction/codeium.vim
        {
            'Exafunction/codeium.vim',
            commit = '289eb72',
            event = 'BufEnter',
            config = function()
                -- C-y will accept the suggestion completion of codeium.
                vim.keymap.set('i', '<C-;>', function()
                    return vim.fn['codeium#Accept']()
                end, { expr = true })
            end
        },

        -- https://github.com/adelarsq/image_preview.nvim
        -- Image Preview for Neovim 🖼
        {
            'adelarsq/image_preview.nvim',
            event = 'VeryLazy',
            config = function()
                require("image_preview").setup()
            end
        },

        -- https://github.com/kcl-lang/kcl.nvim
        -- {
        --     "kcl-lang/kcl.nvim",
        --     ft = {
        --         "kcl",
        --     },
        -- },

        -- 📸 Snapshot plugin with rich features that can
        -- make pretty code snapshots for Neovim.
        {
            "mistricky/codesnap.nvim",
            build = "make",
            config = function()
                require("codesnap").setup({
                    has_breadcrumbs = true,
                    has_line_number = true,
                    show_workspace = true,
                    bg_x_padding = 100,
                    bg_y_padding = 60,
                })
            end
        },

        -- https://github.com/sphamba/smear-cursor.nvim
        -- Neovim plugin to animate the cursor with a smear effect
        {
            "sphamba/smear-cursor.nvim",
            opts = {},
        },

        -- https://github.com/karb94/neoscroll.nvim
        -- Smooth scrolling neovim plugin written in lua
        {
            "karb94/neoscroll.nvim",
            config = function()
                require('neoscroll').setup({})
            end
        },
    }
end

return M
