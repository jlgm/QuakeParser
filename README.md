# QuakeParser
Parser for a Quake 3 Arena log

Prints a report at the end of every game. 

##how to use

- put the log file on same directory as the *parser.rb* and *game.rb*
- open **irb**, load 'parser.rb'
- then make an instance of it passing the file name as parameter (ex.: p = Parser.new("mylog.log"))
- call the instance's run function (in the above example, it would be p.run) 


