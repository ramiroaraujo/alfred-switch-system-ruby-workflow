#!/usr/bin/env ruby
# encoding: utf-8

# require_relative emulation for 1.8
unless Kernel.respond_to?(:require_relative)
  module Kernel
    def require_relative(path)
      require File.join(File.dirname(caller[0]), path.to_str)
    end
  end
end

require_relative 'bundle/bundler/setup'
require 'alfred'

# calculate version of ruby to switch
current_version = `/usr/bin/ruby -v`[5] == '2' ? '2.0' : '1.8'
switch = { '2.0' => '1.8', '1.8' => '2.0' }
new_version = switch[current_version]

Alfred.with_friendly_error do |alfred|
  fb = alfred.feedback

  fb.add_item({
      :title => "Switch Ruby version to #{new_version}",
      :subtitle => 'It will ask for administration privileges to continue',
      :arg => new_version,
      :valid => 'yes',
  })

  # show current ruby version
  fb.add_item({
      :title => "Current Ruby Version: #{current_version}",
      :subtitle => 'This is the current Ruby version installed in /usr/bin/ruby',
      :valid => 'no'
  })

  puts fb.to_xml()
end