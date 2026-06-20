-- ============================================================
-- Bibek's Neovim Configuration
-- ============================================================
-- This file keeps your original Kickstart-based setup, but removes
-- the large Kickstart guide comments and adds modern UI improvements.
--
-- Main goals:
--   - Keep your existing LSP, formatting, completion and keymaps working.
--   - Make Neovim look modern: icons, statusline, buffer tabs, rounded UI,
--     better Telescope layout, notifications and indentation guides.
--   - Keep comments short and useful so you can customize later.
--
-- After replacing your init.lua with this file, run:
--   :Lazy sync
-- Then restart Neovim.
--
-- Important: install and select a Nerd Font in your terminal.
-- Recommended font: JetBrainsMono Nerd Font.
-- ============================================================

-- ============================================================
-- Leader keys and global basics
-- ============================================================
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Enable Nerd Font icons across plugins.
-- Set this to false only if your terminal font is not a Nerd Font.
vim.g.have_nerd_font = true

-- Use the system clipboard.
vim.opt.clipboard = 'unnamedplus'
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

-- Make <Esc> leave terminal mode.
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })

-- ============================================================
-- Editor appearance and behavior
-- ============================================================
vim.o.termguicolors = true -- Required for good colors in modern themes.
vim.o.number = true -- Show absolute line number.
vim.o.relativenumber = true -- Show relative line numbers for easier jumping.
vim.o.mouse = 'a' -- Enable mouse support.
vim.o.showmode = false -- Hide mode text because statusline already shows it.
vim.o.cursorline = true -- Highlight the current line.
vim.o.scrolloff = 10 -- Keep context above/below cursor while scrolling.
vim.o.signcolumn = 'yes' -- Keep diagnostic/git sign column always visible.
vim.o.breakindent = true -- Preserve indentation on wrapped lines.
vim.o.undofile = true -- Persistent undo history.
vim.o.confirm = true -- Ask before quitting with unsaved changes.

-- Cleaner modern UI defaults.
vim.o.winborder = 'rounded' -- Rounded borders for supported floating windows.
vim.o.laststatus = 3 -- One global statusline across the entire window.
vim.o.cmdheight = 1 -- Keep command line compact.
vim.o.pumblend = 10 -- Slight transparency for popup menus.
vim.o.winblend = 0 -- Keep normal floating windows readable.

-- Search behavior.
vim.o.ignorecase = true
vim.o.smartcase = true

-- Performance and key timeout behavior.
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Split windows open in the more natural direction.
vim.o.splitright = true
vim.o.splitbelow = true

-- Show useful whitespace markers.
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Live preview for substitution commands such as :s/foo/bar.
vim.o.inccommand = 'split'

-- ============================================================
-- Diagnostics
-- ============================================================
vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  virtual_text = true, -- Inline diagnostic text at end of line.
  virtual_lines = false, -- Keep this false to avoid noisy multi-line diagnostics.
  jump = { float = true }, -- Show diagnostic float when jumping with [d / ]d.
}

-- ============================================================
-- General keymaps
-- ============================================================
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Window navigation with Ctrl + hjkl.
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to bottom window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to top window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to right window' })

-- Ctrl+Z / Ctrl+Y like common editors.
vim.keymap.set('n', '<C-z>', 'u', { desc = 'Undo' })
vim.keymap.set('i', '<C-z>', '<C-o>u', { desc = 'Undo in insert mode' })
vim.keymap.set('v', '<C-z>', 'u', { desc = 'Undo in visual mode' })
vim.keymap.set('n', '<C-y>', '<C-r>', { desc = 'Redo' })
vim.keymap.set('i', '<C-y>', '<C-o><C-r>', { desc = 'Redo in insert mode' })
vim.keymap.set('v', '<C-y>', '<C-r>', { desc = 'Redo in visual mode' })

-- File explorers.
vim.keymap.set('n', '-', '<cmd>Oil<CR>', { desc = 'Open Oil file manager' })
vim.keymap.set('n', '<leader>o', ':Explore<CR>', { desc = 'Open Netrw' })

-- Fast insert-mode escape.
vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Exit insert mode with jk' })

