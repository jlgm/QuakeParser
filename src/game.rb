#!/usr/bin/env ruby

require 'json'

class Game  

	attr_accessor :kills

	def initialize(game)
		@game = game
		@total_kills = 0
		@players = []
		@kills = Hash.new(0)

		@mods = {
		"0" => "MOD_UNKNOWN",
		"1" => "MOD_SHOTGUN",
		"2" => "MOD_GAUNTLET",
		"3" => "MOD_MACHINEGUN",
		"4" => "MOD_GRENADE",
		"5" => "MOD_GRENADE_SPLASH",
		"6" => "MOD_ROCKET",
		"7" => "MOD_ROCKET_SPLASH",
		"8" => "MOD_PLASMA",
		"9" => "MOD_PLASMA_SPLASH",
		"10" => "MOD_RAILGUN",
		"11" => "MOD_LIGHTNING",
		"12" => "MOD_BFG",
		"13" => "MOD_BFG_SPLASH",
		"14" => "MOD_WATER",
		"15" => "MOD_SLIME",
		"16" => "MOD_LAVA",
		"17" => "MOD_CRUSH",
		"18" => "MOD_TELEFRAG",
		"19" => "MOD_FALLING",
		"20" => "MOD_SUICIDE",
		"21" => "MOD_TARGET_LASER",
		"22" => "MOD_TRIGGER_HURT",
		"23" => "MOD_NAIL",
		"24" => "MOD_CHAINGUN",
		"25" => "MOD_PROXIMITY_MINE",
		"26" => "MOD_KAMIKAZE",
		"27" => "MOD_JUICED",
		"28" => "MOD_GRAPPLE"
		}

		@kill_mods = Hash.new(0)

	end

	def new_player(name)
		@players.push(name)
		@kills[name] = 0
	end

	def change_player_name(name, newName)
		@kills[newName] = @kills.delete(name)
		@players[@players.find_index(name)] = newName
	end

	def kill(killer, mod="0")
		@total_kills = @total_kills + 1
		@kills[killer] = @kills[killer] + 1
		@kill_mods[@mods[mod]] = @kill_mods[@mods[mod]] + 1
	end

	def world_kill(killed, mod="0")
		@total_kills = @total_kills + 1
		@kills[killed] = @kills[killed] - 1
		@kill_mods[@mods[mod]] = @kill_mods[@mods[mod]] + 1
	end

	def print_log
		puts "game_#{@game}: {\n" +  "\ttotal_kills: #{@total_kills}; \n" + "\tplayers: " + @players.to_json + "\n" + "\tkills: " + @kills.to_json + "\n\tkills_by_means: " + @kill_mods.to_json + "\n}"
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
