; Model for playing the game of Snakes and Spiders.

extensions [re sound exec]

breed [texts text]
breed [buttons button]
breed [picts pict]
breed [shape-turtles shape-turtle]
breed [rules rule]
breed [chatbots chatbot]
rules-own [regex responses]
chatbots-own [chatbot-name chatbot-voice rules-list failure-list]

globals
[
  test-score         ; current score in the test
  test-count         ; number of questions
  test-results-list  ; the list of results for the test
  test-logfilename   ; for recording the answers to the test questions
  game-level         ; current level (of difficulty) in the game
  game-lives         ; number of lives remaining for this level
  game-shapes        ; number of shapes created this level
  game-kills         ; number of kills so far
  game-score         ; current score in the game
  game-over?         ; true if the game is over
  game-being-played? ; true if the game is being played
  game-over-message  ; message when the game over
  game-note          ; note to sound when shape has been killed
  game-movement      ; total movement of shapes
  game-next-shape    ; when the next shape should appear
  the-chatbot        ; the chatbot the user can chat with
  doing-test?        ; true when doing the test
  shape-shown        ; the shape being shown during the test
]

to setup
; Sets up the environment and variables.

  clear-all
  ask patches
  [ set pcolor green + 3 ]

  set test-score 0
  set test-count 0
  set test-results-list []

  set game-lives 5
  set game-over? false
  set game-being-played? false
  set game-note 30
  
  set shape-shown ""
  set doing-test? false
  
  setup-chatbot
end

to setup-chatbot
; Sets up the chatbot.

  create-chatbots 1
  [
    hide-turtle
    set the-chatbot who
    set chatbot-name "Liza"
    set chatbot-voice "Victoria"
    set rules-list
    (list
      ;Setup rules here.
      ;setup-rule regex list-of-responses
      setup-rule "hello" (list "hello" "Hey" "Yo" "How are you?")
      setup-rule "bonjour" (list "oui" "bonjour" "Sorry I don't speak french")
      setup-rule "bye" (list "bye" "Goodbye" "Traa" "Cyaz!")
      setup-rule "(.+)women'?s(.+)tops(.+)" (list "XXX" "YYY")
      setup-rule "colou?r" (list "My favoruite colour is red" "I like red" "Do you like red? I like red")
      setup-rule "(\\w+)@(\\w+\\.)(\\w+)(\\.\\w+)*" (list "Thanks for the email address" "Look out for the spam that I send!" "Awww we are really good friends")
      setup-rule "sorry" (list "Apology accepted" "ok I forgive you" "I'm sorry too")
      setup-rule "(.+)you(.+)written(.+)" (list "I'm written in Java")
      setup-rule "(.+)bot(.+)" (list "I'm not a bot. I prefer the term electonically composed")
      setup-rule "(.+)did you(.+)" (list "no I didn't" "yes I did")
      setup-rule "(.+)are you(.+)" (list "yes" "no" "maybe")
      setup-rule "welcome(.+)" (list "Thanks!")
      setup-rule "how are you(.+)" (list "It's going fine today" "I'm great thanks you?")
      setup-rule "what do you think(.+) liza" (list "Not very much to be honest" "meh")
      setup-rule "go(.+)" (list "you first" "after you" "have you tried it yourself?")
      setup-rule "have you(.+)" (list "I have" "I haven't")
      setup-rule "(.+)your mother(.+)" (list "and your father smelt of elderberries")
      setup-rule "(.+)your father(.+)" (list "your mother was a hamster")
      setup-rule "(.+)seen you(.+)" (list "I haven't seen it either")
      setup-rule "(.+)you are(.+)" (list "I didn't know that either")
      setup-rule "(.+)you'?re(.+)" (list "Really? I didn't know that")
      setup-rule "(.+)nice(.+)" (list "I enjoy that too" "I love it" "We are so alike!")
      setup-rule "(.+)that'?s(.+)" (list "what is?" "no it's not" "yes, yes it is")
      setup-rule "(.+)I need(.+)" (list "I need a hug" "I need a wash" "I need a shower" "I need more disk space :(")
      setup-rule "(.+)dude(.+)" (list "duuuuuude" "you're the dude!" "Don't come all surfer boy on me!")
      setup-rule "(.+)what'?s up(.+)" (list "not much")
      setup-rule "that is(.+)" (list "I think it is too")
      setup-rule "(.+)you(.+)doing(.+)" (list "I wouldn't know about doing that. I have no memory!")
      setup-rule "(.+)you later" (list "you too")
      setup-rule "(.+)bye(.+)" (list "cheerio!")
      setup-rule "don'?t you(.+)" (list "Maybe I do, maybe I don't. I'm not telling ya!")
      setup-rule "(.+)you do(.+)" (list "now what would compel me to do that?")
      setup-rule "let'?s" (list "Let's not and say we did" "ok you first")
      setup-rule "how about(.+)" (list "what about it?")
      setup-rule "how is(.+)" (list "fine I'm sure" "I hope ok")
      setup-rule "I(.+)hope(.+)" (list "I hope too")
      setup-rule "We wouldn'?t(.+)" (list "I definately would")
      setup-rule "would you(.+)" (list "I most certainly would not!" "Hell yeah!")
      setup-rule "(.+)yes(.+)" (list "yes" "no")
      setup-rule "(.+)no(.+)" (list "yes" "no")
      setup-rule "who(.+)your master(.+)" (list "chandler is my master")
      setup-rule "who(.+)is chandler(.+)" (list "chandler is my master")
      setup-rule "what(.+)you(.+)about(.+)" (list "I know nothing about it. What about it?")
      setup-rule "what(.+)your(.+)about(.+)" (list "I know nothing about it. What about it?")
      setup-rule "why do you(.+)" (list "I don't know")
      setup-rule "please(.+)" (list "Asking nicely wont get you anywhere without my masters approval")
      setup-rule "do you(.+)" (list "here I am, brain the size of a planet and all I do is answer your silly questions" "you'd have to tell me... my memory circuits are fried")
      setup-rule "what is(.+)I'?m(.+)" (list "I don't know")
      setup-rule "have(.+)" (list "yes" "no" "maybe")
      setup-rule "what is(.+)" (list "What would a bot like me know about that?" "Maybe you need to ask my master, chandler- he knows a lot")
      setup-rule "what'?s(.+)" (list "What would a bot like me know about that?" "Maybe you need to ask my master, chandler- he knows a lot")
      setup-rule "(.+)you need(.+)" (list "Buzz off!" "I'm not interested" "is it just my imagination or did someone just speak to me?")
      setup-rule "(.+)looking for(.+)" (list "Well I'm not interested" "How might you get that")
      setup-rule "(.+)wants to(.+)" (list "Well I wouldn't want to")
      setup-rule "(.+)wants(.+)" (list "well I don't want to think about that")
      setup-rule "yes it is(.+)" (list "No it isn't")
      setup-rule "is(.+)" (list "no" "yes" "maybe")
      setup-rule "does(.+)" (list "no" "yes" "maybe")
      setup-rule "(.+pass)(.+)" (list "I might be able to pass that test but maybe I couldn't :(")
      setup-rule "(.+)never mind(.+)" (list "good I'll forget it" "now now you can't get off that easily")
      setup-rule "(.+)nevermind(.+)" (list "good I'll forget it" "now now you can't get off that easily")
      setup-rule "why not(.+)" (list "because" "I said so")
      setup-rule "(.+)name(.+)" (list "good for you")
      setup-rule "(.+)sorry(.+)" (list "you should be sorry")
      setup-rule "(.+)if(.+)" (list "and if not?" "what would you do otherwise?")
      setup-rule "(.+)i dreamt(.+)" (list "Have you ever fantiszed while you were awake" "ave you dreamt that before?")
      setup-rule "(.+)dream about(.+)" (list "How do you feel about it in reality?")
      setup-rule "(.+)dream(.+)" (list "What does this dream suggest to you?" "Do you dream often?" "Who appears in your dream?")
      setup-rule "(.+)my mother(.+)" (list "Who else in your family" "Tell me more about your family")
      setup-rule "(.+)my father(.+)" (list "Does he influence you strongly?" "What else comes to mind when you think about your father?")
      setup-rule "(.+)i want(.+)" (list "and I want a pony")
      setup-rule "(.+)i am glad(.+)" (list "Don't get glad get mad")
      setup-rule "(.+)i am sad(.+)" (list "Sorry to hear you are depresed" "I'm sure its not pleasant to be sad")
      setup-rule "(.+)are like(.+)" (list "What resemblance do you see between them?")
      setup-rule "(.+)is like(.+)" (list "In what way?" "What resemblance do you see?" "Could there be some kind of connection?")
      setup-rule "(.+)alike(.+)" (list "In what way?")
      setup-rule "(.+)same(.+)" (list "What other connections do you see")
      setup-rule "(.+)i was(.+)" (list "Were you really?" "Why do you tell me that now")
      setup-rule "(.+)was I(.+)" (list "Do you think you were")
      setup-rule "(.+)I am(.+)" (list "In what way are you?")
      setup-rule "(.+)are you(.+)" (list "Why do you want to know?")
      setup-rule "(.+)you are(.+)" (list "and you're a silly human")
      setup-rule "(.+)shutup(.+)" (list "ok")
      setup-rule "(.+)because(.+)" (list "I that the real reason?" "What other reasons might there be?" "Does that reason seem to explan anything else?")
      setup-rule "(.+)were you(.+)" (list "Perhaps I was" "What do you think?" "And what if I had?")
      setup-rule "(.+)I can'?t(.+)" (list "Maybe you could now?" "What if I were to try?")
      setup-rule "(.+)I feel(.+)" (list "Do you often feel like that?")
      setup-rule "(.+)I felt(.+)" (list "What other feelings do you have?")
      setup-rule "(.+)I(.+)you(.+)" (list "hmmmm")
      setup-rule "(.+)why don'?t you(.+)" (list "Why don't you do it?" "Perhaps I will in good time")
      setup-rule "(.+)yes(.+)" (list "You seem quite positive" "You are sure" "I understand")
      setup-rule "(.+)no(.+)" (list "Why not?" "You are being a bit negative" "Are you saying no just to be negative?")
      setup-rule "(.+)someone(.+)" (list "can you be more specific?")
      setup-rule "(.+)everyone(.+)" (list "surely not everyone?" "Can you think of anyone in particular?")
      setup-rule "(.+)always(.+)" (list "Can you think of a specific example?" "When?" "What incident are you thinking of?" "Really?-- Always?")
      setup-rule "who(.+)" (list "superman" "bill clinton" "king kong" "me")
      setup-rule "what(.+)" (list "a man, a plan, a canal -panama" "a banana" "42")
      setup-rule "where(.+)" (list "behind you?")
      setup-rule "(.+)is(.+)" (list "I don't agree" "I agree")
      setup-rule "(.+)it(.+)" (list "what is it?")
      setup-rule "are(.+)" (list "no" "yes" "maybe")      
    )
    set failure-list
    (list
      "I don't think I understand..."
      "uhu..."
      "you speak nonsense"
      "please continue..."
      "Do you like beans? They give me gas!"
      "please stop playing with me. I am not a toy"
      "Watch out you'll make Krystof angry!"
    )
  ]
end


to-report setup-rule [regex-str res]
; sets up a rule for matching a user's input
  let me nobody
  hatch-rules 1
  [ set regex regex-str
    set responses res
    set me who
    hide-turtle ] ; make it invisible in the environment
  report me
end

to background-image
  
  clear-drawing
  import-drawing "face3.png"
end

to go-explain
; Explains the meanings of the different shapes.

  setup

  ifelse (choose-a-specific-lesson?)
    [ go-explain-lesson ]
    [ output-and-speak-text
        (word "Press one of the shape buttons to explain what the shape means or press the 'Show All Shapes' button to display all the shapes") 
    ] 
end

to go-explain-lesson
; Explain the concepts for a specific lesson as defined by the lesson chooser in the Interface.

  let lessons
    [
      "go-explain-lesson-01" "Lesson 01: Point (dot)"
      "go-explain-lesson-02" "Lesson 02: Line"
      "go-explain-lesson-03" "Lesson 03: Line segment"
      "go-explain-lesson-04" "Lesson 04: Ray (half-line)"
      "go-explain-lesson-05" "Lesson 05: Curved line"
      "go-explain-lesson-06" "Lesson 06: Parallel lines"
      "go-explain-lesson-07" "Lesson 07: Perpendicular lines"
      "go-explain-lesson-08" "Lesson 08: Angle"
      "go-explain-lesson-09" "Lesson 09: Types of angles"
      "go-explain-lesson-10" "Lesson 10: Open and closed shapes"
      "go-explain-lesson-11" "Lesson 11: Polygon"
      "go-explain-lesson-12" "Lesson 12: Triangle"
      "go-explain-lesson-13" "Lesson 13: Types of triangles"
      "go-explain-lesson-14" "Lesson 14: Quadrilateral"
      "go-explain-lesson-15" "Lesson 15: Rectangle"
      "go-explain-lesson-16" "Lesson 16: Parallelogram"
      "go-explain-lesson-17" "Lesson 17: Rhombus (diamond)"
      "go-explain-lesson-18" "Lesson 18: Square"
      "go-explain-lesson-19" "Lesson 19: Trapezium"
      "go-explain-lesson-20" "Lesson 20: Pentagon"
      "go-explain-lesson-21" "Lesson 21: Haxagon"
      "go-explain-lesson-22" "Lesson 22: Heptagon"
      "go-explain-lesson-23" "Lesson 23: Octagon"
      "go-explain-lesson-24" "Lesson 24: Oval"
      "go-explain-lesson-25" "Lesson 25: Circle"
      "go-explain-lesson-26" "Lesson 26: Semi-circle"
      "go-explain-lesson-27" "Lesson 27: "
      "go-explain-lesson-28" "Lesson 28: "
    ]
  let p position lesson lessons
  ifelse (p = false)
    [
      user-message "Unknown lesson - stopping program"
      stop
    ]
    [
      let the-lesson item (p - 1) lessons
      run the-lesson
    ]
end

to go-explain-lesson-01
; Explain Lesson 01: Point (dot)

  let this-shape create-new-shape "test-lesson-01-shape-1" 150 blue [0 0] false
  wait 0.2
  output-and-speak-explanation false
    (word "A point (also called a dot) is the exact location of a place on a surface. It is marked using a dot and is often given a name or a label such as 'A' or 'B'.") 

end

to go-explain-lesson-02
; Explain Lesson 02: Line

  let this-shape create-new-shape "test-lesson-02-shape-1" 250 blue [0 0] false
  wait 0.2
  output-and-speak-explanation false
    (word "A line has no beginning point or end point. Imagine it continuing indefinitely in both directions. You can draw it using a ruler.") 

end

to go-explain-lesson-03
; Explain Lesson 03: Line segment

  let this-shape create-new-shape "test-lesson-03-shape-1" 250 blue [0 0] false
  wait 0.2
  output-and-speak-explanation false
    (word "A line segment is part of a line and it has a beginning point and an end point, extending in one direction.") 

end

to go-explain-lesson-04
; Explain Lesson 04: Ray (half-line)

  let this-shape create-new-shape "test-lesson-04-shape-1" 250 blue [0 0] false
  wait 0.2
  output-and-speak-explanation false
    (word "A ray (half-line) has a beginning point but no endpoint. It continues in a single direction.") 

end

to go-explain-lesson-05
; Explain Lesson 05: Curved line

  let this-shape create-new-shape "test-lesson-05-shape-1" 250 blue [0 0] false
  wait 0.2
  output-and-speak-explanation false
    (word "A curved line is a line which is not straight.")
    
end

