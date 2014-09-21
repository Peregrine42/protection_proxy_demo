class Proxy

  def initialize subject, auth
    @subject = subject
    @auth    = auth
  end

  def authenticate!
    raise ProtectionException.new "unauthorised" unless @auth.authenticate
  end

  def respond_to? name
    #[:withdraw, :deposit].include? name || super
    @subject.respond_to? name || super
  end

  def method_missing name, *args
    super unless respond_to? name
    authenticate!
    @subject.send(name, *args)
  end

end

class ProtectionException < Exception
end
