extensions [exec sound]

breed [agents agent]
breed [cells cell]
breed [snakes snake]
breed [spiders spider]
breed [texts text]
breed [buttons button]

globals
[
  test-score           ; current score in the test
  test-count           ; number of questions
  test-results-list    ; the list of results for the test
  game-score           ; current score in the game
  game-setup?          ; true when the game has already been setup
  label-count          ; for setting the cell label numbers
]

snakes-own [illness]   ; used to kill off the snake slowly after its eaten a spider
spiders-own [kills]    ; number of kills that the spider has made
cells-own [perimeter?] ; true if the cell is one the perimeter

to setup
  clear-all
  ask patches
  [ set pcolor green + 3 ]

  set test-score 0
  set test-count 0
  set test-results-list []
  set game-score 0
  set game-setup? false
end
  
to go-explain
  setup
  wait 0.3
  clear-output
  output-print ""
  output-and-speak-explanation "If you move in a vertical direction, you move either up or down. "

  wait 0.5  
  setup-agent 40 turtle-shape blue -30 -75 0 "vertical "
  setup-agent 40 turtle-shape blue 30 165 180 "vertical "
  move-agents (agents with [label = "vertical "]) turtle-speed 240 true

  output-print ""
  output-and-speak-explanation "This is at right angles (perpendicular) to the horizontal direction where you move either left or right."
  
  setup-agent 40 turtle-shape magenta -120 -120 90 "horizontal"
  setup-agent 40 turtle-shape magenta 120 -165 270 "horizontal"
  move-agents (agents with [label = "horizontal"]) turtle-speed 240 true  
end

to go-show
  setup

  setup-block-shape
  wait 0.4

  clear-output
  output-print ""
  output-and-speak-explanation (word
    "To calculate the area of the surface shown, count the number of "
    "square units inside the surface. If the length of the side of one "
    "of the square units shown is 1 centimeter, then the area of the "
    "surface in the example is " (count cells) " square centimeters as there are "
    (count cells) " cells within the surface. (See the animation).")
  foreach sort cells
  [
    ask ? [ set label (word (who + 1)) ]
    wait 0.01
  ]
  wait 0.4
  output-print ""
  output-and-speak-explanation (word
    "To calculate the perimeter instead of the area, simply count the "
    "number of cells that are on the outside of the surface. For the "
    "example shown, there are " (count cells with [perimeter? = true])
    " cells on the outside of the surface. (Again, see the animation).")

  ask cells ; clear all the labels
  [ set label "" ]

  set label-count 1
  label-cell-row 0.05 true -8 0 8
  label-cell-column 0.05 true 0 4 8
  label-cell-row 0.05 true 0 6 4
  label-cell-column 0.05 true 6 0 4
  label-cell-row 0.05 false 0 6 0
  label-cell-column 0.05 true 0 -4 0
  label-cell-row 0.05 true 0 8 -4
  label-cell-column 0.05 true 8 -8 -4
  label-cell-row 0.05 false -4 8 -8
  label-cell-column 0.05 false -4 -8 0
  label-cell-row 0.05 false -8 -4 0
  label-cell-column 0.05 false -8 0 8
  
;  foreach sort cells with [ perimeter? = true ]
;  [
;    ask ? [ set label (word p) ]
;    set p p + 1
;  ]
end

to go-play
  set game-score game-score + 0.001

  ifelse (game-setup? = 0) or not game-setup?
    [ setup-game ]
    [ if (count snakes = 0)
        [
          set game-setup? false
          user-message (word "Game over. Your score was " (precision game-score 0) ".")
          stop
        ]
    ]
  if (count spiders = 0)
    [ create-spiders 1 [ setup-spider true false ]]

  ask turtles
  [
    ifelse (pen-down?)
      [ pen-down ]
      [ pen-up ]
  ]

  ask snakes
  [
    if (illness > -1)
      [
        set illness illness + 1
        ifelse (illness = 10000)
          [ die ]
          [ set color scale-color (brown - 1) illness 0 10000 ]
      ]
  ]
  play-move
end

