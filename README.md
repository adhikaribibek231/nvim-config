# Personal Neovim Configuration

A Neovim setup based on the original Kickstart.nvim idea, customized for a daily-driver editor.

This configuration is intentionally kept mostly in a single `init.lua` so it is easy to read, modify, and debug. It focuses on a modern terminal-based editing experience with good defaults for backend, Python, TypeScript/JavaScript, web development, Git, fuzzy finding, LSP, formatting, completion, and a cleaner UI.

## Preview / Main Features

This config includes:

- **Modern UI**
  - TokyoNight Moon theme
  - Lualine statusline
  - Bufferline tabs
  - Rounded floating windows
  - Noice.nvim command/message UI
  - nvim-notify popups
  - Indentation guides
  - Nerd Font icons

- **Navigation**
  - Telescope fuzzy finder
  - Neo-tree sidebar
  - Oil file manager
  - Buffer switching
  - Window navigation with `Ctrl + h/j/k/l`

- **Coding support**
  - LSP through `nvim-lspconfig`
  - Mason for language server/tool installation
  - Blink.cmp completion
  - LuaSnip snippets
  - Conform formatter
  - Treesitter syntax highlighting
  - Git signs in the gutter

- **Daily-driver keymaps**
  - VS Code-like move line shortcuts
  - `Ctrl + z` undo and `Ctrl + y` redo
  - `jk` to escape insert mode
  - Floating terminal with `Ctrl + t`
  - Telescope file/text search shortcuts

## Requirements

### 1. Neovim

This config is meant for **Neovim 0.12+**.

Check your version:

```bash
nvim --version | head -5
```

If your distro package gives an older version, install the official AppImage.

```bash
mkdir -p ~/.local/bin
cd ~/.local/bin

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod +x nvim-linux-x86_64.appimage
mv nvim-linux-x86_64.appimage nvim
```

Make sure `~/.local/bin` comes before `/usr/bin`:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

Verify:

```bash
which nvim
nvim --version | head -5
```

Expected path:

```text
$HOME/.local/bin/nvim
```

### 2. System dependencies

Install the basic tools needed by Telescope, Treesitter, Mason, formatters, and plugins:

```bash
sudo apt update

sudo apt install -y \
  git \
  curl \
  unzip \
  make \
  gcc \
  g++ \
  ripgrep \
  fd-find \
  xclip \
  nodejs \
  npm
```

On Ubuntu/Debian, `fd` may be installed as `fdfind`. If Telescope cannot find `fd`, create a local symlink:

```bash
mkdir -p ~/.local/bin
ln -s "$(which fdfind)" ~/.local/bin/fd
```

Then reload your shell:

```bash
source ~/.bashrc
```

### 3. Nerd Font

A Nerd Font is required for the icons to display correctly in this config.

Recommended font:

```text
JetBrainsMono Nerd Font Mono Regular
```

Download JetBrainsMono Nerd Font from:

```text
https://www.nerdfonts.com/font-downloads
```

If the extracted folder is at:

```text
$HOME/Downloads/JetBrainsMono
```

install it with:

```bash
mkdir -p ~/.local/share/fonts
cp "$HOME"/Downloads/JetBrainsMono/*.ttf ~/.local/share/fonts/
fc-cache -fv
```

Verify:

```bash
fc-list | grep -i "JetBrains"
```

Test icons:

```bash
echo " 󰈔   󰊢"
```

If icons show as boxes, your terminal is not using the Nerd Font yet.

### 4. Set the terminal font

For Ubuntu/Ptyxis, the easiest approach is to set the GNOME monospace font:

```bash
gsettings set org.gnome.desktop.interface monospace-font-name "JetBrainsMono Nerd Font Mono 11"
```

Then fully close and reopen the terminal.

Good font choices:

- `JetBrainsMono Nerd Font Mono Regular` recommended
- `JetBrainsMono Nerd Font Mono Medium` if Regular feels too thin

Avoid Thin, ExtraLight, Light, Bold, and ExtraBold for long coding sessions.

## Installation

Back up any existing Neovim config first:

```bash
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
mv ~/.local/state/nvim ~/.local/state/nvim.backup
mv ~/.cache/nvim ~/.cache/nvim.backup
```

Clone this repository:

```bash
git clone git@github.com:your-username/nvim-config.git ~/.config/nvim
```

Or using HTTPS:

```bash
git clone https://github.com/your-username/nvim-config.git ~/.config/nvim
```

Open Neovim:

