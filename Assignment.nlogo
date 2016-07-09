breed [drawers drawer]


to setup 

  clear-all ;; clears everything from the stage
  
  ask patches [set pcolor blue] ;; sets the background of the model to blue
     
end

to Examples ;; what happens when Examples is clicked
  
  setup ;; runs setup
  
    
  let r1 1 + random 12 ;; random number between 1 and 12
  let r2 1 + random 12
  let r3 1 + random 12
  
  let n Select_a_Times_Table ;; number carried from the interface
  
  let a1 n * r1 ;; times the interface by the random number
  let a2 n * r2
  let a3 n * r3
  

  ask patch 500 400 ;; coordinates on the screen
  [
    set plabel "Examples of the " ;; printing a string
    set plabel word plabel n ;; adding onto the string with a number
    set plabel word plabel " Times Table" ;; continuing the string with a string
  ] 
    
  ask patch 300 200 ;; different coordinates on the screen
  [
    set plabel n
    set plabel word plabel " x "
    set plabel word plabel r1
    set plabel word plabel " = "
    set plabel word plabel a1
  ]
    
  ask patch 300 100 
  [
    set plabel n
    set plabel word plabel " x "
    set plabel word plabel r2
    set plabel word plabel " = " ;; example question and answers of the sums
    set plabel word plabel a2
  ]
    
  ask patch 300 0 
  [
    set plabel n
    set plabel word plabel " x "
    set plabel word plabel r3
    set plabel word plabel " = "
    set plabel word plabel a3
  ]
   
end

to Explain ;; what happens when Explain is clicked
  
  setup
  
  let r 1 + random 12
  
  let n Select_a_Times_Table
  
  let a n * r
  
  let i 2 ;; set a counter to 2
  
  ask patch 500 400 
  [
    set plabel "Explain the "
    set plabel word plabel n
    set plabel word plabel " Times Table"
  ]
  
  ask patch 300 200 
  [
    set plabel n
    set plabel word plabel " x "
    set plabel word plabel r
    set plabel word plabel " is " ;; explanations of how to work out the sum
    set plabel word plabel r
    set plabel word plabel " sets of "
    set plabel word plabel n
  ]
  
  ask patch 300 100 
  [
    set plabel n
    set plabel word plabel " x "
    set plabel word plabel r
    set plabel word plabel " is "
    set plabel word plabel n
    
    while [i <= r] ;; for when the counter is less than the random number
    [
      set plabel word plabel " + " ;; prints out the correct amount of + for the sum
      set plabel word plabel n
      set i i + 1 ;; increment the counter
    ]
  ]
  ask patch 300 0 
  [
    set plabel n
    set plabel word plabel " x "
    set plabel word plabel r
    set plabel word plabel " = "
    set plabel word plabel a
  ]
  
end


to Question ;; what happens when Question is clicked
  
  setup
  
  let r 1 + random 12
  
  let i 15 
  let j 5 ;; another counter
  
  let n Select_a_Times_Table
  
  let a n * r
  
  ask patch 500 400
  [ 
    set plabel "Test the "
    set plabel word plabel n
    set plabel word plabel " Times Table"  
  ]
  
  ask patch 300 200 
  [
    set plabel "What is "
    set plabel word plabel n
    set plabel word plabel " x " ;; ask what the sum is
    set plabel word plabel r
    set plabel word plabel "?"
  ]
  
  ask patch 300 100 [set plabel "Time Limit"]
  
  while [i >= 0] ;; for when i counter is greater than 0
  [
    every 1 ;; update every second
    [
      ask patch 300 0 [set plabel i] ;; print the timer every second for a countdown
      set i i - 1 ;; decrement i counter
    ]
    
    while [i = 0] ;; when the counter reaches 0
    [
      ask patch 300 100 [set plabel " "]
      
      ask patch 300 0 
      [
        set plabel "Answer: "
        set plabel word plabel a ;; overwrite the timer with the answer to the sum
        set i 0      
      ]
     
      set i 0 
      set j 0 ;; reset the counter
      stop ;; stop the loop
    ]
  ]
  