to go-test
  setup

  output-print ""
  output-explanation "Be sure to check your answers before submitting."

  setup-multi-choice-question "1. Which of the following is normally vertical?"
    ["the side of a building;" "the floor of a room;" "posts of a fence;" "carpet on a floor."]
    93 [-20 -35 -57 -51]
  display
  wait 0.5
  ask-the-question
  check-the-answer 1 [0 2] (word
    "The correct answers were the first (the side of a building) "
    "and the third (the carpet on a floor) which are both "
    "in the vertical direction.")
  clear-the-question

  setup-multi-choice-question "2. Which of the following is normally horizontal?"
    ["the side of a building;" "the floor of a room;" "posts of a fence;" "carpet on a floor."]
    113 [-20 -35 -57 -51]
  display
  wait 0.5
  ask-the-question
  check-the-answer 2 [1 3] (word
    "The correct answers were the second (the floor of a room) "
    "and the fourth (the carpet on a floor) which are both "
    "in the horizontal direction.")
  clear-the-question

  clear-output
  output-print "The results of the test are as follows:\n"

  foreach test-results-list
  [ output-explanation ? ]
  
  output-print (word "Overall percentage-score: " precision test-result 1 " %.")
end

to-report test-result
  report 100 * test-score / test-count
end

to go-check
  clear-output
  output-and-speak-explanation (word
    "If the direction is going in the up or down direction "
    "(like a rocket or elevator), then the direction is vertical. ")
  output-print ""
  output-and-speak-explanation (word
    "If the direction is going across from right to left or from "
    "left to right (like a carpet on the floor of a room, or a "
    "car moving at right angles to yourself), then the direction is horizontal.")
  output-print ""
end

to go-activities

  clear-output
  output-and-speak-explanation "Activity 1."
  output-print ""
  output-and-speak-explanation (word
      "Try thinking of other examples of things that go up or down "
      "in a vertical direction or across in a horizontal "
      "direction. ")
  output-print ""
  output-and-speak-explanation "Activity 2."
  output-print ""
  output-and-speak-explanation (word
      "In the examples you thought of for Activity 1, "
      "find further examples in the opposite direction. "
      "If you thought of an example in the vertical "
      "direction, think of something that runs "
      "perpendicular to it in the horizontal direction, "
      "and vice versa.")
end

to setup-patch-row [colour start-x end-x y]
; Colours a row of patches in row y from start-x to end-x.

  ask patches with [pycor = y]
  [ if (pxcor >= start-x) and (pxcor <= end-x)
      [ set pcolor colour ]
  ]
end

to setup-patch-column [colour x start-y end-y]
; Colours a column of patches in column x from start-y to end-y.

  ask patches with [pxcor = x]
  [ if (pycor >= start-y) and (pycor <= end-y)
      [ set pcolor colour ]
  ]
end

to label-cell-row [wait-time ascending? start-x end-x y]
; Labels a row of cells in row y from start-x to end-x.

  let cells-list []
  if-else (ascending?)
    [ set cells-list sort-on [who] cells with [(ycor = y) and (xcor >= start-x) and (xcor <= end-x)]]
    [ set cells-list sort-by [[who] of ?1 > [who] of ?2] cells with [(ycor = y) and (xcor >= start-x) and (xcor <= end-x)]]
  foreach cells-list
  [
    ask ?
    [ if (label = "")
        [ set label (word label-count)
          set label-count label-count + 1 ]
    ]
    wait wait-time
  ]
end

to label-cell-column [wait-time ascending? x start-y end-y]
; Labels a column of cells in column x from start-y to end-y.

  let cells-list []
  if-else (ascending?)
    [ set cells-list sort-on [who] cells with [(pxcor = x) and (pycor >= start-y) and (pycor <= end-y)]]
    [ set cells-list sort-by [[who] of ?1 > [who] of ?2] cells with [(pxcor = x) and (pycor >= start-y) and (pycor <= end-y)]]
  foreach cells-list
  [
    ask ?
    [ if (label = "")
        [ set label (word label-count)
          set label-count label-count + 1 ]
    ]
    wait wait-time
  ]
