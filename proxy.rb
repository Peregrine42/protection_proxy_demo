class Proxy

  def initialize subject, auth
    @subject = subject
    @auth    = auth
  end

  def authenticate!
    raise ProtectionException.new('unauthorised') unless @auth.authenticate
  end

  def deposit amount
    authenticate!
    @subject.deposit amount
  end

  def withdraw amount
    authenticate!
    @subject.withdraw amount
  end

  def balance
    authenticate!
    @subject.balance
  end

end

class ProtectionException < Exception
end
