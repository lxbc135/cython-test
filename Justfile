# Fibonacci Extension Build Tasks

set shell := ["bash", "-c"]

PYTHON := "./.venv/Scripts/python"
UV := "./.venv/Scripts/uv"
PIP := "./.venv/Scripts/uv pip"

@default:
    just --list

# Install package in development mode
@dev:
    {{PIP}} install -e .

# Install development dependencies
@dev-deps:
    # {{PIP}} install -e .[dev]
    uv sync --group dev

# Build the Cython extension
@build:
    {{PYTHON}} setup.py build_ext --inplace

# Build the wheel distribution
@wheel:
    {{PIP}} install build
    {{PYTHON}} -m build --wheel

# Build source distribution
@sdist:
    {{PIP}} install build
    {{PYTHON}} -m build --sdist

# Build all distributions
@dist: wheel sdist

# Clean build artifacts
@clean:
    {{PYTHON}} setup.py clean --all
    rm -rf build/
    rm -rf dist/
    rm -rf *.egg-info/
    rm -rf src/**/*.c
    rm -rf src/**/*.so
    rm -rf src/**/*.pyd
    find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
    find . -type f -name "*.pyc" -delete 2>/dev/null || true

# Run tests
@test:
    {{PYTHON}} -m pytest tests/ -v

# Install package for testing
@install-test: build
    {{PIP}} install -e .

# Full development setup
@setup: dev-deps build

# Format and lint code
@lint:
    {{PYTHON}} -m pylint src/fibonacci/
    {{PYTHON}} -m black --check src/

# Format code
@format:
    {{PYTHON}} -m black src/

# Create a setup.py file needed for build_ext
@generate-setup:
    {{PYTHON}} -c "import setuptools; from Cython.Build import cythonize; import os; os.system('python setup.py build_ext --inplace')"

# View help
@help:
    @echo "Available tasks:"
    @echo "  just setup          - Install dependencies and build extension"
    @echo "  just dev            - Install in development mode"
    @echo "  just dev-deps       - Install development dependencies"
    @echo "  just build          - Build the Cython extension"
    @echo "  just wheel          - Build wheel distribution"
    @echo "  just sdist          - Build source distribution"
    @echo "  just dist           - Build all distributions"
    @echo "  just clean          - Clean build artifacts"
    @echo "  just test           - Run tests"
    @echo "  just install-test   - Build and install for testing"
