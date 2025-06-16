#!/bin/bash
# Bootstrap script to set up the recipe generation project environment

set -e

# Define project paths
PROJECT_DIR="$HOME/dev/mealplanning"
VENV_DIR="$PROJECT_DIR/.venv"
INPUT_DIR="$PROJECT_DIR/input"
OUTPUT_DIR="$PROJECT_DIR/output"
SCRIPTS_DIR="$PROJECT_DIR/scripts"

# Create project structure
mkdir -p "$INPUT_DIR" "$OUTPUT_DIR" "$SCRIPTS_DIR"

# Install dependencies
sudo apt update && sudo apt install -y \
  python3 \
  python3-pip \
  python3-venv \
  python3-full \
  curl

# Add Python and Pip aliases
if ! grep -q 'alias python=python3' ~/.bashrc; then
  echo 'alias python=python3' >> ~/.bashrc
fi
if ! grep -q 'alias pip=pip3' ~/.bashrc; then
  echo 'alias pip=pip3' >> ~/.bashrc
fi
source ~/.bashrc

# Set up virtual environment
python3 -m venv "$VENV_DIR"
source "$VENV_DIR/bin/activate"

# Install Ollama
curl -fsSL https://ollama.com/install.sh | sh
ollama serve &

# Pull default model
ollama pull gemma:7b

# Install Python package
pip install ollama

# Create placeholder prompt file if missing
if [ ! -f "$INPUT_DIR/prompt-recipe.md" ]; then
  echo "# Example Prompt Format\n\nProvide a structured markdown recipe given the name." > "$INPUT_DIR/prompt-recipe.md"
fi

# Notify
echo "✅ Project bootstrap complete. You can now run ./request_recipe.sh from $PROJECT_DIR"