end
to setup-cell-row [colour start-x end-x y]
; Colours a row of cell agents in row y from start-x to end-x.

  let x start-x
  while [x <= end-x]
  [
    create-cells 1
    [
      set shape "square 3"
      set size 1
      set color colour
      setxy x y
    ]
    set x x + 1
  ]
end

to setup-block-shape

  setup-patch-row blue -8 0 8
  setup-patch-column blue 0 4 8
  setup-patch-row blue 0 6 4
  setup-patch-column blue 6 0 4
  setup-patch-row blue 0 6 0
  setup-patch-column blue 0 -4 0
  setup-patch-row blue 0 8 -4
  setup-patch-column blue 8 -8 -4
  setup-patch-row blue -4 8 -8
  setup-patch-column blue -4 -8 0
  setup-patch-row blue -8 -4 0
  setup-patch-column blue -8 0 8
  
  setup-cell-row (gray + 1) -8 0 8
  setup-cell-row (gray + 1) -8 0 7
  setup-cell-row (gray + 1) -8 0 6
  setup-cell-row (gray + 1) -8 0 5
  setup-cell-row (gray + 1) -8 6 4
  setup-cell-row (gray + 1) -8 6 3
  setup-cell-row (gray + 1) -8 6 2
  setup-cell-row (gray + 1) -8 6 1
  setup-cell-row (gray + 1) -8 6 0
  setup-cell-row (gray + 1) -4 0 -1
  setup-cell-row (gray + 1) -4 0 -2
  setup-cell-row (gray + 1) -4 0 -3
  setup-cell-row (gray + 1) -4 8 -4
  setup-cell-row (gray + 1) -4 8 -5
  setup-cell-row (gray + 1) -4 8 -6
  setup-cell-row (gray + 1) -4 8 -7
  setup-cell-row (gray + 1) -4 8 -8
  
  ask cells
  [ set perimeter? ([pcolor] of patch-here = blue)
    ask patch-here
    [ set pcolor blue ]
;    if (perimeter?)
;      [
;        set shape "square 4"
;        set color sky
;      ]
  ]
end

to setup-agent [this-size this-shape this-colour this-xcor this-ycor this-heading this-label]

  create-agents 1
  [
    set color this-colour
    set size this-size
    set shape this-shape
    set pen-size 3
    setxy this-xcor this-ycor
    set label this-label
    set label-color black
    set heading this-heading
  ]
end

to move-agents [these-agents this-speed this-distance pendown?]

  let repetitions (this-distance / this-speed)
  repeat repetitions
  [
    ask these-agents
    [
      if (pendown?)
        [ pen-down ]
      fd this-speed ]
  ]
end
  
to setup-game
  
  setup
  set game-setup? true
  setup-snakes 5
  create-spiders 5 [ setup-spider true false ]
  ask one-of spiders
  [ set shape "redback spider" ]

  clear-output
  output-print ""
  output-explanation (word
    "Get the snakes to catch and eat the black spiders. "
    "Watch out for the redback spiders, though. They will bite "
    "the snake instead, and the snake will get ill and die.")
  output-print ""
  output-explanation (word
    "Try to keep the snakes from being bitten by the redback "
    "spiders as long as possible.")
  output-print ""
end

to setup-snakes [number]

  let h 0 ; set heading up
  ifelse (count snakes != 0)
    [ set h [heading] of one-of spiders ]
    [
      if (random 2 = 0)
        [ set h 90 ] ; set heading to the right
    ]

  create-snakes number
  [
    set size 50
    set heading h
    set shape "snake"
    setxy random-xcor random-ycor
    set color brown - 1
    set illness -1
  ]
end

to play-move

  ask snakes
  [
    fd turtle-speed
  ]
    
  ask spiders
  [ fd turtle-speed
    if (random 20 = 0)
      [ set heading heading + random 10 - random 10 ]
  ]
  ask spiders
  [
    let these-snakes snakes in-radius 10 with [illness = -1]
    ; print count these-snakes
    if (count these-snakes > 0)
      [
        if (shape = "spider") ; not a redback spider
          [ set game-score game-score + 100 ; get lots of points for eating a spider
            die ]
        
        set kills kills + 1
        if (kills mod 2 = 0)
          [ hatch-spiders 1 [ setup-spider false true ]]
        ask one-of these-snakes
        [ set illness 500 ] ; start at "age" 100 so that scale-color is not too dark
        sound:play-note "CRYSTAL" 60 64 1
        wait 0.5
      ]
  ]
