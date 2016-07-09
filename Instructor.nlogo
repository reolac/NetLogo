; Instructor model.
;
; For illustrating how some NetLogo commands work. The analogy is of
; a driving "instructor" aiding the user to learn how to drive the turtle

;
; Copyright 2011 William John Teahan. All Rights Reserved.
;

; To do:
; 1. Allow user-entered programs.

breed [turtle-agents turtle-agent] ; these are turtle agents that execute the instructions

; breeds used defining event maps
breed [states state]               ; for defining a state in the event map
directed-link-breed [paths path]   ; for defining a path in the event map
breed [walkers walker]             ; for turtle to walk around the event map

states-own 
[ depth       ;; depth in the tree
  stream      ;; the name of the stream of sensory or motor events
  event       ;; the sensory or motor event
]

globals
[
  these-turtle-instructions           ;; list tht defines the turtle instructions that need to be execute each tick
                                      ;; this needs to be a list rather than a single string as we need to display each
                                      ;; instruction being executed in the event map if required
  neighbour                           ;; for storing the nearest neighbour of a turtle
  root-colour node-colour link-colour ;; defines how the event map gets visualised
]

to add-turtles
  
  let this-who 0
  ; add the turtle that executes the instructions
  if (these-turtle-instructions = 0)
    [
      user-message "You need to press one of buttons on the left first to load the instructions."
      stop
    ]
  create-turtle-agents turtles-to-add
  [
    set this-who who
    if (show-who-numbers?)
      [
        set label (word this-who "   ")
        set label-color black
      ]
    set size 6
    set heading 0
    if (not add-at-origin?)
      [ ifelse random-locations?
          [ setxy random-xcor random-ycor ]
          [ while [not mouse-down?] []
            setxy mouse-xcor mouse-ycor ]
      ]
    set color magenta
    set pen-size turtle-pen-size
    pen-down
  ]
  ; add the turtle that walks through the event map
  create-walkers 1
  [
    if (show-who-numbers?)
      [
        set label (word this-who "   ")
        set label-color black
      ]
    if (count states with [hidden? = true] > 0)
      [ hide-turtle ] ; hide walkers as well if the states are hidden
    set size 3
    set color blue
    let this-state one-of states with [count in-path-neighbors = 0]
    let that-state one-of [out-path-neighbors] of this-state
    move-to this-state
    set heading towards that-state
  ]  
end

to setup
  clear-all ;; clear everything
    
  ask patches
  [ set pcolor white] ; paint environment white

  set-default-shape states "circle 2"
  set root-colour magenta - 1
  set node-colour magenta - 1
  set link-colour magenta - 1
end

to go
; Make the model go by directing each turtle to execute the turtle instructions.

  if (count turtle-agents = 0)
    [
      user-message "You need to add one or more turtles into the environment first using the add-turtle button."
      stop
    ]
  ask turtle-agents
  [
    if (these-turtle-instructions = 0)
      [
        user-message "You need to press one of buttons on the left first to load the instructions."
        stop
      ]
    if (change-heading-angle != 0) and (change-tick-interval != 0) and
       (ticks mod change-tick-interval = 0)
      [ ; change the heading periodically if requested
        set heading heading + change-heading-angle
      ]

    let d 0
    foreach these-turtle-instructions
    [
      run ? ; execute the instruction
      
      ; make the walkers move through the event map states to illustrate the "state" of the execution
      ask walkers
      [
        let this-state one-of states with [depth = d]
        if (this-state != nobody)
          [ move-to this-state ]
        display
      ]
      set d d + 1
    ]
  ]
  tick
  display
end

to setup-sun
; Draws a "sun" pattern.

  hide-states
  set these-turtle-instructions
    (list
      "fd 10"
      "rt 10"
      "fd 10"
      "rt 90"
      "set color color + 10"
    )
  set turtle-instructions to-string-instructions these-turtle-instructions
  create-events these-turtle-instructions
end

