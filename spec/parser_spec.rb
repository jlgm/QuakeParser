require '../src/parser'

RSpec.describe Game, "log" do
	it "should receive the log in the constructor" do
		p = Parser.new("----------")
		expect(p.log).to eq "----------"
	end
	
end

RSpec.describe Game, "games" do
	it "should start as an empty array" do
		p = Parser.new("----------")
		expect(p.games).to eq []
	end
	
end

