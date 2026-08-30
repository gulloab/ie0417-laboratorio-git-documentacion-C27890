# Script para regenerar la documentacion del laboratorio
# Requiere: Doxygen, Graphviz, Python 3 con venv

# --- Doxygen (C++) ---
Push-Location doxygen
doxygen Doxyfile 2>&1 | Tee-Object -FilePath build.log
Pop-Location

# --- Sphinx (Python) ---
Push-Location sphinx
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements-docs.txt
sphinx-build -a -E -b html source ..\site\python 2>&1 | Tee-Object -FilePath build.log
deactivate
Pop-Location

Write-Host "Documentacion regenerada en site\cpp y site\python"
