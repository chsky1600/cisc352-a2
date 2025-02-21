(define (problem p2-dungeon)
  (:domain Dungeon)

  ; Naming convention:
  ; - loc-{i}-{j} refers to the location at the i'th column and j'th row (starting in top left corner)
  ; - c{i}{j}{h}{k} refers to the corridor connecting loc-{i}-{j} and loc-{h}-{k}
  (:objects
    loc-2-1 loc-1-2 loc-2-2 loc-3-2 loc-4-2 loc-2-3 - location
    key1 key2 key3 key4 - key
    c2122 c1222 c2232 c3242 c2223 - corridor
  )

  (:init

    ; Hero location and carrying status
    (hero-at loc-2-1)

    ; Locationg <> Corridor Connections
    (connected loc-2-1 loc-2-2 c2122)
    (connected loc-1-2 loc-2-2 c1222)
    (connected loc-2-2 loc-3-2 c2232)
    (connected loc-3-2 loc-4-2 c3242)
    (connected loc-2-2 loc-2-3 c2223)

    ; Key locations
    (key-at key1 loc-1-2)
    (key-at key2 loc-2-3)
    (key-at key3 loc-3-2)
    (key-at key4 loc-4-2)

    ; Locked corridors
    (locked c2232 red)
    (locked c2223 green)
    (locked c3242 purple)

    ; Risky corridors
    (risky c1222)

    ; Key colours
    (key-color key1 red)
    (key-color key2 green)
    (key-color key3 green)
    (key-color key4 purple)

    ; Key usage properties (one use, two use, etc)
    (one-use key1)
    (two-use key2)
    (one-use key3)
    (one-use key4)

  )
  (:goal
    (and
      ; Hero's final location goes here
      (hero-at loc-4-2)
    )
  )

)
