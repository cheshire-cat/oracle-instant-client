default['target_cpu'] = 'x86_64'

default['oracle-instant-client']['version'] = '12.1'

default['oracle-instant-client']['public-url'] = nil

default['oracle-instant-client']['sqlplus']['version'] = '12.1.0.2.0-1'
default['oracle-instant-client']['devel']['version']   = '12.1.0.2.0-1'
default['oracle-instant-client']['basic']['version']   = '12.1.0.2.0-1'

default['oracle-instant-client']['sqlplus']['filename'] = 
  "oracle-instantclient#{node['oracle-instant-client']['version']}-sqlplus-" + \
  "#{node['oracle-instant-client']['sqlplus']['version']}.#{node['target_cpu']}.rpm"
default['oracle-instant-client']['devel']['filename'] = 
  "oracle-instantclient#{node['oracle-instant-client']['version']}-devel-" + \
  "#{node['oracle-instant-client']['devel']['version']}.#{node['target_cpu']}.rpm"
default['oracle-instant-client']['basic']['filename'] = 
  "oracle-instantclient#{node['oracle-instant-client']['version']}-basic-" + \
  "#{node['oracle-instant-client']['basic']['version']}.#{node['target_cpu']}.rpm"

if node['oracle-instant-client']['public-url'].nil?
  default['oracle-instant-client']['basic']['public-url'] = 
    "https://www.dropbox.com/s/hz119gul5sf3ih3/#{node['oracle-instant-client']['basic']['filename']}?dl=1"
  default['oracle-instant-client']['devel']['public-url'] = 
    "https://www.dropbox.com/s/w8vuyydzxuayl0u/#{node['oracle-instant-client']['devel']['filename']}?dl=1"
  default['oracle-instant-client']['sqlplus']['public-url'] = 
    "https://www.dropbox.com/s/i9qyqokq7fg2tmp/#{node['oracle-instant-client']['sqlplus']['filename']}?dl=1"
else
  default['oracle-instant-client']['basic']['public-url'] = 
    node['oracle-instant-client']['public-url'] + node['oracle-instant-client']['basic']['filename']
  default['oracle-instant-client']['devel']['public-url'] = 
    node['oracle-instant-client']['public-url'] + node['oracle-instant-client']['devel']['filename']
  default['oracle-instant-client']['sqlplus']['public-url'] = 
    node['oracle-instant-client']['public-url'] + node['oracle-instant-client']['sqlplus']['filename']
end

default['oracle-instant-client']['basic']['checksum'] = 
  'f0e51e247cc3f210b950fd939ab1f696de9ca678d1eb179ba49ac73acb9a20ed'
default['oracle-instant-client']['devel']['checksum'] = 
  '13b638882f07d6cfc06c85dc6b9eb5cac37064d3d594194b6b09d33483a08296'
default['oracle-instant-client']['sqlplus']['checksum'] = 
  '55ed620063e93eb347456a3ee321c1a93a4ef6c9366bc40e790ac448033fa899'
