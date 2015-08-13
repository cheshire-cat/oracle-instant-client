require 'spec_helper'

# Serverspec examples can be found at
# http://serverspec.org/resource_types.html

if ['debian', 'ubuntu'].include?(os[:family])
  describe command('dpkg -l | grep oracle-instantclient') do
    its(:stdout) { should contain("-basic") }
    its(:stdout) { should contain("-devel") }
    its(:stdout) { should contain("-sqlplus") }
  end
end
