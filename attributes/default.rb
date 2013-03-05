case node['platform']
when "debian","ubuntu"
  default['vsftpd']['config_file'] = "/etc/vsftpd.conf"
when "centos"
  default['vsftpd']['config_file'] = "/etc/vsftpd/vsftpd.conf"
end

default['vsftpd']['users_config'] = "/etc/vsftpd/users"
