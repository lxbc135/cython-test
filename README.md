# Cython Example

A Python extension in Cython example.

## Requirements

* Python 3.8+
* Cython 0.29+
* setuptools 65+

## Quick Start

**Create virtual environment:**

```bash
uv venv --python 3.14
```

That will create virtual environment `.venv` directory with Python 3.14.

**To activate virtual environment (on Linux):**

```bash
source .venv/bin/activate
```

**To activate virtual environment (on Windows Bash):**

```bash
source .venv/Scripts/activate
```

**To install build dependencies:**

```bash
uv sync --group dev
```

**To build for development:**

```bash
uv run python setup.py build_ext --inplace
```

The `--inplace` option creates the built `.pyd`/`.so` extension file directly alongside the source `.pyx` file in the source tree, instead of putting it under build. That allows Python to find it, and lets you use the package without installing it.

**To try package:**

```bash
uv run python -c 'from fibonacci import fibonacci; print(f"fibonacci(10): {fibonacci(10)}")'
```

**Expected Output:**

```txt
fibonacci(10): 55
```

### Example

```python
from fibonacci import fibonacci, fibonacci_sequence

# Calculate the nth Fibonacci number
result = fibonacci(10)  # Returns 55

# Generate sequence of first n Fibonacci numbers
sequence = fibonacci_sequence(10)  # Returns [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
```

## Release Build

**To install current package in editable (development) mode:**

```bash
uv pip install -e .
```

**To uninstall current package in edit mode:**

```bash
uv pip uninstall fibonacci-extension
```

**To build wheel (whl):**

```bash
uv run python -m build --wheel
```

If you get "Access Denied" error whiling removing `%LocalAppData%\Temp\....whl` file on Windows, you can try adding `--no-isolation` option to use local directory.

```bash
uv run python -m build --wheel --no-isolation
```

It creates `.whl` file in `dist` directory.

**To package source distribution (sdist):**

```bash
uv run python -m build --sdist
```

As with wheels, if you get access error with `%LocalAppData%` on Windows, you can try `--no-isolation` option:

```bash
uv run python -m build --sdist --no-isolation
```

It creates `.tar.gz` source distribution in `dist` directory.

## To create setup.py

To create a setup.py file needed for build_ext:

```bash
uv run python -c "import setuptools; from Cython.Build import cythonize; import os; os.system('python setup.py build_ext --inplace')"
```

## Clean up

To clean up:

```bash
uv run python setup.py clean --all
rm -rf build/
rm -rf dist/
rm -rf *.egg-info/
rm -rf src/**/*.c
rm -rf src/**/*.so
rm -rf src/**/*.pyd
find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
find . -type f -name "*.pyc" -delete 2>/dev/null || true
```
