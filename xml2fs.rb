require 'rexml/document'
require 'fileutils'
require 'optparse'

include REXML

input = File.new("fs_schemes/fs_scheme.xml")
doc = Document.new(input)

root = doc.root

def xml_walk(root, prefix)
  buf = []
  root.attributes["name"].each { |attr| buf << prefix + '/' + attr }
  buf.each { |folder| FileUtils.makedirs(folder) }
  buf.each do |prefix|
    root.elements.each { |e| xml_walk(e, prefix) }
  end  
end

xml_walk(root, '/tmp/repository')
