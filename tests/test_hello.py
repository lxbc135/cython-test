"""Tests for the Hello extension."""

from hello import hello


class TestHello:

    def test_hello_world(self):
        """Test greeting for 'World'."""
        assert hello("World") == "Hello, World!"

    def test_hello_name(self):
        """Test greeting for a specific name."""
        assert hello("Alice") == "Hello, Alice!"

    def test_hello_empty_string(self):
        """Test greeting with an empty name."""
        assert hello("") == "Hello, !"

