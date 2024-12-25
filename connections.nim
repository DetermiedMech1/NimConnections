import 
  std/httpclient

var 
  client = newHttpClient()

proc getConnections*():string =
  var
    connections_json:string
    file = open("connections.json")

  try:
    connections_json = client.getContent("https://raw.githubusercontent.com/Eyefyre/NYT-Connections-Answers/refs/heads/main/connections.json")
    file.write(connections_json)
  except:
    connections_json = file.readAll
    echo "unable to update connections from internet"
  finally:
    file.close

  return connections_json