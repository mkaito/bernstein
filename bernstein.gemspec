# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bernstein/version'

Gem::Specification.new do |spec|
  spec.name          = "bernstein"
  spec.version       = Bernstein::VERSION
  spec.authors       = ["Michishige Kaito"]
  spec.email         = ["me@mkaito.com"]
  spec.summary       = %q{Bernstein, German for "amber", is a no-bullshit tool for project management and time tracking.}
  #spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = "http://mkaito.github.io/bernstein"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

	spec.add_dependency "trollop", "~> 2.0"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "minitest", "~> 5.2"
  spec.add_development_dependency "guard", "~> 2.5"
  spec.add_development_dependency "guard-minitest", "~> 2.2"
  spec.add_development_dependency "rake"
end
