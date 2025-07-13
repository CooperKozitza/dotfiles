# Dotfiles Configuration

A comprehensive collection of configuration files for modern development environments, optimized for both Arch Linux and macOS.

## Included Tools & Configurations

### Terminal & Shell
- **[Zsh](https://wiki.archlinux.org/title/zsh)** with **[Oh My Zsh](https://ohmyz.sh/)** - Enhanced shell with plugins and themes
- **[Kitty](https://sw.kovidgoyal.net/kitty/)** - GPU-accelerated terminal emulator with Tokyo Night theme

### Window Manager (Arch Linux)
- **[Hyprland](https://hyprland.org/)** - Dynamic tiling Wayland compositor

### Text Editor
- **[Neovim](https://neovim.io/)** with **[kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)** configuration
  - Pre-configured with LSP, treesitter, and essential plugins
  - Includes custom plugins and Tokyo Night theme

### Development Tools
- **[GitHub CLI](https://cli.github.com/)** - Command-line tool for GitHub
- **[yay](https://github.com/Jguer/yay)** - AUR helper for Arch Linux

## Installation

### Prerequisites

#### Arch Linux
```bash
# Install base packages
sudo pacman -S git zsh neovim kitty hyprland

# Install yay (AUR helper)
git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -si
```

#### macOS with Homebrew
```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install base packages
brew install git zsh neovim kitty gh
```

### Tool-Specific Requirements

#### Zsh & Oh My Zsh
```bash
# Arch Linux
sudo pacman -S zsh

# macOS
brew install zsh

# Oh My Zsh will be automatically available from the included configuration
```

#### Kitty Terminal
- **Arch Linux**: `sudo pacman -S kitty`
- **macOS**: `brew install kitty`
- Includes Tokyo Night color scheme

#### Neovim (kickstart.nvim)
**Required dependencies:**
- **Basic utils**: `git`, `make`, `unzip`, C compiler (`gcc`/`clang`)
- **[ripgrep](https://github.com/BurntSushi/ripgrep)**: Fast text search
- **Clipboard tool**: `xclip`/`xsel` (Linux) or built-in (macOS)
- **[Nerd Font](https://www.nerdfonts.com/)**: For icons (optional but recommended)

```bash
# Arch Linux
sudo pacman -S git make unzip gcc ripgrep xclip
yay -S nerd-fonts-fira-code

# macOS
brew install git make unzip gcc ripgrep
brew install --cask font-fira-code-nerd-font
```

#### Hyprland (Arch Linux only)
See the [Hyprland wiki](https://wiki.hyprland.org/Getting-Started/Installation/) for detailed installation instructions.

```bash
sudo pacman -S hyprland
```

#### GitHub CLI
```bash
# Arch Linux
sudo pacman -S github-cli

# macOS
brew install gh
```

### Clone and Setup

1. **Backup existing configurations** (if any):
```bash
cp -r ~/.config ~/.config.backup
```

2. **Clone this repository**:
```bash
git clone <repository-url> ~/.config
```

3. **Set Zsh as default shell**:
```bash
chsh -s $(which zsh)
```

4. **Install Neovim plugins** (will happen automatically on first launch):
```bash
nvim
```

## Additional Setup

### Font Configuration
For the best experience, install a Nerd Font:
- **Arch Linux**: `yay -S nerd-fonts-fira-code`
- **macOS**: `brew install --cask font-fira-code-nerd-font`

Set `vim.g.have_nerd_font = true` in `nvim/init.lua` after font installation.

### GitHub CLI Authentication
```bash
gh auth login
```

### Development Languages
Install language-specific tools as needed:
- **Node.js/npm**: For TypeScript/JavaScript development
- **Go**: For Go development
- **Python**: For Python development
- **Rust**: For Rust development

## Configuration Structure

```
~/.config/
├── hypr/           # Hyprland configuration (Arch Linux)
├── kitty/          # Kitty terminal configuration
├── nvim/           # Neovim configuration (kickstart.nvim)
├── zsh/            # Zsh and Oh My Zsh configuration
├── gh/             # GitHub CLI configuration
└── yay/            # yay AUR helper configuration (Arch Linux)
```

## Customization

Each tool's configuration can be customized by editing the respective files:
- **Zsh**: Modify `~/.config/zsh/` files
- **Kitty**: Edit `~/.config/kitty/kitty.conf`
- **Neovim**: Customize `~/.config/nvim/init.lua`
- **Hyprland**: Edit `~/.config/hypr/hyprland.conf`

## Troubleshooting

### Common Issues
- **Zsh not loading Oh My Zsh**: Ensure the path in your shell configuration is correct
- **Neovim plugins not working**: Run `:checkhealth` in Neovim to diagnose issues
- **Kitty font issues**: Install a Nerd Font and configure it in `kitty.conf`
- **Hyprland not starting**: Check the [Hyprland troubleshooting guide](https://wiki.hyprland.org/FAQ/)

### Getting Help
- **Arch Linux**: [Arch Wiki](https://wiki.archlinux.org/)
- **Neovim**: [kickstart.nvim documentation](https://github.com/nvim-lua/kickstart.nvim)
- **Hyprland**: [Hyprland documentation](https://hyprland.org/)
- **Kitty**: [Kitty documentation](https://sw.kovidgoyal.net/kitty/)

## License

This configuration is provided as-is. Individual tools maintain their respective licenses.