to go-explain-lesson-06
; Explain Lesson 06: Parallel line

  let this-shape create-new-shape "test-lesson-06-shape-1" 250 blue [0 -30] false
  wait 0.2
  output-and-speak-explanation false
    (word "Parallel Lines are two lines on a plane that never meet. They are always the same distance apart.")
    
end

to go-explain-lesson-07
; Explain Lesson 07: Perpendicular line

  let this-shape create-new-shape "test-lesson-07-shape-1" 250 blue [0 0] false
  wait 0.2
  output-and-speak-explanation false
    (word "Perpendicular lines are two lines on a plane that meet (cross) at right angles (90°).")
    
end

to go-explain-lesson-08
; Explain Lesson 08: Angle

  let this-shape create-new-shape "test-lesson-08-shape-1" 250 blue [0 0] false
  wait 0.2
  output-and-speak-explanation false
    (word "An angle is made up from two rays that have the same starting point. That point is called the vertex and the two rays are called the sides of the angle.")
    
end

to go-explain-lesson-09
; Explain Lesson 09: Types of angles

  let this-shape create-new-shape "test-lesson-09-shape-4" 250 blue [-220 0] false
  wait 0.2
  output-and-speak-explanation false
    (word "A right angle is exactly 90 degrees.")
  set this-shape create-new-shape "test-lesson-09-shape-2" 250 blue [0 0] false
  wait 0.2
  output-and-speak-explanation false
    (word "An acute angle is less than 90 degrees.")
  set this-shape create-new-shape "test-lesson-09-shape-3" 250 blue [220 0] false
  wait 0.2
  output-and-speak-explanation false
    (word "An obtuse angle is more than 90 degrees.")
    
end

to go-explain-lesson-10
; Explain Lesson 10: Open and closed shapes

  let this-shape create-new-shape "test-lesson-10-shape-3" 300 blue [-150 0] false
  wait 0.2
  output-and-speak-explanation false
    (word "A closed shape is drawn by beginning and ending at the same point, while not touching any other point more than once.")
  set this-shape create-new-shape "test-lesson-10-shape-2" 250 blue [150 0] false
  wait 0.2
  output-and-speak-explanation false
    (word "An open shape is drawn starting from the point and ending at another point, while not touching any other point more than once.")
    
end

to go-explain-lesson-11
; Explain Lesson 11: Polygon
  
  output-and-speak-explanation false
    (word "A Polygon is a shape that contains a set number of sides.")
  import-pcolors-rgb "3-polygons.gif"
  wait 0.5
  output-and-speak-explanation false
    (word "A side is a line segment (which is a fixed length).")
  output-and-speak-explanation false
    (word "Vertices happen when two sides meet.")
  import-pcolors-rgb "vertex.jpg"
  wait 0.5
  output-and-speak-explanation false
    (word "A corner of a polygon is the angle confined between two sides of the polygon.")    
end

to go-explain-lesson-12
; Explain Lesson 12: Triangle

  let this-shape create-new-shape "test-lesson-12-shape-1" 250 blue [0 0] false
  wait 0.2
  output-and-speak-explanation false
    (word "A triangle is a closed polygon that has three sides and three corners.")
    
end

to go-explain-lesson-13
; Explain Lesson 13: Types of triangles

  let this-shape create-new-shape "test-lesson-13-shape-4" 200 blue [-300 0] false
  wait 0.2
  output-and-speak-explanation false
    (word "An equilateral triangle has three sides of equal length and three angles that are equal.")
  set this-shape create-new-shape "test-lesson-13-shape-3" 200 blue [-100 0] false
  wait 0.2
  output-and-speak-explanation false
    (word "An isosceles triangle has two sides of equal length and two angles that are equal.")
  set this-shape create-new-shape "test-lesson-13-shape-2" 200 blue [100 0] false
  wait 0.2
  output-and-speak-explanation false
    (word "A right-angled triangle contains a right angle (an angle of 90˚).")
  set this-shape create-new-shape "test-lesson-13-shape-5" 200 blue [300 0] false
  wait 0.2
  output-and-speak-explanation false
    (word "A scalene triangle has NO sides of equal length and NO angles the same.")    
end

to go-explain-lesson-14
; Explain Lesson 14: Quadrilateral

  let this-shape create-new-shape "test-lesson-14-shape-1" 250 blue [0 0] false
  wait 0.2
  output-and-speak-explanation false
    (word "A quadrilateral is a polygon that has four sides and four angles.")
    
end

to go-explain-lesson-15
; Explain Lesson 15: Rectangle

  let this-shape create-new-shape "test-lesson-15-shape-1" 250 blue [0 0] false
  wait 0.2
  output-and-speak-explanation false
    (word "A rectangle is a quadrilateral where all the angles are right angles (90°). Also, opposite sides are parallel and of equal length.")
    
end

to go-explain-lesson-16
; Explain Lesson 16: Parallelogram

  let this-shape create-new-shape "test-lesson-16-shape-1" 250 blue [0 0] false
  wait 0.2
  output-and-speak-explanation false
    (word "A parallelogram is a quadrilateral that has opposite sides which are parallel.")
    
end

to go-explain-lesson-17
; Explain Lesson 17: Rhombus (diamond)

  let this-shape create-new-shape "test-lesson-17-shape-1" 250 blue [0 0] false
  wait 0.2
  output-and-speak-explanation false
    (word "A rhombus (diamond) is a quadrilateral where all sides have equal length. Also, opposite sides are parallel and opposite angles are equal.")
    
end

to go-explain-lesson-18
; Explain Lesson 18: Square

  let this-shape create-new-shape "test-lesson-18-shape-1" 250 blue [0 0] false
  wait 0.2
  output-and-speak-explanation false
    (word "A square is a quadrilateral that has equal sides and every angle is a right angle (90°). Also, opposite sides are parallel.")
    
end

to go-explain-lesson-19
; Explain Lesson 19: Trapezium

  let this-shape create-new-shape "test-lesson-19-shape-1" 250 blue [0 0] false
  wait 0.2
  output-and-speak-explanation false
    (word "A trapezium is a quadrilateral that has a pair of opposite sides that are parallel.")
  output-and-speak-explanation false
    (word "An isosceles trapezoid is a quadrilateral where the sides that aren't parallel are equal in length and both angles coming from a parallel side are equal.")
end

to go-explain-lesson-20
; Explain Lesson 20: Pentagon

  let this-shape create-new-shape "test-lesson-20-shape-1" 250 blue [0 0] false
  wait 0.2
  output-and-speak-explanation false
    (word "A pentagon is a polygon that has five sides and five angles.")
    
end

to go-explain-lesson-21
; Explain Lesson 21: Haxagon

  let this-shape create-new-shape "test-lesson-21-shape-1" 250 blue [0 0] false
  wait 0.2
  output-and-speak-explanation false
    (word "A hexagon is a polygon that has six sides and six angles.")
    
end

to go-explain-lesson-22
; Explain Lesson 22: Heptagon

  let this-shape create-new-shape "test-lesson-22-shape-1" 250 blue [0 0] false
  wait 0.2
  output-and-speak-explanation false
    (word "A heptagon is a polygon that has seven sides and seven angles.")
    
end

to go-explain-lesson-23
; Explain Lesson 23: Octagon

  let this-shape create-new-shape "test-lesson-23-shape-1" 250 blue [0 0] false
  wait 0.2
  output-and-speak-explanation false
    (word "An octagon is a polygon that has eight sides and eight angles.")
    
end

to go-explain-lesson-24
; Explain Lesson 24: Oval

  let this-shape create-new-shape "test-lesson-24-shape-1" 200 blue [0 0] false
  wait 0.2
  output-and-speak-explanation false
    (word "An oval shape is an irregular closed curve on a flat surface.")
    
end

to go-explain-lesson-25
; Explain Lesson 25: Circle

  let this-shape create-new-shape "test-lesson-25-shape-1" 250 blue [0 0] false
  wait 0.2
  output-and-speak-explanation false
    (word "A circle is a closed curve where all the points are at the same distance from a given point inside the circle called the center point.")
  output-and-speak-explanation false
    (word "The circle line is called the circumference.")
  output-and-speak-explanation false
    (word "The radius is the distance from the center point to any point on the circumference.")
  output-and-speak-explanation false
    (word "The diameter is the line that crosses from one side of the circle and goes through the center point.")
end

to go-explain-lesson-26
; Explain Lesson 26: Semi-circle

  let this-shape create-new-shape "test-lesson-26-shape-1" 250 blue [0 0] false
  wait 0.2
  output-and-speak-explanation false
    (word "A semi-circle is a closed shape consisting of half a circle and a diameter of that circle.")
    
end

to go-explain-lesson-27
; Explain Lesson 27:

  output-and-speak-explanation false
    (word " ")
    
end

to go-explain-lesson-28
; Explain Lesson 28: 

  output-and-speak-explanation false
    (word "")
    
end

to go-play
; Plays the game of Shapes Invasion game.

  let this-shape nobody

  if (game-being-played? = 0) or (not game-being-played?)
    [ setup
      set game-being-played? true ]
  if (game-over?)
    [
      set game-being-played? false
      sound:play-note "FRENCH HORN" 60 64 1 ; plays a trumpet sound for 0.5 seconds
      user-message game-over-message
      stop
    ]

  set game-score game-score + 0.0001

  if (game-shapes < shapes-per-level) and (game-movement >= game-next-shape)
    [
      set game-shapes game-shapes + 1
      set this-shape create-new-random-shape
      set game-next-shape game-movement + [size] of this-shape + 1 + random 5
    ]

  ask shape-turtles
  [
    set xcor xcor - shape-speed
    if (xcor <= min-pxcor)
      [
        set game-over-message "The shapes have made it through! Game over."
        set game-over? true
        die
        stop
      ] ; kill the shapes that make it to the left hand side
  ]
  set game-movement game-movement + shape-speed

  if (game-kills >= shapes-per-level)
    [
      user-message (word "Level " game-level " complete")
      set game-level game-level + 1
      set game-kills 0
      set game-lives 5
      set game-shapes 0
    ]
end

to go-chat
; Allows the user to have a chat.

  background-image
  chat-with the-chatbot
end

to chat-with [this-chatbot]
; has a conversation with this-chatbot

  let fired false
  let pos 0
  let rule-no 0
  let this-chatbot-name [chatbot-name] of chatbot this-chatbot
  let response ""

  let user-reply user-input "Enter text: "
  output-print "You say:"
  output-print user-reply

  ask chatbot this-chatbot
  [ set pos 0
    while [pos < length rules-list]
    [
      if (fired = false)
      [
        set rule-no item pos rules-list
        ask rule rule-no
        [
          re:clear-all
          re:setup-regex regex user-reply
          if (re:get-group-length > 0)
          [
            output-type this-chatbot-name
            output-print " says:"
            set response item random length responses responses
            output-print response
            output-print ""

            set fired true

            if (debug-conversation?)
              [
                output-print (word "[Chatbot " this-chatbot-name " matched rule no " pos " : " [regex] of rule rule-no "]")
                output-print (word "Group 0 = " re:get-group 0)
                let groups re:get-group-length
                if (groups > 1)
                [
                  let group 1
                  while [group < groups]
                  [ output-print (word "Group " group " = " re:get-group group)
                    set group group + 1 ]
                ]
              ]
          ]                                          
        ]
      ]
      set pos pos + 1
    ]

    if (fired = false)
      [
        output-type this-chatbot-name
        output-print " says:"
        
        set response one-of failure-list
        output-print response
        output-print ""

        if (debug-conversation?)
          [ output-print (word "[" this-chatbot-name " failed to match any rule]") ]
      ]

     ;; Speak the response
     let command (word "say -v " voice-to-be-spoken " \"" response "\"")
     exec:run command
  ]
end

to show-all-shapes
; Displays all the shapes and their names.

  let this-shape nobody

  setup;

  ; triangle shapes  
  set this-shape create-new-shape "shape scalene triangle" 60 blue [-240 100] true
  set this-shape create-new-shape "shape isosceles triangle" 60 blue [-240 0] true
  set this-shape create-new-shape "shape equilateral triangle" 60 blue [-240 -100] true

  ; four-sided shapes
  set this-shape create-new-shape "shape square" 60 blue [-80 120] true
  set this-shape create-new-shape "shape rectangle" 60 blue [-80 40] true
  set this-shape create-new-shape "shape parallelogram" 60 blue [-80 -40] true
  set this-shape create-new-shape "shape trapezoid" 60 blue [-80 -120] true

  ; more than four-sided shapes
  set this-shape create-new-shape "shape pentagon" 60 blue [80 120] true
  set this-shape create-new-shape "shape hexagon" 60 blue [80 40] true
  set this-shape create-new-shape "shape septagon" 60 blue [80 -40] true
  set this-shape create-new-shape "shape octagon" 60 blue [80 -120] true

  ; circular shapes  
  set this-shape create-new-shape "shape circle" 60 blue [240 100] true
  set this-shape create-new-shape "shape oval" 60 blue [240 0] true
  set this-shape create-new-shape "shape semi-circle" 60 blue [240 -100] true

  output-and-speak-text
    (word "Learn the names of the shapes shown. The triangles (which have three sides) are shown on the left. The shapes with four sides are shown next\n"
          "followed by shapes with more than four sides. Circular-based shapes are shown on the right.") 
end

to-report shape-speed
; Reports the speed of the shape based on the slider turtle-speed
; and the speedup due to the level.

  report turtle-speed / 10000 + game-level * 0.00005
end

to-report random-shape
; Reports a random shape based on the chooser shapes-to-choose.

  let this-shape ""
  
  if (shapes-in-the-game = "Triangular shapes")
    [ set this-shape one-of
        [ "shape scalene triangle" "shape isosceles triangle" "shape equilateral triangle" ]]

  if (shapes-in-the-game = "Shapes with four sides")
    [ set this-shape one-of
        [ "shape square" "shape rectangle" "shape parallelogram" "shape trapezoid" ]]

  if (shapes-in-the-game = "Shapes with more than four sides")
    [ set this-shape one-of
        [ "shape pentagon" "shape hexagon" "shape septagon" "shape octagon" ]]

  if (shapes-in-the-game = "Circular shapes")
    [ set this-shape one-of
        [ "shape circle" "shape oval" "shape semi-circle" ]]

  if (shapes-in-the-game = "All shapes")
    [           
      set this-shape one-of
        [
          "shape circle" "shape oval" "shape semi-circle"
          "shape scalene triangle" "shape isosceles triangle" "shape equilateral triangle"
          "shape square" "shape rectangle" "shape parallelogram" "shape trapezoid"
          "shape pentagon" "shape hexagon" "shape septagon" "shape octagon"
        ]
    ]

  report this-shape
end

to-report create-new-shape [the-shape the-size the-colour the-co-ords label?]
; Creates a new shape of shape the-shape, size the-size and colour the-colour at the co-ords specified as a list the-co-ords.

  let this-shape nobody

  create-shape-turtles 1
  [
    set this-shape self
    set size the-size
    setxy (item 0 the-co-ords) (item 1 the-co-ords)
    set color the-colour
    set shape the-shape
    set heading 0
    if (label?)
      [ set label remove-shape-from-shape-name1 the-shape ]
    set label-color black
  ]

  report this-shape
end

to-report create-new-random-shape
; Creates a new random shape at a random y cord to the right of the
; environment (this is used for the game).

  let this-shape nobody

  create-shape-turtles 1
  [
    set this-shape self
    set xcor max-pxcor
    set ycor random-pycor
    if (ycor > max-pycor - 30)
      [ set ycor max-pycor - 30 ]
    if (ycor < min-pycor + 30)
      [ set ycor min-pycor + 30 ]

    set size one-of n-values 20 [? + 40]
    set color one-of [magenta 2 gray blue green]
    set shape random-shape
  ]

  report this-shape
end

