# dotfiles

Personal terminal, shell and editor settings. Each file sits at the same path
it has under your home directory (`~`): `.config/herdr/config.toml` here goes
to `~/.config/herdr/config.toml`, and so on.

There are two sets:

- **macOS terminal** (current): Ghostty, Herdr, iTerm2, Starship, lazygit and
  delta, all using the **Vesper** theme.
- **Linux** (legacy): zsh with Powerlevel10k, Terminator and Vim.

## Contents

| File | Destination | What it is |
|---|---|---|
| `.config/ghostty/config` | `~/.config/ghostty/config` | Ghostty: theme, font, transparency and quick terminal |
| `.config/ghostty/shaders/*.glsl` | `~/.config/ghostty/shaders/` | CRT monitor effect (optional) |
| `.config/herdr/config.toml` | `~/.config/herdr/config.toml` | Herdr: Vim-style keybindings and theme |
| `Library/Application Support/iTerm2/DynamicProfiles/vesper.json` | same path under `~` | iTerm2 "Guake (Vesper)" profile |
| `Library/Application Support/lazygit/config.yml` | same path under `~` | lazygit: Vesper colors and delta diffs |
| `.config/zsh/terminal-visual.zsh` | `~/.config/zsh/terminal-visual.zsh` | Starship, zoxide, `ls` with icons and zsh plugins |
| `.gitconfig.delta` | `~/.gitconfig.delta` | delta as the git pager |
| `.zshrc`, `.p10k.zsh`, `.bash_aliases` | `~/` | Shell (legacy, Linux) |
| `.vimrc`, `.vimrc.local`, `.vimrc.local.bundles` | `~/` | Vim (legacy) |
| `.config/terminator/config` | `~/.config/terminator/config` | Terminator (legacy, Linux) |

## macOS terminal

### 1. Install

```bash
brew install --cask ghostty font-jetbrains-mono-nerd-font
brew install starship eza zoxide git-delta lazygit \
  zsh-autosuggestions zsh-syntax-highlighting
# optional: fastfetch btop
```

Herdr has its own installer: <https://herdr.dev>.

### 2. Copy the files

From the root of this repo:

```bash
mkdir -p ~/.config/ghostty/shaders ~/.config/herdr ~/.config/zsh \
  ~/Library/Application\ Support/iTerm2/DynamicProfiles \
  ~/Library/Application\ Support/lazygit

cp .config/ghostty/config ~/.config/ghostty/config
cp .config/ghostty/shaders/*.glsl ~/.config/ghostty/shaders/
cp .config/herdr/config.toml ~/.config/herdr/config.toml
cp .config/zsh/terminal-visual.zsh ~/.config/zsh/terminal-visual.zsh
cp .gitconfig.delta ~/.gitconfig.delta
cp "Library/Application Support/iTerm2/DynamicProfiles/vesper.json" \
  ~/Library/Application\ Support/iTerm2/DynamicProfiles/
cp "Library/Application Support/lazygit/config.yml" \
  ~/Library/Application\ Support/lazygit/config.yml
```

Back up any of these files you already have first. If you want changes in the
repo to apply right away, use `ln -s "$PWD/<file>" <destination>` instead of `cp`.

### 3. Hook up the shell and git

At the end of `~/.zshrc`:

```zsh
source ~/.config/zsh/terminal-visual.zsh
```

If you use Oh My Zsh, set `ZSH_THEME=""` so Starship draws the prompt.

For git:

```bash
git config --global include.path ~/.gitconfig.delta
```

### Ghostty

- **Theme:** `Vesper`, bundled with Ghostty. List others with
  `ghostty +list-themes`.
- **Font:** JetBrains Mono Nerd Font, Medium weight, size 14, with
  `font-thicken`.
