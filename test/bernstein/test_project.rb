require 'test_helper'
require 'bernstein/project'

class TestBernsteinProject < Minitest::Test
	def setup
		@project = Bernstein::Project.new
	end

	def test_works
		refute_nil( @project )
	end
end