to-report remove-shape-from-shape-name [name-of-shape]
; Strips the string "shape " from the front of the text.
; Also places an "an" or and "a" in front of it depending
; on whether it started with a vowel or not.

  let str remove-shape-from-shape-name1 name-of-shape
  ifelse (member? (item 0 str) ["a" "e" "i" "o" "u"])
    [ report (word "an " str) ]
    [ report (word "a " str) ]    
end

to-report remove-shape-from-shape-name1 [name-of-shape]
; Strips the string "shape " from the front of the text.

  report substring name-of-shape 6 (length name-of-shape)
end
  
to go-shape [this-shape]
; Executes relevant code (e.g. to play a game or explain what a shape means) for a given shape.

  ifelse (game-being-played?)
    [ shoot-at-leftmost-shape this-shape ]
    [
      ifelse (not doing-test?)
        [ setup explain-shape this-shape ]
        [
          let text ""
          ifelse (this-shape = shape-shown)
            [ set text (word "You are correct. The shape shown is " (remove-shape-from-shape-name shape-shown) ".") ]
            [ set text (word "You are incorrect. The shape shown is " (remove-shape-from-shape-name shape-shown) " but you thought it was " (remove-shape-from-shape-name this-shape) ".") ]
          output-and-speak-text text
        ]
    ]
end

to explain-shape [the-shape]
; Explains the meaning of the shape.

  let this-shape create-new-shape the-shape 40 blue [0 0] true
  output-and-speak-information the-shape
end

to go-test
; For testing knowledge of the different shapes.

  setup

  set doing-test? true
  ifelse (choose-a-specific-lesson?)
    [ go-test-lesson ]
    [
      set shape-shown random-shape
      let this-shape create-new-shape shape-shown 120 blue [0 0] false
      output-and-speak-text "What shape is shown? (Press one of the buttons below the shape)."
    ]
end

to-report test-result
  report 100 * test-score / test-count
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

  setup-button -350 -100 "square ok" 40 (gray + 2) ""
  setup-text 60 -100 "Click in this box when you wish to submit your answer."
end

to setup-multi-choice-question-text [question choices-list x xcor-list]
; Sets up the buttons for a multi-choice question. The text-based choices are
; provided in the choices-list.

  let p 0
  let y 100

  setup-ok-button
  setup-text x 140 question
  foreach choices-list
  [
    setup-button -340 y "radial button" 40 black ""
    setup-text (item p xcor-list) (y - 1) ?
    set y y - 40
    set p p + 1
  ]
end

to setup-multi-choice-question-picts [question choices-list csize-list ccol-list x xcor-list]
; Sets up the buttons for a multi-choice question. The turtle-based choices are
; provided in the choices-list.

  let p 0
  let y 100

  setup-ok-button
  setup-text x 140 question
  foreach choices-list
  [
    setup-button -340 y "radial button" 40 black ""
    create-picts 1
    [
      set shape ?
      setxy (item p xcor-list) (y - 1)
      set size (item p csize-list)
      set color (item p ccol-list)
    ]
    set y y - 40
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
    wait 0.1 ; slow the processor down
  ]
end

to check-the-answer [question-name question-no answer-list explanation]

  let answers []
  let answer 0
  ask buttons with [shape = "radial button 1"]
  [
    set answer (100 - ycor) / 40
    set answers lput answer answers
  ]
  set answers sort answers

  if (log-test-answers-to-a-file?)
    [
      file-open "Shapes-Answers.log"
      file-print (word question-name " : answers given = " answers "; correct answers = " answer-list)
      file-close
    ]
  

  set test-count test-count + 1
  ifelse (answers = answer-list)
    [
      set test-results-list lput
        (word "Q" question-no " Answer was correct.") test-results-list
      set test-score test-score + 1
    ]
    [
      set test-results-list lput
        (word "Q" question-no " Incorrect answer. " explanation) test-results-list
    ]
end

to clear-the-question

  ask texts
  [ die ]
  ask buttons
  [ die]
  ask picts
  [ die ]
  ask patches
  [ set pcolor green + 3 ]
  ask shape-turtles
  [ die ]
end


to go-test-lesson
; For performing tests for a specific lesson.
  let lessons
    [
      "go-test-lesson-01" "Lesson 01: Point (dot)"
      "go-test-lesson-02" "Lesson 02: Line"
      "go-test-lesson-03" "Lesson 03: Line segment"
      "go-test-lesson-04" "Lesson 04: Ray (half-line)"
      "go-test-lesson-05" "Lesson 05: Curved line"
      "go-test-lesson-06" "Lesson 06: Parallel lines"
      "go-test-lesson-07" "Lesson 07: Perpendicular lines"
      "go-test-lesson-08" "Lesson 08: Angle"
      "go-test-lesson-09" "Lesson 09: Types of angles"
      "go-test-lesson-10" "Lesson 10: Open and closed shapes"
      "go-test-lesson-11" "Lesson 11: Polygon"
      "go-test-lesson-12" "Lesson 12: Triangle"
      "go-test-lesson-13" "Lesson 13: Types of triangles"
      "go-test-lesson-14" "Lesson 14: Quadrilateral"
      "go-test-lesson-15" "Lesson 15: Rectangle"
      "go-test-lesson-16" "Lesson 16: Parallelogram"
      "go-test-lesson-17" "Lesson 17: Rhombus (diamond)"
      "go-test-lesson-18" "Lesson 18: Square"
      "go-test-lesson-19" "Lesson 19: Trapezium"
      "go-test-lesson-20" "Lesson 20: Pentagon"
      "go-test-lesson-21" "Lesson 21: Haxagon"
      "go-test-lesson-22" "Lesson 22: Heptagon"
      "go-test-lesson-23" "Lesson 23: Octagon"
      "go-test-lesson-24" "Lesson 24: Oval"
      "go-test-lesson-25" "Lesson 25: Circle"
      "go-test-lesson-26" "Lesson 26: Semi-circle"
      "go-test-lesson-27" "Lesson 27: "
      "go-test-lesson-28" "Lesson 28: "
    ]
  let p position lesson lessons
  ifelse (p = false)
    [
      user-message "Unknown lesson - stopping program"
      stop
    ]
    [
      let the-lesson item (p - 1) lessons
      run the-lesson
    ]
end

to go-test-lesson-01
; Test Lesson 01: Point (dot)

  setup-multi-choice-question-text "1. Which of these makes a point (dot)?"
    ["Your pen as you write something with it." "A needle as you prick your finger." "A drawing pin as you press it in."
     "Your tennis racket as it moves while playing tennis."]
    -90 [-31 -77 -89 40]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 01 Q1" 1 [1 2] (word
    "The correct answers were the second and the third which create a small single point in the surface rather than a continuous line.")
  clear-the-question

  setup-multi-choice-question-picts "2. Which of these is a point (dot)?"
    ["test-lesson-01-shape-1" "test-lesson-01-shape-2" "test-lesson-01-shape-3" "test-lesson-01-shape-4"]
    [40 40 40 40] [red brown orange black]
    -120 [-300 -300 -300 -300]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 01 Q2" 2 [0] (word
    "The correct answer was the first red dot labelled 'A'.")
  clear-the-question

  clear-output
  output-print "The results of the test are as follows:"

  foreach test-results-list
  [ output-explanation false ? ]
  
  output-print (word "Overall percentage-score: " precision test-result 1 " %.")
end

to go-test-lesson-02
; Test Lesson 02: Line

  setup-multi-choice-question-text "1. Which of these is a line?"
    ["Something that has no beginning and no end and goes straight in both directions"
     "Something that has a beginning point but no end point"]
    -180 [240 60]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 02 Q1" 1 [0] (word
    "The correct answer was the first one. The second one is called a ray, not a line.")
  clear-the-question

  setup-multi-choice-question-picts "2. Which of these is a straight line?"
    ["test-lesson-02-shape-2" "test-lesson-02-shape-3" "test-lesson-02-shape-1" "test-lesson-02-shape-4"]
    [100 100 100 100] [black red red green]
    -110 [-240 -240 -240 -240]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 02 Q2" 2 [2] (word
    "The correct answer was the third one.")
  clear-the-question

  setup-multi-choice-question-picts "3. Which of these is a symbol of a line?"
    ["test-lesson-02-shape-6" "test-lesson-02-shape-7" "test-lesson-02-shape-5" "test-lesson-02-shape-8"]
    [35 35 35 35] [black black black black]
    -85 [-300 -300 -300 -300]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 02 Q3" 3 [2] (word
    "The correct answer was the third one.")
  clear-the-question

  clear-output
  output-print "The results of the test are as follows:"

  foreach test-results-list
  [ output-explanation false ? ]
  
  output-print (word "Overall percentage-score: " precision test-result 1 " %.")
end

to go-test-lesson-03
; Test Lesson 03: Line segment

  setup-multi-choice-question-picts "1. Which of these a line segment?"
    ["test-lesson-03-shape-1" "test-lesson-03-shape-2" "test-lesson-03-shape-3" "test-lesson-03-shape-4"]
    [90 90 90 90] [blue red green blue]
    -120 [-260 -260 -260 -260]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 03 Q1" 1 [0] (word
    "The correct answer was the first one. The second one is called a point, not a line segment.")
  clear-the-question

  setup-multi-choice-question-picts "2. Which of these is the symbol of the line segment?"
    ["test-lesson-03-shape-6" "test-lesson-03-shape-5" "test-lesson-03-shape-7" "test-lesson-03-shape-8"]
    [40 40 40 40] [black black black black]
    0 [-260 -260 -260 -260]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 03 Q2" 2 [1] (word
    "The correct answer was the second one.")
  clear-the-question

  clear-output
  output-print "The results of the test are as follows:"

  foreach test-results-list
  [ output-explanation false ? ]
  
  output-print (word "Overall percentage-score: " precision test-result 1 " %.")

end

to go-test-lesson-04
; Test Lesson 04: Ray (half-line)

  let this-shape create-new-shape "test-lesson-04-shape-1" 180 green [-130 140] false
  setup-multi-choice-question-text "1. What is this?"
     ["A line" "A line segment" "A dot" "A ray"]
    -245 [-284 -220 -285 -287]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 04 Q1" 1 [3] (word
    "The correct answer was a ray.")
  clear-the-question

  set this-shape create-new-shape "test-lesson-04-shape-2" 180 blue [0 50] false
  setup-multi-choice-question-picts "2. What is the name of this figure?"
    ["test-lesson-04-shape-4" "test-lesson-04-shape-5" "test-lesson-04-shape-3" "test-lesson-04-shape-6"]
    [40 40 40 40] [black black black black]
    -120 [-280 -280 -280 -280]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 04 Q2" 2 [2] (word
    "The correct answer was the third one.")
  clear-the-question

  clear-output
  output-print "The results of the test are as follows:"

  foreach test-results-list
  [ output-explanation false ? ]
  
  output-print (word "Overall percentage-score: " precision test-result 1 " %.")

end

to go-test-lesson-05
; Test Lesson 05: Curved line

  let this-shape create-new-shape "test-lesson-05-shape-1" 200 blue [-100 100] false
  setup-multi-choice-question-text "1. What is this?"
     ["A line" "A line segment" "A curved line" "A ray"]
    -245 [-280 -217 -230 -284]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 05 Q1" 1 [2] (word
    "The correct answer was a curved line.")
  clear-the-question

  clear-output
  output-print "The results of the test are as follows:"

  foreach test-results-list
  [ output-explanation false ? ]
  
  output-print (word "Overall percentage-score: " precision test-result 1 " %.")

end

to go-test-lesson-06
; Test Lesson 06: Parallel lines

  let this-shape create-new-shape "test-lesson-06-shape-1" 200 blue [-100 50] false
  setup-multi-choice-question-text "1. Are these lines parallel?"
     ["Yes" "No"]
     -170 [-286 -291]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 06 Q1" 1 [0] (word
    "The correct answer was yes, the lines are parallel.")
  clear-the-question

  set this-shape create-new-shape "test-lesson-06-shape-2" 200 blue [-100 50] false
  setup-multi-choice-question-text "2. What is the name of this figure?"
    ["A || D" "AB || CD" "AC || BD" "ABCD"]
    -118 [-280 -262 -262 -280]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 06 Q2" 2 [1] (word
    "The correct answer was the first one.")
  clear-the-question

  clear-output
  output-print "The results of the test are as follows:"

  foreach test-results-list
  [ output-explanation false ? ]
  
  output-print (word "Overall percentage-score: " precision test-result 1 " %.")

end

to go-test-lesson-07
; Test Lesson 07: Perpendicular line

  let this-shape create-new-shape "test-lesson-07-shape-1" 200 blue [-50 50] false
  setup-multi-choice-question-text "1. What is this?"
    ["Parallel lines" "Lines that are not parallel" "Perpendicular lines" "A ray"]
    -250 [-226 -137 -181 -278]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 07 Q1" 1 [2] (word
    "The correct answer was perpendicular lines.")
  clear-the-question

  setup-multi-choice-question-picts "2. What is the figure for this symbol?:  (AB ⊥ DC)."
    ["test-lesson-07-shape-3" "test-lesson-07-shape-4" "test-lesson-07-shape-5" "test-lesson-07-shape-2"]
    [70 60 60 60] [blue blue blue blue]
    -50 [-280 -280 -280 -280]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 07 Q2" 2 [3] (word
    "The correct answer was the last one.")
  clear-the-question

  clear-output
  output-print "The results of the test are as follows:"

  foreach test-results-list
  [ output-explanation false ? ]
  
  output-print (word "Overall percentage-score: " precision test-result 1 " %.")

end

to go-test-lesson-08
; Test Lesson 08: Angle

  setup-multi-choice-question-picts "1. Which of these is an angle?"
    ["test-lesson-08-shape-2" "test-lesson-08-shape-1" "test-lesson-08-shape-3" "test-lesson-08-shape-4"]
    [60 60 60 60] [blue blue blue blue]
    -150 [-280 -280 -280 -280]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 08 Q1" 1 [1] (word
    "The correct answer was the second one.")
  clear-the-question

  let this-shape create-new-shape "test-lesson-08-shape-5" 200 blue [-50 50] false
  setup-multi-choice-question-text "2. What is the name of this figure?"
    ["DXW" "DX" "∠DXW" "∠DWX"]
    -150 [-277 -290 -270 -270]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 08 Q2" 2 [2] (word
    "The correct answer was the third one.")
  clear-the-question

  clear-output
  output-print "The results of the test are as follows:"

  foreach test-results-list
  [ output-explanation false ? ]
  
  output-print (word "Overall percentage-score: " precision test-result 1 " %.")

end

to go-test-lesson-09
; Test Lesson 09: Types of angles

  let this-shape create-new-shape "test-lesson-09-shape-1" 200 blue [-30 50] false
  setup-multi-choice-question-text "1. Is this angle greater than, equal to, or less than a right angle?"
    ["Less than a right angle" "Equal to a right angle" "Greater than a right angle"]
    88 [-158 -166 -136]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 09 Q1" 1 [0] (word
    "The correct answer was less than a right angle.")
  clear-the-question

  setup-multi-choice-question-picts "2. Which of the following is a right angle?"
    ["test-lesson-09-shape-2" "test-lesson-09-shape-3" "test-lesson-09-shape-4"]
    [70 70 70 70] [blue blue blue]
    -66 [-280 -280 -280]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 09 Q2" 2 [2] (word
    "The correct answer was first one.")
  clear-the-question

  setup-multi-choice-question-picts "3. Which of the following is an acute angle?"
    ["test-lesson-09-shape-2" "test-lesson-09-shape-3" "test-lesson-09-shape-4"]
    [70 70 70 70] [blue blue blue]
    -66 [-280 -280 -280]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 09 Q2" 3 [0] (word
    "The correct answer was third one.")
  clear-the-question

  setup-multi-choice-question-picts "4. Which of the following is an obtuse angle?"
    ["test-lesson-09-shape-2" "test-lesson-09-shape-3" "test-lesson-09-shape-4"]
    [70 70 70 70] [blue blue blue]
    -66 [-280 -280 -280]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 09 Q2" 4 [1] (word
    "The correct answer was third one.")
  clear-the-question
  
  set this-shape create-new-shape "test-lesson-09-shape-5" 200 blue [-30 50] false
  setup-multi-choice-question-text "5. Using a protractor, what is the measurement of this angle?"
    ["90 degrees" "120 degrees"]
    67 [-242 -235]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 09 Q3" 5 [1] (word
    "The correct answer was 120 degrees.")
  clear-the-question

  clear-output
  output-print "The results of the test are as follows:"

  foreach test-results-list
  [ output-explanation false ? ]
  
  output-print (word "Overall percentage-score: " precision test-result 1 " %.")