- **Quick terminal (Guake style):** ``ctrl+` `` shows and hides the terminal
  from any app. The first time, macOS asks you to grant Ghostty Accessibility
  permission. `quick-terminal-size = 100%` makes the window fill the screen.
  Use this instead of fullscreen, because a fullscreen window keeps the wrong
  size after you switch monitors.
  - On macOS the quick terminal has no tabs (a Ghostty limitation). Use Herdr
    tabs instead. Splits work.
- **Option as Alt:** only the left Option key (`macos-option-as-alt = left`),
  so Herdr's `alt` keybindings work. The right Option still types special
  characters.
- **Starting folder:** uncomment `working-directory` and set your path.
- **CRT effect:** uncomment `custom-shader`. `crt-soft.glsl` is the subtle
  version; `crt.glsl` is the original, which is strong and unreadable on a
  1080p monitor.
- **Reload the config:** `cmd+shift+,` (comma). `cmd+shift+=` makes the font
  bigger; `cmd+0` resets it.
- **Open at login:** System Settings → General → Login Items.

### Herdr

The prefix is `ctrl+space`. First turn off the macOS shortcut that uses
`ctrl+space` (System Settings → Keyboard → Keyboard Shortcuts → Input Sources).

| Action | Keys |
|---|---|
| Settings | `prefix` `,` |
| Move between panes | `prefix` `h/j/k/l` or `ctrl+alt+h/j/k/l` |
| Split stacked / side by side | `prefix` `s` (or `-`) / `prefix` `v` |
| Resize pane | `prefix` `<` `>` `+` `_` |
| New tab | `prefix` `c` |
| Next / previous tab | `prefix` `n` / `p`, or `ctrl+alt+]` / `ctrl+alt+[` |
| Last pane | `prefix` `;` |
| Next / previous agent | `ctrl+alt+n` / `ctrl+alt+p` |
| Close workspace (worktree stays on disk) | `prefix` `shift+d` |
| Close workspace **and delete the worktree** | `prefix` `alt+d` |

- Reload the config without stopping anything: `herdr server reload-config`.
- `alt+d` only works in a worktree workspace, asks for confirmation and never
  deletes the branch.
- Closing the terminal doesn't stop Herdr: run `herdr` again and everything
  comes back.

### iTerm2 (alternative to Ghostty)

`vesper.json` creates the dynamic profile **Guake (Vesper)**, a child of a
profile named **Guake** that must already exist (create it under Settings →
Profiles). It has the Vesper palette, JetBrains Mono Nerd Font Medium 14,
transparency with blur and the ``ctrl+` `` hotkey.

To make it the profile in use:

1. Settings → Profiles → **Guake (Vesper)** → Other Actions → *Set as Default*.
2. Turn off the hotkey on the original **Guake** profile (Keys → Hotkey
   Window), so two profiles don't both use ``ctrl+` ``.

Ghostty uses the same ``ctrl+` ``. Don't run both apps at the same time.

### Shell

- **Starship:** a standalone program, not an Oh My Zsh theme. To customize the
  prompt, create `~/.config/starship.toml`.
- **zoxide:** `z <part-of-name>` jumps to folders you've visited before.
- **zsh-autosuggestions:** grey suggestions as you type; `→` accepts.
- **zsh-syntax-highlighting:** a command turns green when it exists and red
  when it doesn't.

### delta and lazygit

- **delta:** `git diff`, `git show` and `git log -p` get colors, line numbers
  and side-by-side diffs. `n` / `N` jump between files. In a narrow pane, change
  `side-by-side = true` to `false` in `~/.gitconfig.delta`.
- **lazygit:** uses the Vesper colors and delta for diffs (`|` cycles the diff
  view). The config lives in `~/Library/Application Support/lazygit/`.

## Linux (legacy)

### zsh and Powerlevel10k

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
cp .zshrc .p10k.zsh .bash_aliases ~/
```

To redo the prompt look, run `p10k configure`. The `.zshrc` also sets up nvm
and Android and Java paths; adjust them for your machine.

### Terminator

```bash
mkdir -p ~/.config/terminator
cp .config/terminator/config ~/.config/terminator/config
```

Main shortcuts: `alt+h/j/k/l` moves between panes, `ctrl+k` / `ctrl+j`
switches tabs and `ctrl+esc` hides the window.

### Vim

```bash
cp .vimrc .vimrc.local .vimrc.local.bundles ~/
vim +PlugInstall +qall
```

Based on vim-bootstrap. vim-plug downloads itself the first time you open Vim
(requires `curl`). Extra plugins are in `.vimrc.local.bundles` (gruvbox,
coc.nvim, markdown-preview), and personal preferences in `.vimrc.local`.