end

to Test_All ;; what happens when Test_All is clicked
  
  setup
  
  let r 1 + random 12
  
  let i 15
  let j 5
  
  let n 1 + random 12
  
  let a n * r ;; sets the sums to be random between 1 and 12 x random between 1 and 12
  
  ask patch 500 400
  [ 
    set plabel "Test the "
    set plabel word plabel n
    set plabel word plabel " Times Table"  
  ]
  
  ask patch 300 200 
  [
    set plabel "What is "
    set plabel word plabel n
    set plabel word plabel " x "
    set plabel word plabel r
    set plabel word plabel "?"
  ]
  
  ask patch 300 100 [set plabel "Time Limit"]
  
  while [i >= 0]
  [
    every 1
    [
      ask patch 300 0 [set plabel i]
    set i i - 1
    ]
    
    while [i = 0]
    [
      ask patch 300 100 [set plabel " "]
      
      ask patch 300 0 
      [
        set plabel "Answer: "
        set plabel word plabel a
        set i 0      
      ]
      
      set i 0
      set j 0
      stop
    ]
  ]
  
end

to Explain_Shape
  setup
    create-drawers 1 ;; create a turtle called drawer
    
    ask drawers
    [
      setxy -200 -200 ;; set the coordinates to be in about the centre of the screen
      set color white ;; set the colour of the drawer to be white
      set pen-size 10 ;; set the pen-size
      pen-down ;; turn the pen on
      set heading 90 ;; set the heading to be facing N
    ]
    
    
    let sides 0 ;; initialize sides
    
    if Select_a_Shape = "Triangle"
    [
      set sides 3 ;; sets the sides to be whatever the selected Shape is
    ]
  
    if Select_a_Shape = "Square"
    [
      set sides 4
    ]
    
    if Select_a_Shape = "Pentagon"
    [
      set sides 5
    ]
    
    if Select_a_Shape = "Hexagon"
    [
      set sides 6
    ]
    
    if Select_a_Shape = "Heptagon"
    [
      set sides 7
    ]
    
    if Select_a_Shape = "Octagon"
    [
      set sides 8
    ]
    
    ask patch 500 -800 
    [
      set plabel "A "
      set plabel word plabel Select_a_Shape
      set plabel word plabel " is a " ;; information about the shape
      set plabel word plabel sides
      set plabel word plabel " sided shape."
    ]
    
    
    
    let a 360 / sides ;; calculate the angle of how much the turtle needs to turn to draw the sape
    
    let c sides
    
    while [c >= 0] ;; while there are sides to draw
    [
      ask drawers
      [
        fd 6 ;; moves forward
        lt a ;; turns at the calculated angle
        set c c - 1 ;; decrements the amount of sides needed to be drawn
      ]
    ]
    
end

to Draw_Shape
  setup
  create-drawers 1
  
  ask drawers
    [
      setxy -200 -200
      set color white
      set pen-size 10
      pen-down
      set heading 90
    ]
    
    
  let sides 3 + random 6 ;; any side between 3 and 9 (3 + 6)
  
  
  ask patch 500 -800 
    [
      set plabel "What shape is this? "
    ]
    
    
  let a 360 / sides
    
  let c sides
    
  while [c >= 0]
    [
      ask drawers
      [
        fd 6
        lt a ;; draws the random calculated shape using the same method as before
        set c c - 1
      ]
    ]
  
  let side ""
  
  if sides = 3
    [
      set side "Triangle" ;; sets string to be used based on the random side number assigned the sides
    ]
  
  if sides = 4
    [
      set side "Square"
    ]
  
  if sides = 5
  [
    set side "Pentagon"
  ]
  
  if sides = 6
  [
    set side "Hexagon"
  ]
  
  if sides = 7
  [
    set side "Heptagon"
  ]
  
  if sides = 8
  [
    set side "Octagon"
  ]
  
  let i 15
  
  while [i >= 0]
  [
    every 1
    [
      ask patch 500 -1000 [set plabel i]
      set i i - 1
    ]
    
    ask patch 500 -900 [set plabel "Time Limit"] ;; counter before the answer is printed
    
    while [i = 0]
    [
      ask patch 500 -900 [set plabel " "]
      
      ask patch 500 -1000 
      [
        set plabel "Answer: "
        set plabel word plabel side ;; prints the answer
        set i 0      
      ]
      
      set i 0
      
      stop
    ]
  ]  