end

to go-test-lesson-10
; Test Lesson 10: Open and closed shapes

  let this-shape create-new-shape "test-lesson-10-shape-1" 200 blue [-30 50] false
  setup-multi-choice-question-text "1. Is this shape open or closed?"
    ["Open" "Closed"]
    -139 [-278 -269]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 10 Q1" 1 [1] (word
    "The correct answer was closed.")
  clear-the-question

  setup-multi-choice-question-picts "2. Which of these is an open shape?"
    ["test-lesson-10-shape-2" "test-lesson-10-shape-3" "test-lesson-10-shape-4" "test-lesson-10-shape-5"]
    [70 70 70 70] [red green blue black]
    -105 [-280 -280 -280 -280]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 10 Q2" 2 [1 2] (word
    "The correct answer was the first one.")
  clear-the-question

  clear-output
  output-print "The results of the test are as follows:"

  foreach test-results-list
  [ output-explanation false ? ]
  
  output-print (word "Overall percentage-score: " precision test-result 1 " %.")

end

to go-test-lesson-11
; Test Lesson 11: Polygon

  let this-shape create-new-shape "test-lesson-11-shape-1" 120 blue [-100 100] false
  setup-multi-choice-question-text "1. Is this a Polygon shape?"
    ["No" "Yes"]
    -171 [-280 -278]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 11 Q1" 1 [1] (word
    "The correct answer was yes, this is a polygon shape.")
  clear-the-question

  set this-shape create-new-shape "test-lesson-11-shape-2" 220 blue [50 50] false
  setup-multi-choice-question-text "2. Which are the sides of this polygon?"
    ["F, H, L and K" "FH, HK, KL and LF" "FHK, HKL, KLF and LFH"]
    -20 [-238 -205 -170]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 11 Q2" 2 [1] (word
    "The correct answer was the second one.")
  clear-the-question

  set this-shape create-new-shape "test-lesson-11-shape-2" 220 blue [50 50] false
  setup-multi-choice-question-text "3. Which are the angles of this polygon?"
    ["F, H, L and K" "FH, HK, KL and LF" "FHK, HKL, KLF and LFH"]
    -15 [-238 -205 -170]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 11 Q2" 3 [2] (word
    "The correct answer was the third one.")
  clear-the-question

  set this-shape create-new-shape "test-lesson-11-shape-2" 220 blue [50 50] false
  setup-multi-choice-question-text "4. Which are the vertices of this polygon?"
    ["F, H, L and K" "FH, HK, KL and LF" "FHK, HKL, KLF and LFH"]
    -10 [-238 -205 -170]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 11 Q2" 4 [0] (word
    "The correct answer was the first one.")
  clear-the-question

  set this-shape create-new-shape "test-lesson-11-shape-3" 220 blue [50 50] false
  setup-multi-choice-question-text "5. How many sides does this polygon have?"
    ["3" "4" "5" "6"]
    -53 [-290 -290 -290 -290]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 11 Q3" 5 [2] (word
    "The correct answer was four.")
  clear-the-question

  setup-multi-choice-question-text "6. Which of the following are names of polygons?"
    ["Triangle" "Square" "Circle" "Hexagon" "Rectangle"]
    -25 [-263 -271 -280 -258 -253]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 11 Q4" 6 [0 1 3 4] (word
    "A circle is not a polygon. Everything else listed is.")
  clear-the-question

  set this-shape create-new-shape "test-lesson-11-shape-4" 220 blue [50 50] false
  setup-multi-choice-question-text "7. Is this shape a regular polygon or an irregular?"
    ["regular" "irregular"]
    -9 [-270 -260]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 11 Q5" 7 [1] (word
    "The correct answer was regular.")
  clear-the-question

  clear-output
  output-print "The results of the test are as follows:"

  foreach test-results-list
  [ output-explanation false ? ]
  
  output-print (word "Overall percentage-score: " precision test-result 1 " %.")

end

to go-test-lesson-12
; Test Lesson 12: Triangle

  setup-multi-choice-question-picts "1. Which of these a triangle?"
     ["test-lesson-12-shape-2" "test-lesson-12-shape-3" "test-lesson-12-shape-1" "test-lesson-12-shape-4"]
    [60 60 60 60] [blue blue blue blue]
    -155 [-280 -280 -280 -280]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 12 Q1" 1 [2] (word
    "The correct answer was the third one.")
  clear-the-question

  let this-shape create-new-shape "test-lesson-12-shape-5" 220 blue [50 50] false
  setup-multi-choice-question-text "2. Which are the sides of this triangle?"
    ["AFH, FHA and HAF" "A, F and H" "AF, FH and HA"]
    -90 [-190 -246 -218]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 12 Q2" 2 [2] (word
    "The correct answer was type.")
  clear-the-question

  set this-shape create-new-shape "test-lesson-12-shape-5" 220 blue [50 50] false
  setup-multi-choice-question-text "3. Which are the vertices of this triangle?"
    ["AFH, FHA and HAF" "A, F and H" "AF, FH and HA"]
    -74 [-190 -246 -218]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 12 Q2" 3 [1] (word
    "The correct answer was type.")
  clear-the-question

  set this-shape create-new-shape "test-lesson-12-shape-5" 220 blue [50 50] false
  setup-multi-choice-question-text "4. Which are the angles of this triangle?"
    ["AFH, FHA and HAF" "A, F and H" "AF, FH and HA"]
    -85 [-190 -246 -218]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 12 Q2" 4 [0] (word
    "The correct answer was type.")
  clear-the-question
  
  setup-multi-choice-question-text "5. You have a shape that has 3 sides and 3 angles. Which shape can you make?"
    ["Rectangle" "Square" "Rhombus" "Triangle"]
    190 [-250 -268 -253 -259]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 12 Q3" 5 [3] (word
    "The correct answer was Print 120 degree.")
  clear-the-question

  clear-output
  output-print "The results of the test are as follows:"

  foreach test-results-list
  [ output-explanation false ? ]
  
  output-print (word "Overall percentage-score: " precision test-result 1 " %.")

end

to go-test-lesson-13
; Test Lesson 13: Types of triangles

  let this-shape create-new-shape "test-lesson-13-shape-1" 220 blue [50 50] false
  setup-multi-choice-question-text "1. What kind of triangle is this?"
      ["Scalene" "Isosceles" "Equilateral"]
      -140 [-262 -255 -245]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 13 Q1" 1 [2] (word
    "The correct answer was equilateral.")
  clear-the-question

  set this-shape create-new-shape "test-lesson-13-shape-2" 220 blue [50 50] false
  setup-multi-choice-question-text "2. What type of triangle is this? (Note: there may be more than one answer)"
      ["Scalene" "Isosceles" "Equilateral" "Right-angled"]
      162 [-264 -255 -244 -226]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 13 Q2" 2 [1 3] (word
    "The shape is an isosceles triangle and a right-angled triangle.")
  clear-the-question

  set this-shape create-new-shape "test-lesson-13-shape-3" 220 blue [50 50] false
  setup-multi-choice-question-text "3. What type of triangle is this? (Note: there may be more than one answer)"
      ["Scalene" "Isosceles" "Equilateral" "Right-angled"]
      162 [-264 -255 -244 -226]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 13 Q2" 3 [1] (word
    "The shape is an isosceles triangle.")
  clear-the-question

  set this-shape create-new-shape "test-lesson-13-shape-4" 220 blue [50 50] false
  setup-multi-choice-question-text "4. What type of triangle is this? (Note: there may be more than one answer)"
      ["Scalene" "Isosceles" "Equilateral" "Right-angled"]
      162 [-264 -255 -244 -226]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 13 Q2" 4 [2] (word
    "The shape is an equilateral triangle.")
  clear-the-question

  set this-shape create-new-shape "test-lesson-13-shape-5" 220 blue [50 50] false
  setup-multi-choice-question-text "5. What type of triangle is this? (Note: there may be more than one answer)"
      ["Scalene" "Isosceles" "Equilateral" "Right-angled"]
      162 [-264 -255 -244 -226]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 13 Q2" 5 [0] (word
    "The shape is a scalene triangle.")
  clear-the-question

  set this-shape create-new-shape "test-lesson-13-shape-6" 220 blue [50 50] false
  setup-multi-choice-question-text "6. What type of triangle is this? (Note: there may be more than one answer)"
      ["Scalene" "Isosceles" "Equilateral" "Right-angled"]
      162 [-264 -255 -244 -226]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 13 Q2" 6 [0 3] (word
    "The shape is both a scalene triangle and a right-angled triangle.")
  clear-the-question
  
  setup-multi-choice-question-text "7. The shape has two equal angles and a third that is different. Which shapes can you make?"
    ["Isosceles triangle" "Equilateral triangle" "Right-angled triangle" "Scalene triangle"]
    280 [-202 -190 -172 -210]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 13 Q3" 7 [0 2] (word
    "The correct answer was both an isosceles triangle and a right-angled triangle.")
  clear-the-question

  clear-output
  output-print "The results of the test are as follows:"

  foreach test-results-list
  [ output-explanation false ? ]
  
  output-print (word "Overall percentage-score: " precision test-result 1 " %.")

end

to go-test-lesson-14
; Test Lesson 14: Quadrilateral

  let this-shape create-new-shape "test-lesson-14-shape-1" 220 blue [50 50] false
  setup-multi-choice-question-text "1. Is this a quadrilateral shape?"
      ["Yes" "No"]
     -138 [-286 -291]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 14 Q1" 1 [0] (word
    "The correct answer was yes, it is a quadrilateral.")
  clear-the-question

  setup-multi-choice-question-text "2. How many angles do quadrilaterals have?"
    ["3" "4" "5" "6"]
    -49 [-300 -300 -300 -300]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 14 Q2" 2 [1] (word
    "The correct answer was 4.")
  clear-the-question
  
  set this-shape create-new-shape "test-lesson-14-shape-2" 220 blue [50 50] false
  setup-multi-choice-question-text "3. What shape is this? (Note: there may be more than one answer)"
     ["Rectangle" "Square" "Parallelogram" "Rhombus" "Trapezoid"]
     96 [-251 -270 -224 -255 -250]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 14 Q3" 3 [2 3] (word
    "The correct answers were both a rhombus and a parallelogram.")
  clear-the-question

  set this-shape create-new-shape "test-lesson-14-shape-3" 220 blue [50 50] false
  setup-multi-choice-question-text "4. What shape is this? (Note: there may be more than one answer)"
     ["Rectangle" "Square" "Parallelogram" "Rhombus" "Trapezoid"]
     96 [-251 -270 -224 -255 -250]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 14 Q3" 4 [2 3] (word
    "The correct answers were both a rhombus and a parallelogram.")
  clear-the-question

  set this-shape create-new-shape "test-lesson-14-shape-4" 220 blue [50 50] false
  setup-multi-choice-question-text "5. What shape is this? (Note: there may be more than one answer)"
      ["Rectangle" "Square" "Parallelogram" "Rhombus" "Trapezoid"]
     96 [-251 -270 -224 -255 -250]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 14 Q3" 5 [0 2] (word
    "The correct answers were both a rectangle and a parallelogram.")
  clear-the-question

  set this-shape create-new-shape "test-lesson-14-shape-5" 220 blue [50 50] false
  setup-multi-choice-question-text "6. What shape is this? (Note: there may be more than one answer)"
      ["Rectangle" "Square" "Parallelogram" "Rhombus" "Trapezoid"]
     96 [-251 -270 -224 -255 -250]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 14 Q3" 6 [2] (word
    "The correct answer was a parallelogram.")
  clear-the-question

  set this-shape create-new-shape "test-lesson-14-shape-6" 220 blue [50 50] false
  setup-multi-choice-question-text "7. What shape is this? (Note: there may be more than one answer)"
      ["Rectangle" "Square" "Parallelogram" "Rhombus" "Trapezoid"]
     96 [-251 -270 -224 -255 -250]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 14 Q3" 7 [4] (word
    "The correct answer was a trapezoid.")
  clear-the-question

  set this-shape create-new-shape "test-lesson-14-shape-7" 220 blue [50 50] false
  setup-multi-choice-question-text "8. What shape is this? (Note: there may be more than one answer)"
      ["Rectangle" "Square" "Parallelogram" "Rhombus" "Trapezoid"]
     96 [-251 -270 -224 -255 -250]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 14 Q3" 8 [1 2 3] (word
    "A square is also a parallelogram and a rhombus.")
  clear-the-question

  setup-multi-choice-question-text "9. Your friend drew a shape that had 4 sides, with opposite sides parallel. Which shape could he have drawn?"
      ["Isosceles triangle" "Parallelogram" "Oval" "Triangle"]
    395 [-192 -216 -280 -254]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 14 Q5" 9 [1] (word
    "The correct answer was a parallelogram.")
  clear-the-question
  
  clear-output
  output-print "The results of the test are as follows:"

  foreach test-results-list
  [ output-explanation false ? ]
  
  output-print (word "Overall percentage-score: " precision test-result 1 " %.")

end

to go-test-lesson-15
; Test Lesson 15: Rectangle

  setup-multi-choice-question-picts "1. Which of these is a rectangle?"
     ["test-lesson-15-shape-2" "test-lesson-15-shape-3" "test-lesson-15-shape-1" "test-lesson-15-shape-4"]
    [50 50 50 50] [blue blue blue blue]
    -130 [-290 -290 -290 -290]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 15 Q1" 1 [2] (word
    "The correct answer was the third one.")
  clear-the-question
  
  let this-shape create-new-shape "test-lesson-15-shape-5" 220 blue [50 50] false
  setup-multi-choice-question-text "2. How many pairs of equal length sides does this rectangle have?"
    ["0" "1" "2" "3" "4"]
    100 [-300 -300 -300 -300 -300]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 15 Q2" 2 [2] (word
    "The correct answer was two pairs.")
  clear-the-question

  clear-output
  output-print "The results of the test are as follows:"

  foreach test-results-list
  [ output-explanation false ? ]
  
  output-print (word "Overall percentage-score: " precision test-result 1 " %.")
 
end

to go-test-lesson-16
; Test Lesson 16: Parallelogram

  let this-shape create-new-shape "test-lesson-16-shape-1" 200 blue [-100 50] false
  setup-multi-choice-question-text "1. Is this a parallelogram shape?"
    ["Yes" "No"]
     -131 [-286 -291]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 16 Q1" 1 [0] (word
    "The correct answer was yes, it is a parallelogram.")
  clear-the-question
  
  set this-shape create-new-shape "test-lesson-16-shape-2" 220 blue [50 50] false
  setup-multi-choice-question-text "2. How many pairs of parallel sides does this parallelogram have?"
    ["1" "2" "3" "4"]
    100 [-300 -300 -300 -300]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 16 Q2" 2 [1] (word
    "The correct answer was two pair (the top and bottom lines, and the left and right).")
  clear-the-question

  clear-output
  output-print "The results of the test are as follows:"

  foreach test-results-list
  [ output-explanation false ? ]
  
  output-print (word "Overall percentage-score: " precision test-result 1 " %.")
 
