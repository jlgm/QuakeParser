#!/usr/bin/env ruby

#represents a game session in Quake 3 arena.
#it stores kills, players' names and scores and the reason of all deaths.
# http://joaomarlonigu.com
#author: jlgm

require 'json'

class Game  

	attr_accessor :kills
	
	MODS = {"0" => "MOD_UNKNOWN", "1" => "MOD_SHOTGUN", "2" => "MOD_GAUNTLET", "3" => "MOD_MACHINEGUN", "4" => "MOD_GRENADE",	"5" => "MOD_GRENADE_SPLASH", "6" => "MOD_ROCKET",	"7" => "MOD_ROCKET_SPLASH",	"8" => "MOD_PLASMA",	"9" => "MOD_PLASMA_SPLASH",	"10" => "MOD_RAILGUN",	"11" => "MOD_LIGHTNING",	"12" => "MOD_BFG",	"13" => "MOD_BFG_SPLASH",	"14" => "MOD_WATER",	"15" => "MOD_SLIME",	"16" => "MOD_LAVA",	"17" => "MOD_CRUSH",	"18" => "MOD_TELEFRAG",	"19" => "MOD_FALLING",	"20" => "MOD_SUICIDE",	"21" => "MOD_TARGET_LASER",	"22" => "MOD_TRIGGER_HURT",	"23" => "MOD_NAIL",	"24" => "MOD_CHAINGUN",	"25" => "MOD_PROXIMITY_MINE",	"26" => "MOD_KAMIKAZE",	"27" => "MOD_JUICED",	"28" => "MOD_GRAPPLE"}

	def initialize(game)
		@game = game
		@total_kills = 0
		@players = []
		@kills = Hash.new(0)
		@kill_mods = Hash.new(0)
	end

	def new_player(name)
		if (@players.find_index(name) == nil)
			@players.push(name)
		end
		@kills[name] += 0
	end

	def change_player_name(name, newName)
		@kills[newName] = @kills.delete(name)
		@players[@players.find_index(name)] = newName
	end

	def kill(killer, mod="0")
		@total_kills += 1
		@kills[killer] += 1
		@kill_mods[MODS[mod]] += 1
	end

	def world_kill(killed, mod="0")
		@total_kills += 1
		@kills[killed] -= 1
		@kill_mods[MODS[mod]] += 1
	end

	def to_s
		"game_#{@game}: {\n" +  "  total_kills: #{@total_kills}; \n" + "  players: " + @players.to_json + "\n" + "  kills: " + @kills.to_json + "\n  kills_by_means: " + @kill_mods.to_json + "\n}"
	end

end

