listen "127.0.0.1:3000"
timeout 60
worker_processes 2 # this should be >= nr_cpus
RAILS_ROOT = File.expand_path('../../',  __FILE__)
pid RAILS_ROOT+"/tmp/pids/unicorn.pid"
stdout_path RAILS_ROOT+"/log/unicorn.stdout.log"
stderr_path RAILS_ROOT+"/log/unicorn.stderr.log"
