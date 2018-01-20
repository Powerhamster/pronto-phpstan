# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pronto/phpstan/version'

Gem::Specification.new do |spec|
  spec.name = 'pronto-phpstan'
  spec.version = Pronto::PhpStanVersion::VERSION
  spec.authors = ['Thomas Rothe']
  spec.email = ['th.rothe@gmail.com']

  spec.summary = 'Pronto runner for PHPStan'
  spec.homepage = 'https://github.com/Powerhamster/pronto-phpstan'
  spec.license = 'MIT'

  spec.files = Dir.glob('lib/**/*.rb') + ['pronto-phpstan.gemspec', 'LICENSE', 'README.md']
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'pronto', '>= 0.8.0'
  spec.add_runtime_dependency 'nokogiri', '~> 1.8.0'
  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.5'
end
