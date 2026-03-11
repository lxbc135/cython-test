"""
Hello extension - Hello world example using Cython.
"""

__version__ = "0.1.0"

try:
    from ._hello import hello
except ImportError:
    import warnings
    warnings.warn("Cython extension not found, using pure Python fallback")

    def hello(name):
        """Pure Python fallback for hello."""
        return f"Hello, {name}!"

__all__ = ["hello"]