to setup-square
;; Draws a square.

  hide-states
  set these-turtle-instructions
    (list
      "fd 20"
      "rt 90"
      "fd 20"
      "rt 90"
      "fd 20"
      "rt 90"
      "fd 20"
      "rt 90"
      "set color color + 10"
    )
  set turtle-instructions to-string-instructions these-turtle-instructions
  create-events these-turtle-instructions
end

to setup-rectangle
;; Draws a rectangle.

  hide-states
  set these-turtle-instructions
    (list
      "fd 20"
      "rt 90"
      "fd 20"
      "rt 90"
      "fd 20"
      "set color color + 10"
    )
  set turtle-instructions to-string-instructions these-turtle-instructions
  create-events these-turtle-instructions
end

to setup-triangle
;; Draws an equilateral triangle.

  hide-states
  set these-turtle-instructions
    (list
      "fd 20"
      "rt 120"
      "fd 20"
      "rt 120"
      "fd 20"
      "rt 120"
      "set color color + 10"
    )
  set turtle-instructions to-string-instructions these-turtle-instructions
  create-events these-turtle-instructions
end

to setup-triangles
;; Draws equilateral triangles.

  hide-states
  set these-turtle-instructions
    (list
      "fd 20"
      "rt 120"
      "fd 20"
      "rt 120" 
      "fd 20"
      "pen-up"
      "fd 5"
      "pen-down"
      "rt 120"
      "set color color + 10"
    )
  set turtle-instructions to-string-instructions these-turtle-instructions
  create-events these-turtle-instructions
end

to setup-triangles-1
;; Draws equilateral triangles.

  hide-states
  set these-turtle-instructions
    (list
      "fd 20"
      "rt 120"
      "fd 20"
      "rt 120" 
      "fd 20"
      "rt 60"
      "set color color + 10"
    )
  set turtle-instructions to-string-instructions these-turtle-instructions
  create-events these-turtle-instructions
end

to setup-hexagon
;; Draws a hexagon.

  hide-states
  set these-turtle-instructions
    (list
      "fd 20"
      "rt 60"
      "fd 20"
      "rt 60"
      "fd 20"
      "rt 60"
      "set color color + 10"
    )
  set turtle-instructions to-string-instructions these-turtle-instructions
  create-events these-turtle-instructions
end

to setup-squares
;; Draws four squares.

  hide-states
  set these-turtle-instructions
    (list
      "fd 20"
      "rt 90"
      "fd 20"
      "rt 90"
      "fd 20"
      "rt 90"
      "fd 20"
      "set color color + 10"
    )
  set turtle-instructions to-string-instructions these-turtle-instructions
  create-events these-turtle-instructions
end

to setup-squares-1
;; Draws squares.

  hide-states
  set these-turtle-instructions
    (list
      "fd 20"
      "rt 90"
      "fd 20"
      "rt 90"
      "fd 20"
      "rt 90"
      "fd 20"
      "pen-up"
      "fd 2"
      "rt 90"
      "fd 2"
      "lt 90"
      "pen-down"
      "set color color + 10"
    )
  set turtle-instructions to-string-instructions these-turtle-instructions
  create-events these-turtle-instructions
end

to setup-squares-2
;; Draws squares.

  hide-states
  set these-turtle-instructions
    (list
      "fd 30"
      "rt 90"
      "fd 30"
      "rt 90"
      "fd 30"
      "rt 90"
      "fd 26"
      "rt 90"
      "set color color + 10"
    )
  set turtle-instructions to-string-instructions these-turtle-instructions
  create-events these-turtle-instructions
end

to setup-steps
;; Draws "steps".

  hide-states
  set these-turtle-instructions
    (list
      "fd 20"
      "rt 90"
      "fd 20"
      "rt 90"
      "fd 16"
      "rt 90"
      "fd 16"
      "rt 90"
      "set color color + 10"
    )
  set turtle-instructions to-string-instructions these-turtle-instructions
  create-events these-turtle-instructions
end

