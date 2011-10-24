# The main script.

require 'xml2fs'
require 'optparse'

def parse_options
  options = {} # here optparse will store the arguments
  optparse = OptionParser.new do |opts|
    opts.on('-h', '--help', 'Display this screen') do
      puts opts
      exit
    end
    opts.on('-p', '--prefix PREFIX', 'path to repository') do |p|
      options[:prefix] = p
    end
    opts.on('-s', '--scheme SCHEME', 'repository scheme') do |s|
      options[:scheme] = s
    end
  end
  optparse.parse!
  options # return options
end

args = parse_options
xml2fs = XML2FS.new(args[:scheme], args[:prefix])
xml2fs.xml_walk
