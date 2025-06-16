#!/bin/bash

# If a value was provided as an argument, use it as the venv name.  Otherwise, use the default name ".venv".
VENV_NAME=${1:-".venv"}
# Check if the virtual environment already exists
if [ -d "$VENV_NAME" ]; then
    echo "Virtual environment '$VENV_NAME' already exists. Please remove it before creating a new one."
    exit 1
fi
# Create a new virtual environment in the specified directory
echo "Creating a new virtual environment in '$VENV_NAME'..."

python -m venv "$VENV_NAME"
if [ $? -eq 0 ]; then
    echo "Virtual environment created successfully!"
else
    echo "Failed to create virtual environment. Please check the logs for more details."
    exit 1
fi

# Install ollama and other dependencies
echo "Installing ollama and other dependencies..."
source "$VENV_NAME/bin/activate"
pip install --upgrade pip
.venv/bin/pip install ollama
# pip install -r requirements.txt
if [ $? -eq 0 ]; then
    echo "Dependencies installed successfully!"
else
    echo "Failed to install dependencies. Please check the logs for more details."
    deactivate
    exit 1
fi
# Deactivate the virtual environment
deactivate
echo "Virtual environment setup complete. You can now activate it using 'source $VENV_NAME/bin/activate'."
# End of script
# Note: This script assumes that the Python interpreter is available in the PATH.