to setup-spider
;; Makes a spider wander around aimlessly in its web (can run over the top of other spiders).

  hide-states
  set these-turtle-instructions
    (list
      "set shape \"spider\""
      "set color gray"
      "set heading heading + random 15 - random 15" ; wander aimlessly
      "fd 1"
    )
  set turtle-instructions to-string-instructions these-turtle-instructions
  create-events these-turtle-instructions
end

to setup-spider-1
;; Makes a spider wander around aimlessly in its web avoiding other spiders.

  hide-states
  set these-turtle-instructions
    (list
      "set shape \"spider\""
      "set color gray"
      "set heading heading + random 15 - random 15"
      "set neighbour one-of other turtle-agents in-radius 5"
      "if (neighbour != nobody) and (distance neighbour > 0) [ set heading towards neighbour + 180 ]" ; head in opposite direction to neighbour
      "fd 1"
    )
  set turtle-instructions to-string-instructions these-turtle-instructions
  create-events these-turtle-instructions
end

to setup-morpher
;; Makes a turtle that changes its shape and colour all the time wander around aimlessly in its web.

  hide-states
  set these-turtle-instructions
    (list
      "pen-up"
      "set shape one-of shapes" ; change shape all the time
      "set color color + 10"
      "set heading heading + random 15 - random 15"
      "fd 1"
    )
  set turtle-instructions to-string-instructions these-turtle-instructions
  create-events these-turtle-instructions
end

to-report to-string-instructions [instructions]
;; Converts the instructions list into the string so that it can be used
;; with the Turtle-Instructions Interface Input box to display the code
;; instructions to the user.

  let instr ""
  foreach instructions
  [
    set instr (word instr ? "\n")
  ]
  report instr
end

to reset-layout
  repeat 500 [ layout-spring states paths spring-constant spring-length repulsion-constant ]

  ;; leave space around the edges
  ask states
  [ setxy xcor * 0.95 ycor * 0.95 ]
end

to change-layout
  reset-layout
  display
end

to set-state-label
;; sets the label for the state
  ifelse (show-streams?)
    [ set label (word "[" stream " = " event "]       ") ]
    [ set label (word "[" event "]       ") ]
end

to delete-all-events
;; delete all the events in the environment.

  ask states
  [ die ]
  ask paths
  [ die ]
end

to create-events [instructions]
; Used to create the event map from the list of instructions.

  let y max-pycor - 2
  let these-events []
  foreach instructions
  [
    let this-stream ""
    ifelse ((position "set " ?) != 0) or ((position "set heading " ?) = 0)
      [ set this-stream "motor-event" ]
      [ set this-stream "turtle-event" ]
    set these-events lput (list this-stream ? -10 y) these-events
    set y y - 4.5
  ]
  delete-all-events
  add-events these-events
  ; reset-layout  
end

to add-events [list-of-events]
;; add events in the list-of-events list to the events map.
;; each item of the list-of-events list must consist of a two itemed list.
;; e.g. [[hue 0.9] [brightness 0.8]]

  let this-x 0
  let this-y 0
  let this-depth 0
  let this-stream ""
  let this-event ""
  let this-state nobody
  let next-state nobody
  let these-states states
  let matching-states []
  let matched-all-so-far true
  
  foreach list-of-events
  [ set this-stream (item 0 ?)
    set this-event (item 1 ?)
    set this-x (item 2 ?)
    set this-y (item 3 ?)

    ;; check to see if state already exists
    set matching-states these-states with [stream = this-stream and event = this-event and depth = this-depth]
    ifelse (matched-all-so-far = true) and (count matching-states > 0)
      [
        set next-state one-of matching-states
        ask next-state [ set-state-label ]
        set these-states [out-path-neighbors] of next-state ]
      [ ;; state does not exist - create it
        set matched-all-so-far false
        create-states 1
        [
          hide-turtle
          set size 4
          setxy this-x this-y
          set depth this-depth
          set stream this-stream
          set event this-event
          set-state-label
          ifelse (depth = 0)
            [ set label-color root-colour ]
            [ set label-color node-colour ]
                      
          ifelse (depth = 0)
            [ set color root-colour ]
            [ set color node-colour ]
          set next-state self
        ]
      ]

    if (this-state != nobody)
      [ ask this-state
        [ create-path-to next-state
          [ hide-link
            set color link-colour ]]]
         
    ;; go down the tree
    set this-state next-state    
    set this-depth this-depth + 1
  ]
  ask links [ set thickness 0.4 ]
