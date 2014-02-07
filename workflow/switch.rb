#!/usr/bin/env ruby
# encoding: utf-8

require 'fileutils'

basepath = '/System/Library/Frameworks/Ruby.framework/Versions'

current_version = `/usr/bin/ruby -v`[5] == '2' ? '2.0' : '1.8'
switch = { '2.0' => '1.8', '1.8' => '2.0' }
new_version = switch[current_version]

FileUtils.cd basepath do
  FileUtils.remove_dir 'Current'
  FileUtils.ln_s "#{basepath}/#{new_version}", "#{basepath}/Current"
end