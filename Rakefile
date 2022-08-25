require "sequel/core"
require 'logger'

DATABASE = 'sqlite://music_festivals.db'

namespace :db do
  desc "Run migrations"
  task :migrate, [:version] do |t, args|
    Sequel.extension :migration
    version = args[:version].to_i if args[:version]
    Sequel.connect(DATABASE, logger: Logger.new($stderr)) do |db|
      Sequel::Migrator.run(db, "db/migrations", target: version)
    end
  end

  task :migrate_status do
    Sequel.extension :migration
    Sequel::Migrator.is_current?(DATABASE, 'db/migrations')
  end
end