end

to setup-spider [anywhere? redback?]
; Initialises a spider.

  set size 30
  set color gray - 4
  ifelse (redback?)
    [ set shape "redback spider" ]
    [ set shape "spider" ]
  
  if (anywhere?)
    [ setxy random-xcor * 0.8 random-ycor * 0.8 ] 
  set kills 0
end

to play-vertical-up
  ask snakes
  [ set heading 0 ]
end

to play-vertical-down
  ask snakes
  [ set heading 180 ]
end

to play-horizontal-left
  ask snakes
  [ set heading 270 ]
end

to play-horizontal-right
  ask snakes
  [ set heading 90 ]
end

to output-explanation-list [text-list-to-be-output]
; Writes out the text list to the output box.

  foreach text-list-to-be-output
  [ output-print ? ]
end

to output-explanation [text-to-be-output]
; Outputs the text string text-to-be-output to the output box.

  let text-list split-text-into-list 52 text-to-be-output
  output-explanation-list text-list
end

to speak-explanation [text-to-be-spoken]
; Speaks the text specified by text-to-be-spoken.

  let command (word "say -v " voice-to-be-spoken " \"" text-to-be-spoken "\"")
  exec:run command
end

to output-and-speak-explanation [text-to-be-spoken]

  output-explanation text-to-be-spoken
  speak-explanation text-to-be-spoken
end

to-report split-text-into-list [width text]
; Splits the text into separate sub-texts each less than width in length
; with the slits occuring at word boundaries.

; Make sure that width is always >= max. word length.

  let p 0
  let pp 0
  let space 0
  let this-list []
  let subtext ""

  set text (word text " ") ; ensure space at end of text
  repeat length text
  [
    if (p - pp + 1 > width)
      [
        set subtext substring text pp space
        set pp space + 1
        set this-list lput subtext this-list
      ] 
    if (item p text = " ")
      [ set space p ]
    set p p + 1
  ]
  set subtext substring text pp space
  set this-list lput subtext this-list

  report this-list
end

to setup-text [x y this-text]

  create-texts 1
  [
    set size 0
    set color black
    set label-color black
    setxy x y
    set label this-text
  ]
end

to setup-button [x y this-shape this-size this-colour this-text]
; Initialises a button.

  create-buttons 1
  [
    set shape this-shape
    set size this-size
    set color this-colour
    if (this-text != "")
      [
        set label this-text
        set label-color black
      ]
    setxy x y
  ]
end

to setup-ok-button
; Setups the OK button at the bottom of the environment.

  setup-button -180 -165 "square ok" 50 (gray + 2) ""
  setup-text 120 -170 "Click in this box to submit your answer."
end

to setup-multi-choice-question [question choices-list x xcor-list]

  let p 0
  let y 140

  setup-ok-button
  setup-text x 180 question
  foreach choices-list
  [
    setup-button -190 y "radial button" 30 black ""
    setup-text (item p xcor-list) (y - 3) ?
    set y y - 30
    set p p + 1
  ]
end

to ask-the-question
  let ok false
  let x 0
  let y 0
  let these-buttons nobody
  let click? false

  while [not ok]
  [
    ifelse (not mouse-down?)
      [ set click? false ]
      [
        if (not click?)
          [
            set click? true
            set x mouse-xcor
            set y mouse-ycor
            ask patch x y
            [
              set these-buttons buttons in-radius 20
              if (count these-buttons > 0)
                [
                  ask one-of these-buttons
                  [
                    ifelse (shape = "square ok")
                      [ set ok true ]
                      [ ifelse (shape = "radial button")
                        [ set shape "radial button 1" ] ; toggle radial button
                        [ if (shape = "radial button 1")
                          [ set shape "radial button" ] ; toggle radial button
                        ]
                      ]
                  ]
                  display
                ]
            ]
          ]
      ]
  ]
