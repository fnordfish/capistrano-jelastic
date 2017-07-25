# coding: utf-8
# frozen_string_literal: true
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "capistrano/jelastic/version"

Gem::Specification.new do |spec|
  spec.name          = "capistrano-jelastic"
  spec.version       = Capistrano::Jelastic::VERSION
  spec.authors       = ["Gerardo Navarro Suarez"]
  spec.email         = ["gerardo.navarro@edeka.de"]

  spec.summary       = "Deploying rails apps on Jelastic server in an easy way."
  spec.description   = <<-DESC
Deploying ruby apps on Jelastic server in an easy way.
This gem is an integration for capistrano which incapsulates the capistrano deployment on Jelastic.
The deployment flow in this gem is inspired by the official jelastic documentation for capistrano,
see https://docs.jelastic.com/ssh-capistrano
DESC
  spec.homepage      = "https://github.com/gerardo-navarro/capistrano-jelastic"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.0"

  spec.add_dependency "capistrano", "~> 3.1"
  # Because rvm is used on jelastic to handle ruby versions
  spec.add_dependency "capistrano-rvm"
  spec.add_dependency "capistrano-bundler"
end