end
@#$#@#$#@
GRAPHICS-WINDOW
566
98
1005
558
16
16
13.0
1
10
1
1
1
0
1
1
1
-16
16
-16
16
0
0
1
ticks
30.0

CHOOSER
1058
213
1218
258
Select_a_Times_Table
Select_a_Times_Table
12 11 10 9 8 7 6 5 4 3 2 1
4

TEXTBOX
678
41
919
91
Shapes and Times Tables!
20
105.0
0

BUTTON
1052
327
1135
360
NIL
Examples
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
1144
327
1215
360
NIL
Explain
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
1275
144
1425
505
Select a Times Table or Shape\n\nQuestion quizzes you randomly on the selected Times Table.\n\nTest All quizzes you randomly on a random Times Table.\n\nExamples gives you examples of answers for the selected Times Table.\n\nExplain teaches you how you calculate the selected Times Table.
15
0.0
1

BUTTON
1082
273
1196
306
NIL
Question
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
1101
372
1176
405
NIL
Test_All
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
407
278
545
323
Select_a_Shape
Select_a_Shape
"Triangle" "Square" "Pentagon" "Hexagon" "Heptagon" "Octagon"
4

BUTTON
427
338
539
371
NIL
Explain_Shape
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
205
281
355
452
Select a Shape\n\nExplain_Shape explains the selected shape.\n\nDraw_Shape draws a random shape and quizzes you on what the shape is.
15
0.0
1

BUTTON
429
380
531
413
NIL
Draw_Shape
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

The model attempts to teach two different basic concepts of mathematics, times tables and shapes. By providing information and drawing the shapes and providing examples, explanations and mental arithmetic for the times tables.

## HOW IT WORKS

For the most part the model uses simple mathematics to compute the drawings of the shapes diving 360 by the amount of sides to get the angle to turtle needs to turn. For the multiplication the model uses the numbers from the interface to compute and print out the correct values.

## HOW TO USE IT

You select a shape to draw or a times table to compute.
Examples gives you examples questions and answers of that times table. 
Explain teaches you how to work out the answer. 
Question gives you a question with a time limit before the answer shows.
Test All is like question but gives you a random question instead of being limited to the selected Times Table.
Explain_Shape draws the selected shape and gives information about it.
Draw_Shape draws a random shape and quizzes you on what the shape is.

## THINGS TO NOTICE

Notice how you cannot go to the next question until the timer hits 0.
Notice how the shapes drawn are all equilateral.
Notce how the questions are always random and the answer is always correct to the randomness.
Notice how the shapes are always randomly drawn and always correct with the answer.

## THINGS TO TRY

Try using all of the features in different orders to test the clearing of the screen especially the transition from shapes to times table.
Try retesting the random times table and draw features to ensure that it is random and that all of the elmementes are tested.

## EXTENDING THE MODEL

User input; allow the user to input what the shape is or what the answer to the calcuation is.
Score; a tally of correct and incorrect answers.
A test; 20 random questions giving you a % of correct and incorrect answers at the end.
Multiple choice; give possible answers on the screen for the user to choose from and select by clicking.
Buttons; to cycle to the next question or back controlled in the code instead of on the interface.

## NETLOGO FEATURES

Using the following commands:
breed
random
ask
plabel
let
set
while
if
interface numbers/strings carried into code


## RELATED MODELS

Various models in the Mathematics library, especially the fractions model.

## CREDITS AND REFERENCES

By Michael Smith with reference to the NetLogo User Manual and defaul models from the model libary.
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

answersquare
false
0
Rectangle -7500403 true true 0 30 330 90

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

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

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

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
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
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
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270

@#$#@#$#@
NetLogo 5.0.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180

@#$#@#$#@
0
@#$#@#$#@
