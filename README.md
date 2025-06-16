# Meal Plan Workflow

## The user might perform any of the following actions:
* Ask for a meal plan.
* Ask for a recipe from a meal plan.
* Ask for a recipe fropm the library.
* Journal a meal.

# Directory structure

```
/mealplan/
    ├── .venv/                  # Virtual environment for Python dependencies
    ├── journal/                # User meal journals and logs
    ├── menu/                   # Scripts for generating meal plans
    ├── notes/                  # Notes of what I've learned as I go
    ├── recipe_generate/        # Everything needed for Recipe generation
    │   ├── recipe-request.sh   # Entry point to request a recipe from the Ollama model
    ├── recipes/                # Collection of saved recipes in JSON files.  These can be viewed by a different application.
    ├── scripts/                # Scripts for developer QOL
    └── README.md               # Project overview and documentation
```