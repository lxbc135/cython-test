# cython: language_level=3

"""
Cython implementation of hello world.
"""


def hello(str name) -> str:
    """
    Return a greeting for the given name.

    Args:
        name: The name to greet

    Returns:
        A greeting string
    """
    return f"Hello, {name}!"
