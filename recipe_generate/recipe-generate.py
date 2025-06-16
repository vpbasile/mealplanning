import uuid
import sys
from pathlib import Path
from ollama import Client
import json

# TODO: Tokenize the model everywhere and put it in a configuration file
CURRENT_MODEL="gemma3"

# Set the output directory
OUTPUT_DIR = Path("../output")
INPUT_PROMPT = Path("./recipe-prompt.txt" )
INPUT_SCHEMA = Path("./recipe-schema.json")

def get_recipe_requested():
    # This is usually called by a bash script that passes in a recipe name.  If nothing is passed in, we want to prompt the user to enter a requested recipe
    if len(sys.argv) > 1:
        return " ".join(sys.argv[1:]).strip()
    return input("Enter the name of the recipe: ").strip()

def main():
    recipe_to_generate = get_recipe_requested()
    # Load the prompt description and example
    prompt = INPUT_PROMPT.read_text()
    schema = INPUT_SCHEMA.read_text()
    # Build the prompt for the model
    # *   LLMs have parameters that control randomness. Higher “temperature” settings make the output more creative and potentially more prone to deviations. Lowering the temperature (closer to 0) makes the output more deterministic and focused on following instructions. Top-P is a similar parameter, limiting the pool of potential words. Experimenting with these can help, but often a lower temperature is better for structured output. *Note: not all LLMs expose these parameters directly.*
    prompt = f"{prompt}\n{schema}\nPlease generate a recipe for:  {recipe_to_generate}"
    # Call the model
    client = Client()
    response = client.generate(model=CURRENT_MODEL, prompt=prompt)
    recipe_text = response['response'] # if isinstance(response, dict) else response
    print(recipe_text)
    # save_recipe(recipe_text)

if __name__ == "__main__":
    main()
