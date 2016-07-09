breed [ents ent]  ;; creates the turtles plural = set, non-plural = singular

ents-own ;; gives attributes to the turtles
[
  leaves
  roots
  twigs
]

to setup ;; what happens when setup is clicked

  clear-all ;; clears everything from the stage
  
  ask patches [set pcolor red] ;; sets the background of the model to red
  
    if turtle-behaviour = "Default" ;; if the behaviour is set to default use the atwalker shape
  [
    set-default-shape ents "atwalker"
  ]
    
    if turtle-behaviour = "Random Walk" ;; if the behaviour is set to random walk use the atwalker shape
  [
    set-default-shape ents "atwalker"
  ]
    
     if turtle-behaviour = "Collision" ;; if the behaviour is set to collision use the atwalker shape
  [
    set-default-shape ents "atwalker"
  ]   
   
     if turtle-behaviour = "Ent Mode" ;; if the behaviour is set to ent mode use the ent shape
  [
    set-default-shape ents "ent"
  ]
  
  create-ents turtles-to-create ;; creates the amount of ents from the value on the interface

    ask ents ;; changes things for every ent and not just one
  [ 
    set size turtle-size ;; changes the size of the ent depending on the value on the interface
    set color blue ;; changes the colour of the ent to blue
    setxy random-xcor random-ycor ;; makes the ent spawn at a random location
    set leaves 10 ;; sets the attribute leaves to 10
    set roots 5 ;; sets the attribute roots to 5
    set twigs 1 ;; sets the attirubte twigs to 1
    set pen-size turtle-pen-size ;; sets the pen size of the ent depending on the value on the interface
  ]
  
  if pen-down? ;; if the pen is on on the interface
  [
   ask turtles
   [
      set pen-size turtle-pen-size ;; set the size of the pen to be the size on the interface
      pen-down ;; turn pen on the turtles
   ]
  ] 
end

to go ;; code runs until you press the button again
 
 if turtle-behaviour = "Default" ;; if turtle behaviour is default
 [
   set-default-shape ents "atwalker"
   
   ask turtles
   [
   fd 1 ;; turtle moves forward
   ]
 ]
   
 if turtle-behaviour = "Random Walk" ;; if turtle behaviour is random walk
 [
  set-default-shape ents "atwalker"
  ask turtles
  [    
    rt random-float 360 ;; right random 360
    fd random-float 10  ;; forward random 10
    set heading heading + random 15 - random 15 ;; random heading
    lt random-float 360 ;; left random 360
    bk random-float 10 ;; back random 360
    ;; this makes each agent move at random
  ]
 ]
 
 if turtle-behaviour = "Avoidance" ;; if turtle behaviour is avoidance
 [
   set-default-shape ents "atwalker"
     ask turtles
     [
       fd 1 ;; turtle moves forward
       ask other turtles in-radius 2 ;; if another turtle is in-radius of itself by 2
       [
         lt 180 + random 15 - random 15 ;; turn 180 random
       ]
     ]
 ]
  
 if turtle-behaviour = "Ent Mode" ;; if turtle behaviour is ent mode
 [
   ask turtles
   [
     fd 1 ;; turtle moves forward
   ]
     set-default-shape ents "ent" ;; sets shape from the default atwalker to ent  
 ] 
end

to goOnce ;; repeat code but only runs once
  
   if turtle-behaviour = "Default"
 [
   set-default-shape ents "atwalker"
   
   ask turtles
   [
   fd 1
   ]
 ]
   
 if turtle-behaviour = "Random Walk"
 [
  set-default-shape ents "atwalker"
  ask turtles
  [    
    rt random-float 360
    fd random-float 10    
    set heading heading + random 15 - random 15
    lt random-float 360
    bk random-float 10
  ]
 ]
 
 if turtle-behaviour = "Avoidance"
 [
   set-default-shape ents "atwalker"
     ask turtles
     [
       fd 1
       ask other turtles in-radius 2
       [
         lt 180 + random 15 - random 15
       ]
     ]
 ]
  
 if turtle-behaviour = "Ent Mode"
 [
   ask turtles
   [
     fd 1
   ]
     set-default-shape ents "ent"  
 ]   
end
@#$#@#$#@
GRAPHICS-WINDOW
466
10
981
446
50
40
5.0
1
10
1
1
1
0
1
1
1
-50
50
-40
40
0
0
1
ticks
30.0

BUTTON
13
11
76
44
setup
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
13
50
76
83
NIL
go\n
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
8
89
83
122
go once
goOnce\n
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
2
273
174
306
turtles-to-create
turtles-to-create
1
50
21
1
1
NIL
HORIZONTAL

