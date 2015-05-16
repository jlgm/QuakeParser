require '../src/parser'

RSpec.describe Parser, "log" do
	it "should receive the log in the constructor" do
		p = Parser.new("----------")
		expect(p.log).to eq "----------"
	end
end

RSpec.describe Parser, "games" do
	it "should start as an empty array" do
		p = Parser.new("----------")
		expect(p.games).to eq []
	end
end
	
RSpec.describe Parser, "parse_update" do
	it "parses a line with a ClientUserinfoChanged command" do
		p = Parser.new("")
		p.start_game
		p.parse_update("2 n\\Isgalamido\\tblablabla")
		expect(p.instance_variable_get(:@map)).to eq ({"1022" => "<world>", "2" => "Isgalamido"})
		p.parse_update("2 n\\Joao\\tblablabla")
		expect(p.instance_variable_get(:@map)).to eq ({"1022" => "<world>", "2" => "Joao"})
	end
end

RSpec.describe Parser, "parse_kill" do
	it "parses a line with a Kill: command" do
		p = Parser.new("")
		p.start_game
		p.parse_update("2 n\\Isgalamido\\tblablabla")
		p.parse_kill("1022 2 22: <world> killed Isgalamido by MOD_TRIGGER_HURT")
		expect(p.games[1].kills["Isgalamido"]).to eq -1
		
		p.parse_kill("2 2 0: Isgalamido killed Isgalamido by MOD_UNKNOWN")
		expect(p.games[1].kills["Isgalamido"]).to eq 0 
		
		#Obs.: I'm assuming killing yourself doesn't decrease your score, even though this would make more sense. 
		
		p.parse_kill("2 2 0: Isgalamido killed Isgalamido by MOD_UNKNOWN")
		expect(p.games[1].kills["Isgalamido"]).to eq 1
		p.parse_kill("2 2 0: Isgalamido killed Isgalamido by MOD_UNKNOWN")
		expect(p.games[1].kills["Isgalamido"]).to eq 2
		p.parse_kill("2 2 0: Isgalamido killed Isgalamido by MOD_UNKNOWN")
		expect(p.games[1].kills["Isgalamido"]).to eq 3
		
		p.parse_update("2 n\\Joao\\tblablabla")
		expect(p.games[1].kills["Isgalamido"]).to eq 0
		
		expect(p.instance_variable_get(:@map)).to eq ({"1022" => "<world>", "2" => "Joao"})
		expect(p.games[1].kills["Joao"]).to eq 3
	end
end

