# Object wrapping a reference to a remote drb object.
#
# Method calls on this object are relayed to the remote
# object that this object is a stub for.
class DRbObject

  #...

  # Routes respond_to? to the referenced remote object.
  def respond_to?(msg_id, priv=false)
    case msg_id
    when :_dump
      true
    when :marshal_dump
      false
    else
      method_missing(:respond_to?, msg_id, priv)
    end
  end

  # Routes method calls to the referenced remote object.
  def method_missing(msg_id, *a, &b)
    if DRb.here?(@uri)
      obj = DRb.to_obj(@ref)
      DRb.current_server.check_insecure_method(obj, msg_id)
      return obj.__send__(msg_id, *a, &b)
    end

    succ, result = self.class.with_friend(@uri) do
      DRbConn.open(@uri) do |conn|
        conn.send_message(self, msg_id, a, b)
      end
    end

    if succ
      return result
    elsif DRbUnknown === result
      raise result
    else
      bt = self.class.prepare_backtrace(@uri, result)
      result.set_backtrace(bt + caller)
      raise result
    end
  end

  #...

end
