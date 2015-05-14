#!/usr/bin/env ruby

#converts a quake3 log file into an array of Game objects (@games)
#
#author: jlgm

require_relative 'game'

class Parser

	attr_accessor :log, :games, :scores
	
	WORLD = "1022"
	
	def initialize(file)
		@log = File.read(file)
		@counter = 0
		@games = []
	end
	
	def start_game
		@games[@counter += 1] = Game.new(@counter)
		@map = Hash.new
		@map[WORLD] = "<world>"
	end
	
	def run
		lines = @log.split("\n")
		lines.each do |line|
			self.parse_line(line)
		end
	end
	
	def parse_line(line)
		pattern = /\d+:\d+ \w+:/
		match = pattern.match(line)
		task = match.to_s.split(" ")[1]
		
		if (task == "InitGame:")
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
			@games[@counter].change_player_name(@map[id], name)
		else
			@games[@counter].new_player(name)
		end
		@map[id] = name
	end
	
	def parse_kill(data)
		ids = data.match(/\d+ \d+ \d+/).to_s.split(" ")
		if (ids[0] == WORLD)
			@games[@counter].world_kill(@map[ids[1]], ids[2])
		else
			@games[@counter].kill(@map[ids[0]], ids[2])
		end
	end
	
end

