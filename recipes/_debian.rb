include_recipe 'apt::default'

client_version = node['oracle-instant-client']['version']
tmp_dir = '/tmp'

local_oicb = "#{tmp_dir}/#{node['oracle-instant-client']['basic']['filename']}"
local_oicd = "#{tmp_dir}/#{node['oracle-instant-client']['devel']['filename']}"
local_sqlp = "#{tmp_dir}/#{node['oracle-instant-client']['sqlplus']['filename']}"

remote_oicb = node['oracle-instant-client']['basic']['public-url']
remote_oicd = node['oracle-instant-client']['devel']['public-url']
remote_sqlp = node['oracle-instant-client']['sqlplus']['public-url']

checksum_oicb = node['oracle-instant-client']['basic']['checksum']
checksum_oicd = node['oracle-instant-client']['devel']['checksum']
checksum_sqlp = node['oracle-instant-client']['sqlplus']['checksum']

remote_file "#{local_oicb}" do
  source "#{remote_oicb}"
  checksum "#{checksum_oicb}"
  action :create
end

remote_file "#{local_oicd}" do
  source "#{remote_oicd}"
  checksum "#{checksum_oicd}"
  action :create
end

remote_file "#{local_sqlp}" do
  source "#{remote_sqlp}"
  checksum "#{checksum_sqlp}"
  action :create
end

package 'alien'

execute 'install oracle-instantclient-basic' do
  command "alien -i #{local_oicb}"
  not_if  "dpkg -l | grep oracle-instantclient#{client_version}-basic"
end

execute 'install oracle-instantclient-devel' do
  command "alien -i #{local_oicd}"
  not_if  'dpkg -l | grep oracle-instantclient#{client_version}-devel'
end

execute 'install sqlplus first step' do
  command "alien -i #{local_sqlp}"
  not_if  'dpkg -l | grep oracle-instantclient#{client_version}-sqlplus'
end

package 'libaio1'

oracle_dir = '/usr/lib/oracle'

client_type = 
  case node['target_cpu']
  when 'x86_64' then 'client64'
  else
    Dir.entries(oracle_dir).select do |e|
      File.directory?(File.join(oracle_dir,e)) && e.match(/.*client.*/).first
    end
  end

client_dir = "#{oracle_dir}/#{client_version}/#{client_type}"

raise 'Can not find instant client directory' unless File.directory?(client_dir)

file '/etc/ld.so.conf.d/oracle.conf' do
  owner   'root'
  group   'root'
  mode    '0755'
  action  :create
  content "#{client_dir}/lib/"
end

execute 'install sqlplus final step' do
  command 'ldconfig'
  not_if  'env | grep LD_LIBRARY_PATH'
end
