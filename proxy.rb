class Proxy

  def initialize subject
    @subject = subject
  end

  def deposit amount
    @subject.deposit amount
  end

  def withdraw amount
    @subject.withdraw amount
  end

  def balance
    @subject.balance
  end

end
