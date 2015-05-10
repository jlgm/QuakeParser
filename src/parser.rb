#!/usr/bin/env ruby

require_relative 'game'

class Parser

	attr_accessor :log
	
	def initialize(file)
		@log = File.read(file)
		@counter = 0
		@game = Game.new(0)
		@map = Hash.new
	end
	
	def start_game
		@counter = @counter + 1
		@game = Game.new(@counter)
		@map = Hash.new
		@map["1022"] = "<world>"
	end
	
	def process_kill(data)
		ids = data.match(/\d+ \d+ \d+:/).to_s.split(" ")
		if (ids[0] == "1022")
			@game.world_kill(@map[ids[1]])
		else
			@game.kill(@map[ids[0]])
		end
		
	end
	
	def process_update(post_match)
		id = post_match.match(/\d+/).to_s
		post_id = post_match.match(/\d+/).post_match.to_s
		name = post_id.match(/\\.*?\\/).to_s
		
		name = name[1..name.length-2]
		
		if (@map[id])
			@game.change_player_name(@map[id], name)
		else
			@game.new_player(name)
		end
		
		@map[id] = name
	end
	
	def print_relatorio
		@game.print_log
	end
	
	def parse_line(line)
		pattern = /\d+:\d+ \w+:/
		match = pattern.match(line)
		task = match.to_s.split(" ")[1]
		
		if (task == "InitGame:")
			start_game
		elsif (task == "ClientUserinfoChanged:")
			process_update(match.post_match)
		elsif (task == "Kill:")
			process_kill(match.post_match)
		elsif (task == "ShutdownGame:")
			puts print_relatorio
		end
		
	end
	
	def run
		lines = @log.split("\n")
		lines.each do |line|
			parse_line(line)
		end
		
		puts "end"
	end

end
