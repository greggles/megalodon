# Megalodon

The goal of megalodon to provide a simple, repeatable, and extendable way to setup a modern php development environment on Mac OS X. It consists of a collection of [homebrew](http://mxcl.github.com/homebrew) formulas and [chef](http://www.opscode.com/chef/) recipies. It's pretty awesome.

This project is heavily influenced by [cider/cinderella](https://github.com/atmos/cinderella), which is aimed at providing an environment for ruby/python/node. Megalodon started as a fork of [smeagol](https://github.com/atmos/smeagol) (the chef bits of cinderella), but has since taken a different approach.

## Installation

Install [homebrew](http://mxcl.github.com/homebrew/).

You can use sudo for installing gems, but don't use sudo for anything else. If you already installed Ruby with homebrew then don't use sudo for any of the installation.

Install megalodon:

    gem install megalodon

Run megalodon:

    megalodon install

If `megalodon install` fails along the way try running it again.

If it fails again, read what command failed and run just that command and look at the output.

## Usage

### General

Megalodon uses OSX's built in apache, so you can restart apache like so:

    sudo /usr/sbin/apachectl restart

Everything else that's installed with homebrew should have a plist in ~/Library/LaunchAgents (OSX's equivalent to /etc/init.d), which can be managed with lunchy. It will soon be included in megalodon, but for now just do `gem install lunchy`.

For example, you'd restart mysql like so:

    lunchy restart mysql

### Managing virtual hosts

You will need to edit /etc/hosts as per usual; To add a new virtual host, add a new .json file in:

    ~/.megalodon/data_bags/vhosts

For example, you could add example.com to your /etc/hosts for 127.0.0.1 and then use an entry called example.json in ~/.megalodon/data_bags/vhosts with these contents:

    {
      "id": "example_com",
      "docroot": "/home/yourname/workspace/example/",
      "servername": "example.com",
      "server_aliases": [ "www.example.com", "foo.example.com"]
    }

You can specify additional key/value pairs as desired:

    {
      "id": "example_com",
      "docroot": "/home/yourname/workspace/example/",
      "servername": "example.com",
      "php_admin_value": "xdebug.remote_enable 1",
      "php_admin_value": "xdebug.remote_autostart 1"
    }

To re-generate the apache confs after modifying/adding vhosts:

    megalodon update_vhosts

Then restart apache as above.

## Other notes

mysql default username is root, no password

## Troubleshooting the install
Test if a new virtual host is working using curl:

    curl http://localhost/ -H "Host www.example.com"

Replace www.example.com with the hostname you expect to work. If that returns the content you expect.

