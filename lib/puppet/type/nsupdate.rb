Puppet::Type.newtype(:nsupdate) do
  ensurable

  newparam(:name, :namevar => true) do
  end

  newparam(:server) do
  end

  newparam(:local) do
  end

  newparam(:port) do
    munge do |value|
      Integer(value)
    end
  end

  newparam(:zone) do
  end

  newparam(:class) do
  end

  newparam(:ttl) do
    munge do |value|
      Integer(value)
    end
  end

  newparam(:key) do
  end

  newparam(:keyfile) do
  end

  newparam(:secret) do
  end

  newparam(:prenxdomain) do
  end

  newparam(:prenydomain) do
  end

  newparam(:prenxrrset) do
  end

  newparam(:preyxrrset) do
  end

  newparam(:address) do
  end

end