SLIDER
2
237
174
270
turtle-size
turtle-size
4
10
7
1
1
NIL
HORIZONTAL

SWITCH
7
163
124
196
pen-down?
pen-down?
0
1
-1000

BUTTON
1
125
107
158
NIL
clear-drawing
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
2
311
140
356
turtle-behaviour
turtle-behaviour
"Default" "Random Walk" "Avoidance" "Ent Mode"
2

SLIDER
3
200
175
233
turtle-pen-size
turtle-pen-size
1
10
2
1
1
NIL
HORIZONTAL

@#$#@#$#@
## WHAT IS IT?

This model shows the spawning of turtles at a random location, the model includes interface material for changing various attributes.

## HOW IT WORKS

The turtle behaviours all change the behaviour of the movement of the turtle, default moves the turtle forward, random walk moves the turtle in random directions, collision makes it so the turtles cannot collide and ent mode makes the turtles appear as ents.

## HOW TO USE IT

The model works by selecting options on the interface such as how many turtles to spawn, size of turtles and the behaviour of the turtles then pressing the setup button to setup the stage, then presssing the go forever or go buttons for the turtles to start moving!

## THINGS TO NOTICE

Note how the position of the turtles is completely random everytime the setup button is presssed.
Note how random the movement is on spider mode.
Note how the collision  moves both units 180 rather than just one.
Note how ent mode changes the turtles to ent and other beehaviours change it back.
Note how the background changes from default to red the first time you press setup after opening the model.

## EXTENDING THE MODEL

Have random colours.
More behaviours.
Refined collision detection since current collision can have slight glitches at certain angles.

## CREDITS AND REFERENCES
By Michael Smith with reference to the NetLogo User Manual and default models from the model library.
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

atwalker
false
0
Line -7500403 true 90 135 90 210
Line -7500403 true 90 210 75 210
Line -7500403 true 75 210 75 225
Line -7500403 true 75 225 105 225
Line -7500403 true 105 210 105 135
Line -7500403 true 120 210 120 225
Line -7500403 true 120 225 105 225
Line -7500403 true 120 210 105 210
Line -7500403 true 105 135 195 135
Line -7500403 true 195 135 195 210
Line -7500403 true 195 210 180 210
Line -7500403 true 180 210 180 225
Line -7500403 true 180 225 225 225
Line -7500403 true 225 225 225 210
Line -7500403 true 225 210 210 210
Line -7500403 true 210 210 210 135
Line -7500403 true 90 135 75 135
Line -7500403 true 75 135 75 105
Line -7500403 true 75 105 60 105
Line -7500403 true 60 105 60 120
Line -7500403 true 60 120 15 120
Line -7500403 true 15 120 15 90
Line -7500403 true 15 90 30 75
Line -7500403 true 30 75 60 75
Line -7500403 true 60 75 60 90
Line -7500403 true 60 90 75 90
Line -7500403 true 75 90 75 60
Line -7500403 true 75 60 210 60
Line -7500403 true 210 60 225 60
Line -7500403 true 225 60 225 135
Line -7500403 true 225 135 210 135
Rectangle -7500403 true true 75 60 225 135
Rectangle -7500403 true true 90 135 105 210
Rectangle -7500403 true true 75 210 120 225
Rectangle -7500403 true true 195 135 210 210
Rectangle -7500403 true true 180 210 225 225
Rectangle -7500403 true true 60 90 75 105
Polygon -7500403 true true 15 90 30 75 30 90 15 90 30 75 30 90
Rectangle -7500403 true true 30 90 60 120
Rectangle -16777216 true false 15 90 30 90
Rectangle -7500403 true true 15 90 30 120
Rectangle -16777216 true false 30 75 60 90
Polygon -16777216 true false 15 90 30 75
Line -7500403 true 30 75 60 75

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

ent
false
0
Rectangle -14835848 true false 135 90 165 255
Line -14835848 false 135 120 105 120
Line -14835848 false 105 120 105 180
Line -14835848 false 195 120 195 180
Line -14835848 false 195 120 165 120
Circle -16777216 false false 135 105 30
Line -14835848 false 135 255 135 300
Line -14835848 false 165 255 165 300

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
0
Rectangle -7500403 true true 151 225 180 285
Rectangle -7500403 true true 47 225 75 285
Rectangle -7500403 true true 15 75 210 225
Circle -7500403 true true 135 75 150
Circle -16777216 true false 165 76 116

square
false
0
Rectangle -7500403 true true 30 30 270 270

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
Circle -7500403 true true 238 78 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true -25 81 108
Circle -7500403 true true 191 116 127
Circle -7500403 true true 0 15 120
Circle -7500403 true true 74 194 152

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
NetLogo 5.0.5
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
