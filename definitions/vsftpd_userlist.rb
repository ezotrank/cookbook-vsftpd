#
# Cookbook Name:: vsftpd
# Definition:: vsftpd_userlist
# Author:: Maxim Kremenev <ezo@kremenev.com>
#
# Copyright 2013
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

define :vsftpd_userlist, :add => true do

  execute "Create user_list file" do
    command "touch /etc/vsftpd/user_list && chmod 600 /etc/vsftpd/user_list"
    user 'root'
    creates '/etc/vsftpd/user_list'
  end

  if params[:add]
    execute "add user #{params[:name]} to vsftpd userlist" do
      command <<-EOS
                if [ -z $(grep #{params[:name]} /etc/vsftpd/user_list) ]; then
                  echo "#{params[:name]}" >> /etc/vsftpd/user_list
                fi
              EOS
      notifies :restart, 'service[vsftpd]'
      not_if "grep #{params[:name]} /etc/vsftpd/user_list", user: 'root'
    end
  else
    execute "aaaaa" do
      # command "/usr/sbin/nxdissite #{params[:name]}"
      # notifies :reload, "service[nginx]", params[:timing]
      # only_if do ::File.symlink?("#{node['nginx']['dir']}/sites-enabled/#{params[:name]}") end
    end
  end
end
