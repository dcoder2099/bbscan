# -*- encoding: utf-8 -*-
require File.expand_path('../lib/bbscan/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "bbscan"
  gem.version       = BBScan::VERSION
  gem.authors       = ["Daniel Hedrick"]
  gem.email         = ["dcoder2099 at gmail.com"]
  gem.homepage      = ""
  gem.summary       = %q{Know your BitBuddy.com friends}
  gem.description   = %q{BBScan is a command-line tool that will scan your mailbox and print a list of your new BitBuddy.com friends.}

  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.require_paths = ["lib"]

  gem.add_dependency 'bundler'
  gem.add_dependency 'contextio', '~> 1.3.0'
  gem.add_dependency 'dotenv', '~> 0.6.0'
  gem.add_development_dependency 'rspec', '~> 2.13.0'
end
