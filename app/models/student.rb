class Student < ActiveRecord::Base
  establish_connection YAML.load_file("#{Rails.root}/config/database.yml")['development1']
  
  has_many :student_courses
  has_many :courses, through: 'student_courses'
end
