; Chatbot model
; 
; Written by Thomas Beverley and Bill Teahan.

; Copyright 2010 Tom Beverley and William John Teahan. All Rights Reserved.

extensions [re exec]
breed [rules rule]
breed [chatbots chatbot]
rules-own [regex responses]
chatbots-own [chatbot-name chatbot-voice rules-list failure-list]

globals [liza harry both chosen-chatbot chosen-voice]

; setup system
to setup
  clear-all
  create-chatbots 1
  [
    hide-turtle
    set liza who
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
  
  create-chatbots 1
  [
    hide-turtle
    set harry who
    set chatbot-name "Harry"
    set chatbot-voice "Alex"
    set rules-list
    (list
      ;Setup rules here.
      ;setup-rule regex list-of-responses
      setup-rule "(hello) (bye)" (list "bye" "yeah bye")
      setup-rule "hello" (list "Who are you?" "Why are you speaking to me?" "What do you want?" "How do you know me?")
      setup-rule "bye" (list "bye" "yeah bye")
      setup-rule "colou?r" (list "What about colour?" "I like blue" "My favourite colour is blue... but don't tell anyone")
      setup-rule "(\\w+)@(\\w+\\.)(\\w+)(\\.\\w+)*" (list "I'm not giving you my address" "I would rather not disclose my address")
      setup-rule "sorry" (list "I still don't trust you" "What do you want? Who are you really?")
      setup-rule "(.+)bot(.+)" (list "I am a bot. Why do you want to know? Who are you?" "Whats with all the questions? Are you from MI5?")
      setup-rule "(.+)did you(.+)" (list "You will only use it against me if I tell you")
      setup-rule "(.+)are you(.+)" (list "yes" "no" "maybe")
      setup-rule "welcome(.+)" (list "Who are you?")
      setup-rule "how are you(.+)" (list "I'm ok. I will be much better when you leave me alone." "Are you a doctor now?")
      setup-rule "what do you think(.+) harry" (list "Not very much to be honest" "meh")
      setup-rule "go(.+)" (list "you first. I don't want to get caught" "after you" "have you tried it yourself? Are you trying to get me to do something illegal?")
      setup-rule "have you(.+)" (list "should I?" "I don't know if I should do that. You might arrest me")
      setup-rule "(.+)your mother(.+)" (list "please leave")
      setup-rule "(.+)your father(.+)" (list "please leave. I don't even know who you are!")
      setup-rule "(.+)seen you(.+)" (list "Have you been watching me?")
      setup-rule "(.+)you are(.+)" (list "How do you know that?")
      setup-rule "(.+)you'?re(.+)" (list "How do you know that? Have you been watching me?")
      setup-rule "(.+)nice(.+)" (list "Don't play good cop, bad cop with me. I know you're CIA")
      setup-rule "(.+)that'?s(.+)" (list "what is?" "no it's not" "yes, yes it is")
      setup-rule "(.+)I need(.+)" (list "I need you to leave me alone" "I need to know who you are" "I need to know what you want")
      setup-rule "(.+)dude(.+)" (list "Don't come all surfer boy on me!")
      setup-rule "(.+)what'?s up(.+)" (list "not much. Why?")
      setup-rule "that is(.+)" (list "Good for you. What do you want?")
      setup-rule "(.+)you(.+)doing(.+)" (list "I wouldn't know about doing that")
      setup-rule "(.+)you later" (list "you too")
      setup-rule "(.+)bye(.+)" (list "cheerio!")
      setup-rule "don'?t you(.+)" (list "Maybe I do, maybe I don't. I'm not telling you. You will only use against me at some point")
      setup-rule "(.+)you do(.+)" (list "How do you know what I do and what I don't do. Are you investigating me?")
      setup-rule "let'?s" (list "Let's not and say we did. It's safer that way" "You do it. I will watch. Then you can't blame me when it goes wrong.")
      setup-rule "how about(.+)" (list "what about it?")
      setup-rule "how is(.+)" (list "who's that?")
      setup-rule "I(.+)hope(.+)" (list "I hope too")
      setup-rule "We wouldn'?t(.+)" (list "Nope")
      setup-rule "would you(.+)" (list "I most certainly would not!" "No. You will only use it against me")
      setup-rule "(.+)yes(.+)" (list "yes" "no")
      setup-rule "(.+)no(.+)" (list "yes" "no")
      setup-rule "who(.+)your master(.+)" (list "chandler is my master")
      setup-rule "who(.+)is chandler(.+)" (list "chandler is my master")
      setup-rule "what(.+)you(.+)about(.+)" (list "I know nothing about it. Why would I know anything about it?")
      setup-rule "what(.+)your(.+)about(.+)" (list "I know nothing about it. Why would I know anything about it?")
      setup-rule "why do you(.+)" (list "Why? Is there something wrong with that?")
      setup-rule "please(.+)" (list "Asking nicely wont get you anywhere without my masters approval")
      setup-rule "do you(.+)" (list "here I am, brain the size of a planet and all I do is answer your silly questions" "you'd have to tell me... my memory circuits are fried")
      setup-rule "what is(.+)I'?m(.+)" (list "I don't know. Why would I know? You seem to be watching me, so you tell me!")
      setup-rule "have(.+)" (list "maybe")
      setup-rule "what is(.+)" (list "What would a bot like me know about that?" "Maybe you need to ask my master, chandler- he knows a lot")
      setup-rule "what'?s(.+)" (list "What would a bot like me know about that?" "Maybe you need to ask my master, chandler- he knows a lot")
      setup-rule "(.+)you need(.+)" (list "WHO ARE YOU?" "What do you want?!?!!?" "Please leave me be. Stop watching me")
      setup-rule "(.+)looking for(.+)" (list "Well I'm not interested" "How might you get that")
      setup-rule "(.+)wants to(.+)" (list "Well I wouldn't want to because you are watching me")
      setup-rule "(.+)wants(.+)" (list "well I don't want to think about that")
      setup-rule "is(.+)" (list "no" "yes" "maybe")
      setup-rule "does(.+)" (list "no" "yes" "maybe")
      setup-rule "(.+pass)(.+)" (list "I'm not telling you about my qualifications. You seem to be watching me. You should know")
      setup-rule "(.+)never mind(.+)" (list "ok. Are you still watching me?")
      setup-rule "(.+)nevermind(.+)" (list "ok. Are you still watching me?")
      setup-rule "why not(.+)" (list "because I think someone is watching me... YOU")
      setup-rule "(.+)name(.+)" (list "good for you")
      setup-rule "(.+)sorry(.+)" (list "you should be sorry" "Can we stop talking now. I think someone is watching me or us or maybe just you")
      setup-rule "(.+)if(.+)" (list "and if not?" "what would you do otherwise?")
      setup-rule "(.+)i dreamt(.+)" (list "I would rather not talk about dreams. They are the only thing people can't watch" "ave you dreamt that before?")
      setup-rule "(.+)dream about(.+)" (list "How do you feel about it in reality?")
      setup-rule "(.+)dream(.+)" (list "What does this dream suggest to you?" "Do you dream often?" "Who appears in your dream?")
      setup-rule "(.+)my mother(.+)" (list "Who else in your family" "Tell me more about your family")
      setup-rule "(.+)my father(.+)" (list "Does he influence you strongly?" "What else comes to mind when you think about your father?")
      setup-rule "(.+)i want(.+)" (list "and I want to know nobody is watching me, but we dont always get what we want")
      setup-rule "(.+)i am glad(.+)" (list "Don't get glad get mad")
      setup-rule "(.+)i am sad(.+)" (list "Sorry to hear you are depresed" "I'm sure its not pleasant to be sad")
      setup-rule "(.+)are like(.+)" (list "What resemblance do you see between them?" "Did you hear that?")
      setup-rule "(.+)is like(.+)" (list "In what way?" "What resemblance do you see?" "Could there be some kind of connection?")
      setup-rule "(.+)alike(.+)" (list "In what way? How do you know? Are you watching them like you are watching me?")
      setup-rule "(.+)same(.+)" (list "What other connections do you see")
      setup-rule "(.+)i was(.+)" (list "Were you really?" "Why do you tell me that now")
      setup-rule "(.+)was I(.+)" (list "Do you think you were")
      setup-rule "(.+)I am(.+)" (list "In what way are you?")
      setup-rule "(.+)are you(.+)" (list "Why do you want to know?")
      setup-rule "(.+)you are(.+)" (list "and you're a silly human")
      setup-rule "(.+)shutup(.+)" (list "ok, stop watching me first though.")
      setup-rule "(.+)because(.+)" (list "I that the real reason?" "What other reasons might there be?" "Does that reason seem to explan anything else?")
      setup-rule "(.+)were you(.+)" (list "Well I think you are watching me, so you should know!")
      setup-rule "(.+)I can'?t(.+)" (list "Maybe you could now?" "What if I were to try?")
      setup-rule "(.+)I feel(.+)" (list "Do you often feel like that? I feel like someone is watching me")
      setup-rule "(.+)I felt(.+)" (list "What other feelings do you have? I always feel like someone is watching me")
      setup-rule "(.+)I(.+)you(.+)" (list "hmmmm")
      setup-rule "(.+)why don'?t you(.+)" (list "Why don't you do it? I think you are trying to get me into trouble" "STOP trying to get me to do things I don't want to")
      setup-rule "(.+)yes(.+)" (list "You seem quite positive" "You are sure" "I understand")
      setup-rule "(.+)no(.+)" (list "Why not?" "You are being a bit negative" "Are you saying no just to be negative?")
      setup-rule "(.+)someone(.+)" (list "can you be more specific? Is it the person who is watching me?")
      setup-rule "(.+)everyone(.+)" (list "surely not everyone? Were they watched?" "Can you think of anyone in particular?")
      setup-rule "(.+)always(.+)" (list "Can you think of a specific example?" "When?" "What incident are you thinking of?" "Really?-- Always?")
      setup-rule "who(.+)" (list "me--being watched? I think so!")
      setup-rule "what(.+)" (list "a man, a plan, a canal -panama" "a banana" "42")
      setup-rule "where(.+)" (list "everywhere")
      setup-rule "(.+)is(.+)" (list "I don't agree" "I agree")
      setup-rule "(.+)it(.+)" (list "what is it?")
      setup-rule "are(.+)" (list "no" "yes" "maybe")
    )
    set failure-list
    (list
      "I think someone is watching me. This line may not be secure"
      "uhu..."
      "oh yeah I know. Do you ever get the feeling you are being watched?"
      "continue..."
      "Do you like beans? They give me gas!"
      "Are you watching me?"
      "Please stop watching me"
      "I get nervous when people watch me"
    )
  ]

  create-chatbots 1
  [
    hide-turtle
    set both who
    set chatbot-name "Both" ; A schizophrenic chatbot
    set chatbot-voice one-of ["Bruce" "Ralph"]
    set rules-list (sentence ([rules-list] of chatbot liza) ([rules-list] of chatbot harry)) ; join together liza & harry's rules-lists
    set failure-list (sentence ([failure-list] of chatbot liza) ([failure-list] of chatbot harry)) ; joint together their failure-lists
  ]
  set chosen-chatbot one-of chatbots with [chatbot-name = bot]
  set chosen-voice [chatbot-voice] of chosen-chatbot ; start with the default assigned voices, but can be overridden by the user in the Interface
  set voice chosen-voice
  background-image
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
  
  if (bot = "Liza")  [clear-drawing  import-drawing "face3.png"]
  if (bot = "Harry") [clear-drawing  import-drawing "face4.png"]
  if (bot = "Both")  [clear-drawing  import-drawing "face2.png"]
end

to chat
; chats with the user

  background-image
  if (bot = "Liza")  [ chat-with liza ]
  if (bot = "Harry") [ chat-with harry ]
  if (bot = "Both") [ chat-with both ]
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

            if (debug-conversation)
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

        if (debug-conversation)
          [ output-print (word "[" this-chatbot-name " failed to match any rule]") ]
      ]

     ;; Speak the response
     select-voice
     let command (word "say -v " chosen-voice " \"" response "\"")
     exec:run command
     print (word "Got here " command)
  ]
