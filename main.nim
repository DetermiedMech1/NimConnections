import game, ui
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

ui.drawLoop(objects, 10):
  var i = -1
  objects = collect:
    for word in words:
      inc i
      Box(content: word,
          x: (i mod 4)*13, y: (i div 4)*5,
          w: words.sortedByIt(it.len)[^1].len, h: 2).render(choices.contains word)
  
  choices.add stdin.readLine()
  if choices.len == 4: 
    words = (game.checkOptions(answers,choices))[0]
    let ok = (game.checkOptions(answers,choices))[1]
    echo ok
    choices = @[]
  

