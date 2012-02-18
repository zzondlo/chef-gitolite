chef-gitolite
=============

Description
-----------

This cookbook installs [gitolite](https://github.com/sitaramc/gitolite) system-wide using the [root method](http://sitaramc.github.com/gitolite/root.html).

Requirements
------------

### Chef

Tested on 0.10.2

### Platform

Tested on Ubuntu LTS 10.04

### Cookbook

Depends on [git cookbook from Opscode](http://community.opscode.com/cookbooks/git)

Usage
-----

Include `recipe[gitolite::default]` in your run_list and override the defaults you want changed to perform a system-wide installation of gitolite.

#FIX Example of using gitolite_instance definition