server "server01.datarift.nl", :web, :app, :db, primary: true

set :application, "todo"
set :domain, "datarift.nl"
set :user, "deploy"
set :deploy_to, "/var/www/#{domain}/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, :git
set :repository,  "git@github.com:eboskma/#{application}.git"
set :branch, "master"

namespace :deploy do
	%w[start stop restart].each do |cmd|
		desc "#{command} unicorn server"
		task command, roles: :app, except: {no_release: true} do
			run "/etc/init.d/unicorn_#{application} #{command}"
		end
	end

	task :setup_config, roles: :app do
		sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
		sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
		run "mkdir -p #{shared_path}/config"
		putsh File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
		puts "Now edit the config files in #{shared_path}."
	end
	after "deploy:setup", "deploy:setup_config"

	task :symlink_config, roles: :app do
		run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
	end
	after "deploy:finalize_update", "deploy:symlink_config"

	desc "Make sure local git is in sync with remote."
	task :check_revision, roles: :web do
		unless `git rev-parse HEAD` == `git rev-parse origin/master`
			puts "!! WARNING !!"
			puts "HEAD is not the same as origin/master"
			puts "Run `git push` to sync changes."
			exit
		end
	end

	before "deploy", "deploy:check_revision"
end