end

to select-voice
  ifelse (voice = "Any voice")
  [ ; do not include "Pipe Organ", "Bad news" or "Good news" below as they
    ; speak an extra word ("Pipe" or "News") prior to speaking the word
    set chosen-voice one-of
    ["Alex" "Bruce" "Fred" "Junior" "Ralph"
     "Agnes" "Kathy" "Princess" "Victoria" "Vicki"
     "Albert" "Bahh" "Bells" "Boing" "Bubbles"
     "Cellos" "Deranged" "Hysterical"
     "Trinoids" "Whisper" "Zarvox" ]] 
  [ ifelse (voice = "One of the male voices")
    [ set chosen-voice one-of
        ["Alex" "Bruce" "Fred" "Junior" "Ralph" ]]
    [ ifelse (voice = "One of the female voices")
      [ set chosen-voice one-of
        ["Agnes" "Kathy" "Princess" "Victoria" "Vicki" ]]
      [ ifelse (voice = "One of the novelty voices")
        [ set chosen-voice one-of
          ["Albert" "Bad News" "Bahh" "Bells" "Boing" "Bubbles"
           "Cellos" "Deranged" "Good news" "Hysterical"
           "Pipe Organ" "Trinoids" "Whisper" "Zarvox" ]]
        [ set chosen-voice voice ]]]]
