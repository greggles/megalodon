
module Megalodon
  module_function

  def current_php_version
    link = File.readlink "/usr/local/bin/php"
    link.split("/")[-3].to_f
  end

  def php_package_names(&block)
    php_versions do |version|
      package_name = "php#{version.to_s.scan(/[\d]/).join}"
      block.call package_name
    end
  end

  def current_php_version
    current_version = node["megalodon"]["php"]["default_version"]
  end

  def php_extensions(version, &block)
    extensions = node['megalodon']['php']['extensions']
    if node['megalodon']['php'][version]
      extensions += node['megalodon']['php'][version]['extensions']
    end
    current_version = php_package_name version

    if block
      extensions.each do |ext|
        block.call "#{current_version}-#{ext}"
      end
    else
      extensions
    end
  end

  def php_versions(&block)
    versions = node['megalodon']['php']['versions']

    if block
      node['megalodon']['php']['versions'].each do |version|
        block.call version
      end
    else
      versions
    end
  end

  def non_active_php_versions(&block)
    non_active_php_versions = php_versions.reject do |version|
      version == node["megalodon"]["php"]["default_version"]
    end

    if block
      non_active_php_versions.each do |version|
        block.call version
      end
    else
      non_active_php_versions
    end
  end

  def php_package_name(version)
    "php#{version.to_s.scan(/[\d]/).join}"
  end
end

class Chef::Recipe
  include Megalodon
end

