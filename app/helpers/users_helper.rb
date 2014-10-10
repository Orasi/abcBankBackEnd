module UsersHelper

  def transaction_number(id)
    (number_of_transactions < id) ? id - number_of_transactions : id
  end

  def number_of_transactions
    @user.transactions.last.id - (@user.transactions.first.id - 1)
  end
end
