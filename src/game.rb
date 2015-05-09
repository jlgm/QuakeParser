#!/usr/bin/env ruby

class Game  

  def initialize(game)
    @game = game
    @total_kills = 0
    @players = []
    @kills = Hash.new(0)
  end
  
  def new_player(name)
  	@players.push(name)
  	@kills[name] = 0
  end
  
  def change_player_name(name, newName)
  	@kills[newName] = @kills.delete(name)
  	@players[@players.find_index(name)] = newName
  end
  
  def kill(killer)
  	@total_kills = @total_kills + 1
  	@kills[killer] = @kills[killer] + 1
  end
  
  def world_kill(killed)
  	@total_kills = @total_kills + 1
  	@kills[killed] = @kills[killed] - 1
  end
  
  def print_log
  	puts "game_#{@game}: {\n" +  "\ttotal_kills: #{@total_kills}; \n" + "\tplayers: " + @players.to_s + "\n" + "\tkills: " + @kills.to_s + " \n}"
  end

end

#tests

if __FILE__ == $0
  g = Game.new(1)
  
  g.new_player("joao")
  g.new_player("carlotas")
  
  g.print_log
  
  g.kill("joao")
  g.kill("joao")
  g.kill("joao")
  g.kill("joao")
  g.kill("joao")
  g.kill("carlotas")
  
  g.world_kill("carlotas")
  g.world_kill("carlotas")
  g.world_kill("carlotas")
  g.world_kill("carlotas")
  g.world_kill("carlotas")
  
  g.print_log
  
  g.world_kill("carlotas")
  g.world_kill("carlotas")
  
  g.print_log
  
  g.change_player_name("carlotas", "carlinhos")
  g.kill("carlinhos")
  
  g.print_log
  
end
