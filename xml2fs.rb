require 'rexml/document'
require 'fileutils'
require 'optparse'

include REXML

class XML2FS
  attr_accessor :scheme
  attr_accessor :prefix
  
  def initialize(scheme, prefix)
    @input = File.new(scheme)
    @doc = Document.new(@input)
    @root = @doc.root
    @prefix = prefix     
  end
  
  def xml_walk(root = @root, prefix = @prefix)
    buf = []
    root.attributes["name"].each { |attr| buf << prefix + '/' + attr }
    buf.each { |folder| FileUtils.makedirs(folder) }
    buf.each do |prefix|
      root.elements.each { |e| xml_walk(e, prefix) }
    end 
  end
  
end
