#!/bin/bash

echo "Installing Nikki AI..."

if ! command -v aichat &> /dev/null; then
  echo "Install aichat: sudo pacman -S aichat"
  exit 1
fi
if ! command -v ollama &> /dev/null; then
  echo "Install Ollama: https://ollama.com/download"
  exit 1
fi

mkdir -p ~/.config/fish/functions
cp fish/nikki.fish ~/.config/fish/functions/

cp bin/setup-rag.fish ~/bin/setup-rag

if [ ! -f ~/.config/aichat/config.yaml ]; then
  cp config/aichat-config.yaml ~/.config/aichat/config.yaml
  echo "⚠️ Edit ~/.config/aichat/config.yaml for your system"
fi

mkdir -p ~/.config/aichat/roles
cp roles/redteam-ru.yaml ~/.config/aichat/roles/

echo "✅ The installation is complete! Use 'Nikki' in the terminal. (Example: Nikki generate a reverse TCP shell in C)"
