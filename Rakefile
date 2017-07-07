<<<<<<< HEAD
require 'bundler/setup'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'foodcritic'
=======
#!/usr/bin/env rake
>>>>>>> chef-cookbooks/master

require_relative 'tasks/maintainers'

# Style tests. cookstyle (rubocop) and Foodcritic
namespace :style do
  begin
    require 'cookstyle'
    require 'rubocop/rake_task'

    desc 'Run Ruby style checks'
    RuboCop::RakeTask.new(:ruby)
  rescue LoadError => e
    puts ">>> Gem load error: #{e}, omitting style:ruby" unless ENV['CI']
  end

<<<<<<< HEAD
  desc 'Run Chef style checks'
  FoodCritic::Rake::LintTask.new(:chef) do |t|
    t.options = { search_gems: true,
                  fail_tags: ['any'],
                  chef_version: '12.4.1',
                  tags: ['~FC005']
                }
=======
  begin
    require 'foodcritic'

    desc 'Run Chef style checks'
    FoodCritic::Rake::LintTask.new(:chef) do |t|
      t.options = {
        fail_tags: ['any'],
        progress: true
      }
    end
  rescue LoadError
    puts ">>> Gem load error: #{e}, omitting style:chef" unless ENV['CI']
>>>>>>> chef-cookbooks/master
  end
end

desc 'Run all style checks'
task style: ['style:chef', 'style:ruby']

# ChefSpec
begin
  require 'rspec/core/rake_task'

  desc 'Run ChefSpec examples'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError => e
  puts ">>> Gem load error: #{e}, omitting spec" unless ENV['CI']
end

# Integration tests. Kitchen.ci
namespace :integration do
<<<<<<< HEAD
  desc 'Run Test Kitchen with Vagrant'
  task :vagrant do
    require 'kitchen'
    Kitchen.logger = Kitchen.default_file_logger
    Kitchen::Config.new.instances.each do |instance|
      instance.test(:always)
    end
  end
=======
  begin
    require 'kitchen/rake_tasks'
>>>>>>> chef-cookbooks/master

    desc 'Run kitchen integration tests'
    Kitchen::RakeTasks.new
  rescue StandardError => e
    puts ">>> Kitchen error: #{e}, omitting #{task.name}" unless ENV['CI']
  end
  task :ec2 do
    require 'kitchen'
    Kitchen.logger = Kitchen.default_file_logger
    @loader = Kitchen::Loader::YAML.new(project_config: './.kitchen.ec2.yml')
    config = Kitchen::Config.new(loader: @loader)
    threads = []
    config.instances.each do |instance|
      threads << Thread.new do
        instance.test(:always)
      end
    end
    threads.map(&:join)
  end
end

<<<<<<< HEAD
desc 'Run all tests on CI Platform'
task ci: ['style', 'spec'] # 'integration:cloud'
=======
namespace :supermarket do
  begin
    require 'stove/rake_task'

    desc 'Publish cookbook to Supermarket with Stove'
    Stove::RakeTask.new
  rescue LoadError => e
    puts ">>> Gem load error: #{e}, omitting #{task.name}" unless ENV['CI']
  end
end
>>>>>>> chef-cookbooks/master

task ec2: ['style', 'spec', 'integration:ec2']
# Default
<<<<<<< HEAD
task default: ['style', 'spec', 'integration:vagrant']

task test: ['style', 'spec']
=======
task default: %w(style spec)
>>>>>>> chef-cookbooks/master
