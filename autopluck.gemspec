# -*- encoding: utf-8 -*-
require File.expand_path('../lib/autopluck/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Rob Hanlon"]
  gem.email         = ["rob@mediapiston.com"]
  gem.description   = "Converts your maps to plucks when appropriate."
  gem.summary       = "Converts your maps to plucks when appropriate."
  gem.homepage      = "http://github.com/ohwillie/autopluck"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "autopluck"
  gem.require_paths = ["lib"]
  gem.version       = Autopluck::VERSION

  gem.add_dependency 'rbx-require-relative'

  gem.add_development_dependency 'rspec', '2.10.0'
  gem.add_development_dependency 'activerecord', '3.2.6'
  gem.add_development_dependency 'sqlite3', '1.3.6'

  gem.add_development_dependency 'rake-compiler'
end
