package "vsftpd" do
  action :install
end

service "vsftpd" do
  supports :status => true, :restart => true, start: true
  action [ :enable, :nothing ]
end

directory node['vsftpd']['users_config'] do
  owner "root"
  group "root"
  mode "0755"
  action :create
  recursive true
end

cookbook_file node['vsftpd']['config_file'] do
  source "vsftpd.conf"
  mode "0600"
  notifies :restart, 'service[vsftpd]'
end

node["vsftpd_users"].each do |user, options|
  template "/etc/vsftpd/users/#{user}" do
    source "user_config.erb"
    owner "root"
    group "root"
    variables(:config_lines => options)
  end

  # vsftpd_userlist user
end if node["vsftpd_users"]


