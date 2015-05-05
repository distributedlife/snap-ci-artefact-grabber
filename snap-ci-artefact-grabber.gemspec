# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |spec|
  spec.name          = "snap-ci-artefact-grabber"
  spec.version       = SnapCI::VERSION
  spec.authors       = ["Ryan Boucher"]
  spec.email         = ["ryan.boucher@distributedlife.com"]

  spec.summary       = %q{Helps you get artefacts off Snap-CI.}
  spec.homepage      = "https://github.com/distributedlife/snap-ci-artefact-grabber"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "stub_env", "~> 1.0.2"
  spec.add_development_dependency "fakeweb", "~> 1.3"
end