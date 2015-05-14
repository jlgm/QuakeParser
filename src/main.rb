#!/usr/bin/env ruby

require_relative 'parser'

class Main

	def initialize(file)
		@parser = Parser.new(file)
	end
	
	def run
		@parser.run			
		self.print_games
		self.print_ranking
	end
	
	def print_games
		@parser.games.each do |game|
			puts game if game
		end
	end
	
	def print_ranking
		scores = Hash.new(0)	
		@parser.games.each do |game|
			scores.update(game.kills) {|key, oldval, newval| scores[key] = oldval + newval } if game
		end
			
		ranking = Hash.new
		scores.sort_by {|_key, value| -value}.each do |key,value|
			ranking[key] = value
		end
		puts "global_ranking: " + JSON.pretty_generate(ranking) + "\n"
	end
	
end

m = Main.new("log/quake.log")
m.run

