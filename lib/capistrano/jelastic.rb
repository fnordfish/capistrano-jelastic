# frozen_string_literal: true
# Loading normal stuff
require "capistrano/rvm"
require "capistrano/bundler"
require "capistrano/rails/assets"
require "capistrano/rails/migrations"

load File.expand_path("../tasks/jelastic.rake", __FILE__)
