import std/[terminal, 
            strutils, 
            sequtils, 
            tables, 
            rdstdin, 
            os]

var
  termh* = terminalHeight()
  termw* = terminalWidth()

proc resetTerminal*() = 
  terminal.eraseScreen()
  terminal.setCursorPos(0, 0)

type
  Box* = object
    content*: string
    x*, y*, w*, h*: int
  Drawable* = object
    x*, y*: int
    layers*: seq[string]

let
  topLeft = ["┌", "╔"]
  topRight = ["┐", "╗"]
  bottomLeft = ["└", "╚"]
  bottomRight = ["┘", "╝"]
  horizontal = ["─", "═"]
  vertical = ["│", "║"]

proc render*(b: Box, double: bool): Drawable =
  var
    layers = @[topLeft[double.int]    & horizontal[double.int].repeat(b.w) & topRight[double.int]] &
                          @[(vertical[double.int]  & " ".repeat(b.w)        & vertical[double.int]    & "\n")].repeat(b.h div 2).foldl(a & b) &
                          @[vertical[double.int]   & b.content.center(b.w)  & vertical[double.int]    & "\n"] &
                          @[(vertical[double.int]  & " ".repeat(b.w)        & vertical[double.int]    & "\n")].repeat(b.h div 2).foldl(a & b) &
                          @[bottomLeft[double.int] & horizontal[double.int].repeat(b.w) & bottomRight[double.int] & "\n",]

  return Drawable(x: b.x, y: b.y, layers: layers)

template drawLoop*(objects:seq[Drawable], redrawDelay:int = 10, body:untyped) =
  hideCursor()
  while true:
    resetTerminal()
    for obj in objects:
      var current_layer = 0

      for layer in obj.layers:
        current_layer.inc

        terminal.setCursorPos(obj.x, obj.y+current_layer)
        echo layer
    
    body

    sleep(redrawDelay)

