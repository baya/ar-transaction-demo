class Number < ActiveRecord::Base

  pg_db = YAML.load_file("#{Rails.root}/config/database.yml")['development_pg']
  mysql_db = YAML.load_file("#{Rails.root}/config/database.yml")['development_mysql']
  # self.establish_connection(pg_db)
  self.establish_connection(mysql_db)

  # validates :i, uniqueness: true
  
end
