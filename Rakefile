require "bundler/setup"
require "rake/extensiontask"
require "rspec/core/rake_task"
require "woof_util/gem_rake_tasks"

Rake::ExtensionTask.new("subdomainz")
WoofUtil::GemRakeTasks.create_tasks

RSpec::Core::RakeTask.new "spec"
task :build do
  Dir.chdir('ext') do
    output = `ruby extconf.rb`
    raise output unless $? == 0
    output = `make`
    raise output unless $? == 0
  end
end
