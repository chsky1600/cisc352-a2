(define (problem p4-dungeon)
  (:domain Dungeon)

  (:objects
    ;locations of the objects 
    loc-1-1 loc-2-1 loc-3-1
    loc-1-2 loc-2-2 loc-3-2
      - location

    ;Corridors
    c1112   
    c1121   
    c2112  
    c2131   
    c3132   
    c1222   
    c2232   
      - corridor

    ;Keys
    key-red key-green key-purple key-yellow key-rainbow
      - key
  )

  (:init

    ;Hero location and carrying status
    (hero-at loc-1-1)
    (hand-free)

    ;Locationg <> Corridor Connections

    ;loc-1-1 <-> loc-1-2 (unlocked)
    (connected loc-1-1 loc-1-2 c1112)
    (connected loc-1-2 loc-1-1 c1112)
    (adjacent loc-1-1 c1112)
    (adjacent loc-1-2 c1112)

    ;loc-1-1 <-> loc-2-1 (locked red)
    (connected loc-1-1 loc-2-1 c1121)
    (connected loc-2-1 loc-1-1 c1121)
    (adjacent loc-1-1 c1121)
    (adjacent loc-2-1 c1121)

    ;loc-2-1 <-> loc-1-2 (locked green)
    (connected loc-2-1 loc-1-2 c2112)
    (connected loc-1-2 loc-2-1 c2112)
    (adjacent loc-2-1 c2112)
    (adjacent loc-1-2 c2112)

    ;loc-2-1 <-> loc-3-1 (locked purple)
    (connected loc-2-1 loc-3-1 c2131)
    (connected loc-3-1 loc-2-1 c2131)
    (adjacent loc-2-1 c2131)
    (adjacent loc-3-1 c2131)

    ;loc-3-1 <-> loc-3-2 (locked rainbow)
    (connected loc-3-1 loc-3-2 c3132)
    (connected loc-3-2 loc-3-1 c3132)
    (adjacent loc-3-1 c3132)
    (adjacent loc-3-2 c3132)

    ;loc-1-2 <-> loc-2-2 (locked yellow)
    (connected loc-1-2 loc-2-2 c1222)
    (connected loc-2-2 loc-1-2 c1222)
    (adjacent loc-1-2 c1222)
    (adjacent loc-2-2 c1222)

    ;loc-2-2 <-> loc-3-2 (unlocked, but risky)
    (connected loc-2-2 loc-3-2 c2232)
    (connected loc-3-2 loc-2-2 c2232)
    (adjacent loc-2-2 c2232)
    (adjacent loc-3-2 c2232)

    ;Risky corridors
    (risky c2232)

    ;Key locations
    (key-at key-red loc-1-2)
    (key-at key-green loc-2-1)
    (key-at key-purple loc-2-1)
    (key-at key-yellow loc-3-1)
    (key-at key-rainbow loc-2-2)

    ;Locked corridors
    (locked c1121) (corr-colour c1121 red)
    (locked c2112) (corr-colour c2112 green)
    (locked c2131) (corr-colour c2131 purple)
    (locked c3132) (corr-colour c3132 rainbow)
    (locked c1222) (corr-colour c1222 yellow)


    ;Key colors
    (key-color key-red red)
    (key-color key-green green)
    (key-color key-purple purple)
    (key-color key-yellow yellow)
    (key-color key-rainbow rainbow)

    ;Key usage properties (one use, two use, etc)
    (one-use key-red)
    (two-use key-green)
    (one-use key-purple)
    (one-use key-yellow)
    (multi-use key-rainbow)
  )

  ;Hero's final location goes here
  (:goal
    (hero-at loc-3-2)
  )
)
