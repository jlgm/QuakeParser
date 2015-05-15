require '../src/game'

RSpec.describe Game, "kills" do
	it "should start empty" do
		g = Game.new(0)
		expect(g.kills).to be_empty
	end

	it "should have value 0 as default for a key" do
		g = Game.new(0)
		g.new_player("joao")
		expect(g.kills["joao"]).to eq 0
	end

	it "should increase it's value whenever a key has a kill registered" do
		g = Game.new(0)
		g.new_player("joao")
		g.kill("joao", "0")
		expect(g.kills["joao"]).to eq 1
		g.kill("joao","0")
		expect(g.kills["joao"]).to eq 2
	end

	it "should keep the kills even when player changes his/her name" do
		g = Game.new(0)
		g.new_player("joao")
		g.kill("joao", "0")
		g.kill("joao", "0")
		g.change_player_name("joao", "joaizn")
		expect(g.kills["joaizn"]).to eq 2
		expect(g.kills["joao"]).to eq 0
	end

	it "decreases a player's score whenever a world_kill happens to him/her" do
		g = Game.new(0)
		g.new_player("joao")
		g.kill("joao", "0")
		expect(g.kills["joao"]).to eq 1
		g.world_kill("joao", "0")
		expect(g.kills["joao"]).to eq 0
		g.world_kill("joao", "0")
		expect(g.kills["joao"]).to eq -1
	end

end

RSpec.describe Game, "total_kills" do
	it "should start as 0" do
		g = Game.new(0)
		expect(g.instance_variable_get(:@total_kills)).to eq 0		
	end
	
	it "should should increase when someone is killed" do
		g = Game.new(0)
		g.new_player("joao")
		g.kill("joao","0")
		expect(g.instance_variable_get(:@total_kills)).to eq 1
		g.kill("joao", "1")
		expect(g.instance_variable_get(:@total_kills)).to eq 2
		g.world_kill("joao", "2")
		expect(g.instance_variable_get(:@total_kills)).to eq 3		
	end
	
end

