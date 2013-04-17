# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack_prof/version'

Gem::Specification.new do |spec|
  spec.name          = "rack_prof"
  spec.version       = RackProf::VERSION
  spec.authors       = ["Kazuyuki Kohno"]
  spec.email         = ["jugyo.org@gmail.com"]
  spec.description   = %q{Rack middleware for profiling}
  spec.summary       = %q{Rack middleware for profiling}
  spec.homepage      = "https://githug.com/jugyo/rack_prof"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rack"
  spec.add_dependency "ruby-prof"
  spec.add_dependency "launchy"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
