set dotenv-load

alias d := dbg
alias p := pex
alias i := install
alias f := fmt
alias r := run
alias u := upgrade
alias upkg := upgrade-package

install:
    pipx install -e .

pex:
    pex pex --requirement requirements.txt --executable isthmus.py --output-file ~/.bin/isthmus

fmt:
    ruff format isthmus.py

run:
    python isthmus.py

dbg:
    pudb isthmus.py

@upgrade-package pkg:
    pip-compile --upgrade-package {{pkg}}

venv:
    echo "Removing .venv"
    rm -rf .venv/
    python -m venv .venv
    source .venv/bin/activate
    pip install pip-tools
    pip-compile requirements.in
    pip install --requirement requirements.txt
    pip-compile requirements-dev.in
    pip install --requirement requirements-dev.txt

sync:
    pip-sync

upgrade:
    echo "upgrading all packages!"
    pip-compile --upgrade requirements.txt
    git add requirements.txt requirements-dev.txt
    git commit -m "Upgrade requirements.txt"
