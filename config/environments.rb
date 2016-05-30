puts "!!!!!!!!!!!!!  RUNNING ENVIRONMENTS FILE !!!!!!!!!!!!!"

configure :production, :development do
  enable :sessions

  db = URI.parse('mysql2://root:password@localhost/talle_db' || "mysql2://#{ENV['DB_USERNAME']}:#{ENV['DB_PASSWORD']}@#{ENV['DB_HOSTNAME']}/talle_db")
  pool = ENV['DB_POOL'] || ENV['MAX_THREADS'] || 5
  ActiveRecord::Base.establish_connection(
        adapter:   db.scheme,
        host:      db.host,
        username:  db.user,
        password:  db.password,
        database:  db.path[1..-1],
        encoding:  'utf8',
        pool:      pool
  )
end