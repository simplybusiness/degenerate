# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'degenerate'
set :repo_url, ENV['USER']+'@192.168.30.1:'+__dir__+'/..'

set :ssh_options, {
 forward_agent: true,
 user:          'sbopr',
 auth_methods:  %w(publickey)
}
set :deploy_to, '/home/sbopr/' + fetch(:application)
set :unicorn_config_path, fetch(:deploy_to) + '/current/config/unicorn.rb'

# 12 factor app guidelines say that all deployments should be as similar
# as possible.  Instead of introducing a rails env per deployment
# (production, staging, load testing, integration, spikes, partner qa ...)
# we set RAILS_ENV to production everywhere and use feature flags or
# configuration settings to vary the things that need varying

set :rails_env, "production"

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :branch, `git rev-parse --abbrev-ref HEAD`.chomp

after 'deploy:publishing', 'deploy:restart'

# there will probably already be a "deploy" namespace.  add this task to
# whatever else is there already
namespace :deploy do
  task :restart do
    invoke 'unicorn:reload'
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
