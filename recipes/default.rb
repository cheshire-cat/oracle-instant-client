begin
  include_recipe "oracle-instant-client::_#{node['platform_family']}"
rescue Chef::Exceptions::RecipeNotFound
  Chef::Log.warn "Your platform is not supported"
end