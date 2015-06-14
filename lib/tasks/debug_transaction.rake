namespace :debug_transaction do
  task ar_base: ['environment'] do
    
    david = Account.find_by(name: 'david')
    mary = Account.find_by(name: 'mary')

    puts "before: david:#{david.money}, mary:#{mary.money}"
    
    ActiveRecord::Base.transaction do
      david.withdrawal(100)
      mary.deposit(100)
    end

    puts "after: david:#{david.money}, mary:#{mary.money}"
    
  end
end
