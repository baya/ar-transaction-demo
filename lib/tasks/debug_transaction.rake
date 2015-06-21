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

  task single_transaction_01: ['environment'] do
    account = Account.find_by_name('david')
    balance = Balance.find(1)

    puts "before balance.amount: #{balance.amount}"
    puts "before account.money: #{account.money}"

    Account.transaction do
      balance.amount = 200
      balance.save!
      account.money = 300
      account.save!
      raise 'debug transaction 01'
    end

  end


  task single_transaction_02: ['environment'] do
    account = Account.find_by_name('david')
    balance = Balance.find(1)

    puts "before balance.amount: #{balance.amount}"
    puts "before account.money: #{account.money}"

    balance.transaction do
      balance.amount = 200
      balance.save!
      account.money = 300
      account.save!
      raise 'debug transaction 01'
    end

  end


  task single_transaction_03: ['environment'] do
    account = Account.find_by_name('david')
    balance = Balance.find(1)

    puts "before balance.amount: #{balance.amount}"
    puts "before account.money: #{account.money}"

    ActiveRecord::Base.transaction do
      balance.amount = 200
      balance.save!
      account.money = 300
      account.save!
      raise 'debug transaction 01'
    end

  end

  
end
