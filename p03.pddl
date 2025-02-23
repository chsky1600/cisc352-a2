(define (problem p3-dungeon)
  (:domain Dungeon)

  ; Naming convention:
  ; - loc-{i}-{j} refers to the location at the i'th column and j'th row (starting in top left corner)
  ; - c{i}{j}{h}{k} refers to the corridor connecting loc-{i}-{j} and loc-{h}-{k}
  (:objects
    loc-3-4 loc-4-5 loc-1-2 loc-2-2 loc-3-2 loc-3-3 loc-2-5 loc-1-3 loc-2-1 loc-1-4 loc-3-5 loc-2-4 loc-4-4 loc-2-3 loc-4-3 - location
    c2122 c1222 c2232 c1213 c1223 c2223 c3223 c3233 c1323 c2333 c1314 c2314 c2324 c2334 c3334 c1424 c2434 c2425 c2535 c3545 c4544 c4443 - corridor
    key1 key2 key3 key4 key5 key6 - key
  )

  (:init

    ; Hero location and carrying status
    (hero-at loc-2-1)
    (hand-free)

    ;Corridor Connections
    ;; Corridor c2122 connecting loc-2-1 <-> loc-2-2
    (connected loc-2-1 loc-2-2 c2122)
    (connected loc-2-2 loc-2-1 c2122)
    (adjacent loc-2-1 c2122)
    (adjacent loc-2-2 c2122)

    ;; Corridor c1222 connecting loc-1-2 <-> loc-2-2
    (connected loc-1-2 loc-2-2 c1222)
    (connected loc-2-2 loc-1-2 c1222)
    (adjacent loc-1-2 c1222)
    (adjacent loc-2-2 c1222)

    ;; Corridor c2232 connecting loc-2-2 <-> loc-3-2
    (connected loc-2-2 loc-3-2 c2232)
    (connected loc-3-2 loc-2-2 c2232)
    (adjacent loc-2-2 c2232)
    (adjacent loc-3-2 c2232)

    ;; Corridor c1213 connecting loc-1-2 <-> loc-1-3
    (connected loc-1-2 loc-1-3 c1213)
    (connected loc-1-3 loc-1-2 c1213)
    (adjacent loc-1-2 c1213)
    (adjacent loc-1-3 c1213)

    ;; Corridor c1223 connecting loc-1-2 <-> loc-2-3
    (connected loc-1-2 loc-2-3 c1223)
    (connected loc-2-3 loc-1-2 c1223)
    (adjacent loc-1-2 c1223)
    (adjacent loc-2-3 c1223)

    ;; Corridor c2223 connecting loc-2-2 <-> loc-2-3
    (connected loc-2-2 loc-2-3 c2223)
    (connected loc-2-3 loc-2-2 c2223)
    (adjacent loc-2-2 c2223)
    (adjacent loc-2-3 c2223)

    ;; Corridor c3223 connecting loc-3-2 <-> loc-2-3
    (connected loc-3-2 loc-2-3 c3223)
    (connected loc-2-3 loc-3-2 c3223)
    (adjacent loc-3-2 c3223)
    (adjacent loc-2-3 c3223)

    ;; Corridor c3233 connecting loc-3-2 <-> loc-3-3
    (connected loc-3-2 loc-3-3 c3233)
    (connected loc-3-3 loc-3-2 c3233)
    (adjacent loc-3-2 c3233)
    (adjacent loc-3-3 c3233)

    ;; Corridor c1323 connecting loc-1-3 <-> loc-2-3
    (connected loc-1-3 loc-2-3 c1323)
    (connected loc-2-3 loc-1-3 c1323)
    (adjacent loc-1-3 c1323)
    (adjacent loc-2-3 c1323)

    ;; Corridor c2333 connecting loc-2-3 <-> loc-3-3
    (connected loc-2-3 loc-3-3 c2333)
    (connected loc-3-3 loc-2-3 c2333)
    (adjacent loc-2-3 c2333)
    (adjacent loc-3-3 c2333)

    ;; Corridor c1314 connecting loc-1-3 <-> loc-1-4
    (connected loc-1-3 loc-1-4 c1314)
    (connected loc-1-4 loc-1-3 c1314)
    (adjacent loc-1-3 c1314)
    (adjacent loc-1-4 c1314)

    ;; Corridor c2314 connecting loc-2-3 <-> loc-1-4
    (connected loc-2-3 loc-1-4 c2314)
    (connected loc-1-4 loc-2-3 c2314)
    (adjacent loc-2-3 c2314)
    (adjacent loc-1-4 c2314)

    ;; Corridor c2324 connecting loc-2-3 <-> loc-2-4
    (connected loc-2-3 loc-2-4 c2324)
    (connected loc-2-4 loc-2-3 c2324)
    (adjacent loc-2-3 c2324)
    (adjacent loc-2-4 c2324)

    ;; Corridor c2334 connecting loc-2-3 <-> loc-3-4
    (connected loc-2-3 loc-3-4 c2334)
    (connected loc-3-4 loc-2-3 c2334)
    (adjacent loc-2-3 c2334)
    (adjacent loc-3-4 c2334)

    ;; Corridor c3334 connecting loc-3-3 <-> loc-3-4
    (connected loc-3-3 loc-3-4 c3334)
    (connected loc-3-4 loc-3-3 c3334)
    (adjacent loc-3-3 c3334)
    (adjacent loc-3-4 c3334)

    ;; Corridor c1424 connecting loc-1-4 <-> loc-2-4
    (connected loc-1-4 loc-2-4 c1424)
    (connected loc-2-4 loc-1-4 c1424)
    (adjacent loc-1-4 c1424)
    (adjacent loc-2-4 c1424)

    ;; Corridor c2434 connecting loc-2-4 <-> loc-3-4
    (connected loc-2-4 loc-3-4 c2434)
    (connected loc-3-4 loc-2-4 c2434)
    (adjacent loc-2-4 c2434)
    (adjacent loc-3-4 c2434)

    ;; Corridor c2425 connecting loc-2-4 <-> loc-2-5
    (connected loc-2-4 loc-2-5 c2425)
    (connected loc-2-5 loc-2-4 c2425)
    (adjacent loc-2-4 c2425)
    (adjacent loc-2-5 c2425)

    ;; Corridor c2535 connecting loc-2-5 <-> loc-3-5
    (connected loc-2-5 loc-3-5 c2535)
    (connected loc-3-5 loc-2-5 c2535)
    (adjacent loc-2-5 c2535)
    (adjacent loc-3-5 c2535)

    ;; Corridor c3545 connecting loc-3-5 <-> loc-4-5
    (connected loc-3-5 loc-4-5 c3545)
    (connected loc-4-5 loc-3-5 c3545)
    (adjacent loc-3-5 c3545)
    (adjacent loc-4-5 c3545)

    ;; Corridor c4544 connecting loc-4-5 <-> loc-4-4
    (connected loc-4-5 loc-4-4 c4544)
    (connected loc-4-4 loc-4-5 c4544)
    (adjacent loc-4-5 c4544)
    (adjacent loc-4-4 c4544)

    ;; Corridor c4443 connecting loc-4-4 <-> loc-4-3
    (connected loc-4-4 loc-4-3 c4443)
    (connected loc-4-3 loc-4-4 c4443)
    (adjacent loc-4-4 c4443)
    (adjacent loc-4-3 c4443)

    ; Key locations
    (key-at key1 loc-2-1)
    (key-at key2 loc-2-3)
    (key-at key3 loc-2-3)
    (key-at key4 loc-2-3)
    (key-at key5 loc-2-3)
    (key-at key6 loc-4-4)

    ; Locked corridors
    (locked c2223)
    (corr-colour c2223 red) 

    (locked c1223)
    (corr-colour c1223 red) 

    (locked c3223)
    (corr-colour c3223 red)

    (locked c1323)
    (corr-colour c1323 red)

    (locked c2314)
    (corr-colour c2314 red)

    (locked c2324)
    (corr-colour c2324 red) 

    (locked c2334)
    (corr-colour c2334 red)

    (locked c2333)
    (corr-colour c2333 red)

    (locked c2425)
    (corr-colour c2425 purple)

    (locked c2535)
    (corr-colour c2535 green)

    (locked c3545)
    (corr-colour c3545 purple)

    (locked c4544)
    (corr-colour c4544 green)

    (locked c4443)
    (corr-colour c4443 rainbow)

    ; Risky corridors
    (risky c2223)
    (risky c1223)
    (risky c3223)
    (risky c1323)
    (risky c2314)
    (risky c2324)
    (risky c2334)
    (risky c2333)

    ; Key colours
    (key-color key1 red)
    (key-color key2 green)
    (key-color key3 green)
    (key-color key4 purple)
    (key-color key5 purple)
    (key-color key6 rainbow)

    ; Key usage properties (one use, two use, etc)
    (multi-use key1)
    (one-use key2)
    (one-use key3)
    (one-use key4)
    (one-use key5)
    (one-use key6)

  )
  (:goal
    (and
      ; Hero's final location goes here
      (hero-at loc-4-3)
    )
  )

)
