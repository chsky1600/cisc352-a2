(define (problem p1-dungeon)
  (:domain Dungeon)

  (:objects
    ;; Locations
    loc-3-1 loc-1-2 loc-2-2 loc-3-2 loc-4-2 loc-2-3 loc-3-3 loc-2-4 loc-3-4 loc-4-4 - location

    ;; Keys
    key1 key2 key3 key4 - key

    ;; Corridors
    c3132 c1222 c2232 c3242 c2223 c3233 c2333 c2324 c3334 c2434 c3444 - corridor
  )

(:init
  ;; Hero location
  (hero-at loc-1-2)
  (hand-free)

  ;; Corridor connections
  ;; Corridor c3132 connecting loc-3-1 <--> loc-3-2
  (connected loc-3-1 loc-3-2 c3132)
  (connected loc-3-2 loc-3-1 c3132)
  (adjacent loc-3-1 c3132)
  (adjacent loc-3-2 c3132)

  ;; Corridor c1222 connecting loc-1-2 <--> loc-2-2
  (connected loc-1-2 loc-2-2 c1222)
  (connected loc-2-2 loc-1-2 c1222)
  (adjacent loc-1-2 c1222)
  (adjacent loc-2-2 c1222)

  ;; Corridor c2232 connecting loc-2-2 <--> loc-3-2
  (connected loc-2-2 loc-3-2 c2232)
  (connected loc-3-2 loc-2-2 c2232)
  (adjacent loc-2-2 c2232)
  (adjacent loc-3-2 c2232)

  ;; Corridor c3242 connecting loc-3-2 <--> loc-4-2
  (connected loc-3-2 loc-4-2 c3242)
  (connected loc-4-2 loc-3-2 c3242)
  (adjacent loc-3-2 c3242)
  (adjacent loc-4-2 c3242)

  ;; Corridor c2223 connecting loc-2-2 <--> loc-2-3
  (connected loc-2-2 loc-2-3 c2223)
  (connected loc-2-3 loc-2-2 c2223)
  (adjacent loc-2-2 c2223)
  (adjacent loc-2-3 c2223)

  ;; Corridor c3233 connecting loc-3-2 <--> loc-3-3
  (connected loc-3-2 loc-3-3 c3233)
  (connected loc-3-3 loc-3-2 c3233)
  (adjacent loc-3-2 c3233)
  (adjacent loc-3-3 c3233)

  ;; Corridor c2333 connecting loc-2-3 <--> loc-3-3
  (connected loc-2-3 loc-3-3 c2333)
  (connected loc-3-3 loc-2-3 c2333)
  (adjacent loc-2-3 c2333)
  (adjacent loc-3-3 c2333)

  ;; Corridor c2324 connecting loc-2-3 <--> loc-2-4
  (connected loc-2-3 loc-2-4 c2324)
  (connected loc-2-4 loc-2-3 c2324)
  (adjacent loc-2-3 c2324)
  (adjacent loc-2-4 c2324)

  ;; Corridor c3334 connecting loc-3-3 <--> loc-3-4
  (connected loc-3-3 loc-3-4 c3334)
  (connected loc-3-4 loc-3-3 c3334)
  (adjacent loc-3-3 c3334)
  (adjacent loc-3-4 c3334)

  ;; Corridor c2434 connecting loc-2-4 <--> loc-3-4
  (connected loc-2-4 loc-3-4 c2434)
  (connected loc-3-4 loc-2-4 c2434)
  (adjacent loc-2-4 c2434)
  (adjacent loc-3-4 c2434)

  ;; Corridor c3444 connecting loc-3-4 <--> loc-4-4
  (connected loc-3-4 loc-4-4 c3444)
  (connected loc-4-4 loc-3-4 c3444)
  (adjacent loc-3-4 c3444)
  (adjacent loc-4-4 c3444)

  ;; Key locations
  (key-at key1 loc-2-2)
  (key-at key2 loc-2-4)
  (key-at key3 loc-4-2)
  (key-at key4 loc-4-4)

  ;; locked corridors (single-argument) plus corridor-colour mapping
  (locked c2324)
  (corr-colour c2324 red)

  (locked c2434)
  (corr-colour c2434 red)

  (locked c3444)
  (corr-colour c3444 yellow)

  (locked c3242)
  (corr-colour c3242 purple)

  (locked c3132)
  (corr-colour c3132 rainbow)

  ;; Risky corridors
  (risky c2324)
  (risky c2434)

  ;; Key colours
  (key-color key1 red)
  (key-color key2 yellow)
  (key-color key3 rainbow)
  (key-color key4 purple)

  ;; Key usage properties
  (multi-use key1)
  (two-use key2)
  (one-use key3)
  (one-use key4)
)

  (:goal
    (and
      ;; The hero needs to end up at loc-3-1
      (hero-at loc-3-1)
    )
  )
)