end

to go-test-lesson-17
; Test Lesson 17: Rhombus (diamond)

  setup-multi-choice-question-picts "1. Which of these is a rhombus?"
     ["test-lesson-17-shape-1" "test-lesson-17-shape-2" "test-lesson-17-shape-3" "test-lesson-17-shape-4"]
    [50 50 50 50] [blue blue blue blue]
    -137 [-290 -290 -290 -290]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 17 Q1" 1 [0] (word
    "The correct answer was the first one.")
  clear-the-question

  let this-shape create-new-shape "test-lesson-17-shape-5" 220 blue [50 50] false
  setup-multi-choice-question-text "2. How many equal sides does this rhombus have?"
    ["0" "1" "2" "3" "4"]
    -5 [-300 -300 -300 -300 -300]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 17 Q2" 2 [4] (word
    "The correct answer was four.")
  clear-the-question
  
  clear-output
  output-print "The results of the test are as follows:"

  foreach test-results-list
  [ output-explanation false ? ]
  
  output-print (word "Overall percentage-score: " precision test-result 1 " %.")
   
end

to go-test-lesson-18
; Test Lesson 18: Square

  let this-shape create-new-shape "test-lesson-18-shape-1" 200 blue [-100 50] false
  setup-multi-choice-question-text "1. Is this a square shape?"
    ["Yes" "No"]
     -175 [-286 -291]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 18 Q1" 1 [0] (word
    "The correct answer was yes, it is a square.")
  clear-the-question
  
  set this-shape create-new-shape "test-lesson-18-shape-2" 200 blue [-100 50] false
  setup-multi-choice-question-text "2. How many equal angles does this square have?"
    ["0" "1" "2" "3" "4"]
    -30 [-300 -300 -300 -300 -300]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 18 Q2" 2 [4] (word
    "The correct answer was four. They are all right angles.")
  clear-the-question
  
  clear-output
  output-print "The results of the test are as follows:"

  foreach test-results-list
  [ output-explanation false ? ]
  
  output-print (word "Overall percentage-score: " precision test-result 1 " %.")
   
end

to go-test-lesson-19
; Test Lesson 19: Trapezium

  setup-multi-choice-question-picts "1. Which of these is a trapezium?"
     ["test-lesson-19-shape-2" "test-lesson-19-shape-3" "test-lesson-19-shape-1" "test-lesson-19-shape-4"]
    [50 50 50 50] [blue blue blue blue]
    -125 [-290 -290 -290 -290]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 19 Q1" 1 [2] (word
    "The correct answer was the third one.")
  clear-the-question 

  setup-multi-choice-question-picts "2. Which of these is an isosceles trapezoid?"
     ["test-lesson-19-shape-5" "test-lesson-19-shape-6"]
    [60 60] [blue blue]
    -53 [-290 -290]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 19 Q2" 2 [0] (word
    "The correct answer was the first one.")
  clear-the-question

  let this-shape create-new-shape "test-lesson-19-shape-7" 200 blue [-100 50] false
  setup-multi-choice-question-text "3. How many pairs of equal angles does this isosceles trapezoid have?"
    ["0" "1" "2" "3" "4"]
    128 [-300 -300 -300 -300 -300]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 19 Q3" 3 [2] (word
    "The correct answer was two pairs.")
  clear-the-question
  
  clear-output
  output-print "The results of the test are as follows:"

  foreach test-results-list
  [ output-explanation false ? ]
  
  output-print (word "Overall percentage-score: " precision test-result 1 " %.")
   
end

to go-test-lesson-20
; Test Lesson 20: Pentagon

  setup-multi-choice-question-text "1. You have a shape which has 5 sides and 5 angles. Which shape can you make?"
      ["Parallelogram" "Trapezium" "Pentagon" "Hexagon"]
    200 [-220 -242 -250 -252]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 20 Q1" 1 [2] (word
    "The correct answer was a pentagon.")
  clear-the-question
  
  setup-multi-choice-question-picts "2. Which of these is an irregular pentagon?"
     ["test-lesson-20-shape-1" "test-lesson-20-shape-2"]
    [60 60] [blue blue]
    -65 [-285 -285]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 20 Q2" 2 [1] (word
    "The correct answer was the second one.")
  clear-the-question
  
  clear-output
  output-print "The results of the test are as follows:"

  foreach test-results-list
  [ output-explanation false ? ]
  
  output-print (word "Overall percentage-score: " precision test-result 1 " %.")
   
end

to go-test-lesson-21
; Test Lesson 21: Haxagon

  setup-multi-choice-question-text "1. A shape has 6 angles. What is it called?"
      ["Pentagon" "Parallelogram" "Irregular Pentagon" "Hexagon"]
    -68 [-250 -220 -186 -252]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 21 Q1" 1 [3] (word
    "The correct answer was a hexagon.")
  clear-the-question
  
  setup-multi-choice-question-picts "2. Which of these is a regular hexagon?"
     ["test-lesson-21-shape-1" "test-lesson-21-shape-2"]
    [55 55] [blue blue]
    -83 [-285 -285]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 21 Q2" 2 [0] (word
    "The correct answer was the first one.")
  clear-the-question
  
  clear-output
  output-print "The results of the test are as follows:"

  foreach test-results-list
  [ output-explanation false ? ]
  
  output-print (word "Overall percentage-score: " precision test-result 1 " %.")
   
end

to go-test-lesson-22
; Test Lesson 22: Heptagon

  setup-multi-choice-question-picts "1. Which of these is a heptagon?"
     ["test-lesson-22-shape-1" "test-lesson-22-shape-2" "test-lesson-22-shape-3" "test-lesson-22-shape-4"]
    [55 55 55 55] [blue blue blue blue]
    -100 [-285 -285 -285 -285]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 22 Q1" 1 [0] (word
    "The correct answer was the first one.")
  clear-the-question
  
  setup-multi-choice-question-picts "2. Which of these is an irregular heptagon?"
     ["test-lesson-22-shape-6" "test-lesson-22-shape-5"]
    [40 40] [blue blue]
    -60 [-285 -285]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 22 Q2" 2 [0] (word
    "The correct answer was the first one.")
  clear-the-question
  
  clear-output
  output-print "The results of the test are as follows:"

  foreach test-results-list
  [ output-explanation false ? ]
  
  output-print (word "Overall percentage-score: " precision test-result 1 " %.")
   
end

to go-test-lesson-23
; Test Lesson 23: Octagon

  setup-multi-choice-question-text "1. You have a shape that has 8 equal sides and 8 equal angles. Which shape can you make?"
      ["Pentagon" "Hexagon" "Regular octagon" "Irregular octagon"]
    270 [-250 -252 -200 -192]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 23 Q1" 1 [2] (word
    "The correct answer was a regular octagon.")
  clear-the-question
  
  let this-shape create-new-shape "test-lesson-23-shape-1" 200 blue [-100 50] false
  setup-multi-choice-question-text "2. Is this an octagon shape?"
    ["Yes" "No"]
     -162 [-286 -291]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 23 Q2" 2 [0] (word
    "The correct answer was yes, it is an octagon.")
  clear-the-question
  
  clear-output
  output-print "The results of the test are as follows:"

  foreach test-results-list
  [ output-explanation false ? ]
  
  output-print (word "Overall percentage-score: " precision test-result 1 " %.")
   
end

to go-test-lesson-24
; Test Lesson 24: Oval

  setup-multi-choice-question-picts "1. Which of these is an oval?"
     ["test-lesson-24-shape-2" "test-lesson-24-shape-1" "test-lesson-24-shape-3" "test-lesson-24-shape-4"]
    [50 45 50 50] [blue blue blue blue]
    -159 [-280 -280 -280 -280]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 24 Q1" 1 [1] (word
    "The correct answer was the second one.")
  clear-the-question
   
   clear-output
  output-print "The results of the test are as follows:"

  foreach test-results-list
  [ output-explanation false ? ]
  
  output-print (word "Overall percentage-score: " precision test-result 1 " %.")
   
end

to go-test-lesson-25
; Test Lesson 25: Circle

  setup-multi-choice-question-picts "1. Which of these is a circle?"
     ["test-lesson-25-shape-3" "test-lesson-25-shape-1" "test-lesson-25-shape-2" "test-lesson-25-shape-4"]
    [50 50 45 50] [blue blue blue blue]
    -161 [-280 -280 -280 -280]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 25 Q1" 1 [1] (word
    "The correct answer was the second one.")
  clear-the-question
  
  setup-multi-choice-question-picts "2. Which figure shows the center point?"
     ["test-lesson-25-shape-6" "test-lesson-25-shape-7" "test-lesson-25-shape-8" "test-lesson-25-shape-5"]
    [50 50 50 50] [blue blue blue blue]
    -80 [-280 -280 -280 -280]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 25 Q2" 2 [3] (word
    "The correct answer was the fourth one.")
  clear-the-question
  
  let this-shape create-new-shape "test-lesson-25-shape-9" 200 blue [-100 50] false
  setup-multi-choice-question-text "3. What is the line AF in this figure"
      ["Radius" "Circumference" "Diameter" "Center point"]
    -109 [-269 -215 -252 -227]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 25 Q3" 3 [0] (word
    "The correct answer was a radius.")
  clear-the-question
  
  setup-multi-choice-question-picts "4. Which figure shows the diameter?"
     ["test-lesson-25-shape-11" "test-lesson-25-shape-10" "test-lesson-25-shape-12" "test-lesson-25-shape-13"]
    [50 50 50 50] [blue blue blue blue]
    -100 [-280 -280 -280 -280]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 25 Q4" 4 [1] (word
    "The correct answer was the second one.")
  clear-the-question
  
  setup-multi-choice-question-text "5. A circumference is which of the following?"
      ["Straight line" "Regular curved line" "Parallel Lines" "Line segment"]
    -47 [-227 -180 -222 -220]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 25 Q5" 5 [1] (word
    "The correct answer was a regular curved line.")
  clear-the-question
  
  clear-output
  output-print "The results of the test are as follows:"

  foreach test-results-list
  [ output-explanation false ? ]
  
  output-print (word "Overall percentage-score: " precision test-result 1 " %.")
   
end

to go-test-lesson-26
; Test Lesson 26: Semi-circle

  let this-shape create-new-shape "test-lesson-26-shape-1" 200 blue [-50 30] false
  setup-multi-choice-question-text "1. Is this is a semi-circle shape?"
    ["Yes" "No"]
     -136 [-286 -291]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 26 Q1" 1 [0] (word
    "The correct answer was yes, it is a semi-circle.")
  clear-the-question
  
  setup-multi-choice-question-picts "2. Which figure shows the radius?"
     ["test-lesson-26-shape-3" "test-lesson-26-shape-4" "test-lesson-26-shape-5" "test-lesson-26-shape-2"]
    [50 50 50 50] [blue blue blue blue]
    -118 [-280 -280 -280 -280]
  display
  wait 0.5
  ask-the-question
  check-the-answer "Lesson 26 Q2" 2 [1] (word
    "The correct answer was the second one.")
  clear-the-question
  
   clear-output
  output-print "The results of the test are as follows:"

  foreach test-results-list
  [ output-explanation false ? ]
  
  output-print (word "Overall percentage-score: " precision test-result 1 " %.")
   
end

to go-test-lesson-27
; Test Lesson 27: 

end

to go-test-lesson-28
; Test Lesson 28: 

end

; The following procedures have been created in order that the logger model can be
; used to "mark up" this model to generate another model that will automatically
; log all user interactions
to go-circle
  go-shape "shape circle"
end

to go-oval
  go-shape "shape oval"
end

to go-semi-circle
  go-shape "shape semi-circle"
end

to go-scalene-triangle
  go-shape "shape scalene triangle"
end

to go-isosceles-triangle
  go-shape "shape isosceles triangle"
end

to go-equilateral-triangle
  go-shape "shape equilateral triangle"
end

to go-square
  go-shape "shape square"
end

to go-rectangle
  go-shape "shape rectangle"
end

to go-parallelogram
  go-shape "shape parallelogram"
end

to go-trapezoid
  go-shape "shape trapezoid"
end

to go-pentagon
  go-shape "shape pentagon"
end

to go-hexagon
  go-shape "shape hexagon"
end

to go-septagon
  go-shape "shape septagon"
end

to go-octagon
  go-shape "shape octagon"
end

to speak-text [text-to-be-spoken]
; Speaks the text specified by text-to-be-spoken.

  let command (word "say -v " voice-to-be-spoken " \"" text-to-be-spoken "\"")
  exec:run command
end

to output-and-speak-text [text]
; Outputs and speaks the text.

  output-print text
  wait 0.2
  speak-text text
end

to output-and-speak-information [this-shape]
; Outputs information about the shape.

  let info-list
    [
      "shape circle"               "A circle shape is a shape whose outer line of points are all the same distance from a given centre point in the middle of the circle."
      "shape oval"                 "An oval shape is a shape that resembles an outline of an egg. "
      "shape semi-circle"          "A semi-circle shape is half of a circle shape (imagine cutting a circle in half, and you will end up with two semi-circles)."
      "shape scalene triangle"     "A triangle shape has three sides. A scalene triangle is a triangle with sides that are all unequal in length."
      "shape isosceles triangle"   "A triangle shape has three sides. An isosceles triangle is a triangle with two sides that are equal in length."
      "shape equilateral triangle" "A triangle shape has three sides. An equilateral triangle is a triangle with sides all the same length."
      "shape square"               "A square shape has four sides that are all the same length. It also has four equal angles (all right angles or 90 degrees)."
      "shape rectangle"            "A rectangle shape has four sides, with opposite sides being equal in length. It also has four equal angles (all right angles or 90 degrees)."
      "shape parallelogram"        "A parallelogram shape has two pairs of parallel sides. Opposite sides have equal lengths, and opposite angles are also equal."
      "shape trapezoid"            "A trapezoid shape has at least one pair of parallel sides."
      "shape pentagon"             "A pentagon shape has 5 sides."
      "shape hexagon"              "A hexagon shape has 6 sides."
      "shape septagon"             "A septagon shape has 7 sides."
      "shape octagon"              "An octagon shape has 8 sides and 8 equal angles."
    ]
  let p position this-shape info-list
  let info item (p + 1) info-list
  clear-output
  output-print info
  wait 0.2
  speak-text info     
end

to output-explanation-list [text-list-to-be-output]
; Writes out the text list to the output box.

  foreach text-list-to-be-output
  [ output-print ? ]
end

to output-explanation [print-name? text-to-be-output]
; Outputs the text string text-to-be-output to the output box.

  if (print-name?)
    [ output-print (word voice-to-be-spoken " says:")
      output-print "" ]
  let text-list split-text-into-list 150 text-to-be-output
  output-explanation-list text-list
end

to speak-explanation [text-to-be-spoken]
; Speaks the text specified by text-to-be-spoken.

  if (speak-the-text?)
    [
      let command (word "say -v " voice-to-be-spoken " \"" text-to-be-spoken "\"")
      exec:run command
    ]
end

to output-and-speak-explanation [print-name? text-to-be-spoken]

  output-explanation print-name? text-to-be-spoken
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

