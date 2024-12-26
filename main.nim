import game, ui
import algorithm, sequtils

let 
  answers = game.getAnswers()

var 
  objects: seq[Drawable]

for i in 0..<16:
  objects.add Box(
    content: answers[i],
    x: (i mod 4)*13, y: (i div 4)*5,
    w: answers.sortedByIt(it.len)[^1].len, h: 2).render()

ui.drawLoop(objects,10)