-- Move lines like VS Code.
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { desc = 'Move line down' })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move line up' })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })
vim.keymap.set('n', '<Down>', ':m .+1<CR>==', { desc = 'Move line down' })
vim.keymap.set('n', '<Up>', ':m .-2<CR>==', { desc = 'Move line up' })
vim.keymap.set('v', '<Down>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', '<Up>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Paste over selection without replacing clipboard content.
vim.keymap.set('x', '<leader>p', [['_dP]], { desc = 'Paste without losing clipboard' })

-- Telescope shortcuts similar to Ctrl+P workflow.
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { desc = 'Find text' })

-- Comment toggle using Comment.nvim.
vim.keymap.set('n', '<C-_>', 'gcc', { remap = true, desc = 'Toggle comment line' })
vim.keymap.set('v', '<C-_>', 'gc', { remap = true, desc = 'Toggle comment selection' })

-- Direct go-to-definition shortcut.
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })

-- Built-in terminal splits.
vim.keymap.set('n', '<leader>ts', function()
  vim.cmd 'split'
  vim.cmd 'terminal'
  vim.cmd 'startinsert'
end, { desc = 'Terminal split' })

vim.keymap.set('n', '<leader>tv', function()
  vim.cmd 'vsplit'
  vim.cmd 'terminal'
  vim.cmd 'startinsert'
end, { desc = 'Terminal vertical split' })

vim.keymap.set({ 'n', 't' }, '<C-t>', '<cmd>ToggleTerm<CR>', { desc = 'Toggle floating terminal' })

-- ============================================================
-- Autocommands
-- ============================================================
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight copied text briefly',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- ============================================================
-- Bootstrap lazy.nvim plugin manager
-- ============================================================
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then error('Error cloning lazy.nvim:\n' .. out) end
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================
-- Plugins
-- ============================================================
require('lazy').setup({
  -- ------------------------------------------------------------
  -- Small quality-of-life plugins
  -- ------------------------------------------------------------
  { 'NMAC427/guess-indent.nvim', opts = {} }, -- Detect indentation style automatically.
  { 'numToStr/Comment.nvim', opts = {} }, -- gcc/gc comment toggling.
  { 'stevearc/oil.nvim', opts = { default_file_explorer = false } }, -- Edit directories like buffers.
  { 'windwp/nvim-autopairs', opts = {} }, -- Auto-close brackets, quotes, etc.
  { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font }, -- File icons for UI plugins.

  -- Smooth cursor animation.
  {
    'sphamba/smear-cursor.nvim',
    opts = {
      stiffness = 0.8,
      trailing_stiffness = 0.5,
      smear_between_buffers = true,
      smear_between_neighbor_lines = true,
    },
  },

  -- Floating terminal toggled with Ctrl+t.
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      direction = 'float',
      float_opts = { border = 'rounded' },
    },
  },

  -- ------------------------------------------------------------
  -- Modern UI plugins
  -- ------------------------------------------------------------

  -- TokyoNight theme. Change style to: storm, moon, night, day.
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      require('tokyonight').setup {
        style = 'moon',
        transparent = false,
        terminal_colors = true,
        styles = {
          comments = { italic = false },
          keywords = { italic = false },
          functions = {},
          variables = {},
          sidebars = 'dark',
          floats = 'dark',
        },
      }
      vim.cmd.colorscheme 'tokyonight-moon'
    end,
  },

  -- Modern statusline at the bottom.
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        theme = 'tokyonight',
        globalstatus = true,
        section_separators = '',
        component_separators = '',
      },
    },
  },

  -- Buffer tabs at the top.
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        mode = 'buffers',
        separator_style = 'thin',
        diagnostics = 'nvim_lsp',
        always_show_bufferline = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },

  -- Indentation guides for cleaner code structure.
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = { char = '│' },
      scope = { enabled = true },
    },
  },

  -- Better command line, messages and LSP popups.
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    opts = {
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
      },
    },
  },

  -- Notification popups used by Noice and other plugins.
  {
    'rcarriga/nvim-notify',
    opts = {
      stages = 'fade',
      timeout = 2000,
      background_colour = '#000000',
    },
  },

  -- Optional modern sidebar. Oil remains available on '-'.
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    keys = {
      { '<leader>e', '<cmd>Neotree toggle<CR>', desc = 'Toggle file explorer' },
    },
    opts = {
      filesystem = {
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        width = 32,
      },
    },
  },

  -- ------------------------------------------------------------
  -- Git UI
  -- ------------------------------------------------------------
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
      },
    },
  },

  -- ------------------------------------------------------------
  -- Which-key: popup that shows available keymaps
  -- ------------------------------------------------------------
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,
      icons = { mappings = vim.g.have_nerd_font },
      spec = {
        { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
        { '<leader>t', group = '[T]erminal / [T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { '<leader>f', group = '[F]ind / [F]ormat' },
      },
    },
  },

  -- ------------------------------------------------------------
  -- Telescope fuzzy finder
  -- ------------------------------------------------------------
  {
    'nvim-telescope/telescope.nvim',
    enabled = true,
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function() return vim.fn.executable 'make' == 1 end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      local telescope = require 'telescope'
      local themes = require 'telescope.themes'
      local builtin = require 'telescope.builtin'

      telescope.setup {
        defaults = {
          border = true,
          winblend = 5,
          prompt_prefix = vim.g.have_nerd_font and '   ' or '> ',
          selection_caret = vim.g.have_nerd_font and ' ' or '> ',
          layout_strategy = 'horizontal',
          layout_config = {
            width = 0.9,
            height = 0.85,
            preview_width = 0.55,
          },
        },
        extensions = {
          ['ui-select'] = { themes.get_dropdown() },
        },
      }

      pcall(telescope.load_extension, 'fzf')
      pcall(telescope.load_extension, 'ui-select')

      -- Search and navigation keymaps.
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch Telescope pickers' })
      vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch recent files' })
      vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Find existing buffers' })

      -- LSP pickers are attached only when an LSP is active for the buffer.
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
        callback = function(event)
          local buf = event.buf
          vim.keymap.set('n', 'grr', builtin.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' })
          vim.keymap.set('n', 'gri', builtin.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementation' })
          vim.keymap.set('n', 'grd', builtin.lsp_definitions, { buffer = buf, desc = '[G]oto [D]efinition' })
          vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, { buffer = buf, desc = 'Open document symbols' })
          vim.keymap.set('n', 'gW', builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = 'Open workspace symbols' })
          vim.keymap.set('n', 'grt', builtin.lsp_type_definitions, { buffer = buf, desc = '[G]oto [T]ype definition' })
        end,
      })

      -- Fuzzy search inside the current buffer.
      vim.keymap.set(
        'n',
        '<leader>/',
        function()
          builtin.current_buffer_fuzzy_find(themes.get_dropdown {
            winblend = 10,
            previewer = false,
          })
        end,
        { desc = 'Fuzzy search current buffer' }
      )

      -- Search only inside currently open files.
      vim.keymap.set(
        'n',
        '<leader>s/',
        function()
          builtin.live_grep {
            grep_open_files = true,
            prompt_title = 'Live Grep in Open Files',
          }
        end,
        { desc = '[S]earch in open files' }
      )

      -- Search your Neovim config quickly.
      vim.keymap.set('n', '<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  -- ------------------------------------------------------------
  -- LSP setup
  -- ------------------------------------------------------------
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'saghen/blink.cmp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('gra', vim.lsp.buf.code_action, '[G]oto code [A]ction', { 'n', 'x' })
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method('textDocument/documentHighlight', event.buf) then
            local highlight_group = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })

            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_group,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_group,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client:supports_method('textDocument/inlayHint', event.buf) then
            map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle inlay [H]ints')
          end
        end,
      })

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Add/remove servers here. Mason will install them automatically.
      local servers = {
        basedpyright = {},
        ts_ls = {},
        html = {},
        cssls = {},
        jsonls = {},
        -- clangd = {},
        -- gopls = {},
        -- rust_analyzer = {},
      }

      local ensure_installed = {
        'basedpyright',
        'typescript-language-server',
        'html-lsp',
        'css-lsp',
        'json-lsp',
        'lua-language-server',
        'stylua',
      }
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      for name, server in pairs(servers) do
        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
        vim.lsp.config(name, server)
        vim.lsp.enable(name)
      end

      -- Lua language server settings for editing this Neovim config.
      vim.lsp.config('lua_ls', {
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              version = 'LuaJIT',
              path = { 'lua/?.lua', 'lua/?/init.lua' },
            },
            workspace = {
              checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file('', true),
            },
          })
        end,
        settings = { Lua = {} },
      })
      vim.lsp.enable 'lua_ls'
    end,
  },

  -- ------------------------------------------------------------
  -- Formatting
  -- ------------------------------------------------------------
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function() require('conform').format { async = true, lsp_format = 'fallback' } end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- C/C++ formatting is disabled because style can vary widely.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then return nil end
        return { timeout_ms = 500, lsp_format = 'fallback' }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- python = { 'isort', 'black' },
        -- javascript = { 'prettierd', 'prettier', stop_after_first = true },
      },
    },
  },

  -- ------------------------------------------------------------
  -- Autocompletion
  -- ------------------------------------------------------------
  {
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then return end
          return 'make install_jsregexp'
        end)(),
        opts = {},
      },
    },
    opts = {
      keymap = { preset = 'default' },
      appearance = { nerd_font_variant = 'mono' },
      completion = {
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets' },
      },
      snippets = { preset = 'luasnip' },
      fuzzy = { implementation = 'lua' },
      signature = { enabled = true },
    },
  },

  -- Highlight TODO/FIXME/NOTE comments.
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  -- Useful textobjects and surround editing. Statusline part removed because lualine is used.
  {
    'nvim-mini/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()
    end,
  },

  -- Treesitter syntax highlighting.
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'python',
        'javascript',
        'typescript',
        'json',
        'css',
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts) require('nvim-treesitter.configs').setup(opts) end,
  },
}, {
  ui = {
    border = 'rounded',
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
