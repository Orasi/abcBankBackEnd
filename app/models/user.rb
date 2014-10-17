class User < ActiveRecord::Base
  has_many :transactions
  has_many :transfers

  def total_balance(from_account, to_account, transfer_amount)
    total_from_account = self.amount_in(from_account) - transfer_amount.to_i
    total_to_account = self.amount_in(to_account) + transfer_amount.to_i
    self.update_attributes(from_account => total_from_account, to_account.to_sym => total_to_account)
  end

  def amount_in(account)
    self.send(account).to_i
  end

  def create_transaction(transfer_params, type)
    setup_transaction_with transfer_params, transfer_params[:amount], 'to_account', transfer_params[:to_account] == 'credit_balance' ? 'debit' : 'credit', type
    setup_transaction_with transfer_params, transfer_params[:amount].to_f * -1, 'from_account', 'debit', type
    self.total_balance(transfer_params[:from_account], transfer_params[:to_account], transfer_params[:amount])
  end

  def setup_transaction_with(transfer_params, amount, account, type, location)
    date = DateTime.now.to_date
    self.transactions.create!(
        amount: amount,
        date: date,
        location: location.capitalize,
        account: transfer_params[account.to_sym],
        prev_balance: self.amount_in(transfer_params[account.to_sym]),
        new_balance: self.calculate_balance(transfer_params[account.to_sym], transfer_params[:amount], type)
    )
  end

  def calculate_balance(account, amount, operator='credit')
    case operator
      when 'credit'
        self.amount_in(account) + amount.to_i
      else
        self.amount_in(account) - amount.to_i
    end
  end

  def self.create_user(username, password)
    u = User.create(username: username, password: password, checking_balance: 1923.18, savings_balance: 12654.83, credit_balance: 5195.78)

    u.transactions.create(account: 'saving', date: DateTime.now - 21.days, location: "Withdrawal", amount: -1000.00, prev_balance: 1511.15, new_balance: 511.15)
    u.transactions.create(account: 'saving', date: DateTime.now - 15.days, location: "Interest Accrued", amount: 98.68, prev_balance: 511.15, new_balance: 609.83)
    u.transactions.create(account: 'saving', date: DateTime.now - 9.days, location: "Deposit", amount: 45.00, prev_balance: 609.83, new_balance: 654.83)
    u.transactions.create(account: 'saving', date: DateTime.now - 8.days, location: "Deposit", amount: 2000.00, prev_balance: 654.83, new_balance: 2654.83)
    u.transactions.create(account: 'checking', date: DateTime.now - 7.days, location: "McDonalds", amount: -7.45, prev_balance: 1658.54, new_balance: 1651.09)
    u.transactions.create(account: 'checking', date: DateTime.now - 7.days,location: "Target", amount: -108.68, prev_balance: 1651.09, new_balance: 1542.41)
    u.transactions.create(account: 'checking', date: DateTime.now - 6.days,location: "FootLocker", amount: -87.02, prev_balance: 1542.41, new_balance: 1455.39)
    u.transactions.create(account: 'checking', date: DateTime.now - 5.days,location: "Direct Deposit", amount: 4500.00, prev_balance: 1455.39, new_balance: 5955.39)
    u.transactions.create(account: 'checking', date: DateTime.now - 5.days,location: "Ikea", amount: -584.45, prev_balance: 5955.39, new_balance: 5370.94)
    u.transactions.create(account: 'checking', date: DateTime.now - 5.days,location: "House Payment", amount: -975.12, prev_balance: 5370.94, new_balance: 4395.82)
    u.transactions.create(account: 'checking', date: DateTime.now - 4.days,location: "Check #1234", amount: 75.00, prev_balance: 4395.82, new_balance: 4465.82)
    u.transactions.create(account: 'credit', date: DateTime.now - 3.days, location: "Duke Energy", amount: 145.15, prev_balance: 3051.98, new_balance: 3197.13)
    u.transactions.create(account: 'credit', date: DateTime.now - 3.days, location: "Payment", amount: -30.00, prev_balance: 3197.13, new_balance: 3167.13)
    u.transactions.create(account: 'checking', date: DateTime.now - 3.days,location: "McDonalds", amount: -7.45, prev_balance: 4465.82, new_balance: 4458.37)
    u.transactions.create(account: 'credit', date: DateTime.now - 3.days, location: "ABC Store", amount: 74.13, prev_balance: 3167.13, new_balance: 3241.26)
    u.transactions.create(account: 'saving', date: DateTime.now - 2.days, location: "Deposit", amount: 10000.00, prev_balance: 2654.83, new_balance: 12654.83)
    u.transactions.create(account: 'credit', date: DateTime.now - 2.days, location: "Best Buy", amount: 1345.55, prev_balance: 3241.26, new_balance: 4586.81)
    u.transactions.create(account: 'credit', date: DateTime.now - 2.days, location: "WalMart", amount: 4.87, prev_balance: 4586.81, new_balance: 4591.68)
    u.transactions.create(account: 'credit', date: DateTime.now - 1.days, location: "ABC Store", amount: 5.72, prev_balance: 4591.68, new_balance: 4597.4)
    u.transactions.create(account: 'credit', date: DateTime.now - 1.days, location: "Apple Store", amount: 487.21, prev_balance: 4597.4, new_balance: 5084.61)
    u.transactions.create(account: 'credit', date: DateTime.now - 1.days, location: "Steakhouse", amount: 55.98, prev_balance: 5084.61, new_balance: 5140.59)
    u.transactions.create(account: 'credit', date: DateTime.now, location: "Gas Station", amount: 45.05, prev_balance: 5140.59, new_balance: 5185.64)
    u.transactions.create(account: 'credit', date: DateTime.now, location: "Target", amount: 10.14, prev_balance: 5185.64, new_balance: 5195.78)
    u.transactions.create(account: 'checking', date: DateTime.now - 0.days,location: "WalMart", amount: -35.19, prev_balance: 4458.37, new_balance: 4423.18)
    u.transactions.create(account: 'checking', date: DateTime.now - 0.days,location: "Harah's", amount: -2500.00, prev_balance: 4423.18, new_balance: 1923.18)
    return u
  end
end
