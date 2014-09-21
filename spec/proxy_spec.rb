require_relative '../proxy'
require_relative '../account'
require_relative './shared_account_spec'

describe Proxy do

  context 'user is ok' do

    it_behaves_like "an account" do
      let(:auth)    { double(:auth, authenticate: true) }
      let(:account) { Proxy.new(Account.new, auth)      }
    end

  end

  context "it's a trap!" do

    let(:auth)    { double(:auth, authenticate: false) }
    let(:account) { Proxy.new(Account.new, auth)       }

    it 'raises an error' do
      expect { account.withdraw 10_000 }.to raise_error ProtectionException, 'unauthorised'
    end
  end
end