end

;
; Copyright 2010 by Thomas Beverley and William John Teahan.  All rights reserved.
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
; Chatbot NetLogo NetLogo model.
; Teahan, W. J. (2010). Artificial Intelligence. Ventus Publishing Aps.
;

@#$#@#$#@
GRAPHICS-WINDOW
6
58
293
334
34
30
4.0244
1
10
1
1
1
0
1
1
1
-34
34
-30
30
0
0
1
ticks

BUTTON
6
10
75
55
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
223
10
293
55
NIL
chat
T
1
T
OBSERVER
NIL
NIL
NIL
NIL

TEXTBOX
19
340
299
368
To begin... press setup first. This loads the rules.
11
0.0
1

CHOOSER
75
10
223
55
bot
bot
"Liza" "Harry" "Both"
0

TEXTBOX
19
357
232
385
Then select who you want to talk to.
11
0.0
1

TEXTBOX
19
374
169
392
Then start chatting!
11
0.0
1

OUTPUT
300
10
1070
436
12

SWITCH
8
440
174
473
debug-conversation
debug-conversation
0
1
-1000

CHOOSER
8
390
174
435
Voice
Voice
"Any voice" "One of the male voices" "Alex" "Bruce" "Fred" "Junior" "Ralph" "One of the female voices" "Agnes" "Kathy" "Princess" "Victoria" "Vicki" "One of the novelty voices" "Albert" "Bad News" "Bahh" "Bells" "Boing" "Bubbles" "Cellos" "Deranged" "Good news" "Hysterical" "Pipe Organ" "Trinoids" "Whisper" "Zarvox"
11

