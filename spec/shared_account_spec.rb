shared_examples_for "an account" do
  describe '#deposit' do
    it 'makes a deposit from the account' do
      account.deposit 50
      expect(account.balance).to eq 50
    end
  end

  describe '#withdraw' do
    it 'makes a withdrawal from the account' do
      account.deposit 50
      account.withdraw 30
      expect(account.balance).to eq 20
    end
  end
end

