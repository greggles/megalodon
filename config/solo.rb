#
# Chef Solo Config File
#
megalodon_tmp_root = "#{Dir.tmpdir}/megalodon"
megalodon_root = File.expand_path(File.join(File.dirname(__FILE__), ".."))

log_level          :info
log_location       STDOUT
sandbox_path       "#{megalodon_tmp_root}/sandboxes"
file_cache_path    "#{megalodon_tmp_root}/cookbooks"
file_backup_path   "#{megalodon_tmp_root}/backup"
cache_options      ({ :path => "#{megalodon_tmp_root}/cache/checksums", :skip_expires => true })

# Optionally store your JSON data file and a tarball of cookbooks remotely.
#json_attribs "http://chef.example.com/dna.json"
#recipe_url   "http://chef.example.com/cookbooks.tar.gz"
cookbook_path ["#{megalodon_root}/cookbooks", "#{megalodon_root}/vendor/cookbooks"]
role_path     "#{megalodon_root}/roles"
data_bag_path "#{ENV['HOME']}/.megalodon/data_bags"

Mixlib::Log::Formatter.show_time = false
