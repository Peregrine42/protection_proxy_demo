require_relative '../proxy'
require_relative '../account'

describe Proxy do

  context 'user is ok' do

    let!(:auth)    { double(:auth, authenticate: true) }
    let!(:account) { Proxy.new(Account.new, auth)      }

    it 'delegates account operations to its subject' do
      account.deposit 50
      account.withdraw 10
      expect(account.balance).to eq 40
    end

  end

  context "it's a trap!" do

    let!(:auth)    { double(:auth, authenticate: false) }
    let!(:account) { Proxy.new(Account.new, auth)       }

    it 'raises an error' do
      expect { account.withdraw 10_000 }.to raise_error ProtectionException, 'unauthorised'
    end
  end
end