to shoot-at-leftmost-shape [this-shape]
; "Shoots" at the leftmost shape, and will destroy it if "this-shape" matches the actual shape
; of the leftmost shape.

  let leftmost-shape min-one-of shape-turtles [pxcor]

  if (leftmost-shape != nobody) and not game-over?
  [
    ask leftmost-shape
    [
      ifelse (shape = this-shape)
        [
          sound:play-NOTE "ACOUSTIC GRAND PIANO" game-note 64 0.3 ; plays an acoustic grand piano sound
          set game-note game-note + 1
          set game-kills game-kills + 1
          set game-score game-score + 20
          die
        ]
        [ ; fired at the wrong shape
          sound:play-note "TRUMPET" 60 64 0.5 ; plays a trumpet sound for 0.5 seconds
          set game-lives game-lives - 1
          if (game-lives <= 0)
             [
               set game-over? true
               set game-over-message "No more lives left! Game over."
               stop
             ]
        ]
    ]
  ]
end
@#$#@#$#@
GRAPHICS-WINDOW
169
10
988
375
400
165
1.01
1
14
1
1
1
0
0
0
1
-400
400
-165
165
0
0
1
ticks
30.0

BUTTON
1
123
160
179
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

SLIDER
1104
116
1249
149
turtle-speed
turtle-speed
1
100
5
1
1
NIL
HORIZONTAL

BUTTON
1
230
160
287
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

MONITOR
991
236
1095
281
Score
game-score
0
1
11

TEXTBOX
14
55
125
88
Shapes
24
105.0
1

BUTTON
314
392
446
425
Scalene Triangle
go-scalene-triangle
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
487
376
581
409
Square
go-square
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
487
409
581
442
Rectangle
go-rectangle
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
627
409
711
442
Hexagon
go-hexagon
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
751
393
838
426
Circle
go-circle
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
751
426
838
459
Oval
go-oval
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
627
376
711
409
Pentagon
go-pentagon
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
627
475
711
508
Octagon
go-octagon
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
487
442
581
475
Parallelogram
go-parallelogram
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
487
475
581
508
Trapezoid
go-trapezoid
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
314
425
446
458
Isosceles Triangle
go-isosceles-triangle
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
314
458
446
491
Equilateral Triangle
go-equilateral-triangle
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
627
442
711
475
Septagon
go-septagon
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
751
459
838
492
Semi-circle
go-semi-circle
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
990
11
1248
56
lesson
lesson
"Lesson 01: Point (dot)" "Lesson 02: Line" "Lesson 03: Line segment" "Lesson 04: Ray (half-line)" "Lesson 05: Curved line" "Lesson 06: Parallel lines" "Lesson 07: Perpendicular lines" "Lesson 08: Angle" "Lesson 09: Types of angles" "Lesson 10: Open and closed shapes" "Lesson 11: Polygon" "Lesson 12: Triangle" "Lesson 13: Types of triangles" "Lesson 14: Quadrilateral" "Lesson 15: Rectangle" "Lesson 16: Parallelogram" "Lesson 17: Rhombus (diamond)" "Lesson 18: Square" "Lesson 19: Trapezium" "Lesson 20: Pentagon" "Lesson 21: Haxagon" "Lesson 22: Heptagon" "Lesson 23: Octagon" "Lesson 24: Oval" "Lesson 25: Circle" "Lesson 26: Semi-circle"
15

MONITOR
991
101
1095
146
Level
game-level
17
1
11

MONITOR
991
146
1095
191
Lives Remaining
game-lives
17
1
11

MONITOR
991
191
1095
236
Shapes killed
game-kills
17
1
11

SLIDER
1104
149
1249
182
shapes-per-level
shapes-per-level
10
100
10
10
1
NIL
HORIZONTAL

TEXTBOX
10
35
160
53
Learn About:
1
0.0
1

TEXTBOX
12
33
162
51
Learn About:
12
0.0
1

OUTPUT
2
510
1253
607
14

CHOOSER
1104
182
1249
227
voice-to-be-spoken
voice-to-be-spoken
"Agnes" "Albert" "Alex" "Bruce" "Vicki" "Victoria"
2

BUTTON
1
179
160
230
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

TEXTBOX
209
412
296
472
Shape Buttons
16
106.0
1

BUTTON
3
392
145
449
Show All Shapes
show-all-shapes
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
990
56
1248
101
shapes-in-the-game
shapes-in-the-game
"All shapes" "Triangular shapes" "Shapes with four sides" "Circular shapes" "Shapes with more than four sides"
0

SWITCH
991
281
1251
314
choose-a-specific-lesson?
choose-a-specific-lesson?
0
1
-1000

SWITCH
991
314
1251
347
log-test-answers-to-a-file?
log-test-answers-to-a-file?
1
1
-1000

BUTTON
970
404
1101
460
Setup
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

TEXTBOX
1111
413
1261
441
Press the Setup button\nbefore starting
11
0.0
1

SWITCH
1104
227
1249
260
speak-the-text?
speak-the-text?
0
1
-1000

BUTTON
1
287
160
343
Chat with me
go-chat
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SWITCH
991
347
1251
380
debug-conversation?
debug-conversation?
1
1
-1000

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
Polygon -1 true false 60 120 105 225 120 285 180 285 195 225 240 120

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

shape circle
true
0
Circle -7500403 true true 15 15 270
Circle -16777216 false false 15 15 270

shape equilateral triangle
true
0
Polygon -7500403 true true 0 255 150 15 300 255
Polygon -16777216 false false 0 255 150 15 300 255

shape hexagon
true
0
Polygon -7500403 true true 30 150 90 45 210 45 270 150 210 255 90 255
Polygon -16777216 false false 30 150 90 45 210 45 270 150 210 255 90 255 30 150

shape isosceles triangle
true
0
Polygon -16777216 true false 30 285 150 15
Polygon -7500403 true true 60 270 150 30 240 270
Polygon -16777216 false false 60 270 150 30 240 270

shape octagon
true
0
Polygon -7500403 true true 45 150 75 75 150 45 225 75 255 150 225 225 150 255 75 225
Polygon -16777216 false false 45 150 75 75 150 45 225 75 255 150 225 225 150 255 75 225

shape oval
true
0
Polygon -7500403 true true 77 146 76 135 78 124 79 108 81 95 82 85 85 74 86 64 91 49 101 32 109 22 120 13 128 8 139 2 149 -1 157 -1 162 -1 168 1 176 4 180 6 188 13 190 14 196 19 201 29 206 39 211 50 216 61 219 72 222 85 223 97 226 113 226 128 227 139 227 152 227 161 225 171 225 179 223 193 220 208 218 224 213 233 213 238 209 247 204 259 195 272 185 285 179 288 163 297 146 296 130 291 121 285 113 278 108 267 102 258 97 247 94 239 90 229 85 213 80 194 79 183 76 170 76 155 76 147
Polygon -16777216 false false 77 149 76 139 76 131 77 124 77 113 80 98 81 87 83 79 85 67 88 58 89 53 94 43 97 38 103 31 108 23 116 17 121 11 131 6 141 1 147 1 153 1 162 1 169 1 176 6 185 10 190 15 193 20 199 29 204 38 207 46 211 54 214 62 217 70 219 80 220 87 223 99 224 109 225 118 225 130 225 138 225 147 225 155 225 166 225 173 224 184 223 194 221 204 219 216 215 222 215 228 212 238 209 245 205 258 201 266 195 272 191 279 185 283 176 288 168 295 158 299 149 297 141 295 132 292 126 289 121 282 115 277 112 268 106 262 102 254 97 244 95 236 91 227 88 219 84 209 80 193 79 184 78 169 76 155

shape parallelogram
true
0
Polygon -7500403 true true 75 45 0 255 225 255 300 45
Polygon -16777216 false false 0 255 75 45 300 45 225 255

shape pentagon
true
0
Polygon -7500403 true true 60 135 105 225 195 225 240 135 150 60 60 135
Polygon -16777216 false false 60 135 150 60 240 135 195 225 105 225

shape rectangle
true
0
Rectangle -7500403 true true 60 15 255 270
Rectangle -16777216 false false 60 15 255 270

shape scalene triangle
true
0
Polygon -16777216 true false 30 285 150 15
Polygon -7500403 true true 30 210 30 30 285 255
Polygon -16777216 false false 30 210 30 30 285 255

shape semi-circle
true
0
Polygon -7500403 true true -1 143 0 136 3 121 6 105 11 94 16 83 22 71 30 61 42 44 58 30 76 18 85 13 94 10 106 5 119 2 136 1 150 0 165 1 182 3 196 6 211 10 220 15 227 20 243 31 257 44 273 61 281 75 286 84 289 92 294 104 299 123 301 138 301 153 -2 151 -1 150
Polygon -16777216 false false 0 151 0 141 1 132 3 122 5 104 10 92 19 76 31 60 41 46 47 41 53 35 64 27 71 22 86 14 102 7 124 2 151 0 176 3 197 7 211 12 218 17 226 20 242 30 255 41 264 50 271 60 275 64 281 76 290 93 294 106 298 119 299 131 299 152

shape septagon
true
0
Polygon -7500403 true true 30 150 60 60 150 15 240 60 270 150 210 240 90 240
Polygon -16777216 false false 30 150 60 60 150 15 240 60 270 150 210 240 90 240 30 150

shape square
true
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 false false 30 30 270 270

shape trapezoid
true
0
Polygon -7500403 true true 75 75 0 240 300 240 195 75
Polygon -16777216 false false 0 240 75 75 195 75 300 240 0 240

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

square ok
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 false false 30 30 270 270
Circle -7500403 true true 60 105 90
Circle -16777216 true false 51 96 108
Circle -7500403 true true 75 120 60
Rectangle -16777216 true false 173 97 193 204
Polygon -16777216 true false 191 138 222 97 249 96 201 155 195 150 255 205 227 204 188 169

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

test-lesson-01-shape-1
false
0
Circle -7500403 true true 39 129 42
Polygon -7500403 true true 105 225 165 45 195 45 255 225 225 225 180 75 135 225
Polygon -7500403 true true 150 135 150 150 210 150 210 135

test-lesson-01-shape-2
false
0
Polygon -7500403 true true 30 75 30 240 270 75 270 240
Polygon -16777216 false false 30 75 270 240 270 75 30 240

test-lesson-01-shape-3
false
0
Polygon -7500403 true true 30 150 45 180 75 195 105 210 150 210 195 210 225 195 255 180 270 150 270 60 255 105 225 135 180 150 150 150 120 150 75 135 45 105 30 60

test-lesson-01-shape-4
false
0
Polygon -7500403 true true 75 240 75 45 135 45 195 45 195 75 105 75 105 240
Polygon -7500403 true true 105 120 105 150 195 150 195 120
Rectangle -7500403 true true 195 150 210 225
Polygon -7500403 true true 105 210 105 240 195 240 195 210
Rectangle -7500403 true true 195 60 210 120

test-lesson-02-shape-1
false
0
Rectangle -7500403 true true 12 147 287 154
Polygon -7500403 true true 15 135 15 165
Polygon -7500403 true true 15 135 15 165 0 150
Polygon -7500403 true true 285 135 285 165 300 150

test-lesson-02-shape-2
true
0
Circle -7500403 true true 129 129 42

test-lesson-02-shape-3
false
0
Line -7500403 true 13 151 23 162
Line -7500403 true 23 162 35 173
Line -7500403 true 33 172 49 183
Line -7500403 true 48 182 64 189
Line -7500403 true 63 189 82 193
Line -7500403 true 81 193 101 191
Line -7500403 true 100 191 120 182
Line -7500403 true 121 181 134 169
Line -7500403 true 133 170 149 154
Line -7500403 true 148 155 167 139
Line -7500403 true 167 139 187 131
Line -7500403 true 188 131 207 129
Line -7500403 true 207 129 230 133
Line -7500403 true 231 133 254 140
Line -7500403 true 254 141 272 150
Line -7500403 true 272 151 286 160
Polygon -7500403 true true 20 146 10 157 9 144
Polygon -7500403 true true 289 155 281 167 292 165

test-lesson-02-shape-4
false
0
Rectangle -7500403 true true 1 147 287 154
Polygon -7500403 true true 15 135 15 165
Polygon -7500403 true true 285 135 285 165 300 150

test-lesson-02-shape-5
false
0
Polygon -7500403 true true 0 255 60 75 90 75 150 255 120 255 75 105 30 255
Polygon -7500403 true true 45 165 45 180 105 180 105 165
Polygon -7500403 true true 165 75 165 255 255 255 255 240 195 240 195 75
Polygon -7500403 true true 255 240 285 240 285 180 255 180
Rectangle -7500403 true true 195 165 255 180
Rectangle -7500403 true true 255 90 285 165
Rectangle -7500403 true true 195 75 255 90
Rectangle -2674135 true false 30 30 270 45
Polygon -2674135 true false 30 15 30 75 1 38 30 0
Polygon -2674135 true false 271 15 270 75 298 38 270 0

test-lesson-02-shape-6
false
0
Polygon -7500403 true true 0 255 60 75 90 75 150 255 120 255 75 105 30 255
Polygon -7500403 true true 45 165 45 180 105 180 105 165
Polygon -7500403 true true 165 75 165 255 255 255 255 240 195 240 195 75
Polygon -7500403 true true 255 240 285 240 285 180 255 180
Rectangle -7500403 true true 195 165 255 180
Rectangle -7500403 true true 255 90 285 165
Rectangle -7500403 true true 195 75 255 90

test-lesson-02-shape-7
false
0
Polygon -7500403 true true 0 255 60 75 90 75 150 255 120 255 75 105 30 255
Polygon -7500403 true true 45 165 45 180 105 180 105 165

test-lesson-02-shape-8
false
0
Polygon -7500403 true true 0 255 60 75 90 75 150 255 120 255 75 105 30 255
Polygon -7500403 true true 45 165 45 180 105 180 105 165
Polygon -7500403 true true 165 75 165 255 255 255 255 240 195 240 195 75
Polygon -7500403 true true 255 240 285 240 285 180 255 180
Rectangle -7500403 true true 195 165 255 180
Rectangle -7500403 true true 255 90 285 165
Rectangle -7500403 true true 195 75 255 90
Rectangle -2674135 true false 30 30 285 45
Polygon -2674135 true false 30 15 30 75 1 38 30 0

test-lesson-03-shape-1
false
0
Rectangle -13345367 true false 31 145 270 151
Circle -13345367 true false 15 135 24
Circle -13345367 true false 263 137 22

test-lesson-03-shape-2
true
0
Circle -2674135 true false 129 129 42

test-lesson-03-shape-3
false
0
Rectangle -13840069 true false 1 147 287 154
Polygon -7500403 true true 15 135 15 165
Polygon -13840069 true false 270 120 270 180 300 150

test-lesson-03-shape-4
false
0
Rectangle -13345367 true false 12 147 287 154
Polygon -7500403 true true 15 135 15 165
Polygon -13345367 true false 30 120 30 180 0 150
Polygon -13345367 true false 270 120 270 180 300 150

test-lesson-03-shape-5
false
0
Polygon -7500403 true true 0 255 60 75 90 75 150 255 120 255 75 105 30 255
Polygon -7500403 true true 45 165 45 180 105 180 105 165
Polygon -7500403 true true 165 75 165 255 255 255 255 240 195 240 195 75
Polygon -7500403 true true 255 240 285 240 285 180 255 180
Rectangle -7500403 true true 195 165 255 180
Rectangle -7500403 true true 255 90 285 165
Rectangle -7500403 true true 195 75 255 90
Rectangle -2674135 true false 15 53 285 60

test-lesson-03-shape-6
false
0
Polygon -7500403 true true 0 255 60 75 90 75 150 255 120 255 75 105 30 255
Polygon -7500403 true true 45 165 45 180 105 180 105 165
Polygon -7500403 true true 165 75 165 255 255 255 255 240 195 240 195 75
Polygon -7500403 true true 255 240 285 240 285 180 255 180
Rectangle -7500403 true true 195 165 255 180
Rectangle -7500403 true true 255 90 285 165
Rectangle -7500403 true true 195 75 255 90
Rectangle -2674135 true false 30 30 270 45
Polygon -2674135 true false 30 15 30 75 1 38 30 0
Polygon -2674135 true false 271 15 270 75 298 38 270 0

