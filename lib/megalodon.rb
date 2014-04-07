require "json"

module Megalodon
  DATA_BAG_PATH = "#{ENV['HOME']}/.megalodon/data_bags"

  class << self

  def php_switch(version)
    version = version.to_f
    file_name = "#{DATA_BAG_PATH}/megalodon/php-config.json"
    php_config = JSON.parse File.read(file_name)

    php_config["current_version"] = version
    if not php_config["versions"].include? version.to_f
      php_config["versions"].push version
    end

    File.write file_name, JSON.pretty_generate(php_config)
  end

  end
end
