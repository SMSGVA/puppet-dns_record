Puppet::Type.newtype(:dns_record) do
  ensurable

  newparam(:name, :namevar => true) do
  end

  newparam(:mname) do
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
    defaultto 'IN'
  end

  newparam(:ttl) do
    munge do |value|
      Integer(value)
    end
    defaultto 86400
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

  newparam(:type) do
    defaultto :A
  end

  newparam(:priority) do
    defaultto 10
  end

  newparam(:weight) do
    defaultto 0
  end

  newparam(:srv_port) do
  end

end