```bash
nvim
```

Lazy.nvim will bootstrap automatically.

Then run inside Neovim:

```vim
:Lazy sync
```

Restart Neovim after plugin installation finishes:

```vim
:qa
```

Then open it again:

```bash
nvim
```

## Post-install checks

Run these inside Neovim:

```vim
:Lazy
```

Check plugin installation status.

```vim
:Mason
```

Check language servers and tools.

```vim
:checkhealth
```

General health check.

```vim
:checkhealth nvim-treesitter
```

Treesitter parser check.

## Main plugins

| Area | Plugin |
|---|---|
| Plugin manager | `lazy.nvim` |
| Theme | `folke/tokyonight.nvim` |
| Statusline | `nvim-lualine/lualine.nvim` |
| Buffer tabs | `akinsho/bufferline.nvim` |
| File sidebar | `nvim-neo-tree/neo-tree.nvim` |
| File manager | `stevearc/oil.nvim` |
| Fuzzy finder | `nvim-telescope/telescope.nvim` |
| LSP | `neovim/nvim-lspconfig` |
| Tool installer | `mason.nvim`, `mason-tool-installer.nvim` |
| Completion | `saghen/blink.cmp` |
| Snippets | `LuaSnip` |
| Formatting | `stevearc/conform.nvim` |
| Syntax | `nvim-treesitter/nvim-treesitter` |
| Git gutter | `lewis6991/gitsigns.nvim` |
| Keymap helper | `folke/which-key.nvim` |
| Command UI | `folke/noice.nvim` |
| Notifications | `rcarriga/nvim-notify` |
| Comments | `numToStr/Comment.nvim` |
| Autopairs | `windwp/nvim-autopairs` |
| Indent guides | `indent-blankline.nvim` |
| Terminal | `toggleterm.nvim` |

## Keymaps

Leader key:

```text
Space
```

### File and search

| Key | Action |
|---|---|
| `Space ff` | Find files |
| `Space fg` | Live grep / search text |
| `Space sh` | Search help |
| `Space sk` | Search keymaps |
| `Space sc` | Search commands |
| `Space sn` | Search Neovim config |
| `Space Space` | Show open buffers |
| `Space /` | Search inside current buffer |
| `Space s/` | Search only open files |

### File explorers

| Key | Action |
|---|---|
| `-` | Open Oil file manager |
| `Space e` | Toggle Neo-tree sidebar |
| `Space o` | Open Netrw |

### Windows and buffers

| Key | Action |
|---|---|
| `Ctrl h` | Move to left window |
| `Ctrl j` | Move to lower window |
| `Ctrl k` | Move to upper window |
| `Ctrl l` | Move to right window |
| `:bnext` or `:bn` | Next buffer |
| `:bprevious` or `:bp` | Previous buffer |
| `Space Space` | Pick buffer with Telescope |

Recommended optional buffer-switching keymaps:

```lua
vim.keymap.set('n', '<S-h>', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<S-l>', '<cmd>bnext<CR>', { desc = 'Next buffer' })
```

### Editing

| Key | Action |
|---|---|
| `jk` | Exit insert mode |
| `Ctrl z` | Undo |
| `Ctrl y` | Redo |
| `Alt j` | Move line/selection down |
| `Alt k` | Move line/selection up |
| `Up` | Move line/selection up |
| `Down` | Move line/selection down |
| `Space p` in visual mode | Paste without replacing clipboard |

### Comments

| Key | Action |
|---|---|
| `Ctrl /` or `Ctrl _` | Toggle comment line/selection |
| `gcc` | Toggle current line comment |
| `gc` in visual mode | Toggle selected lines |

### LSP

| Key | Action |
|---|---|
| `gd` | Go to definition |
| `grd` | Telescope LSP definitions |
| `grr` | Telescope LSP references |
| `gri` | Telescope LSP implementations |
| `grt` | Telescope LSP type definitions |
| `grn` | Rename symbol |
| `gra` | Code action |
| `grD` | Go to declaration |
| `Space th` | Toggle inlay hints |

### Formatting

| Key | Action |
|---|---|
| `Space f` | Format current buffer |

### Terminal

| Key | Action |
|---|---|
| `Ctrl t` | Toggle floating terminal |
| `Space ts` | Open terminal in horizontal split |
| `Space tv` | Open terminal in vertical split |
| `Esc` or `Esc Esc` in terminal | Leave terminal insert mode |

## LSP and Mason tools

The config currently enables these LSP servers:

