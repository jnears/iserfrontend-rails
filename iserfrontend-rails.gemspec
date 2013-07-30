# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'iserfrontend/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "iserfrontend-rails"
  spec.version       = Iserfrontend::Rails::VERSION
  spec.authors       = ["Paul Groves"]
  spec.email         = ["pmgroves@essex.ac.uk"]
  spec.description   = %q{Frontend code for ISER websites}
  spec.summary       = %q{CSS and JS}
  spec.homepage      = "https://github.com/paulgroves/iserfrontend-rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.require_path  = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency "railties", "~> 4.0"
end
