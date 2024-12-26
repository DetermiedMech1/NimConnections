import std/[json,
            times,
            sequtils,
            sugar]

import connections

type
  Answer* = object
    level: int
    group: string
    members: seq[string]

  Game* = object
    id: int
    date: string
    answers: seq[Answer]


let
    connections_json = connections.getConnections()
    connections_data = connections_json.parseJson
    games = connections_data.mapIt(it.to(Game))

    today = now().format("yyyy-MM-dd")


proc getGame*(date:string = today): Game =
  let filtered = games.filter(proc (g: Game): bool = g.date == today)
  if filtered.len > 0:
    return filtered[0]
  else:
    raise newException(ValueError, "No game found for date: " & date)

proc getAnswers*(game:Game = getGame(today)):seq[string] =
  let all_answers = collect:
    for lvl in getGame().answers:
      lvl.members
    
  return all_answers.foldl(a & b)
