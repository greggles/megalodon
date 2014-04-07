
#
# Cookbook Name:: megalodon
# Recipe:: php_extensions
#

php_extensions(node["megalodon"]["php"]["default_version"]) do |ext|
  package ext
end
