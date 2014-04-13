
default['megalodon']['brew_prefix'] = `brew --prefix`.strip
default['megalodon']['docroot'] = "#{default['megalodon']['brew_prefix']}/var/www"

php_config = Chef::DataBagItem.load "megalodon", "php-config"
default_package_name = Megalodon.php_package_name php_config["current_version"]

default['megalodon']['php']['default_version'] = php_config["current_version"]
default['megalodon']['php']['prefix'] = "/usr/local/opt/#{default_package_name}"
default['megalodon']['php']['versions'] = php_config["versions"]

default['megalodon']['php']['extensions'] = [
  "mcrypt",
  "memcached",
  "redis",
  "xhprof",
  "xdebug",
]
default['megalodon']['php'][5.3]['extensions'] = [
  "apc",
]
default['megalodon']['php'][5.4]['extensions'] = [
  "opcache",
  "apcu",
]
