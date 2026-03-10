"""Setup configuration for Hello Cython extension."""

from setuptools import setup, Extension

use_cython = False
try:
    from Cython.Build import cythonize  # type: ignore
    use_cython = True
except ImportError:
    pass

# Prefer Cython when available, fallback to the generated C source.
source_suffix = ".pyx" if use_cython else ".c"
ext_modules = [
    Extension(
        "hello._hello",
        sources=[f"src/hello/_hello{source_suffix}"],
        language="c",
    )
]

if use_cython:
    ext_modules = cythonize(ext_modules, language_level=3) # type: ignore

setup(
    ext_modules=ext_modules, # type: ignore
    package_dir={"": "src"},
    packages=["hello"],
)
