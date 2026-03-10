# Cython Example

A Python extension in Cython example.

## Requirements

* Python 3.8+
* Cython 0.29+
* setuptools 65+

## Quick Start

### Create virtual environment

```bash
uv venv --python 3.14
```

That will create virtual environment `.venv` directory with Python 3.14.

### To activate virtual environment (on Linux)

```bash
source .venv/bin/activate
```

### To activate virtual environment (on Windows Bash)

```bash
source .venv/Scripts/activate
```

### To install build dependencies

```bash
uv sync --group dev
```

### To build for development

```bash
uv run python setup.py build_ext --inplace
```

The `--inplace` option creates the built `.pyd`/`.so` extension file directly alongside the source `.pyx` file in the source tree, instead of putting it under build. That allows Python to find it, and lets you use the package without installing it.

### To try the package

```bash
uv run python -c 'from hello import hello; print(hello("world"))'
```

It should output `Hello, world!`.

### setup.py build_ext without --inplace

If you run `setup.py build_ext` without `--inplace` option, then you would need to install the package before using it, as shown below.

### To install current package in editable (development) mode

```bash
uv pip install -e .
```

### To uninstall current package in edit mode

```bash
uv pip uninstall cython-test
```

**Expected Output:**

```txt
Hello, world!
```

### Example

```python
from hello import hello

print(hello('world'))
```

## Release Build

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

## To build wheel for another python version

You can build for another Python version while current virtual environment is active by using `uv run --python <version>`.

For example, to build for Python 3.12:

```bash
uv run --python 3.12 python -m build --wheel --no-isolation
```

It will create `.whl` for Python 3.12 in `dist` directory.

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
