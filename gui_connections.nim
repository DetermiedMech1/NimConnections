# This example shows some possibilities to align controls with a LayoutContainer.

import nigui, game, sequtils, sugar

app.init()

let 
  answers = game.getAnswers()

var 
  words = game.checkOptions(answers)[0]

var 
    mainContainer = newLayoutContainer(Layout_Vertical)
    i = -1

for y in 0..<4:
    var 
        innerContainer = newLayoutContainer(Layout_Horizontal)
    innerContainer.xAlign = XAlign_Center
    innerContainer.widthMode = WidthMode_Expand

    for x in 0..<4:
        inc i
        var btn = newButton(words[i])
        btn.width = 100
        btn.height = 100
        btn.widthMode = WidthMode_Expand
        innerContainer.add(btn)
    
    mainContainer.add(innerContainer)

var window = newWindow()
window.width = 800
window.height = 600
window.add(mainContainer)
window.show()

app.run()

