# Project Setup: Recipe Generator with WSL, Python, and Ollama

This guide walks you through setting up a Python-based recipe generation tool using Ollama inside WSL.

---

## 🖥️ System Requirements
- Windows 10 or 11
- WSL (Windows Subsystem for Linux)
- Ubuntu (or compatible distro)

---

## 🔧 Step-by-Step Setup

### 1. Install WSL (if not already installed)
Open PowerShell as Administrator:

```powershell
wsl --install
```

Reboot if prompted. Ubuntu will be installed by default.

---

### 2. Set Up Development Directory

In your WSL terminal:

```bash
mkdir -p ~/dev/mealplanning
cd ~/dev/mealplanning
```

---

### 3. Install Python and Pip (if not already installed)

```bash
sudo apt update
sudo apt install python3 python3-pip python3-venv python3-full -y
```

Create helpful aliases:

```bash
echo 'alias python=python3' >> ~/.bashrc
echo 'alias pip=pip3' >> ~/.bashrc
source ~/.bashrc
```

---

### 4. Create a Python Virtual Environment

```bash
python -m venv .venv
source .venv/bin/activate
```

---

### 5. Install Ollama

```bash
curl -fsSL https://ollama.com/install.sh | sh
ollama serve &
```

---

### 6. Pull a Model

```bash
ollama pull gemma:7b
```

Test it:

```bash
ollama run gemma:7b
```

---

### 7. Install Python Dependencies

Inside your venv:

```bash
pip install ollama
```

---

### 8. Set Up Project Structure

```
mealplanning/
├── .venv/
├── input/
│   └── prompt-recipe.md
├── output/
│   └── *.md
├── scripts/
│   └── generate_recipe.py
└── request_recipe.sh
```

---

### 9. Make the Shell Script Executable

```bash
chmod +x request_recipe.sh
```

---

### 10. Run the Script

```bash
./request_recipe.sh
```

The script will prompt for a recipe title, generate a recipe using Ollama, and save the result to the `output/` folder.

---

## 🧠 Tips

- `ollama list`: View available models.
- `ollama pull llama3`: Try different models.
- `deactivate`: Exit Python virtual environment.

---

## ✅ You're Done!
You now have a working recipe generator powered by local AI and Python!