end

to move-state
; Moves the selected states to where the mouse is.

  if mouse-down?
  [
    let candidate min-one-of states with [hidden? = false] [distancexy mouse-xcor mouse-ycor]
    if (candidate != nobody) and ([distancexy mouse-xcor mouse-ycor] of candidate < 3)
    [
      ;; The WATCH primitive puts a "halo" around the watched rule-node.
      watch candidate
      while [mouse-down?]
      [
        ;; If we don't force the display to update, the user won't
        ;; be able to see the rule-node moving around.
        display
        ;; The SUBJECT primitive reports the rule-node being watched.
        let this-xcor mouse-xcor
        let this-ycor mouse-ycor
        ask subject
        [ setxy this-xcor this-ycor ]
      ]
      ;; Undoes the effects of WATCH.  Can be abbreviated RP.
      reset-perspective
    ]
  ]
  display
end

to hide-states
; Hides the states and links.

  ask states
  [ hide-turtle ]
  ask paths
  [ hide-link ]
  ask walkers
  [ hide-turtle ]
end

to show-states
; Shows the states and links.

  ask states
  [ show-turtle ]
  ask paths
  [ show-link ]
  ask walkers
  [ show-turtle ]
end

to move-turtle
; Moves the selected turtle to where the mouse is.

  if mouse-down?
  [
    let candidate min-one-of turtle-agents [distancexy mouse-xcor mouse-ycor]
    if (candidate != nobody) and [distancexy mouse-xcor mouse-ycor] of candidate < 3
    [
      ;; The WATCH primitive puts a "halo" around the watched rule-node.
      watch candidate
      while [mouse-down?]
      [
        ;; If we don't force the display to update, the user won't
        ;; be able to see the rule-node moving around.
        display
        ;; The SUBJECT primitive reports the rule-node being watched.
        let this-xcor mouse-xcor
        let this-ycor mouse-ycor
        ask subject
        [ pen-up
          setxy this-xcor this-ycor
          pen-down ]
      ]
      ;; Undoes the effects of WATCH.  Can be abbreviated RP.
      reset-perspective
    ]
  ]
  display
end;

to spider-pens-down
  ask turtle-agents with [shape = "spider"]
  [ pen-down ]
end

to spider-pens-up
  ask turtle-agents with [shape = "spider"]
  [ pen-up ]
end
; Copyright 2010 by William John Teahan.  All rights reserved.
;
; Permission to use, modify or redistribute this model is hereby granted,
; provided that both of the following requirements are followed:
; a) this copyright notice is included.
; b) this model will not be redistributed for profit without permission
;    from William John Teahan.
; Contact William John Teahan for appropriate licenses for redistribution for
; profit.
;
; To refer to this model in publications, please use:
;
; Teahan, W. J. (2010).  Central Park Events NetLogo model.
;   Artificial Intelligence. Ventus Publishing Aps.
;
@#$#@#$#@
GRAPHICS-WINDOW
381
46
997
503
50
35
6.0
1
13
1
1
1
0
1
1
1
-50
50
-35
35
1
1
1
ticks

BUTTON
701
10
815
43
NIL
change-layout
T
1
T
OBSERVER
NIL
NIL
NIL
NIL

SLIDER
1000
310
1130
343
spring-constant
spring-constant
0
1
0.35
0.05
1
NIL
HORIZONTAL

SLIDER
1000
343
1130
376
spring-length
spring-length
0
50
6
1
1
NIL
HORIZONTAL

SLIDER
999
376
1130
409
repulsion-constant
repulsion-constant
1
100
17
1
1
NIL
HORIZONTAL

BUTTON
448
10
538
43
NIL
move-state
T
1
T
OBSERVER
NIL
NIL
NIL
NIL

