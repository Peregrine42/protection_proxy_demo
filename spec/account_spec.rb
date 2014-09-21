require_relative '../account'

describe Account, '#deposit' do

  it 'makes a deposit from the account' do
    account = Account.new
    account.deposit 50
    expect(account.balance).to eq 50
  end

end

describe Account, '#withdraw' do

  it 'makes a withdraw from the account' do
    account = Account.new
    account.deposit 50
    account.withdraw 30
    expect(account.balance).to eq 20
  end

end
