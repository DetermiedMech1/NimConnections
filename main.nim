import game, ui
import std/[algorithm, 
            sequtils,
            sugar,
            random]

let 
  answers = game.getAnswers()

var 
  objects: seq[Drawable]
  (words, _):(seq[string], bool) = game.checkOptions(answers)
shuffle(words)

ui.drawLoop(objects, 5):
  var i = -1
  objects = collect:
    for word in words:
      inc i
      Box(content: word,
          x: (i mod 4)*13, y: (i div 4)*5,
          w: words.sortedByIt(it.len)[^1].len, h: 2).render()
  