end

to check-the-answer [question-no answer-list explanation]

  let answers []
  let answer 0
  ask buttons with [shape = "radial button 1"]
  [
    set answer (140 - ycor) / 30
    set answers lput answer answers
  ]
  set answers sort answers

  set test-count test-count + 1
  ifelse (answers = answer-list)
    [
      set test-results-list lput
        (word "Q" question-no " Answer was correct.\n") test-results-list
      set test-score test-score + 1
    ]
    [
      set test-results-list lput
        (word "Q" question-no " Incorrect answer. " explanation "\n") test-results-list
    ]
end

to clear-the-question

  ask texts
  [ die ]
  ask buttons
  [ die]
  ask patches
  [ set pcolor green + 3 ]
end
@#$#@#$#@
GRAPHICS-WINDOW
191
10
661
461
11
10
20.0
1
10
1
1
1
0
1
1
1
-11
11
-10
10
0
0
1
ticks
30.0

BUTTON
3
163
188
223
Let me explain it to you
go-explain
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

TEXTBOX
13
38
166
100
Area and Perimeter
22
0.0
1

SLIDER
665
374
801
407
turtle-speed
turtle-speed
0.01
1
0.04
0.01
1
NIL
HORIZONTAL

BUTTON
3
283
187
343
Let me test you
go-test
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
3
223
187
283
Play with me
go-play
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

CHOOSER
665
328
801
373
turtle-shape
turtle-shape
"default" "turtle" "spider" "squirrel" "bug" "ant 2" "car" "balloon"
0

OUTPUT
665
33
1123
320
14

TEXTBOX
665
10
815
30
Our Conversation:
16
112.0
1

BUTTON
797
416
975
476
How to check your answers
go-check
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

CHOOSER
813
330
963
375
voice-to-be-spoken
voice-to-be-spoken
"Agnes" "Albert" "Alex" "Bruce" "Vicki" "Victoria"
2

TEXTBOX
9
10
159
32
Learn About:
18
113.0
1

BUTTON
3
104
188
163
Let me show you some examples
go-show
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
192
466
298
499
Vertical Up
play-vertical-up
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
298
466
415
499
Vertical Down
play-vertical-down
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
415
466
527
499
Horizontal Left
play-horizontal-left
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
527
466
643
499
Horizontal Right
play-horizontal-right
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SWITCH
813
375
963
408
pen-down?
pen-down?
1
1
-1000

BUTTON
663
416
797
476
Some Activities for you
go-activities
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
976
329
1084
374
Score for Game
game-score
0
1
11

BUTTON
992
416
1085
475
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
3
343
187
405
Chat with me
go-chat
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

ant 2
true
0
Polygon -7500403 true true 150 19 120 30 120 45 130 66 144 81 127 96 129 113 144 134 136 185 121 195 114 217 120 255 135 270 165 270 180 255 188 218 181 195 165 184 157 134 170 115 173 95 156 81 171 66 181 42 180 30
Polygon -7500403 true true 150 167 159 185 190 182 225 212 255 257 240 212 200 170 154 172
Polygon -7500403 true true 161 167 201 150 237 149 281 182 245 140 202 137 158 154
Polygon -7500403 true true 155 135 185 120 230 105 275 75 233 115 201 124 155 150
Line -7500403 true 120 36 75 45
Line -7500403 true 75 45 90 15
Line -7500403 true 180 35 225 45
Line -7500403 true 225 45 210 15
Polygon -7500403 true true 145 135 115 120 70 105 25 75 67 115 99 124 145 150
Polygon -7500403 true true 139 167 99 150 63 149 19 182 55 140 98 137 142 154
Polygon -7500403 true true 150 167 141 185 110 182 75 212 45 257 60 212 100 170 146 172

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

balloon
false
0
Circle -7500403 true true 54 -6 192
Polygon -7500403 true true 60 120 105 225 120 285 180 285 195 225 240 120

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

car cross
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58
Polygon -2674135 true false 30 30 285 255 270 270 15 45 30 30
Polygon -2674135 true false 15 255 270 30 285 45 30 270

