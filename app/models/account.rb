class Account < ActiveRecord::Base

  after_save :create_op_log_for_save
  after_destroy :create_op_log_for_destroy

  def withdrawal(money_num)
    decrement!(:money, money_num)
    raise 'withdrawal fail'
  end

  def deposit(money_num)
    increment!(:money, money_num)
    # raise 'deposit fail'
  end

  private
  
  def create_op_log_for_save
    AccountOpLog.create(action: 'save', account_id: self.id)
    # raise 'boom!'
  end

  def create_op_log_for_destroy
    AccountOpLog.create(action: 'destroy', account_id: self.id)
    raise 'boom!'
  end
  
end
