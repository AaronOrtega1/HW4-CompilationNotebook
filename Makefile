VENV = .venv
PYTHON = $(VENV)/bin/python
PIP = $(VENV)/bin/pip

install: $(VENV)/bin/activate

$(VENV)/bin/activate: requirements.txt
	python -m venv $(VENV)
	$(PIP) install --upgrade pip
	$(PIP) install -r requirements.txt
	touch $(VENV)/bin/activate  # Mark as complete

run: install
	$(PYTHON) hello.py

install-aws: $(VENV)/bin/activate
	$(PIP) install --upgrade pip
	$(PIP) install -r requirements-aws.txt

install-amazon-linux: $(VENV)/bin/activate
	$(PIP) install --upgrade pip
	$(PIP) install -r amazon-linux.txt

lint: $(VENV)/bin/activate
	$(VENV)/bin/pylint --disable=R,C hello.py

format: $(VENV)/bin/activate
	$(VENV)/bin/black *.py

test: $(VENV)/bin/activate
	$(PYTHON) -m pytest -vv --cov=hello test_hello.py

clean:
	rm -rf $(VENV)
	rm -rf .pytest_cache
	rm -rf .coverage

.PHONY: install run install-aws install-amazon-linux lint format test clean
