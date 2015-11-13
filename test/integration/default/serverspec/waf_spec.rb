require 'spec_helper'

expected_rules = {
  'ssh22' => {
    'Rule Name:' => 'ssh22',
    'Enabled:' => 'Yes',
    'Direction:' => 'In',
    'LocalIP:' => 'Any',
    'RemoteIP:' => 'Any',
    'Protocol:' => 'TCP',
    'LocalPort:' => '22',
    'RemotePort:' => 'Any',
    'Action:' => 'Allow'
  },
  'ssh2222' => {
    'Rule Name:' => 'ssh2222',
    'Enabled:' => 'Yes',
    'Direction:' => 'In',
    'LocalIP:' => 'Any',
    'RemoteIP:' => 'Any',
    'Protocol:' => 'TCP',
    'LocalPort:' => '2200,2222',
    'RemotePort:' => 'Any',
    'Action:' => 'Allow'
  },
  'temp1' => {
    'Rule Name:' => 'temp1',
    'Enabled:' => 'Yes',
    'Direction:' => 'In',
    'LocalIP:' => 'Any',
    'RemoteIP:' => 'Any',
    'Protocol:' => 'TCP',
    'LocalPort:' => '1234',
    'RemotePort:' => 'Any',
    'Action:' => 'Block'
  },
  'temp2' => {
    'Rule Name:' => 'temp2',
    'Enabled:' => 'Yes',
    'Direction:' => 'In',
    'LocalIP:' => 'Any',
    'RemoteIP:' => 'Any',
    'Protocol:' => 'TCP',
    'LocalPort:' => '1235',
    'RemotePort:' => 'Any',
    'Action:' => 'Block'
  },
  'addremove2' => {
    'Rule Name:' => 'addremove2',
    'Enabled:' => 'Yes',
    'Direction:' => 'In',
    'LocalIP:' => 'Any',
    'RemoteIP:' => 'Any',
    'Protocol:' => 'TCP',
    'LocalPort:' => '1236',
    'RemotePort:' => 'Any',
    'Action:' => 'Block'
  },
  'block-192.168.99.99' => {
    'Rule Name:' => 'block-192.168.99.99',
    'Enabled:' => 'Yes',
    'Direction:' => 'In',
    'LocalIP:' => 'Any',
    'RemoteIP:' => '192.168.99.99/32',
    'Protocol:' => 'TCP',
    'LocalPort:' => 'Any',
    'RemotePort:' => 'Any',
    'Action:' => 'Block'
  },
  'prepend' => {
    'Rule Name:' => 'prepend',
    'Enabled:' => 'Yes',
    'Direction:' => 'In',
    'LocalIP:' => 'Any',
    'RemoteIP:' => 'Any',
    'Protocol:' => 'TCP',
    'LocalPort:' => '7788',
    'RemotePort:' => 'Any',
    'Action:' => 'Allow'
  },
  'allow world to winrm' => {
    'Rule Name:' => 'allow world to winrm',
    'Enabled:' => 'Yes',
    'Direction:' => 'In',
    'LocalIP:' => 'Any',
    'RemoteIP:' => 'Any',
    'Protocol:' => 'TCP',
    'LocalPort:' => '5989',
    'RemotePort:' => 'Any',
    'Action:' => 'Allow'
  }
}

describe service('Windows Firewall'), if: waf? do
  it 'enabled' do
    expect(subject).to be_enabled
  end
  it 'is running' do
    expect(subject).to be_running
  end
end

expected_rules.each do |rule, rule_values|
  describe command("netsh advfirewall firewall show rule name='#{rule}'"), if: waf? do
    rule_values.each do |name, value|
      its(:stdout) { should match(/^#{name}\s+#{value}$/) }
    end
  end
end