caterpillar
true
0
Polygon -7500403 true true 165 210 165 225 135 255 105 270 90 270 75 255 75 240 90 210 120 195 135 165 165 135 165 105 150 75 150 60 135 60 120 45 120 30 135 15 150 15 180 30 180 45 195 45 210 60 225 105 225 135 210 150 210 165 195 195 180 210
Line -16777216 false 135 255 90 210
Line -16777216 false 165 225 120 195
Line -16777216 false 135 165 180 210
Line -16777216 false 150 150 201 186
Line -16777216 false 165 135 210 150
Line -16777216 false 165 120 225 120
Line -16777216 false 165 106 221 90
Line -16777216 false 157 91 210 60
Line -16777216 false 150 60 180 45
Line -16777216 false 120 30 96 26
Line -16777216 false 124 0 135 15

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

rabbit
true
0
Polygon -7500403 true true 61 150 76 180 91 195 103 214 91 240 76 255 61 270 76 270 106 255 132 209 151 210 181 210 211 240 196 255 181 255 166 247 151 255 166 270 211 270 241 255 240 210 270 225 285 165 256 135 226 105 166 90 91 105
Polygon -7500403 true true 75 164 94 104 70 82 45 89 19 104 4 149 19 164 37 162 59 153
Polygon -7500403 true true 64 98 96 87 138 26 130 15 97 36 54 86
Polygon -7500403 true true 49 89 57 47 78 4 89 20 70 88
Circle -16777216 true false 37 103 16
Line -16777216 false 44 150 104 150
Line -16777216 false 39 158 84 175
Line -16777216 false 29 159 57 195
Polygon -5825686 true false 0 150 15 165 15 150
Polygon -5825686 true false 76 90 97 47 130 32
Line -16777216 false 180 210 165 180
Line -16777216 false 165 180 180 165
Line -16777216 false 180 165 225 165
Line -16777216 false 180 210 210 240

radial button
true
0
Circle -7500403 false true 69 69 162
Circle -7500403 false true 90 90 120

radial button 1
true
0
Circle -7500403 false true 69 69 162
Circle -7500403 false true 90 90 120
Circle -2674135 true false 97 97 106

redback spider
true
0
Polygon -7500403 true true 134 255 104 240 96 210 98 196 114 171 134 150 119 135 119 120 134 105 164 105 179 120 179 135 164 150 185 173 199 195 203 210 194 240 164 255
Line -7500403 true 167 109 170 90
Line -7500403 true 170 91 156 88
Line -7500403 true 130 91 144 88
Line -7500403 true 133 109 130 90
Polygon -7500403 true true 167 117 207 102 216 71 227 27 227 72 212 117 167 132
Polygon -7500403 true true 164 210 158 194 195 195 225 210 195 285 240 210 210 180 164 180
Polygon -7500403 true true 136 210 142 194 105 195 75 210 105 285 60 210 90 180 136 180
Polygon -7500403 true true 133 117 93 102 84 71 73 27 73 72 88 117 133 132
Polygon -7500403 true true 163 140 214 129 234 114 255 74 242 126 216 143 164 152
Polygon -7500403 true true 161 183 203 167 239 180 268 239 249 171 202 153 163 162
Polygon -7500403 true true 137 140 86 129 66 114 45 74 58 126 84 143 136 152
Polygon -7500403 true true 139 183 97 167 61 180 32 239 51 171 98 153 137 162
Circle -2674135 true false 120 165 60

rocket
true
0
Polygon -7500403 true true 120 165 75 285 135 255 165 255 225 285 180 165
Polygon -1 true false 135 285 105 135 105 105 120 45 135 15 150 0 165 15 180 45 195 105 195 135 165 285
Rectangle -7500403 true true 147 176 153 288
Polygon -7500403 true true 120 45 180 45 165 15 150 0 135 15
Line -7500403 true 105 105 135 120
Line -7500403 true 135 120 165 120
Line -7500403 true 165 120 195 105
Line -7500403 true 105 135 135 150
Line -7500403 true 135 150 165 150
Line -7500403 true 165 150 195 135

