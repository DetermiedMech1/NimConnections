import illwill
import std/[json,times,sequtils]
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


proc getLatestGame*(): Game =
  let filtered = games.filter(proc (g: Game): bool = g.date == today)
  if filtered.len > 0:
    return filtered[0]
  else:
    raise newException(ValueError, "No game found for today")