TEXTBOX
589
503
925
543
The environment and the turtle agent(s)
16
0.0
1

INPUTBOX
105
46
380
503
Turtle-Instructions
set shape \"spider\"\nset color gray\nset heading heading + random 15 - random 15\nfd 1\n
1
1
String (commands)

TEXTBOX
144
505
294
525
Turtle instructions
16
0.0
1

BUTTON
538
10
620
43
NIL
hide-states
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL

BUTTON
620
10
701
43
NIL
show-states
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL

BUTTON
269
10
350
43
add-turtle(s)
add-turtles
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL

BUTTON
104
10
184
43
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL

BUTTON
184
10
269
43
go once
go
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL

SWITCH
1001
177
1131
210
add-at-origin?
add-at-origin?
1
1
-1000

BUTTON
3
343
103
376
NIL
setup-sun
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL

SWITCH
1001
243
1131
276
show-who-numbers?
show-who-numbers?
1
1
-1000

SWITCH
1001
210
1131
243
random-locations?
random-locations?
0
1
-1000

SWITCH
1001
276
1131
309
show-streams?
show-streams?
0
1
-1000

BUTTON
3
46
103
79
NIL
setup-square
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL

BUTTON
3
178
103
211
NIL
setup-rectangle
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL

BUTTON
3
79
103
112
NIL
setup-squares
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL

BUTTON
3
112
103
145
NIL
setup-squares-1
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL

BUTTON
3
145
103
178
NIL
setup-squares-2
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL

BUTTON
3
375
103
408
NIL
setup-steps
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL

BUTTON
815
10
904
43
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

BUTTON
3
211
103
244
NIL
setup-triangle
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL

BUTTON
3
310
103
343
NIL
setup-hexagon
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL

BUTTON
3
244
103
277
NIL
setup-triangles
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL

BUTTON
3
408
103
441
NIL
setup-spider
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL

BUTTON
3
474
103
507
NIL
setup-morpher
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL

BUTTON
3
441
103
474
NIL
setup-spider-1
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL

SLIDER
1001
46
1131
79
turtles-to-add
turtles-to-add
1
20
5
1
1
NIL
HORIZONTAL

BUTTON
6
10
104
43
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

BUTTON
3
277
104
310
NIL
setup-triangles-1
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL

BUTTON
350
10
448
43
NIL
move-turtle
T
1
T
OBSERVER
NIL
NIL
NIL
NIL

SLIDER
1001
79
1131
112
change-heading-angle
change-heading-angle
0
360
0
1
1
NIL
HORIZONTAL

SLIDER
1001
112
1131
145
change-tick-interval
change-tick-interval
0
100
26
1
1
NIL
HORIZONTAL

BUTTON
904
10
1020
43
NIL
spider-pens-down
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL

BUTTON
1020
10
1130
43
NIL
spider-pens-up
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL

SLIDER
1001
144
1131
177
turtle-pen-size
turtle-pen-size
1
5
1
0.1
1
NIL
HORIZONTAL

@#$#@#$#@
WHAT IS IT?
-----------
This model is like a "driving instructor" for NetLogo. It tries to help the user understand basic NetLogo commands for "driving" their turtles such as forward (fd for short), pen-up (pu), pen-down (pd), left-turn (lt) and right-turn (rt).

WHAT IS ITS PURPOSE?
--------------------
The purpose of this model is to illustrate how various simple NetLogo turtle commands work, by providing an animation of the execution of the model. A secondary purpose is to show how, although a turtle agent may be directed using simple commands, this does not necessarily mean that only simple patterns can emerge as a result.

HOW IT WORKS
------------
The turtle instructions shown in the Turtle-Instructions input box are executed each tick for each turtle agent that is added by the user into the environment using an ask command in the go procedure. These turtles are identified using a separate breed called turtle-agents since the keyword turtles is already used.
 
An event map representation (Teahan, 2011) is used to represent the turtle instructions in order to animate the execution of the model. The model uses turtle agents to represent the states in the event map, and uses links agents to represent the paths between states. States own three variables:

