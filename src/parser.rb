#!/usr/bin/env ruby

require_relative 'game'

class Parser

	attr_accessor :log
	
	WORLD = "1022"
	
	def initialize(file)
		@log = File.read(file)
		@counter = 0
		@map = Hash.new
		@ranking = Hash.new(0)
	end
	
	def start_game
		@counter = @counter + 1
		@game = Game.new(@counter)
		@map = Hash.new
		@map[WORLD] = "<world>"
	end
	
	def run
		lines = @log.split("\n")
		lines.each do |line|
			self.parse_line(line)
		end
		@ranking.update(@game.kills) {|key, oldval, newval| @ranking[key] = oldval + newval }
		self.print_relatorio
		self.print_geral_ranking
	end
	
	def print_geral_ranking
		sorted_ranking = Hash.new
		@ranking.sort_by {|_key, value| -value}.each do |key,value|
			sorted_ranking[key] = value
		end
		puts "global_ranking: " + JSON.pretty_generate(sorted_ranking) + "\n"
	end
	
	def parse_line(line)
		pattern = /\d+:\d+ \w+:/
		match = pattern.match(line)
		task = match.to_s.split(" ")[1]
		
		if (task == "InitGame:")
			if (@game)
				@ranking.update(@game.kills) {|key, oldval, newval| @ranking[key] = oldval + newval }
				self.print_relatorio
			end
			self.start_game
		elsif (task == "ClientUserinfoChanged:")
			self.parse_update(match.post_match)
		elsif (task == "Kill:")
			self.parse_kill(match.post_match)
		end
	end
	
	def parse_update(data)
		id = data.match(/\d+/).to_s
		post_id = data.match(/\d+/).post_match.to_s
		name = post_id.match(/\\.*?\\/).to_s
		
		name = name[1..name.length-2]
		
		if (@map[id])
			@game.change_player_name(@map[id], name)
		else
			@game.new_player(name)
		end
		@map[id] = name
	end
	
	def parse_kill(data)
		ids = data.match(/\d+ \d+ \d+/).to_s.split(" ")
		if (ids[0] == WORLD)
			@game.world_kill(@map[ids[1]], ids[2])
		else
			@game.kill(@map[ids[0]], ids[2])
		end
	end
	
	def print_relatorio
		@game.print_log
	end

end

p = Parser.new("log/quake.log")
p.run
