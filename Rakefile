require "rspec/core/rake_task"
require_relative 'lib/secret_santa'

task default: %w[run]

task :run do
  SecretSanta.new.run
end

task :test do
  RSpec::Core::RakeTask.new(:spec)
  Rake::Task["spec"].execute
end