- depth: The depth in the event map tree.
- stream: The stream name (where a stream consists of a sequence of sensory or motor events).
- event: The event - e.g. sensory, motor.

A spring layout is used to visualise the event map if the change-layout button is pressed.
 
HOW TO USE IT
-------------
Press the setup button first. Then press one of the other setup buttons to load the instructions for a particular pattern or turtle program (such as setup-square, setup-triangles or setup-spider). Then press the add-turtle button one or more times to add turtles into the environment. The instructions are executed once the go forever button or go once buttons have been pressed.

To view an animation of the instructions being executed, press the show-states button. Pressing the hide-states will remove this from the display. When the states are shown, a small blue turtle for each environment turtle is shown at the state that represents the current instruction that the environment turtle is executing. If the show-who-numbers? switch is set to On before the turtles are created, then the corresponding who numbers will be displayed with each turtle. In this manner, it is possible to track which turtle is executing which instruction. To slow down the animation to see the instructions being executed one at a time, you will need to set the speed slider in the Interface to very slow (i.e. near to the left slide of the slider).

The layout of the states can be altered using the move-states and change-layout buttons. For the latter, the layout can be dynamically altered by changing the values in the spring-constant, spring-length and repulsion-constant sliders that control the layout. One effective technique is to reduce the value of the spring-length slider to 0, then slowly increase it back up again until the desired length and layout is achieved. Alternatively, you can move the position of an individual state using the move-states button.

THE INTERFACE
-------------
The model's Interface buttons are defined as follows:

- setup: This will clear the environment and variables. This must be done first, but is not required subsequently unless you want to start from scratch again.

- setup-square: This will define the instructions for drawing a single square.

- setup-squares: This will define the instructions for drawing squares that are adjacent to each other. It results in four squares being drawn around the turtle's original position if the go-once button is pressed four times or if the go forever button is pressed.

- setup-squares-1: This will define the instructions for drawing squares that are adjacent to each other but slightly translated in space. It results in four squares being drawn around the turtle's original position if the go-once button is pressed four times or if the go forever button is pressed.

- setup-squares-2: This will define the instructions for overlapping squares to be drawn at right angles to the original heading of the turtle agent.

- setup-triangle: This will define the instructions for drawing a single triangle.

- setup-triangles-2: This will define the instructions for overlapping triangles to be drawn at 240 degrees to the original heading of the turtle agent.

- setup-rectangle: This will define the instructions for drawing a single rectangle.

- setup-triangle: This will define the instructions for drawing a single triangle.

- setup-triangles: This will define the instructions for overlapping triangles to be drawn in the direction of 240 degrees to the original heading of the turtle agent.

- setup-triangles-1: This will define the instructions for drawing six triangles around the centre that form an outer hexagon, and look like a transparent cube.

- setup-hexagon: This will define the instructions for drawing three sides of a hexagon. The full hexagaon shape will be formed after two time ticks.

- setup-sun: This will define the instructions for drawing a sun-like pattern. Each tick, two lines are drawn at an angle of 10 degrees, and the turtle agent then turns right by 90 degrees. After eighteen ticks, this will draw the final overall shape with an unfilled circle in the centre.

- setup-steps: This will define the instructions for drawing four lines that almost form a square but the end point ends up being slightly translated away from the start point. Subsequent drawings of this shape will prduce a step-like effect with the pattern moving in the direction that is at an angle of 45 degrees from the initial heading of the turtle agent.

- setup-spider: This will define the instructions for a spider that will random wander around the environment. It draws the path it takes using the pen-down command. It does not try to avoid other turtle agents if their are more than one turtle in the environment; it simply runs over or under any other agents it encounters.

- setup-spider-1: This will define the instructions for a randomly wandering spider as for the setup-spider button, but does not draw its own path (the pen is kept up using the pen-up command). It will also try to avoid hitting the other turtles if there are more than one turtle in the environment.

- setup-morpher: This will define the instructions for a turtle agent that randomly wanders like the spider defined using the setup-spider button, but without drawing its path. Each tick the turtle agent will randomly select a shape for itself by selecting one from the turtle shapes library.

