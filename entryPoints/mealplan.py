import ollama
import os

print("Begin mealplan.py")

model = "gemma3:1b"

# The filename will need today's date in YYYY-MM-DD format
today = ollama.utils.get_today_date()

# Using input and output files to make htings persist
input_file = "../input/nutrition.txt"
output_file = "../output/menu-" + today + ".txt"

if not os.path.exists(input_file):
    print("Input file '{input_file}' not found.")
    exit(1)

# Read the input file
with open(input_file, "r") as f:
    items = f.read().strip()


# Prepare the prompt for the model
# TODO Eventually it should take my recent meals into consideration

prompt = f"""
You are an assistant that helps me decide what to eat.

Here is my heuristic for meal planning: {items}

Please help me come up with five days of breakfast, lunch and dinner.

"""


# Send the prompt and get the response
try:
    response = ollama.generate(model=model, prompt=prompt)
    generated_text = response.get("response", "")
    # print("==== Response: ===== \n")
    # print(generated_text)

    # Write the result to the output file
    with open(output_file, "w") as f:
        f.write(generated_text.strip())

    print(f"Output has been saved to '{output_file}'.")
except Exception as e:
    print("An error occurred:", str(e))
