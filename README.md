# Dotfiles

Personal dotfiles configuration for macOS. This repository contains my shell configuration, prompt setup, and development environment settings.

## ⚠️ Privacy Notice

I carefully ensure that this repository contains **only general configuration information**. No sensitive data, API keys, passwords, or personal information is stored here.

## 🖥️ Platform

This configuration is designed for **macOS**.

## 📦 Prerequisites

Install the following packages using Homebrew:

```bash
brew install zsh-completions
brew install starship
brew install direnv
brew install pyenv
brew install kubectl
brew install krew
```

## 📁 Structure

- `.zshrc` - Main Zsh configuration with aliases, history settings, and tool initializations
- `.direnvrc` - Direnv configuration for project-specific environment variables
- `.config/starship.toml` - Starship prompt configuration

## 🚀 Setup

This repository uses a bare Git repository approach. After cloning this repository to `~/.dotfiles`, the `dotfiles` alias defined in `.zshrc` provides a convenient way to manage these files directly from your home directory using standard Git commands (e.g., `dotfiles status`, `dotfiles add`, `dotfiles commit`).

## 🛠️ Included Tools

- **Starship** - Fast and customizable prompt
- **Direnv** - Environment variable management per project
- **Pyenv** - Python version management
- **Kubectl** - Kubernetes command-line tool
- **Krew** - Kubectl plugin manager
- **Zsh completions** - Enhanced shell completions
- **Git aliases** - Convenient Git shortcuts
