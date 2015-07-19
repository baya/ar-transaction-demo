# -*- coding: utf-8 -*-
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

  task distribute_01: ['environment'] do
    student = Student.find_by_name('Jim')
    course = Course.find_by_name('数学课')

    puts "before student.units: #{student.units}"
    puts "before StudentCourse.all.to_a: #{StudentCourse.all.to_a}"

    Student.transaction do
      course.enroll(student)
      student.units += course.units
      student.save

      raise 'debug distribute 01 transactions'
    end
    
  end

  task distribute_02: ['environment'] do
    student = Student.find_by_name('Jim')
    course = Course.find_by_name('数学课')

    puts "before student.units: #{student.units}"
    puts "before StudentCourse.all.to_a: #{StudentCourse.all.to_a}"

    Student.transaction do
      StudentCourse.transaction do
        course.enroll(student)
        student.units += course.units
        student.save

        raise 'debug distribute 02 transactions'
      end
    end
    
  end

  task for_save: ['environment'] do
    # Account.create(name: 'kyk01')
    Account.create(name: 'kyk02')
  end

  task for_destroy: ['environment'] do
    account = Account.find_by(name: 'kyk03')
    account ||= Account.create(name: 'kyk03')

    account.destroy
  end

  task for_rollback_exception: ['environment'] do
    begin
      Number.transaction do
        Number.create(i: 0)
        Number.create(i: 1)
        # raise ActiveRecord::Rollback
        raise 'boom!'
      end
    rescue Exception => e
      puts e.message
    end

  end

  task for_create: ['environment'] do

    Number.transaction do
      Number.create(i: 0)
      Number.create(i: 0)
    end
    
  end

  task for_pg: ['environment'] do
    # Suppose that we have a Number model with a unique column called 'i'.
    Number.transaction do
      Number.create(i: 6)
      begin
        # This will raise a unique constraint error...
        Number.create!(i: 6)
      rescue ActiveRecord::StatementInvalid => e
        puts "+++++++++++++++"
        puts e.message
      end

      # On PostgreSQL, the transaction is now unusable. The following
      # statement will cause a PostgreSQL error, even though the unique
      # constraint is no longer violated:
      Number.create(i: 7)
      # => "PGError: ERROR:  current transaction is aborted, commands
      #     ignored until end of transaction block"
    end
  end


  task for_pg_2: ['environment'] do
    # Suppose that we have a Number model with a unique column called 'i'.
    Number.transaction do
      Number.create(i: 6)
      begin
        # This will raise a unique constraint error...
        Number.create!(i: 6)
      rescue Exception => e
        puts "+++++++++++++++"
        puts e.message
      end

      # On PostgreSQL, the transaction is now unusable. The following
      # statement will cause a PostgreSQL error, even though the unique
      # constraint is no longer violated:
      Number.create(i: 7)
      # => "PGError: ERROR:  current transaction is aborted, commands
      #     ignored until end of transaction block"
    end
  end

  task for_nested_1: ['environment'] do
    User.transaction do
      User.create(name: 'Kotori')
      User.transaction do
        User.create(name: 'Nemu')
        raise ActiveRecord::Rollback
      end
    end
  end


  task for_nested_2: ['environment'] do
    User.transaction do
      User.create(name: 'Kotori2')
      User.transaction do
        User.create(name: 'Nemu2')
        raise 'boom!'
      end
    end
  end

  task for_nested_3: ['environment'] do
    User.transaction do
      User.create(name: 'Kotori3')
      User.transaction(requires_new: true) do
        User.create(name: 'Nemu3')
        raise ActiveRecord::Rollback
      end
    end
  end

  task for_nested_4: ['environment'] do
    User.transaction do
      User.create(name: 'Kotori4')
      begin
        User.transaction do
          User.create(name: 'Nemu4')
          raise 'boom!'
        end
      rescue Exception => e
        puts "!!!!!!!!!!!!!"
        puts e.message
      end
    end
  end


  task for_nested_5: ['environment'] do
    User.transaction do
      User.create(name: 'Kotori5')
      begin
        User.transaction(requires_new: true) do
          User.create(name: 'Nemu5')
          raise 'boom!'
        end
      rescue Exception => e
        puts "!!!!!!!!!!!!!"
        puts e.message
      end
    end
  end

end
