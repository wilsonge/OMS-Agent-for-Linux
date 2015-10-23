#!/usr/local/ruby-2.2.0/bin rake

require 'rake/testtask'
require 'rake/clean'

task :test => [:base_test]

desc 'Run test_unit based test'
Rake::TestTask.new(:base_test) do |t|
  plugin_test_files = Dir["#{ENV['PLUGINS_TEST_DIR']}/*test*.rb"].sort
  script_test_files = Dir["#{ENV['BASE_DIR']}/test/installer/scripts/*test*.rb"].sort
  t.test_files = plugin_test_files + script_test_files
  t.verbose = true
  t.warning = true
end

desc 'Run test with simplecov'
task :coverage do |t|
  ENV['SIMPLE_COV'] = '1'
  Rake::Task["test"].invoke
end

task :default => [:test, :build]