- go: This is a forever button that asks all turtles to execute the turtle instructions continuously unless the button is pressed again.

- go once: This asks all turtles to execute the turtle instructions once only.

- add-turtle(s): This will add the number of new turtle agents into the environment specified by the turtles-to-add slider. If the add-at-origin? switch is set to On, the turtles will be placed at the origin of the environment (in the centre). Otherwise, if the random-locations? switch is set to On, the turtles will be placed at random locations; otherwise, they will be placed at a location specified by the next mouse click.

- move-turtle: This allows the user to select a specific turtle in order to move it to another location. Move the mouse to above the turtle that you wish to move, left click on it (this will draw a halo around the turtle that is selected) then drag it (while still holding the mouse down) to the new location and then release the mouse button.

- move-state: This allows the user to select a specific state in the event map in order to move to another location. The states need to be visible using the show-states button for this to work. Move the mouse to above the state that you wish to move, left click on it (this will draw a halo around the state that is selected) then drag it (while still holding the mouse down) to the new location and then release the mouse button.

- hide-states: This hides the states and links in the event map. The event map is used to represent the instructions in order to provide an animation of the execution of the model.

- show-states: This makes the the states and links in the event map visible again. The event map is used to represent the instructions in order to provide an animation of the execution of the model.

- change-layout: This can be used to change the layout of the event map states and links by changing the values in the three sliders spring-constant, sprint-length and repulsion-constant.

- clear-drawing: This will clear the drawing inside the environment. Only the turtle agents will remain.

- spider-pens-down: This will make all the turtles in the environment that have "spider" shapes place their pens down.

- spider-pens-up: This will make all the turtles in the environment that have "spider" shapes place their pens up.

The model's Interface sliders are defined as follows:

- turtles-to-add: This specifies the number of new turtles to be added into the environment when the add-turtle(s) button is pressed.

- change-heading: This specifies the angle (in degrees) by which each turtle changes its heading each tick (before the turtle instructions are executed). The value of the change-tick-interval slider must be non-zero first for this to occur. Use these two sliders if you wish more complex patterns to be drawn rather than the default shape or pattern.

- change-tick-interval: This specifies the tick interval at which the change in heading will occur if the change-heading slider in non-zero.

- turtle-pen-size: This sets the size of the pen for all new turtles subsequently added into the environment.

- spring-constant: This is a value used by the layout-spring command when drawing the states and links in the event map. Changing it will usually not affect the visualisation of the event map much.

- spring-length: This modifies the length of the paths between the states of the event map network. Notice that the clutter in the event map layout can often be removed by setting the value of the spring-length slider to zero and then increasing it afterwards.

- repulsion-constant: This controls how much each of the states repel each other.
Notice how the repulsion-constant slider can be used to "repel" the states away from each other (for larger values) and "attract" the states towards each other (for smaller values).

The model's Interface switches are defined as follows:

- add-at-origin?: If set to On, this will result in new turtle agents being added at the origin in the environment. This overides the random-locations? switch.

- random-locations?: If set to On, this will result in new turtle agents being added at random locations in the environment. This is overridden by the random-locations? switch.

- show-who-numbers?: If set to On, this will result in the who number being displayed with any new turtle agent that is subsequently added into the environment. If the event map is being shown using the show-states button, then the corresponding who numbers will also be drawn alongside the blue turtles that are drawn in the event map. These can then be used to determine at what point each environment turtle is at in the list of instructions as they are being executed.

- show-streams?: If this is set to On, then the event map will be created with stream names shown as well. (This is to show that this representation does indeed conform to the event map format).  

THINGS TO NOTICE
----------------
Notice that simple rules (instructions) do not necessarily result in simple behaviour (what the observer sees). Complex behaviour can arise even for the simplest set of instructions, such as drawing a square, rectangle or triangle.

Notice how a slight variation in behaviour, such as changing the heading each tick using the change-heading and change-tick-interval, results in much more complex patterns being drawn rather than the default shapes or patterns.

