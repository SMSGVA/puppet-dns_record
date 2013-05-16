Puppet::Type.type(:dns_record).provide(:nsupdate) do
  require 'pp'

  commands  :nsupdate => 'nsupdate',
            :dig      => 'dig'

  def create
    if ! resource[:mname]
      resource[:mname] = resource[:name]
    end
    tmp_file = "/tmp/nsupdate_create_#{resource[:mname]}"
    cmd = [
      command(:nsupdate)
    ]
    createstring = []
    if resource[:key] and resource[:secret]
      createstring.push("key #{resource[:key]} #{resource[:secret]}")
    end

    if resource[:server]
      createstring.push("server #{resource[:server]}")
    end
    if resource[:zone]
      createstring.push("zone #{resource[:zone]}")
    end
    if resource[:type] == 'MX'
      createstring.push("update add #{resource[:mname]} #{resource[:ttl]} #{resource[:class]} #{resource[:type]} #{resource[:priority]} #{resource[:address]}")
    elsif resource[:type] == 'SRV'
      createstring.push("update add #{resource[:mname]} #{resource[:ttl]} #{resource[:class]} #{resource[:type]} #{resource[:priority]} #{resource[:weight]} #{resource[:srv_port]} #{resource[:address]}")
    else
      createstring.push("update add #{resource[:mname]} #{resource[:ttl]} #{resource[:class]} #{resource[:type]} #{resource[:address]}")
    end
    createstring.push("send")
    createstring.push('')
    File.open(tmp_file, 'w') {|f| f.write( createstring.join("\n") ) }
    cmd.push(tmp_file)

    Puppet::Util::Execution.execute(
      cmd,
      :failonfail => true,
      :combine => true
    )
#    File.delete(tmp_file)
  end

  def destroy
    if ! resource[:mname]
      resource[:mname] = resource[:name]
    end
    tmp_file = "/tmp/nsupdate_destroy_#{resource[:mname]}"
    cmd = [
      command(:nsupdate)
    ]
    destroystring = []
    if resource[:keyfile]
      cmd.push("-k #{resource[:keyfile]}")
    end
    if resource[:key] and resource[:secret]
      destroystring.push("key #{resource[:key]} #{resource[:secret]}")
    end

    if resource[:server]
      destroystring.push("server #{resource[:server]}")
    end
    if resource[:zone]
      destroystring.push("zone #{resource[:zone]}")
    end
    destroystring.push("update delete #{resource[:mname]} #{resource[:type]}")
    destroystring.push("send")
    destroystring.push('')
    File.open(tmp_file, 'w') {|f| f.write( destroystring.join("\n") ) }
    cmd.push(tmp_file)
    Puppet::Util::Execution.execute(
      cmd,
      :failonfail => true,
      :combine => true
    )
#    File.delete(tmp_file)
  end

  def exists?
    if ! resource[:mname]
      resource[:mname] = resource[:name]
    end
    options = []
    if resource[:server]
      options.push("@#{resource[:server]}")
    end
    options.push("-t #{resource[:type]}")
    if options
      output = dig('+short', options.join(' '), resource[:mname]).chomp
    else
      output = dig('+short', resource[:mname]).chomp
    end

    if output == resource[:address]
      true
    else
      false
    end
  end

end
