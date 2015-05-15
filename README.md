# QuakeParser
Parser for a Quake 3 Arena log

Prints a report at the end of every game and shows a global ranking. 

##How to use

- Put the log file inside the folder */src/log* with the name *quake.log*
- Run with ```ruby main.rb```

##Running tests

- Testers will be in */spec* 
- Run all of them with the command ```rspec *```

##Example

A Q3A game log would be something like this:

```
16:53 InitGame: \capturelimit\8\g_maxGameClients\0\timelimit\15\fraglimit\20\dmflags\0\bot_minplayers\0\sv_allowDownload\0\sv_maxclients\16\sv_privateClients\2\g_gametype\4\sv_hostname\Code Miner Server\sv_minRate\0\sv_maxRate\10000\sv_minPing\0\sv_maxPing\0\sv_floodProtect\1\version\ioq3 1.36 linux-x86_64 Apr 12 2009\protocol\68\mapname\Q3TOURNEY6_CTF\gamename\baseq3\g_needpass\0
16:53 ClientConnect: 4
16:53 ClientUserinfoChanged: 4 n\Zeh\t\2\model\sarge/default\hmodel\sarge/default\g_redteam\\g_blueteam\\c1\1\c2\5\hc\100\w\0\l\0\tt\0\tl\1
16:53 ClientBegin: 4
16:53 ClientConnect: 7
16:53 ClientUserinfoChanged: 7 n\Assasinu Credi\t\1\model\james\hmodel\*james\g_redteam\\g_blueteam\\c1\4\c2\5\hc\100\w\0\l\0\tt\0\tl\0
16:53 ClientBegin: 7
16:56 Item: 4 weapon_railgun
16:58 Item: 4 item_armor_body
17:06 Item: 4 weapon_railgun
17:16 Kill: 1022 4 22: <world> killed Zeh by MOD_TRIGGER_HURT
17:19 Item: 4 weapon_railgun
17:25 Item: 4 team_CTF_redflag
17:28 Kill: 1022 4 22: <world> killed Zeh by MOD_TRIGGER_HURT
17:31 Item: 4 ammo_rockets
17:31 Item: 4 ammo_bullets
17:32 Item: 4 weapon_rocketlauncher
17:35 ClientDisconnect: 7
17:35 Item: 4 team_CTF_redflag
17:37 Item: 4 ammo_rockets
17:37 Item: 4 ammo_bullets
17:38 Item: 4 weapon_rocketlauncher
17:41 Item: 4 team_CTF_blueflag
17:43 Item: 4 weapon_rocketlauncher
17:48 Kill: 1022 4 22: <world> killed Zeh by MOD_TRIGGER_HURT
17:50 ClientDisconnect: 4
31:53 Exit: Timelimit hit.
31:53 red:0 blue:1
981:06 ClientConnect: 2
981:06 ClientUserinfoChanged: 2 n\Dono da Bola\t\3\model\sarge/krusade\hmodel\sarge/krusade\g_redteam\\g_blueteam\\c1\5\c2\5\hc\95\w\0\l\0\tt\0\tl\0
981:08 ClientUserinfoChanged: 2 n\Dono da Bola\t\3\model\sarge\hmodel\sarge\g_redteam\\g_blueteam\\c1\4\c2\5\hc\95\w\0\l\0\tt\0\tl\0
981:08 ClientBegin: 2
981:11 ClientConnect: 3
981:11 ClientUserinfoChanged: 3 n\Fasano Again\t\3\model\razor/id\hmodel\razor/id\g_redteam\\g_blueteam\\c1\3\c2\5\hc\100\w\0\l\0\tt\0\tl\0
981:13 ClientConnect: 4
981:13 ClientUserinfoChanged: 4 n\Isgalamido\t\3\model\xian/default\hmodel\xian/default\g_redteam\\g_blueteam\\c1\4\c2\5\hc\100\w\0\l\0\tt\0\tl\0
981:14 ClientUserinfoChanged: 3 n\Oootsimo\t\3\model\razor/id\hmodel\razor/id\g_redteam\\g_blueteam\\c1\3\c2\5\hc\100\w\0\l\0\tt\0\tl\0
981:14 ClientBegin: 3
981:17 ClientUserinfoChanged: 4 n\Isgalamido\t\3\model\uriel/zael\hmodel\uriel/zael\g_redteam\\g_blueteam\\c1\5\c2\5\hc\100\w\0\l\0\tt\0\tl\0
981:17 ClientBegin: 4
981:19 ClientConnect: 5
981:19 ClientUserinfoChanged: 5 n\Assasinu Credi\t\3\model\james\hmodel\*james\g_redteam\\g_blueteam\\c1\4\c2\5\hc\95\w\0\l\0\tt\0\tl\0
981:21 say: Oootsimo: team red
981:22 ClientUserinfoChanged: 5 n\Assasinu Credi\t\3\model\james\hmodel\*james\g_redteam\\g_blueteam\\c1\4\c2\5\hc\100\w\0\l\0\tt\0\tl\0
981:22 ClientBegin: 5
981:26 say: Isgalamido: team blue
981:27 ShutdownGame: 
```

The parser converts all this information into well structured data, as it follows:

```
game_1: {
  total_kills: 3; 
  players: ["Zeh","Assasinu Credi","Dono da Bola","Oootsimo","Isgalamido"]
  kills: {"Zeh":-3,"Dono da Bola":0,"Oootsimo":0,"Isgalamido":0,"Assasinu Credi":0}
  kills_by_means: {"MOD_TRIGGER_HURT":3}
}

global_ranking: {
  "Assasinu Credi": 0,
  "Dono da Bola": 0,
  "Isgalamido": 0,
  "Oootsimo": 0,
  "Zeh": -3
}

```