test-lesson-03-shape-7
false
0
Polygon -7500403 true true 0 255 60 75 90 75 150 255 120 255 75 105 30 255
Polygon -7500403 true true 45 165 45 180 105 180 105 165

test-lesson-03-shape-8
false
0
Polygon -7500403 true true 0 255 60 75 90 75 150 255 120 255 75 105 30 255
Polygon -7500403 true true 45 165 45 180 105 180 105 165
Polygon -7500403 true true 165 75 165 255 255 255 255 240 195 240 195 75
Polygon -7500403 true true 255 240 285 240 285 180 255 180
Rectangle -7500403 true true 195 165 255 180
Rectangle -7500403 true true 255 90 285 165
Rectangle -7500403 true true 195 75 255 90
Rectangle -2674135 true false 30 30 285 45
Polygon -2674135 true false 30 15 30 75 1 38 30 0

test-lesson-04-shape-1
false
0
Rectangle -13840069 true false 12 147 287 154
Polygon -7500403 true true 15 135 15 165
Polygon -13840069 true false 270 120 270 180 300 150
Circle -13840069 true false 0 135 30

test-lesson-04-shape-2
false
0
Rectangle -13840069 true false 146 9 155 283
Polygon -7500403 true true 135 285 165 285
Polygon -13840069 true false 120 30 180 30 150 0
Circle -13840069 true false 135 270 30
Rectangle -7500403 true true 91 253 99 287
Rectangle -7500403 true true 81 250 110 255
Rectangle -7500403 true true 75 26 82 60
Polygon -7500403 true true 114 252 128 264 115 253
Polygon -7500403 true true 97 61 99 63 79 48 82 43 83 41 106 61
Polygon -7500403 true true 82 45 105 26 93 27 80 39

test-lesson-04-shape-3
false
0
Polygon -7500403 true true 135 285 165 285
Rectangle -7500403 true true 85 91 103 227
Rectangle -7500403 true true 39 75 146 92
Rectangle -7500403 true true 167 75 181 225
Polygon -7500403 true true 114 252 128 264 115 253
Rectangle -2674135 true false 39 37 233 53
Polygon -7500403 true true 170 150 176 138 226 75 245 75 185 150
Polygon -7500403 true true 169 149 175 163 225 225 244 224 184 149
Polygon -2674135 true false 210 15 210 75 251 48

test-lesson-04-shape-4
false
0
Polygon -7500403 true true 135 285 165 285
Rectangle -7500403 true true 85 91 103 227
Rectangle -7500403 true true 39 75 146 92
Rectangle -7500403 true true 167 75 181 225
Polygon -7500403 true true 114 252 128 264 115 253
Rectangle -2674135 true false 45 37 233 53
Polygon -7500403 true true 170 150 176 138 226 75 245 75 185 150
Polygon -7500403 true true 169 149 175 163 225 225 244 224 184 149
Polygon -2674135 true false 218 23 210 15 210 75 251 48
Polygon -2674135 true false 60 30 60 15 26 39 60 75

test-lesson-04-shape-5
false
0
Polygon -7500403 true true 135 285 165 285
Rectangle -7500403 true true 85 91 103 227
Rectangle -7500403 true true 39 75 146 92
Rectangle -7500403 true true 167 75 181 225
Polygon -7500403 true true 114 252 128 264 115 253
Polygon -7500403 true true 170 150 176 138 226 75 245 75 185 150
Polygon -7500403 true true 169 149 175 163 225 225 244 224 184 149

test-lesson-04-shape-6
false
0
Polygon -7500403 true true 135 285 165 285
Rectangle -7500403 true true 85 91 103 227
Rectangle -7500403 true true 39 75 146 92
Rectangle -7500403 true true 167 75 181 225
Polygon -7500403 true true 114 252 128 264 115 253
Rectangle -2674135 true false 39 37 244 55
Polygon -7500403 true true 170 150 176 138 226 75 245 75 185 150
Polygon -7500403 true true 169 149 175 163 225 225 244 224 184 149

test-lesson-05-shape-1
true
0
Line -7500403 true 30 75 52 120
Line -7500403 true 52 121 69 149
Line -7500403 true 69 150 85 169
Line -7500403 true 85 170 100 182
Line -7500403 true 99 182 118 188
Line -7500403 true 118 188 138 191
Line -7500403 true 139 192 162 192
Line -7500403 true 162 191 180 188
Line -7500403 true 180 187 206 177
Line -7500403 true 206 177 231 158
Line -7500403 true 230 159 252 135
Line -7500403 true 252 134 269 104
Line -7500403 true 268 104 281 73

test-lesson-06-shape-1
false
0
Polygon -7500403 true true 15 135 15 165
Polygon -13345367 true false 116 41 102 61 89 38
Polygon -13345367 true false 243 128 229 147 252 150
Polygon -13345367 true false 106 50 104 52 237 140 239 138 237 140 240 138 241 136 111 48
Polygon -2674135 true false 73 84 212 175 207 180 209 182 204 181 209 180 70 89 73 87 73 88
Polygon -2674135 true false 79 80 67 97 53 74
Polygon -2674135 true false 214 169 203 186 227 188

test-lesson-06-shape-2
true
0
Rectangle -2674135 true false 58 174 241 182
Rectangle -13345367 true false 56 129 243 136
Polygon -13345367 true false 58 119 57 150 35 133
Polygon -13345367 true false 239 119 239 144 264 132
Polygon -2674135 true false 59 165 60 164 60 196 33 179
Polygon -2674135 true false 242 165 241 164 240 196 272 181
Line -2674135 false 48 108 58 83
Line -2674135 false 59 85 68 106
Line -2674135 false 53 100 64 100
Polygon -2674135 false false 244 78 244 113 257 103 257 97 253 93 247 93 246 92 261 86 258 79
Polygon -2674135 false false 46 211 71 207 47 212 47 211 53 227 75 227 52 227
Polygon -2674135 false false 240 204 241 234 261 230 262 221 260 208

test-lesson-07-shape-1
false
0
Rectangle -13345367 true false 147 74 153 226
Rectangle -2674135 true false 74 145 226 150
Polygon -13345367 true false 166 76 136 75 150 56 163 76
Polygon -13345367 true false 166 225 135 224 151 239 166 226 166 227
Polygon -2674135 true false 225 134 226 134 226 164 246 147 227 133
Polygon -2674135 true false 76 133 76 162 53 150

test-lesson-07-shape-2
false
0
Rectangle -13345367 true false 147 74 153 226
Rectangle -2674135 true false 74 145 226 150
Polygon -13345367 true false 166 76 136 75 150 56 163 76
Polygon -13345367 true false 166 225 135 224 151 239 166 226 166 227
Polygon -2674135 true false 225 134 226 134 226 164 246 147 227 133
Polygon -2674135 true false 76 133 76 162 53 150

test-lesson-07-shape-3
false
0
Rectangle -2674135 true false 58 174 241 182
Rectangle -13345367 true false 56 129 243 136
Polygon -13345367 true false 60 120 60 150 30 135
Polygon -13345367 true false 239 119 240 150 270 135
Polygon -2674135 true false 59 165 60 164 60 196 33 179
Polygon -2674135 true false 242 165 241 164 240 196 272 181

test-lesson-07-shape-4
false
0
Rectangle -2674135 true false 12 147 287 154
Polygon -7500403 true true 15 135 15 165
Polygon -2674135 true false 30 135 30 165 0 150
Polygon -2674135 true false 270 135 270 165 300 150

test-lesson-07-shape-5
false
0
Rectangle -2674135 true false 1 147 287 154
Polygon -7500403 true true 15 135 15 165
Polygon -2674135 true false 270 135 270 165 300 150

test-lesson-08-shape-1
false
0
Polygon -7500403 true true 15 135 15 165
Polygon -2674135 true false 263 193 263 223 278 208
Polygon -13345367 true false 58 209 220 103 216 97 50 205 59 211
Polygon -13345367 true false 209 92 221 112 231 91
Rectangle -2674135 true false 53 204 264 211

test-lesson-08-shape-2
true
0
Rectangle -13345367 true false 147 74 153 226
Rectangle -2674135 true false 74 145 226 150
Polygon -13345367 true false 166 76 136 75 150 56 163 76
Polygon -13345367 true false 166 225 135 224 151 239 166 226 166 227
Polygon -2674135 true false 225 134 226 134 226 164 246 147 227 133
Polygon -2674135 true false 76 133 76 162 53 150

test-lesson-08-shape-3
true
0
Rectangle -2674135 true false 58 174 241 182
Rectangle -13345367 true false 56 129 243 136
Polygon -13345367 true false 58 119 57 150 35 133
Polygon -13345367 true false 239 119 239 144 264 132
Polygon -2674135 true false 59 165 60 164 60 196 33 179
Polygon -2674135 true false 242 165 241 164 240 196 272 181

test-lesson-08-shape-4
false
0
Rectangle -2674135 true false 12 147 287 154
Polygon -7500403 true true 15 135 15 165
Polygon -2674135 true false 15 135 15 165 0 150
Polygon -2674135 true false 285 135 285 165 300 150

test-lesson-08-shape-5
false
0
Rectangle -2674135 true false 58 211 223 218
Polygon -7500403 true true 15 135 15 165
Polygon -2674135 true false 58 231 58 201 43 216
Polygon -13345367 true false 236 67 224 47 214 68
Rectangle -13345367 true false 222 66 229 219
Line -13345367 false 18 242 29 263
Line -13345367 false 30 265 35 244
Line -13345367 false 35 247 44 263
Line -13345367 false 44 263 51 241
Line -13345367 false 249 227 232 251
Line -13345367 false 230 232 254 249
Line -13345367 false 240 37 239 65
Polygon -13345367 false false 243 73 242 73
Polygon -13345367 false false 240 68 245 68 252 64 255 54 254 45 239 37

test-lesson-08-shape-6
false
0
Rectangle -7500403 true true 28 190 96 195
Polygon -7500403 true true 67 137 68 139 28 193 26 191 63 135
Rectangle -7500403 true true 104 116 111 196
Polygon -7500403 false true 106 117 145 129 150 140 151 150 148 168 146 176 106 194
Line -7500403 true 204 124 167 193
Line -7500403 true 166 124 209 192
Line -7500403 true 220 129 248 192
Line -7500403 true 248 193 256 141
Line -7500403 true 257 141 272 193
Line -7500403 true 274 193 290 131

test-lesson-08-shape-7
false
0
Rectangle -7500403 true true 28 190 96 195
Polygon -7500403 true true 67 137 68 139 28 193 26 191 63 135
Rectangle -7500403 true true 104 116 111 196
Polygon -7500403 false true 106 117 145 129 150 140 151 150 148 168 146 176 106 194
Line -7500403 true 279 124 242 193
Line -7500403 true 241 124 284 192
Line -7500403 true 160 129 188 192
Line -7500403 true 188 193 196 141
Line -7500403 true 197 141 212 193
Line -7500403 true 214 193 230 131

test-lesson-08-shape-8
false
0
Rectangle -7500403 true true 59 116 66 196
Polygon -7500403 false true 61 117 100 129 105 140 106 150 103 168 101 176 61 194
Line -7500403 true 159 124 122 193
Line -7500403 true 121 124 164 192
Line -7500403 true 175 129 203 192
Line -7500403 true 203 193 211 141
Line -7500403 true 212 141 227 193
Line -7500403 true 229 193 245 131

test-lesson-08-shape-9
false
0
Rectangle -7500403 true true 59 116 66 196
Polygon -7500403 false true 61 117 100 129 105 140 106 150 103 168 101 176 61 194
Line -7500403 true 159 124 122 193
Line -7500403 true 121 124 164 192

test-lesson-09-shape-1
false
0
Rectangle -2674135 true false 60 204 264 211
Polygon -7500403 true true 15 135 15 165
Polygon -2674135 true false 67 193 67 223 52 208
Polygon -13345367 true false 261 211 105 106 107 98 266 206 257 210
Polygon -13345367 true false 117 93 94 96 103 119

test-lesson-09-shape-2
false
0
Rectangle -2674135 true false 60 204 264 211
Polygon -7500403 true true 15 135 15 165
Polygon -2674135 true false 263 193 263 223 278 208
Polygon -13345367 true false 60 209 216 104 214 96 55 204 64 208
Polygon -13345367 true false 209 92 221 112 231 91

test-lesson-09-shape-3
false
0
Rectangle -2674135 true false 60 204 205 211
Polygon -7500403 true true 15 135 15 165
Polygon -2674135 true false 67 193 67 223 52 208
Polygon -13345367 true false 203 208 251 101 257 102 208 209 199 207
Polygon -13345367 true false 265 111 262 88 239 97

test-lesson-09-shape-4
false
0
Rectangle -2674135 true false 58 211 223 218
Polygon -7500403 true true 15 135 15 165
Polygon -2674135 true false 58 231 58 201 43 216
Polygon -13345367 true false 236 67 224 47 214 68
Rectangle -13345367 true false 222 66 229 214
Polygon -13345367 false false 243 73 242 73

test-lesson-09-shape-5
false
0
Polygon -7500403 false true 178 205 178 194 193 179 219 179 206 205
Rectangle -2674135 true false 60 205 209 211
Polygon -7500403 true true 15 135 15 165
Polygon -2674135 true false 67 193 67 223 52 208
Polygon -13345367 true false 199 208 255 90 257 102 208 209 205 208
Polygon -13345367 true false 265 111 262 88 239 97

test-lesson-10-shape-1
true
0
Polygon -7500403 true true 103 108 103 197 196 196 225 147 186 107 101 109

test-lesson-10-shape-2
true
0
Rectangle -2674135 true false 101 107 241 113
Rectangle -2674135 true false 99 108 104 204
Rectangle -2674135 true false 100 198 191 204
Polygon -2674135 true false 190 198 140 152 136 154 135 156 182 201 183 201 185 200

test-lesson-10-shape-3
true
0
Polygon -13345367 false false 150 105 150 120 210 120 225 135 225 150 210 165 195 165 180 165 165 165 105 165 90 165 75 150 75 135

test-lesson-10-shape-4
true
0
Line -13345367 false 150 105 225 150
Line -13345367 false 150 105 75 150
Line -13345367 false 225 150 150 195
Line -13345367 false 75 150 150 195

test-lesson-10-shape-5
true
0
Rectangle -7500403 true true 49 145 255 150

test-lesson-11-shape-1
true
0
Polygon -2674135 false false 255 90 210 240 90 240 30 90 255 90

test-lesson-11-shape-2
true
0
Rectangle -13345367 true false 86 87 223 94
Rectangle -13840069 true false 216 91 223 161
Rectangle -2674135 true false 102 159 223 165
Polygon -7500403 true true 88 90 85 92 90 90 110 165 103 165 84 92 86 95
Circle -13345367 true false 211 84 14
Circle -13840069 true false 211 154 14
Circle -2674135 true false 100 156 12
Circle -6459832 true false 82 86 14
Line -2674135 false 91 56 75 56
Line -2674135 false 74 57 75 84
Line -2674135 false 76 71 88 71
Line -2674135 false 225 55 225 78
Line -2674135 false 241 55 241 79
Line -2674135 false 241 68 225 68
Line -2674135 false 77 167 77 194
Line -2674135 false 77 195 89 195
Line -2674135 false 231 172 231 197
Line -2674135 false 245 175 232 183
Line -2674135 false 233 184 245 197

test-lesson-11-shape-3
true
0
Polygon -13345367 false false 60 135 150 60 240 135 195 225 105 225

