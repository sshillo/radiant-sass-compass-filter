=begin
require 'find'
class AddLibraries < ActiveRecord::Migration
  def self.up
    Find.find(File.join(SassCompassFilterExtension.root,"lib","frameworks")) do |path|
      add_lib(path) if File.file?(path)
    end
  end

  def self.down
    Find.find(File.join(SassCompassFilterExtension.root,"lib","blueprint")) do |path|
      rm_lib(path) if File.file?(path)
    end
  end
end
def rm_lib(path)
  SassLibrary.find_by_name(File.basename(path).gsub(/^_/,'')).destroy
end
def add_lib(path)
  puts "Adding #{File.basename(path).gsub(/^_/,'')}"
  root = Page.find_by_url
  name = File.basename(path).gsub(/^_/,'')
  currDir = File.dirname(path).gsub("#{SassCompassFilterExtension.root}",'')
  slug = File.join(curr)
  SassLibrary.create(:name => File.basename(path).gsub(/^_/,''), :content => File.open(path).read) 
end
=end