sheep
false
0
Rectangle -7500403 true true 151 225 180 285
Rectangle -7500403 true true 47 225 75 285
Rectangle -7500403 true true 15 75 210 225
Circle -7500403 true true 135 75 150
Circle -16777216 true false 165 76 116

snake
true
0
Polygon -7500403 true true 135 0 150 0 165 15 195 75 180 120 165 165 165 210 180 240 180 285 165 315 150 315 150 285 135 240 120 165 120 120 90 75 120 15
Circle -16777216 true false 105 45 30
Circle -16777216 true false 150 45 30

spider
true
0
Polygon -7500403 true true 134 255 104 240 96 210 98 196 114 171 134 150 119 135 119 120 134 105 164 105 179 120 179 135 164 150 185 173 199 195 203 210 194 240 164 255
Line -7500403 true 167 109 170 90
Line -7500403 true 170 91 156 88
Line -7500403 true 130 91 144 88
Line -7500403 true 133 109 130 90
Polygon -7500403 true true 167 117 207 102 216 71 227 27 227 72 212 117 167 132
Polygon -7500403 true true 164 210 158 194 195 195 225 210 195 285 240 210 210 180 164 180
Polygon -7500403 true true 136 210 142 194 105 195 75 210 105 285 60 210 90 180 136 180
Polygon -7500403 true true 133 117 93 102 84 71 73 27 73 72 88 117 133 132
Polygon -7500403 true true 163 140 214 129 234 114 255 74 242 126 216 143 164 152
Polygon -7500403 true true 161 183 203 167 239 180 268 239 249 171 202 153 163 162
Polygon -7500403 true true 137 140 86 129 66 114 45 74 58 126 84 143 136 152
Polygon -7500403 true true 139 183 97 167 61 180 32 239 51 171 98 153 137 162

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 1
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 false false 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

square 3
false
0
Rectangle -7500403 false true 15 15 285 285

square 4
false
15
Rectangle -7500403 false false 15 15 285 285
Rectangle -1 true true 15 15 285 285

square ok
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 false false 30 30 270 270
Circle -7500403 true true 60 105 90
Circle -16777216 true false 51 96 108
Circle -7500403 true true 75 120 60
Rectangle -16777216 true false 173 97 193 204
Polygon -16777216 true false 191 138 222 97 249 96 201 155 198 148 255 205 227 204 188 169

squirrel
false
0
Polygon -7500403 true true 87 267 106 290 145 292 157 288 175 292 209 292 207 281 190 276 174 277 156 271 154 261 157 245 151 230 156 221 171 209 214 165 231 171 239 171 263 154 281 137 294 136 297 126 295 119 279 117 241 145 242 128 262 132 282 124 288 108 269 88 247 73 226 72 213 76 208 88 190 112 151 107 119 117 84 139 61 175 57 210 65 231 79 253 65 243 46 187 49 157 82 109 115 93 146 83 202 49 231 13 181 12 142 6 95 30 50 39 12 96 0 162 23 250 68 275
Polygon -16777216 true false 237 85 249 84 255 92 246 95
Line -16777216 false 221 82 213 93
Line -16777216 false 253 119 266 124
Line -16777216 false 278 110 278 116
Line -16777216 false 149 229 135 211
Line -16777216 false 134 211 115 207
Line -16777216 false 117 207 106 211
Line -16777216 false 91 268 131 290
Line -16777216 false 220 82 213 79
Line -16777216 false 286 126 294 128
Line -16777216 false 193 284 206 285

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -8630108 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -8630108 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -8630108 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -8630108 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -8630108 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -7500403 true true 135 285 195 285 270 90 30 90 105 285
Polygon -7500403 true true 270 90 225 15 180 90
Polygon -7500403 true true 30 90 75 15 120 90
Circle -1 true false 183 138 24
Circle -1 true false 93 138 24

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270

@#$#@#$#@
NetLogo 5.0.2
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 1.0 0.0
0.0 1 1.0 0.0
0.2 0 1.0 0.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180

@#$#@#$#@
0
@#$#@#$#@
