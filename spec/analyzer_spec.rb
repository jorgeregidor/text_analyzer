require_relative "../analyzer"

describe "Analyzer" do 

	describe "not file" do
		before(:all) do
	 		@analyzer = Analyzer.new("")
	  end

	  it "error is not empty" do
  		expect(@analyzer.error.nil?).to eq(false)
	  end

	  it "text is empty" do
	  	expect(@analyzer.text.nil?).to eq(true)
	  end
	end

	describe "right file" do
		before(:all) do
	 		@analyzer = Analyzer.new("spec/text2.txt")
	 		@analyzer.calculate
	  end

	  it "text is not empty" do
	  	expect(@analyzer.text.nil?).to eq(false)
	  end

	  it "error is empty" do
	  	expect(@analyzer.error.nil?).to eq(true)
	  end

	  it "error is empty" do
	  	expect(@analyzer.error.nil?).to eq(true)
	  end

	  it "number of sentences" do
	  	expect(@analyzer.sentences.count).to eq(24)
	  end

	  it "number of unique sentences" do
	  	expect(@analyzer.uniq_sentences.count).to eq(13)
	  end

	  it "number of words" do
	  	expect(@analyzer.nwords).to eq(136)
	  end

	  it "number of sentences" do
	  	expect(@analyzer.nwords_uniq_sentences).to eq(69)
	  end

	  it "number of words in longest line" do
	  	expect(@analyzer.sorted_sentences[-1][1]).to eq(10)
	  end

	  it "histogram is correct" do
	  	expect(@analyzer.histogram[0]).to eq(["*","*","-"])
	  	expect(@analyzer.histogram[1]).to eq(["-","-","-"])
	  end 

	end

end
