root = "/var/www/datarift.nl/todo/current"
working_directory_root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn_err.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.todo.sock"
worker_processes 2
timeout 30
