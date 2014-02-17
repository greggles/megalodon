
default['megalodon']['php']['default_version'] = 5.4
default['megalodon']['brew_prefix'] = `brew --prefix`.strip
default_package_name = Megalodon::php_package_name default['megalodon']['php']['default_version']
default['megalodon']['php_prefix'] = "/usr/local/opt/#{default_package_name}"
default['megalodon']['docroot'] = "#{default['megalodon']['brew_prefix']}/var/www"
default['megalodon']['php']['versions'] = [5.3, 5.4]#, 5.5]
default['megalodon']['php']['extensions'] = [
  "apc",
  "memcached",
  "redis",
  "xhprof",
]

