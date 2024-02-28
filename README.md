# presence.nvim

![presence.nvim](https://gist.githubusercontent.com/andweeb/df3216345530234289b87cf5080c2c60/raw/8de399cfed82c137f793e9f580027b5246bc4379/presence.nvim.png)

This repository uses
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-%23FE5196?logo=conventionalcommits&logoColor=white)](https://conventionalcommits.org)

**[Features](#features)** | **[Installation](#installation)** |
**[Configuration](#configuration)** | **[Troubleshooting](#troubleshooting)** |
**[Development](#development)** | **[Contributing](#contributing)**

> Discord [Rich Presence](https://discord.com/rich-presence) plugin for [Neovim](https://neovim.io)

![Presence demo](https://gist.githubusercontent.com/andweeb/df3216345530234289b87cf5080c2c60/raw/ad916fec8de921d0021801a0af877a5349621e7e/presence-demo-a.gif)

## Features

- Light and unobtrusive
- No Python/Node providers (or CoC) required
- Cross-platform support: macOS, nixOS, Linux[\*](#notes),
Windows, WSL
- Startup time is fast(er than other Rich Presence plugins, by
[kind of a lot](https://github.com/andweeb/presence.nvim/wiki/Plugin-Comparisons))
- Written in Lua and [highly configurable](#configuration) in Lua
(but also configurable in VimL if you want)
- Manages Rich Presence across multiple Neovim instances in various environments
(tmux panes/windows, ssh sessions, terminal tabs/windows, etc.)
- Now with Flatpak support!

## Installation

Use your favorite plugin manager

- [vim-plug](https://github.com/junegunn/vim-plug): `Plug 'jiriks74/presence.nvim'`
- [packer.nvim](https://github.com/wbthomason/packer.nvim): `use 'jiriks74/presence.nvim'`
- [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "jiriks74/presence.nvim",
  event = "UIEnter",
},
```

### Notes

- Requires [Neovim 0.5](https://github.com/neovim/neovim/releases/tag/v0.5.0)
or higher
- Rich Presence should work automatically after installation
(unless you're using WSL, in which case
[see here](https://github.com/andweeb/presence.nvim/wiki/Rich-Presence-in-WSL))

## Configuration

Configuration is not necesary unless you want to override the default config.

If you want to change the default config here are your options in Lua and VimL:

### Lua

Require the plugin and call `setup` with a config table with one or more of the
following keys:

```lua
-- The setup config table shows all available config options with their default values:
require("presence").setup({
    -- General options
    auto_update         = true,                       -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
    neovim_image_text   = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
    main_image          = "neovim",                   -- Main image display (either "neovim" or "file")
    client_id           = "1172122807501594644",       -- Use your own Discord application client id (not recommended)
    log_level           = nil,                        -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
    debounce_timeout    = 10,                         -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
    enable_line_number  = false,                      -- Displays the current line number instead of the current project
    blacklist           = {},                         -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
    buttons             = true,                       -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
    file_assets         = {},                         -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
    show_time           = true,                       -- Show the timer

    -- Rich Presence text options
    editing_text        = "Editing %s",               -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
    file_explorer_text  = "Browsing %s",              -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
    git_commit_text     = "Committing changes",       -- Format string rendered when committing changes in git (either string or function(filename: string): string)
    plugin_manager_text = "Managing plugins",         -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
    reading_text        = "Reading %s",               -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
    workspace_text      = "Working on %s",            -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
    line_number_text    = "Line %s out of %s",        -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
})
```

### VimL

Or if global variables are more your thing, you can use any of the following instead:

```viml
" General options
let g:presence_auto_update         = 1
let g:presence_neovim_image_text   = "The One True Text Editor"
let g:presence_main_image          = "neovim"
let g:presence_client_id           = "1172122807501594644"
let g:presence_log_level
let g:presence_debounce_timeout    = 10
let g:presence_enable_line_number  = 0
let g:presence_blacklist           = []
let g:presence_buttons             = 1
let g:presence_file_assets         = {}
let g:presence_show_time           = 1

" Rich Presence text options
let g:presence_editing_text        = "Editing %s"
let g:presence_file_explorer_text  = "Browsing %s"
let g:presence_git_commit_text     = "Committing changes"
let g:presence_plugin_manager_text = "Managing plugins"
let g:presence_reading_text        = "Reading %s"
let g:presence_workspace_text      = "Working on %s"
let g:presence_line_number_text    = "Line %s out of %s"
```

## Troubleshooting

- Ensure that Discord is running
- Ensure that your Neovim version is 0.5 or higher
- Ensure Game Activity is enabled in your Discord settings
- Enable logging and inspect the logs after opening a buffer
  - Set the [`log_level`](#lua) setup option or [`g:presence_log_level`](#viml)
  to `"debug"`
  - Load a file and inspect the logs with `:messages`
- If there is a `Failed to determine Discord IPC socket` error, your particular
OS may not yet be supported
  - If you don't see an existing
  [issue](https://github.com/jiriks74/presence.nvim/issues)
  or [card](https://github.com/jiriks74/presence.nvim/projects/1#column-14183588)
  for your OS, create a prefixed
  [issue](https://github.com/jiriks74/presence.nvim/issues/new)
  (e.g. `[Void Linux]`)
- Still not working and need help? Create a new
[issue](https://github.com/jiriks74/presence.nvim/issues)!

## Development

- Clone the repo: `git clone https://github.com/jiriks74/presence.nvim.git`
- Enable [logging](#configuration) and ensure that `presence.nvim` is **_not_**
in the list of vim plugins in your config
- Run `nvim` with your local changes: `nvim --cmd
'set rtp+=path/to/your/local/presence.nvim' file.txt`
- Ensure that there are no [luacheck](https://github.com/mpeterv/luacheck/)
errors: `luacheck lua`

## Contributing

**Please use [Conventional Commits](https://www.conventionalcommits.org/)
if you want to contribute.
It makes everyones jobs easier.**

**This project uses [StyLua](https://github.com/JohnnyMorganz/StyLua).
Please format your code using StyLua for better readability**

Pull requests are very welcome, feel free to open an issue to work on
or message [me (@jiriks74)](https://discordapp.com/users/517810049360461837) on my
[Discord server](https://discord.gg/cCq3qcB4jB)!

Asset additions and changes are also welcome! Supported file types can be found in
[`file_assets.lua`](lua/presence/file_assets.lua) and their referenced asset files
can be found [in this folder](https://www.dropbox.com/sh/j8913f0gav3toeh/AADxjn0NuTprGFtv3Il1Pqz-a?dl=0).
