require 'optparse'
require 'pp'

def parse_options
  options = {}
  list_of_commands = ['create_repo',
                      'update',
                      'list',
                      'help' ]
  cmd = ARGV[0]
  optparse = OptionParser.new
  case cmd
  when 'create-repo', 'cr'
    optparse.on('-h', '--help', 'discplay this screen') do
        puts optparse
        exit
    end
    optparse.on('-p', '--prefix PREFIX', 'path to repository') do |p|
      options[:prefix] = p
    end
    optparse.on('-s', '--scheme SCHEME', 'repository scheme') do |s|
      options[:scheme] = s
    end
  when 'update', 'up'
    optparse.on('-h', '--help', 'display this screen') do
      puts optparse
      exit
    end
    optparse.on('-p', '--prefix PREFIX', 'path to repository') do |p|
      options[:prefix] = p
    end
  when 'list'
    puts 'Available commands:'
    list_of_commands.each do |command|
      puts "\t" + command
    end    
  when 'help', '--help', '-h', 'h'
    puts "Usage:\t #$0 command [options]"
    exit
  else
    puts "Unknown command: '#{ARGV[0]}'"
    exit
  end
  optparse.parse!
  options # return options
end

parse_options
