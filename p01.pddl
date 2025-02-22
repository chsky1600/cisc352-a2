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
    (hero-at loc-3-1)

    ;; Corridor connections
    (connected loc-3-1 loc-3-2 c3132)
    (connected loc-1-2 loc-2-2 c1222)
    (connected loc-2-2 loc-3-2 c2232)
    (connected loc-3-2 loc-4-2 c3242)
    (connected loc-2-2 loc-2-3 c2223)
    (connected loc-3-2 loc-3-3 c3233)
    (connected loc-2-3 loc-3-3 c2333)
    (connected loc-2-3 loc-2-4 c2324)
    (connected loc-3-3 loc-3-4 c3334)
    (connected loc-2-4 loc-3-4 c2434)
    (connected loc-3-4 loc-4-4 c3444)

    ;; Key locations
    (key-at key1 loc-1-2)
    (key-at key2 loc-2-3)
    (key-at key3 loc-3-3)
    (key-at key4 loc-3-4)

    ;; Locked corridors (single-argument), plus corridor-colour mapping
    (locked c2232)
    (corr-colour c2232 red)

    (locked c2333)
    (corr-colour c2333 green)

    (locked c2324)
    (corr-colour c2324 purple)

    ;; Risky corridors
    (risky c1222)

    ;; Key colours
    (key-color key1 red)
    (key-color key2 green)
    (key-color key3 green)
    (key-color key4 purple)

    ;; Key usage properties
    (one-use key1)
    (two-use key2)
    (one-use key3)
    (one-use key4)
  )

  (:goal
    (and
      ;; The hero needs to end up at loc-4-4
      (hero-at loc-4-4)
    )
  )
)