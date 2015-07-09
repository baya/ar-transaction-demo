class StudentCourse < ActiveRecord::Base
  establish_connection YAML.load_file("#{Rails.root}/config/database.yml")['development2']

  belongs_to :student
  belongs_to :course
end
