# frozen_string_literal: true
namespace :load do
  task :defaults do
    set :deploy_to, "/var/www/webroot"

    # Default value for linked_dirs is []
    set :linked_dirs, fetch(:linked_dirs, []) | [
      "log",
      "tmp/pids",
      "tmp/cache",
      "tmp/sockets",
      "vendor/bundle",
      "public/system"
    ]

    set :jelastic_seeding_enabled, false
    set :jelastic_tmp_restart, false
  end
end

namespace :deploy do
  desc "Creating symlink to update assets"
  task :symlink do
    on roles(:app) do
      execute :ln, "-sf #{fetch(:deploy_to)}/current #{deploy_path}/ROOT"
    end
  end

  desc "Reload the database with seed data"
  task seed: [:set_rails_env] do
    if fetch(:seeding_enabled)
      on primary fetch(:migration_role) do
        within release_path do
          with rails_env: fetch(:rails_env) do
            execute :rake, "db:seed"
          end
        end
      end
    end
  end

  desc "Restart Application using tmp/restart.txt"
  task :restart do
    if fetch(:jelastic_tmp_restart)
      on roles(:web), in: :groups, limit: 3, wait: 10 do
        within release_path do
          execute :touch, "tmp/restart.txt"
        end
      end
    end
  end

  after :migrate, :seed
  before :restart, :symlink
  after :publishing, :restart
end
