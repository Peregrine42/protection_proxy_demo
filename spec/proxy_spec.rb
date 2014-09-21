require_relative '../proxy'
require_relative '../account'

describe Proxy do

  it 'delegates account operations to its subject' do
    account = Proxy.new(Account.new)
    account.deposit 50
    account.withdraw 10
    expect(account.balance).to eq 40
  end

end
