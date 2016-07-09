extensions [re exec sound]

breed [agents agent]
breed [snakes snake]
breed [spiders spider]
breed [texts text]
breed [buttons button]
breed [rules rule]
breed [chatbots chatbot]
rules-own [regex responses]
chatbots-own [chatbot-name chatbot-voice rules-list failure-list]

globals
[
  test-score         ; current score in the test
  test-count         ; number of questions
  test-results-list  ; the list of results for the test
  game-score         ; current score in the game
  game-setup?        ; true when the game has already been setup
  the-chatbot        ; the chatbot agent for use to chat with
]

snakes-own [illness] ; used to kill off the snake slowly after its eaten a spider
spiders-own [kills]  ; number of kills that the spider has made

to setup-display
  clear-all
  ask patches
  [ set pcolor green + 3 ]
end

to setup
  setup-display
  setup-chatbot

  set test-score 0
  set test-count 0
  set test-results-list []
  set game-score 0
  set game-setup? false
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

to setup-chatbot

  create-chatbots 1
  [
    hide-turtle
    set the-chatbot self
    set chatbot-name voice-to-be-spoken
    set chatbot-voice voice-to-be-spoken
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
 
to go-explain
  setup
  wait 0.3
  clear-output
  output-print ""
  output-and-speak-explanation true "If you move in a vertical direction, you move either up or down. "

  wait 0.5  
  setup-agent 40 turtle-shape blue -30 -75 0 "vertical "
  setup-agent 40 turtle-shape blue 30 165 180 "vertical "
  move-agents (agents with [label = "vertical "]) turtle-speed 240 true

  output-print ""
  output-and-speak-explanation false "This is at right angles (perpendicular) to the horizontal direction where you move either left or right."
  
  setup-agent 40 turtle-shape magenta -120 -120 90 "horizontal"
  setup-agent 40 turtle-shape magenta 120 -165 270 "horizontal"
  move-agents (agents with [label = "horizontal"]) turtle-speed 240 true  
end

to go-show
  setup
  import-pcolors-rgb "Images/Atlantis-Rollback.jpg"

  clear-output
  output-print ""
  output-and-speak-explanation true "Rockets and balloons rise in a vertical direction whereas cars do not."

  setup-agent 40 "rocket" (violet - 1) 10 -80 0 "rocket"
  setup-agent 40 "balloon" (violet - 1) -40 -80 0 "balloon"
  setup-agent 40 "car cross" (violet - 1) -140 -170 90 "car"

  move-agents (agents with [member? label ["rocket" "balloon" ]]) turtle-speed 150 true

  output-print ""
  output-and-speak-explanation false "The car shown now moves in a horizontal direction."

  ask agents with [shape = "car cross"]
  [ set shape "car"]
  move-agents (agents with [shape = "car"]) turtle-speed 250 true
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
  output-explanation true "Be sure to check your answers before submitting."

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
  [ output-explanation false ? ]
  
  output-print (word "Overall percentage-score: " precision test-result 1 " %.")
end

to-report test-result
  report 100 * test-score / test-count
end

to go-check
  clear-output
  output-and-speak-explanation true (word
    "If the movement is up or down (like for a rocket "
    "or an elevator), then the direction is vertical. ")
  output-print ""
  output-and-speak-explanation false (word
    "If the movement is going across from right to left or from "
    "left to right (like a carpet on the floor of a room, or a "
    "car moving at right angles to yourself), then the direction is horizontal.")
  output-print ""
end

to go-activities

  setup-display
  output-and-speak-explanation false (word
      "Try thinking of other examples of things that go up or down "
      "in a vertical direction or across in a horizontal "
      "direction. ")
  output-print ""
  output-and-speak-explanation true "Activity 2."
  output-print ""
  output-and-speak-explanation false (word
      "In the examples you thought of for Activity 1, "
      "find further examples in the opposite direction. "
      "If you thought of an example in the vertical "
      "direction, think of something that runs "
      "perpendicular to it in the horizontal direction, "
      "and vice versa.")
end

to go-story-1

  setup-display
  import-pcolors-rgb "Images/Neil-Armstrong.jpg"
  output-and-speak-explanation true (word
    "Imagine you are Neil Armstrong, the commander of Apollo 11 "
    "just about to blast off into space towards the moon. ")
  output-print ""

  setup-display
  import-pcolors-rgb "Images/Apollo-11-1.jpg"
  output-and-speak-explanation false (word
    "The countdown has just reached zero, and the rocket blasts off. "
    "As the rocket flies up into the sky, it is moving in a vertical "
    "direction.")
  output-print ""

  setup-display
  import-pcolors-rgb "Images/Apollo-11-2.jpg"
  output-and-speak-explanation false (word
    "Now imagine again you are Neil Armstrong having landed on the "
    "moon. You have just stepped onto the lunar surface, the first "
    "man ever to do so. You decide to walk around a bit to explore. "
    "As you walk (or hop) around, you are moving in a horizontal "
    "direction (as long as you don't start climbing any hills!)")
end

to go-story-2

  setup-display
  import-pcolors-rgb "Images/Ben-Nevis-1.jpg"
  output-and-speak-explanation true (word
    "Imagine you are rock climber at the base of one of the rock "
    "faces to the north of Ben Nevis in Scotland. As you are "
    "walking up to the rock face, you are moving horizontally "
    "across the ground." )
  output-print ""

  setup-display
  import-pcolors-rgb "Images/Ben-Nevis-2.jpg"
  output-and-speak-explanation false (word
    "Now imagine you are half way up the rock face. As you continue "
    "to climb up the rock face, you are moving in a vertical "
    "direction.")
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
  output-explanation true (word
    "I am the snakes and you are the spiders. ")
  output-print ""
  output-explanation false (word
    "Get your snakes to catch and eat my black spiders. "
    "Watch out for my redback spiders, though. They will bite "
    "your snakes instead, and they will get ill and die.")
  output-print ""
  output-explanation false (word
    "Try to keep your snakes from being bitten by my redback "
    "spiders for as long as possible.")
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
          [ hatch-spiders 5 [ setup-spider false true ]]
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

to output-explanation [print-name? text-to-be-output]
; Outputs the text string text-to-be-output to the output box.

  if (print-name?)
    [ output-print (word voice-to-be-spoken " says:")
      output-print "" ]
  let text-list split-text-into-list 52 text-to-be-output
  output-explanation-list text-list
end

to speak-explanation [text-to-be-spoken]
; Speaks the text specified by text-to-be-spoken.

  let command (word "say -v " voice-to-be-spoken " \"" text-to-be-spoken "\"")
  exec:run command
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

to go-chat
; Chats with the user

  chat-with the-chatbot
end

to chat-with [this-chatbot]
; has a conversation with this-chatbot

  let fired false
  let pos 0
  let rule-no 0
  let this-chatbot-name [chatbot-name] of this-chatbot
  let response ""

  let user-reply user-input "Enter text: "
  output-print "You say:"
  output-print user-reply

  ask this-chatbot
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
     output-and-speak-explanation true response
  ]