Notice that another way of producing complexity is to add multiple agents rather than use a single agent.

THINGS TO TRY
-------------
In order to see an animation of the execution of the instructions for each turtle agent, press the show-states button. Try moving the speed slider in the Interface to "slower" to slow the animation down in order to see each instruction being executed individually.

Try pressing different setup buttons in the middle of the execution. The turtles will switch their behaviour and draw different patterns. Try getting the model to draw the shapes and patterns in different orientations or different directions in this manner.

Try temporarily pausing the execution when the go button is pressed, then add new turtles at new locations, Then press the go button to restart execution. The new turtles will draw the shapes and patterns at different angles and in different directions depending on the change-heading-angle and change-tick-interval sliders.

Try altering the values of the sliders to see what effect this has on the model.

Try changing the values of change-heading-angle and change-tick-interval sliders. This will change the turtle's heading each tick interval and mean that if the pattern being drawn is static, it will start to be drawn slightly translated around the environment rather than at a single location. As a result, an astonishing variety of further patterns can be generated.

Try setting the change-heading-angle to 70, the change-tick-interval to 1 then press setup followed by setup-square. Notice the circle that gets created around the outside - this circle is constructed out of line segments from the sides of the squares. Then try setting the change-heading-angle to 100, the change-tick-interval to 2 then press setup followed by setup-square again. Notice the circle halo at the centre of the pattern and the previous pattern - this is an optical illusion. Try moving the speed slider to "faster" for the second pattern. At some point it will appear that the central spokes of the pattern start rotating in a counter-clockwise fashion (this is another optical illusion), whereas when the speed slider is set to "normal", it is clear that the squares are drawn in a clockwise fashion. What happens when you use a change-tick-interval of 3 instead of 2? What happens when you change the change-heading-angle to another angle?

Try setting the change-heading-angle to 100, the change-tick-interval to 3 then press setup followed by setup-sun. What happens when you use a change-tick-interval of 2 instead of 3? What happens when you change the change-heading-angle to another angle?

Try setting the change-heading-angle to 20, the change-tick-interval to 2 then press setup followed by setup-hexagon. What happens when you use a change-tick-interval of 1 or 3 instead of 2? What happens when you change the change-heading-angle to another angle?

Try setting the change-heading-angle to 20, the change-tick-interval to 3 then press setup followed by setup-spider. What happens when you use a change-tick-interval of 1 or 2 instead of 3? What happens when you change the change-heading-angle to another angle?

Try getting the spiders to spin by altering the settings of the change-heading-angle and the change-tick-interval.

EXTENDING THE MODEL
-------------------
Try adding further setup buttons for other types of patterns. For example, try adding a setup-tirangles-2 button that uses triangles to draw star patterns.

NETLOGO FEATURES
----------------
The model uses the layout-spring command for modifying the layout of the network of states (turtle agents) and paths (link agents). The hide-turtle, show-turtle, hide-link and show-link commands are used to hide and display the states and links in the event map that is used to animate the order that the instructions are executed.

RELATED MODELS
--------------
See the Nested Squares and Nested Triangles models for further examples of what can be drawn used squares and triangles. See the Wall Following Events model for an example of the use of the event map representation. 

CREDITS AND REFERENCES
----------------------
This model was created by William John Teahan.

To refer to this model in publications, please use:

Instructor NetLogo model.
Teahan, W. J. (2011). Agent Directed Simulation in NetLogo. Ventus Publishing Aps. (To appear).
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
Circle -1 true false 30 30 240

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

spider
true
0
Polygon -8630108 true false 134 255 104 240 96 210 98 196 114 171 134 150 119 135 119 120 134 105 164 105 179 120 179 135 164 150 185 173 199 195 203 210 194 240 164 255
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

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270

@#$#@#$#@
NetLogo 4.1.1
@#$#@#$#@
random-seed 2
setup
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

arrow 1
0.0
-0.2 0 0.0 1.0
0.0 0 0.0 1.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 60 195
Line -7500403 true 150 150 240 195
Line -7500403 true 150 0 150 300

curved path
12.0
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
