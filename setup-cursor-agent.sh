#!/bin/bash
set -e

echo "🚀 Cursor Agent - Complete Setup"
echo "================================="

# 1. Install Homebrew if not present
if ! command -v brew &>/dev/null; then
  echo "📦 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add brew to PATH for this session (macOS Apple Silicon vs Intel)
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
  elif [[ -f /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
else
  echo "✅ Homebrew already installed"
fi

# 2. Install Git if not present
if ! command -v git &>/dev/null; then
  echo "📦 Installing Git..."
  brew install git
else
  echo "✅ Git already installed"
fi

# 3. Install Cursor CLI
echo "📦 Installing Cursor CLI..."
curl -sSf https://cursor.com/install | bash

# 4. Ensure ~/.local/bin is in PATH
grep -q '.local/bin' ~/.zshrc 2>/dev/null || echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
export PATH="$HOME/.local/bin:$PATH"

echo ""
echo "✅ Setup complete!"
echo "   Run 'source ~/.zshrc' or open a new terminal, then run: agent"