end
@#$#@#$#@
GRAPHICS-WINDOW
191
10
646
486
222
222
1.0
1
14
1
1
1
0
1
1
1
-222
222
-222
222
0
0
1
ticks
30.0

BUTTON
6
107
189
163
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
12
38
165
100
Vertical and Horizontal
22
0.0
1

SLIDER
839
367
960
400
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
6
322
189
374
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
6
374
189
431
Play a game with me
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
960
322
1072
367
turtle-shape
turtle-shape
"default" "turtle" "spider" "squirrel" "bug" "ant 2" "car" "balloon"
0

OUTPUT
647
34
1094
321
14

TEXTBOX
652
10
802
30
Our Conversation:
16
112.0
1

BUTTON
648
324
831
378
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
839
322
960
367
voice-to-be-spoken
voice-to-be-spoken
"Agnes" "Albert" "Alex" "Bruce" "Vicki" "Victoria"
2

TEXTBOX
8
10
158
32
Learn About:
18
113.0
1

BUTTON
6
163
189
219
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
191
486
297
519
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
297
486
414
519
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
414
486
528
519
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
528
486
646
519
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
960
367
1072
400
pen-down?
pen-down?
1
1
-1000

BUTTON
648
378
831
432
Some activities for you to try out
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
704
434
804
479
Score for Game
game-score
0
1
11

BUTTON
648
434
704
479
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
6
219
189
269
Let me tell you a story
go-story-1
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
6
269
189
322
Let me tell you another story
go-story-2
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
6
431
189
486
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

SWITCH
856
411
1045
444
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
