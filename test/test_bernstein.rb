require 'test_helper'
require 'bernstein'

class TestBernstein < Minitest::Test
	def test_hello_says_hello
		assert_equal("hello!", Bernstein.hello)
	end

	def test_hello_returns_string
		assert_kind_of(String, Bernstein.hello)
	end

	def test_hello_takes_no_arguments
		assert_raises(ArgumentError) { Bernstein.hello(1) }
	end
end
