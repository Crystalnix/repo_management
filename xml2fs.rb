require 'rexml/document'
require 'fileutils'
require 'optparse'

include REXML

input = File.new("fs_schemes/fs_scheme.xml")
doc = Document.new(input)

root = doc.root

options = {}

optparse = OptionParser.new do |opts|
   # Set a banner, displayed at the top
   # of the help screen.
   opts.banner = "Usage: oxml2fs.rb [options]"
 
   # Define the options, and what they do
   options[:prefix] = false
   opts.on( '-p', '--prefix', 'destination directory' ) do
     options[:prefix] = true
   end
 
   options[:input] = false
   opts.on( '-i', '--input', 'XML directories scheme' ) do
     options[:input] = true
   end
 
   # This displays the help screen, all programs are
   # assumed to have this option.
   opts.on( '-h', '--help', 'Display this screen' ) do
     puts opts
     exit
   end
 end

optparse.parse!


def xml_walk(root, prefix)
  buf = []
  root.attributes["name"].each { |attr| buf << prefix + '/' + attr }
  buf.each { |folder| FileUtils.makedirs(folder) }
  buf.each do |prefix|
    root.elements.each { |e| xml_walk(e, prefix) }
  end  
end

xml_walk(root, '/tmp/repository')