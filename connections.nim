import 
  std/httpclient

var 
  client = newHttpClient()

proc getConnections*():string =
  var
    connections_json:string
    file = "connections.json"

  try:
    connections_json = client.getContent("https://raw.githubusercontent.com/Eyefyre/NYT-Connections-Answers/refs/heads/main/connections.json")
  except:
    echo "unable to update connections from internet"
    connections_json = file.readFile
  finally:
    file.writeFile(connections_json)

  return connections_json