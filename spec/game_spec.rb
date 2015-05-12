require '../src/game'

RSpec.describe Game, "kills" do
	it "should start empty" do
		g = Game.new(0)
		g.kills == []
	end
end
