require './analyzer.rb'

analizer = Analyzer.new(ARGV[0])
if analizer.error
	analizer.print_error
else
	analizer.calculate
end