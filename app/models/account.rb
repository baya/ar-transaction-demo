class Account < ActiveRecord::Base

  def withdrawal(money_num)
    decrement!(:money, money_num)
    raise 'withdrawal fail'
  end

  def deposit(money_num)
    increment!(:money, money_num)
    # raise 'deposit fail'
  end
  
end
