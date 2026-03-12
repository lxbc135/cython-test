"""Tests for the Hello extension."""

from hello import hello


class TestHello:

    def test_hello_world(self):
        """Test greeting for 'World'."""
        assert hello("World") == "Hello, World!"
