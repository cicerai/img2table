#!/bin/bash

VENV = ./activate_venv
DIR := $(shell pwd)
export PYTHONPATH := $(DIR)/src

include ./deploy/$(ENV).env

# Virtual environment commands
venv:
	python -m venv ./venv || true
	. $(VENV); python -m pip install pip wheel --upgrade;
	. $(VENV); python -m pip install torch torchvision --index-url https://download.pytorch.org/whl/cpu
	. $(VENV); python -m pip install -r requirements-dev.txt

update:
	. $(VENV); python -m pip install torch torchvision --index-url https://download.pytorch.org/whl/cpu
	. $(VENV); python -m pip install -U -r requirements-dev.txt

# Test commands
test:
	. $(VENV); pytest --cov-report term --cov=src

# Examples commands
jupyter-examples:
	. $(VENV); cd examples && jupyter notebook

update-examples:
	. $(VENV);
	for f in $(PWD)/examples/*.ipynb; do \
	  jupyter nbconvert --to notebook --execute $$f --inplace; \
	done

clean: clean-build clean-pyc clean-test ## remove all build, test, coverage and Python artifacts

clean-build: ## remove build artifacts
	rm -fr build/
	rm -fr dist/
	rm -fr .eggs/
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.egg' -exec rm -f {} +

clean-pyc: ## remove Python file artifacts
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

clean-test: ## remove test and coverage artifacts
	rm -fr .tox/
	rm -f .coverage
	rm -fr htmlcov/
	rm -fr .pytest_cache

dist: clean ## builds source and wheel package
	python setup.py sdist
	python setup.py bdist_wheel
	ls -l dist

gcloud-auth:
	gcloud auth activate-service-account \
	${SERVICE_ACCOUNT} \
	--key-file=${SA_KEY_FILE}

release: gcloud-auth dist ## package and upload a release
	twine upload --verbose --repository-url https://us-central1-python.pkg.dev/$(PROJECT_ID)/img2table/ dist/*



