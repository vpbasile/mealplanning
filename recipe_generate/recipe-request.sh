#!/bin/bash

# This script prompts the user for a recipe title, sets it as an environment variable,
# activates the virtual environment, runs the Python script to generate the recipe,
# checks if the script ran successfully, and then deactivates the virtual environment.
# This script assumes that the virtual environment is located in the .venv directory
# This script is intended to be run from the root directory of the project.


# Use the first argument as the recipe title, or prompt the user if none is given.
RECIPE_TITLE="${1:-}"
# Check if the recipe title is empty and prompt the user for input if it is.    
if [ -z "$RECIPE_TITLE" ]; then
read -p "Please enter the title of the recipe you want to generate:" RECIPE_TITLE
fi

# Start the virtual environment and run the Python script to generate the recipe.
export RECIPE_TITLE
echo "Generating recipe for: $RECIPE_TITLE"

# Activate the virtual environment and 
VENV_PATH="../.venv/bin/activate"
if [ ! -f "$VENV_PATH" ]; then
  echo "❌ Virtual environment not found at $VENV_PATH"
  exit 1
fi

source "$VENV_PATH"
# Check if the ollama command is available
if ! command -v ollama &> /dev/null; then
    echo "❌ ollama command not found. Please install ollama and try again."
    deactivate
    exit 1
fi

# run the Python script to generate the recipe
python3 ./recipe-generate.py "$RECIPE_TITLE"

# Check if the script ran successfully
if [ $? -eq 0 ]; then
    echo "Recipe generated successfully!"
else
    echo "Failed to generate recipe. Please check the logs for more details."
fi
# Deactivate the virtual environment
deactivate
# End of script