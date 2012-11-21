Puppet::Type.type(:nsupdate).provide(:nsupdate) do
  require 'pp'

  commands  :nsupdate => 'nsupdate',
            :dig      => 'dig'

  def create

  end

  def destroy
    cmd = [
      command(:nsupdate)
    ]
    destroystring = [
      "update delete #{resource[:name]} #{resource[:address]}"
    ]
    Puppet::Util::Execution.execute(
      cmd,
      :stdinstring => destroystring.join('\n'),
      :failonfail => true,
      :combine => true
    )
  end

  def exists?
    output = dig('+short', resource[:name]).chomp

    if output == resource[:address]
      true
    else
      false
    end
  end

end
