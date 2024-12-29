import game, tui
import std/[algorithm, 
            sequtils,
            sugar,
            random]

let 
  answers = game.getAnswers()

var 
  objects: seq[Drawable]
  (words, _) = game.checkOptions(answers)
  choices: seq[string]

shuffle(words)

tui.drawLoop(objects, 10):
  var i = -1
  let longest = words.sortedByIt(it.len)[^1]

  objects = collect:
    for word in words:
      inc i
      Box(content: word,
          x: (i mod 4)*(longest.len+4), y: (i div 4)*5,
          w: longest.len+2, h: 2).render(choices.contains word)
  