| Language / Area | LSP config name | Mason package |
|---|---|---|
| Python | `basedpyright` | `basedpyright` |
| TypeScript / JavaScript | `ts_ls` | `typescript-language-server` |
| HTML | `html` | `html-lsp` |
| CSS | `cssls` | `css-lsp` |
| JSON | `jsonls` | `json-lsp` |
| Lua | `lua_ls` | `lua-language-server` |

Formatter:

| Language | Formatter |
|---|---|
| Lua | `stylua` |

To manually open Mason:

```vim
:Mason
```

To check active LSP clients for the current buffer:

```vim
:LspInfo
```

## Treesitter

Treesitter provides better syntax highlighting and code awareness.

Configured parsers include:

```text
bash, c, lua, markdown, markdown_inline, query, vim, vimdoc,
python, javascript, typescript, json, css, html
```

Update parsers:

```vim
:TSUpdate
```

Check health:

```vim
:checkhealth nvim-treesitter
```

If you see warnings about `tree-sitter` CLI, it is usually not required for normal parser installation. It is mainly needed for grammar development or `:TSInstallFromGrammar`.

Optional install:

```bash
npm install -g tree-sitter-cli
```

## Common maintenance commands

Update plugins:

```vim
:Lazy update
```

Reinstall/sync plugins:

```vim
:Lazy sync
```

Clean unused plugins:

```vim
:Lazy clean
```

Check errors/messages:

```vim
:messages
```

Open health check:

```vim
:checkhealth
```

Open plugin manager:

```vim
:Lazy
```

Open Mason:

```vim
:Mason
```

## Troubleshooting

### Icons show as boxes

Your terminal is not using a Nerd Font.

Fix:

```bash
gsettings set org.gnome.desktop.interface monospace-font-name "JetBrainsMono Nerd Font Mono 11"
```

Then restart the terminal.

Also make sure this is enabled in `init.lua`:

```lua
vim.g.have_nerd_font = true
```

### `nvim-treesitter.configs` not found

You likely have a mismatch between your Neovim version and the installed Treesitter branch.

Recommended fix:

1. Use Neovim 0.12+
2. Delete the old plugin copy
3. Run Lazy sync again

```bash
rm -rf ~/.local/share/nvim/lazy/nvim-treesitter
nvim
```

Inside Neovim:

```vim
:Lazy sync
```

### `attempt to call field 'install'`

Your Treesitter config and installed Treesitter branch do not match.

Use the classic setup in `init.lua`:

```lua
require('nvim-treesitter.configs').setup(opts)
```

Then reinstall:

```bash
rm -rf ~/.local/share/nvim/lazy/nvim-treesitter
nvim
```

Inside Neovim:

```vim
:Lazy sync
```

### Mason says package not found

Mason package names are not always the same as LSP config names.

Examples:

| LSP config | Mason package |
|---|---|
| `jsonls` | `json-lsp` |
| `cssls` | `css-lsp` |
| `html` | `html-lsp` |
| `ts_ls` | `typescript-language-server` |
| `lua_ls` | `lua-language-server` |

### Telescope live grep does not work

Install ripgrep:

```bash
sudo apt install ripgrep
```

### Telescope file finder does not use fd

Install fd:

```bash
sudo apt install fd-find
mkdir -p ~/.local/bin
ln -s "$(which fdfind)" ~/.local/bin/fd
```

### Clipboard does not work

Install xclip:

```bash
sudo apt install xclip
```

This config uses:

```lua
vim.opt.clipboard = 'unnamedplus'
```

## Repository structure

Current structure is intentionally simple:

```text
~/.config/nvim/
├── init.lua
├── lazy-lock.json
└── README.md
```

Later, this can be split into modules like:

```text
lua/
├── config/
│   ├── options.lua
│   ├── keymaps.lua
│   └── autocmds.lua
└── plugins/
    ├── ui.lua
    ├── lsp.lua
    ├── telescope.lua
    └── editor.lua
```

For now, single-file is easier to understand and maintain.

## Notes to myself

- Keep `lazy-lock.json` tracked so plugin versions are reproducible.
- Prefer small, readable config changes over copying large plugin configs blindly.
- When something breaks, first check:
  - `:messages`
  - `:Lazy`
  - `:checkhealth`
  - `:Mason`
- Do not update every plugin while in the middle of important work.
- Back up `init.lua` before major changes.

## Credits

This configuration originally started from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), but it has been customized into my personal daily-driver Neovim setup.
