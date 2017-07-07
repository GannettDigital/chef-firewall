require 'bundler/setup'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'foodcritic'

# Style tests. Rubocop and Foodcritic
namespace :style do
  desc 'Run Ruby style checks'
  RuboCop::RakeTask.new(:ruby)

  desc 'Run Chef style checks'
  FoodCritic::Rake::LintTask.new(:chef) do |t|
    t.options = { search_gems: true,
                  fail_tags: ['any'],
                  chef_version: '12.4.1',
                  tags: ['~FC005']
                }
  end
end

desc 'Run all style checks'
task style: ['style:chef', 'style:ruby']

# Rspec and ChefSpec
desc 'Run ChefSpec unit tests'
RSpec::Core::RakeTask.new(:spec) do |t, _args|
  t.rspec_opts = 'test/unit'
end

# Integration tests. Kitchen.ci
namespace :integration do
  desc 'Run Test Kitchen with Vagrant'
  task :vagrant do
    require 'kitchen'
    Kitchen.logger = Kitchen.default_file_logger
    Kitchen::Config.new.instances.each do |instance|
      instance.test(:always)
    end
  end

  desc 'Run Test Kitchen with cloud plugins'
  task :cloud do
    if ENV['CI_DOES_NOT_WORK'] == 'true'
      Kitchen.logger = Kitchen.default_file_logger
      @loader = Kitchen::Loader::YAML.new(local_config: '.kitchen.cloud.yml')
      config = Kitchen::Config.new(loader: @loader)
      concurrency = config.instances.size
      queue = Queue.new
      config.instances.each { |i| queue << i }
      concurrency.times { queue << nil }
      threads = []
      concurrency.times do
        threads << Thread.new do
          while instance = queue.pop
            instance.test(:always)
          end
        end
      end
      threads.map(&:join)
    end
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

desc 'Run all tests on CI Platform'
task ci: ['style', 'spec'] # 'integration:cloud'

task ec2: ['style', 'spec', 'integration:ec2']
# Default
task default: ['style', 'spec', 'integration:vagrant']

task test: ['style', 'spec']
