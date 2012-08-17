#!/usr/bin/env rake

task :default => :spec

require 'bundler/gem_tasks'
require 'rake/extensiontask'

Rake::ExtensionTask.new('autopluck')

task :spec => :compile do
  system("rspec spec")
end