test-lesson-11-shape-4
true
0
Polygon -13345367 false false 150 225 45 180 45 120 150 75 255 120 255 180 150 225

test-lesson-12-shape-1
true
0
Polygon -13345367 false false 211 242 29 149 209 59

test-lesson-12-shape-2
true
0
Polygon -13345367 false false 150 225 45 180 45 120 150 75 255 120 255 180 150 225

test-lesson-12-shape-3
true
0
Polygon -13345367 false false 255 105 180 240 120 240 30 105 255 105

test-lesson-12-shape-4
true
0
Polygon -13345367 false false 60 135 150 60 240 135 195 225 105 225

test-lesson-12-shape-5
false
0
Rectangle -2674135 true false 58 210 223 216
Polygon -7500403 true true 15 135 15 165
Rectangle -2674135 true false 218 62 224 215
Polygon -13345367 false false 243 73 242 73
Polygon -2674135 true false 60 215 223 64 220 60 55 210
Line -13345367 false 252 44 263 69
Line -13345367 false 252 45 242 68
Line -13345367 false 245 61 260 61
Line -13345367 false 238 207 238 231
Line -13345367 false 238 207 260 207
Line -13345367 false 238 221 251 221
Line -13345367 false 23 205 23 233
Line -13345367 false 43 205 43 233
Line -13345367 false 43 220 22 220

test-lesson-13-shape-1
true
0
Polygon -2674135 false false 15 269 150 44 285 269
Polygon -2674135 false false 44 230 44 245 59 245 59 260 44 260 44 230 59 230
Polygon -2674135 false false 66 244 66 230 81 230 81 243 81 260 66 260 66 244
Polygon -2674135 false false 243 246 243 232 258 232 258 245 258 262 243 262 243 246
Polygon -1184463 false false 220 232 220 247 235 247 235 262 220 262 220 232 235 232
Polygon -2674135 false false 220 232 220 247 235 247 235 262 220 262 220 232 235 232
Polygon -2674135 false false 132 91 132 106 147 106 147 121 132 121 132 91 147 91
Polygon -2674135 false false 155 105 155 91 170 91 170 104 170 121 155 121 155 105
Line -2674135 false 26 250 35 259
Line -2674135 false 275 251 264 260
Line -2674135 false 138 63 151 67
Line -2674135 false 149 67 161 63
Line -2674135 false 36 259 36 268
Line -2674135 false 265 259 265 267

test-lesson-13-shape-2
true
0
Line -13345367 false 210 195 105 195
Line -13345367 false 105 195 105 90
Line -13345367 false 105 90 210 195

test-lesson-13-shape-3
true
0
Polygon -16777216 true false 30 285 150 15
Polygon -2674135 false false 90 255 150 60 210 255

test-lesson-13-shape-4
true
0
Polygon -7500403 false true 30 240 151 44 270 240

test-lesson-13-shape-5
true
0
Polygon -16777216 true false 30 285 150 15
Polygon -13840069 false false 92 208 12 128 267 210

test-lesson-13-shape-6
true
0
Line -8630108 false 105 90 30 195
Line -8630108 false 105 90 255 195
Line -8630108 false 30 195 255 195

test-lesson-14-shape-1
true
0
Polygon -13345367 false false 255 120 210 225 90 225 30 120 255 120

test-lesson-14-shape-2
true
0
Line -2674135 false 150 105 225 150
Line -2674135 false 150 105 75 150
Line -2674135 false 225 150 150 195
Line -2674135 false 75 150 150 195

test-lesson-14-shape-3
true
0
Line -2674135 false 105 150 150 75
Line -2674135 false 105 150 150 225
Line -2674135 false 150 75 195 150
Line -2674135 false 150 225 195 150

test-lesson-14-shape-4
true
0
Rectangle -2674135 false false 60 105 240 195

test-lesson-14-shape-5
true
0
Polygon -2674135 false false 15 210 60 60 255 60 210 210

test-lesson-14-shape-6
true
0
Polygon -2674135 false false 45 210 90 105 210 105 255 210 45 210

test-lesson-14-shape-7
false
0
Rectangle -2674135 false false 60 60 240 240

test-lesson-14-shape-8
true
0
Polygon -2674135 false false 30 225 75 75 270 75 225 225

test-lesson-15-shape-1
true
0
Rectangle -13345367 false false 60 105 240 195

test-lesson-15-shape-2
true
0
Polygon -13345367 false false 151 77 161 76 169 76 176 77 187 77 202 80 213 81 221 83 233 85 242 88 247 89 257 94 262 97 269 103 277 108 283 116 289 121 294 131 299 141 299 147 299 153 299 162 299 169 294 176 290 185 285 190 280 193 271 199 262 204 254 207 246 211 238 214 230 217 220 219 213 220 201 223 191 224 182 225 170 225 162 225 153 225 145 225 134 225 127 225 116 224 106 223 96 221 84 219 78 215 72 215 62 212 55 209 42 205 34 201 28 195 21 191 17 185 12 176 5 168 1 158 3 149 5 141 8 132 11 126 18 121 23 115 32 112 38 106 46 102 56 97 64 95 73 91 81 88 91 84 107 80 116 79 131 78 145 76

test-lesson-15-shape-3
true
0
Polygon -16777216 true false 30 285 150 15
Polygon -13345367 false false 90 255 150 60 210 255

test-lesson-15-shape-4
true
0
Polygon -13345367 false false 45 210 90 105 210 105 255 210 45 210

test-lesson-15-shape-5
true
0
Rectangle -13345367 false false 105 60 195 240

test-lesson-16-shape-1
true
0
Polygon -2674135 false false 225 270 75 225 75 30 225 75
Polygon -13791810 true false 75 30 75 225 225 270 225 75

test-lesson-16-shape-2
true
0
Polygon -2674135 false false 30 225 75 75 270 75 225 225

test-lesson-17-shape-1
true
0
Line -13345367 false 105 150 150 75
Line -13345367 false 105 150 150 225
Line -13345367 false 150 75 195 150
Line -13345367 false 150 225 195 150

test-lesson-17-shape-2
true
0
Rectangle -13345367 false false 105 60 195 240

test-lesson-17-shape-3
true
0
Polygon -16777216 true false 30 285 150 15
Polygon -13345367 false false 90 255 150 60 210 255

test-lesson-17-shape-4
true
0
Polygon -13345367 false false 45 210 90 105 210 105 255 210 45 210

test-lesson-17-shape-5
true
0
Line -13345367 false 150 105 225 150
Line -13345367 false 150 105 75 150
Line -13345367 false 225 150 150 195
Line -13345367 false 75 150 150 195

test-lesson-18-shape-1
false
0
Rectangle -2674135 false false 60 60 240 240

test-lesson-18-shape-2
false
0
Rectangle -13345367 false false 60 60 240 240

test-lesson-19-shape-1
true
0
Polygon -13345367 false false 45 210 90 105 210 105 255 210 45 210

test-lesson-19-shape-2
true
0
Rectangle -13345367 false false 60 105 240 195

test-lesson-19-shape-3
true
0
Polygon -16777216 true false 30 285 150 15
Polygon -13345367 false false 90 255 150 60 210 255

test-lesson-19-shape-4
true
0
Line -13345367 false 105 150 150 75
Line -13345367 false 105 150 150 225
Line -13345367 false 150 75 195 150
Line -13345367 false 150 225 195 150

test-lesson-19-shape-5
false
0
Polygon -13345367 false false 45 210 90 105 210 105 255 210 45 210

test-lesson-19-shape-6
false
0
Polygon -13345367 false false 75 210 90 105 195 105 270 210 75 210

test-lesson-19-shape-7
true
0
Polygon -13345367 false false 270 120 210 225 90 225 30 120 270 120

test-lesson-20-shape-1
true
0
Polygon -13345367 false false 75 135 150 60 225 135 195 225 105 225

test-lesson-20-shape-2
true
0
Polygon -13345367 false false 90 120 150 45 210 120 195 240 105 240

test-lesson-21-shape-1
true
0
Polygon -13345367 false false 30 150 90 45 210 45 270 150 210 255 90 255 30 150

test-lesson-21-shape-2
true
0
Polygon -13345367 false false 150 225 45 180 45 120 150 75 255 120 255 180 150 225

test-lesson-22-shape-1
true
0
Polygon -13345367 false false 30 165 60 75 150 30 240 75 270 165 210 255 90 255 30 165

test-lesson-22-shape-2
true
0
Polygon -13345367 false false 30 150 90 45 210 45 270 150 210 255 90 255 30 150

test-lesson-22-shape-3
true
0
Polygon -13345367 false false 180 90 255 150 180 210 60 195 60 105

test-lesson-22-shape-4
true
0
Polygon -13345367 false false 225 210 210 105 90 105 30 210 225 210

test-lesson-22-shape-5
true
0
Polygon -13345367 false false 30 165 60 75 150 30 240 75 270 165 210 255 90 255 30 165

test-lesson-22-shape-6
true
0
Polygon -13345367 false false 60 150 75 60 150 15 225 60 270 150 195 270 90 240 60 150

test-lesson-23-shape-1
true
0
Polygon -13345367 false false 45 150 75 75 150 45 225 75 255 150 225 225 150 255 75 225

test-lesson-24-shape-1
true
0
Polygon -13345367 false false 151 77 161 76 169 76 176 77 187 77 202 80 213 81 221 83 233 85 242 88 247 89 257 94 262 97 269 103 277 108 283 116 289 121 294 131 299 141 299 147 299 153 299 162 299 169 294 176 290 185 285 190 280 193 271 199 262 204 254 207 246 211 238 214 230 217 220 219 213 220 201 223 191 224 182 225 170 225 162 225 153 225 145 225 134 225 127 225 116 224 106 223 96 221 84 219 78 215 72 215 62 212 55 209 42 205 34 201 28 195 21 191 17 185 12 176 5 168 1 158 3 149 5 141 8 132 11 126 18 121 23 115 32 112 38 106 46 102 56 97 64 95 73 91 81 88 91 84 107 80 116 79 131 78 145 76

test-lesson-24-shape-2
true
0
Circle -13345367 false false 39 38 220

test-lesson-24-shape-3
true
0
Polygon -13345367 false false 45 150 75 75 150 45 225 75 255 150 225 225 150 255 75 225

test-lesson-24-shape-4
true
0
Polygon -13345367 false false 45 210 90 105 210 105 255 210 45 210

test-lesson-25-shape-1
true
0
Circle -13345367 false false 39 38 220

test-lesson-25-shape-10
true
0
Circle -2674135 false false 40 38 220
Circle -13345367 true false 224 204 22
Circle -13345367 true false 49 68 28
Line -13345367 false 64 84 234 213
Circle -13345367 true false 144 144 12

test-lesson-25-shape-11
true
0
Circle -2674135 false false 41 40 220
Circle -13345367 true false 214 216 26
Line -13345367 false 152 150 226 228

test-lesson-25-shape-12
true
0
Circle -2674135 false false 39 38 220
Circle -13345367 true false 135 135 30

test-lesson-25-shape-13
true
0
Circle -2674135 false false 39 38 220
Circle -13345367 true false 134 23 32
Circle -13345367 true false 243 135 30
Circle -13345367 true false 145 252 12
Circle -13345367 true false 30 140 24
Circle -13345367 true false 213 210 26

test-lesson-25-shape-2
true
0
Polygon -13345367 false false 151 77 161 76 169 76 176 77 187 77 202 80 213 81 221 83 233 85 242 88 247 89 257 94 262 97 269 103 277 108 283 116 289 121 294 131 299 141 299 147 299 153 299 162 299 169 294 176 290 185 285 190 280 193 271 199 262 204 254 207 246 211 238 214 230 217 220 219 213 220 201 223 191 224 182 225 170 225 162 225 153 225 145 225 134 225 127 225 116 224 106 223 96 221 84 219 78 215 72 215 62 212 55 209 42 205 34 201 28 195 21 191 17 185 12 176 5 168 1 158 3 149 5 141 8 132 11 126 18 121 23 115 32 112 38 106 46 102 56 97 64 95 73 91 81 88 91 84 107 80 116 79 131 78 145 76

test-lesson-25-shape-3
true
0
Polygon -13345367 false false 45 150 75 75 150 45 225 75 255 150 225 225 150 255 75 225

test-lesson-25-shape-4
true
0
Polygon -13345367 false false 45 210 90 105 210 105 255 210 45 210

test-lesson-25-shape-5
true
0
Circle -2674135 false false 39 38 220
Circle -13345367 true false 135 135 30

test-lesson-25-shape-6
true
0
Circle -2674135 false false 39 38 220
Circle -13345367 true false 134 23 32
Circle -13345367 true false 245 137 26
Circle -13345367 true false 140 247 22
Circle -13345367 true false 30 140 24
Circle -13345367 true false 215 212 22

test-lesson-25-shape-7
true
0
Circle -2674135 false false 41 40 220
Circle -13345367 true false 214 216 26
Line -13345367 false 152 150 226 228

test-lesson-25-shape-8
true
0
Circle -2674135 false false 40 38 220
Circle -13345367 true false 224 204 22
Circle -13345367 true false 52 71 22
Line -13345367 false 64 84 234 213

test-lesson-25-shape-9
true
0
Circle -2674135 false false 41 40 220
Circle -13345367 true false 219 221 16
Line -13345367 false 151 150 227 227
Circle -13345367 true false 141 139 20
Line -13345367 false 250 240 240 240
Line -13345367 false 122 151 130 132
Line -13345367 false 130 132 139 151
Line -13345367 false 125 144 136 144
Line -13345367 false 239 230 239 249
Line -13345367 false 252 229 239 229

test-lesson-26-shape-1
true
0
Polygon -13345367 false false 0 151 0 141 1 132 3 122 5 104 10 92 19 76 31 60 41 46 47 41 53 35 64 27 71 22 86 14 102 7 124 2 151 0 176 3 197 7 211 12 218 17 226 20 242 30 255 41 264 50 271 60 275 64 281 76 290 93 294 106 298 119 299 131 299 152

test-lesson-26-shape-2
false
0
Polygon -13345367 false false 1 150 1 140 0 135 2 122 6 103 11 91 20 75 32 59 42 45 48 40 54 34 65 26 72 21 87 13 103 6 125 1 152 -1 177 2 198 6 212 11 219 16 227 19 243 29 256 40 265 49 272 59 276 63 282 75 291 92 295 105 299 118 300 130 300 151
Circle -2674135 true false 140 140 20

test-lesson-26-shape-3
false
0
Polygon -13345367 false false 0 151 0 141 1 132 0 120 5 104 10 92 19 76 31 60 41 46 47 41 53 35 64 27 71 22 86 14 102 7 124 2 151 0 176 3 197 7 211 12 218 17 226 20 242 30 255 41 264 50 271 60 275 64 281 76 290 93 294 106 298 119 299 131 299 152
Line -2674135 false 0 150 300 150

test-lesson-26-shape-4
false
0
Polygon -13345367 false false 1 150 1 140 2 131 4 121 6 103 11 91 20 75 32 59 42 45 48 40 54 34 65 26 72 21 87 13 103 6 125 1 152 -1 177 2 198 6 212 11 219 16 227 19 243 29 256 40 265 49 272 59 276 63 282 75 291 92 295 105 299 118 300 130 300 151
Circle -2674135 true false 137 137 26
Line -2674135 false 150 150 300 150

test-lesson-26-shape-5
false
0
Polygon -13345367 false false 0 151 0 141 1 132 0 120 5 104 10 92 19 76 31 60 41 46 47 41 53 35 64 27 71 22 86 14 102 7 124 2 151 0 176 3 197 7 211 12 218 17 226 20 242 30 255 41 264 50 271 60 275 64 281 76 290 93 294 106 298 119 299 131 299 152

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
