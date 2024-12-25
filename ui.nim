import illwillWidgets
import illwill
import strformat, strutils

proc exitProc() {.noconv.} =
  illwillDeinit()
  showCursor()
  quit(0)

illwillInit(fullscreen=true, mouse=true)
setControlCHook(exitProc)
hideCursor()

var 
  tb = newTerminalBuffer(terminalWidth(), terminalHeight())
  btns: seq[(int, int, Button)]

for i in 0..<16:
  let x = (i mod 4) * 15
  let y = (i div 4) * 4
  btns.add(
    (x, y, newButton("Button", x+1, y+1, 14, 3, true, fgRed))
  )

for btn in btns:
  tb.render(btn[2])

while true:
  tb.display()