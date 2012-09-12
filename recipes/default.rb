package "vsftpd" do
  action :install
end

directory "/etc/vsftpd/users" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

cookbook_file "/etc/vsftpd/vsftpd.conf" do
  source "vsftpd.conf" # this is the value that would be inferred from the path parameter
  mode "0600"
end

node["vsftpd_users"].each do |user, options|
  template "/etc/vsftpd/users/#{user}" do
    source "user_config.erb"
    owner "root"
    group "root"
    variables(:config_lines => options)
  end
end

service "vsftpd" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
