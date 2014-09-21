require_relative '../account'
require_relative './shared_account_spec'

describe Account do
  it_behaves_like "an account" do
    let(:account) { Account.new }
  end
end
