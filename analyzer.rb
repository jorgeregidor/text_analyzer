class Analyzer

	attr_reader :file_path

	attr_accessor :text
	attr_accessor :error
	attr_accessor :sentences 
	attr_accessor :uniq_sentences
	attr_accessor :nwords
	attr_accessor :nwords_uniq_sentences
	attr_accessor :sorted_sentences
	attr_accessor :histogram 

	def initialize file_path
		if (file_path == nil) or file_path==""
			self.error = "No path"
		else
			begin
				lines = File.readlines(file_path)
				self.text = lines.join
			rescue Exception => e
				self.error = e.message
			end
		end
	end

	def calculate
		self.sentences = self.text.scan(/[^\.!;?]+[\.!;?]/).map(&:strip)
		self.uniq_sentences = self.sentences.uniq
		self.nwords = self.text.split.count
		self.nwords_uniq_sentences = self.uniq_sentences.join(" ").split.count
		self.sorted_sentences = self.uniq_sentences.map{ |s| [s, s.split.count]  }.sort_by{ |s| s[1] }
		self.histogram = create_histogram

		print_results
		print_histogram

	end

	def print_error
		puts "ERROR: #{self.error}"
	end


	private

		def print_results
			puts "#{self.sentences.count} sentences"
			puts "#{self.uniq_sentences.count} unique sentences"
			puts "#{self.nwords} words"
			puts "#{self.nwords_uniq_sentences} words in unique sentences"
			puts "#{self.sorted_sentences[-1][1]} words in longest line"
		end

		def create_histogram
			histogramHash = Hash.new(0)
			

			# histogramHash hash (key = number of words, value = number of sentences)
			self.sorted_sentences.each do |s|
			  histogramHash[s[1]] += 1
			end

			max_number = histogramHash.values.max
			max_words = sorted_sentences[-1][1]

			return create_columns(max_words, max_number, histogramHash)

		end

		def print_histogram 
			(self.histogram[0].count-1).downto(0).each do |x| 
				row = String.new
				self.histogram.map do |column|
					row << column[x]
				end
				puts row
			end 

			puts "1234567890" * (self.sorted_sentences[-1][1]/10 +1)
		end

		def create_columns (max_words, max_number, histogramHash)
	    result = Array.new

			max_words.times do |n|
				column = Array.new
				sentence_number = histogramHash[n+1] or 0
				sentence_number.times do 
					column << "*"
				end
				(max_number - sentence_number).times do
					column << "-"
				end

				result << column
			end

			return result
		end

end