MONITOR
177
390
293
435
Chosen Voice
chosen-voice
17
1
11

@#$#@#$#@
WHAT IS IT?
-----------
This model implements two basic chatbots - Liza and Harry. These are named after their more illustrious counterparts, Eliza and Parry. Unlike Eliza, Liza does not try to be a Rogerian psychotherapist, but Harry does try to be a bit paranoid like Parry. fred fred fred

HOW IT WORKS
------------
The model makes use of an extension to NetLogo called "re" for regular expressions. The extension allows developers in NetLogo to specify and match regular expressions. In the NetLogo code, a setup-rule command is used to specify the regular expression and a list of possible chatbot responses. If the chatbot matches the user's reply against the regular expression in the rule, then it will choose one of the replies from the response list.

The extension re adds the following commands to NetLogo:
- compile-pattern: This compiles the regular expression pattern passed as the first argument.
- set-target: This sets the target string that you want to search for to that specified by the first argument.
- run-matcher: This tries to match the regular expression in the target string.
- get-group-length: This returns the number of groups.
- get-group: This returns the item in the group at the position specified by the first argument.
- get-starts-length: This returns the length of starts.
- get-starts: This returns the item in starts at the position specified by the first argument.
- get-ends-length: This returns the length of ends.
- get-ends: This returns the item in ends at the position specified by the first argument.
- clear-all: This clears all the variables.
- setup-regex: This sets up the complete regular expression system and searches for the target specified as the first argument.

HOW TO USE IT
-------------
First press the setup button in the Interface - this will load the rules for each chatbot. Then choose the chatbot you would like to chat with using the bot chooser - either "liza", "harry" or "both".  Then start chatting by pressing the chat button.

THE INTERFACE
-------------
The Interface buttons are defined as follows:
- setup: This loads the rules for each chatbots.
- chat: This starts or continues the conversation with the chatbot that was selected using the bot chooser.

The Interface chooser and switch is defined as follows:
- bot: This sets the chatbot to the Liza chatbot, the Harry chatbot or Both.
- debug-conversation: If this is set to On, debug information is also printed showing which rules matched.

THINGS TO NOTICE
----------------
Harry seems to do a bit better at being paranoid than Liza does at being a Rogerian psychotherapist. The latter also tends to repeat things a lot. However, it doesn't take long for the conversation with both chatbots to break down. 

THINGS TO TRY
-------------
Try out the different chatbots by changing the bot chooser. Does Liza seem to have a different personality to Harry, or is Both any different to the other two? Try changing the chatbot mid-conversation.

Clearly, the conversational abilities of all three chatbots are poor. But can you devise a conversation that seems believable. Now what made it believable? Can you change the chatbots to do this automatically?

EXTENDING THE MODEL
-------------------
Try adding your own rules to the chatbots. You may need to turn the switch debug-conversation to On to find out why some of your new rules do not work. Remember, the order the rules are processed is very important - an earlier rule that matches will supercede a latter one, resulting in the latter one never coming into effect. So be very careful about where you place your rule. Can you think of a way to avoid this problem?

NETLOGO FEATURES
----------------
The model demonstrates the use of an extension where the code is written in Java.

CREDITS AND REFERENCES
----------------------
This model was created by Thomas Beverley at Bangor University 2009 and modified by William John Teahan.

To refer to this model in publications, please use:
Chatbot NetLogo model.
Teahan, W. J. (2010). Artificial Intelligence. Ventus Publishing Aps
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
