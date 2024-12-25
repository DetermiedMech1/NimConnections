import illwill
import std/[json,times]
import connections

let
    connections_json = connections.getConnections()
    connections_data = connections_json.parseJson

    today = now().format("yyyy-MM-dd")

for game in connections_data:
    echo game{"date"}