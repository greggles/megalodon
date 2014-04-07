# encoding: UTF-8

#
# Cookbook Name:: megalodon
# Recipe:: php
#

php_options = [
  "--with-mysql",
  "--with-imap",
  "--with-apache",
  "--with-cgi",
  "--with-debug",
]

php_versions do |version|
  package_name = php_package_name version

  package package_name do
    action :install
    options php_options.join
  end

  template "#{node["megalodon"]["brew_prefix"]}/etc/php/#{version}/php.ini" do
    source "php.ini.erb"
    mode "0644"
  end

  # Add owner writes to this file so that pear wil work.
  file "/usr/local/opt/#{package_name}/lib/php/.lock" do
    mode "0644"
  end

end

non_active_packages = non_active_php_versions.map do |version|
  php_package_name version
end

active_package = php_package_name node["megalodon"]["php"]["default_version"]
execute "unlink non-active php" do
  command "brew unlink #{non_active_packages.join}"
end

execute "link active php" do
  command "brew link #{active_package}"
end

include_recipe "megalodon::php_extensions"

bash "Fix the default PEAR permissions and config" do
  code <<-EOS
    pear config-set php_ini $(brew --prefix php)/etc/php5/php.ini
    pecl config-set php_suffix /$(brew --prefix php| awk -F'/' '{print $6}')/bin/php
  EOS
end
