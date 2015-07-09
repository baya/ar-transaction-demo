class Course < ActiveRecord::Base
  establish_connection YAML.load_file("#{Rails.root}/config/database.yml")['development3']

  has_many :student_courses
  has_many :students, through: 'student_courses'

  def enroll(student)
    self.students << student
    save
  end
  
end
