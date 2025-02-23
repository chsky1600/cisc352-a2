(define (problem p4-dungeon)
  (:domain Dungeon)

  ; Come up with your own problem instance (see assignment for details)
  ; NOTE: You _may_ use new objects for this problem only.

  ; Naming convention:
  ; - loc-{i}-{j} refers to the location at the i'th column and j'th row (starting in top left corner)
  ; - c{i}{j}{h}{k} refers to the corridor connecting loc-{i}-{j} and loc-{h}-{k}
  (:objects
    loc-1-1 - location
    c1111 - corridor
    key1 - key
  )

  (:init

    ; Hero location and carrying status

    ; Locationg <> Corridor Connections

    ; Key locations

    ; Locked corridors

    ; Risky corridors

    ; Key colours

    ; Key usage properties (one use, two use, etc)

  )
  (:goal
    (and
      ; Hero's final location goes here
    )
  )

)

(define (problem p4-dungeon)
  (:domain Dungeon)

  ;; We have six locations and seven corridors (5 locked, each a different color).
  ;; The hero must navigate from loc-1-1 to loc-3-2, collecting and using the
  ;; correct keys in a nontrivial order. Corridor c2232 is risky and collapses,
  ;; forcing extra moves to pick up/drop keys and clean messy rooms.

  (:objects
    ;; Locations
    loc-1-1 loc-2-1 loc-3-1
    loc-1-2 loc-2-2 loc-3-2
      - location

    ;; Corridors
    c1112   ; loc-1-1 <-> loc-1-2 (unlocked)
    c1121   ; loc-1-1 <-> loc-2-1 (locked red)
    c2112   ; loc-2-1 <-> loc-1-2 (locked green)
    c2131   ; loc-2-1 <-> loc-3-1 (locked purple)
    c3132   ; loc-3-1 <-> loc-3-2 (locked rainbow)
    c1222   ; loc-1-2 <-> loc-2-2 (locked yellow)
    c2232   ; loc-2-2 <-> loc-3-2 (risky, unlocked)
      - corridor

    ;; Keys
    key-red key-green key-purple key-yellow key-rainbow
      - key
  )

  (:init
    ;; The hero starts in loc-1-1 with no key in hand.
    (hero-at loc-1-1)
    (hand-free)

    ;; Corridor connections & adjacency.

    ;; 1) loc-1-1 <-> loc-1-2 (unlocked)
    (connected loc-1-1 loc-1-2 c1112)
    (connected loc-1-2 loc-1-1 c1112)
    (adjacent loc-1-1 c1112)
    (adjacent loc-1-2 c1112)

    ;; 2) loc-1-1 <-> loc-2-1 (locked red)
    (connected loc-1-1 loc-2-1 c1121)
    (connected loc-2-1 loc-1-1 c1121)
    (adjacent loc-1-1 c1121)
    (adjacent loc-2-1 c1121)

    ;; 3) loc-2-1 <-> loc-1-2 (locked green)
    (connected loc-2-1 loc-1-2 c2112)
    (connected loc-1-2 loc-2-1 c2112)
    (adjacent loc-2-1 c2112)
    (adjacent loc-1-2 c2112)

    ;; 4) loc-2-1 <-> loc-3-1 (locked purple)
    (connected loc-2-1 loc-3-1 c2131)
    (connected loc-3-1 loc-2-1 c2131)
    (adjacent loc-2-1 c2131)
    (adjacent loc-3-1 c2131)

    ;; 5) loc-3-1 <-> loc-3-2 (locked rainbow)
    (connected loc-3-1 loc-3-2 c3132)
    (connected loc-3-2 loc-3-1 c3132)
    (adjacent loc-3-1 c3132)
    (adjacent loc-3-2 c3132)

    ;; 6) loc-1-2 <-> loc-2-2 (locked yellow)
    (connected loc-1-2 loc-2-2 c1222)
    (connected loc-2-2 loc-1-2 c1222)
    (adjacent loc-1-2 c1222)
    (adjacent loc-2-2 c1222)

    ;; 7) loc-2-2 <-> loc-3-2 (unlocked, but risky)
    (connected loc-2-2 loc-3-2 c2232)
    (connected loc-3-2 loc-2-2 c2232)
    (adjacent loc-2-2 c2232)
    (adjacent loc-3-2 c2232)
    (risky c2232)

    ;; Lock states & colors
    (locked c1121) (corr-colour c1121 red)
    (locked c2112) (corr-colour c2112 green)
    (locked c2131) (corr-colour c2131 purple)
    (locked c3132) (corr-colour c3132 rainbow)
    (locked c1222) (corr-colour c1222 yellow)

    ;; Keys placed in the dungeon
    (key-at key-red loc-1-2)
    (key-at key-green loc-2-1)
    (key-at key-purple loc-2-1)
    (key-at key-yellow loc-3-1)
    (key-at key-rainbow loc-2-2)

    ;; Key colors
    (key-color key-red red)
    (key-color key-green green)
    (key-color key-purple purple)
    (key-color key-yellow yellow)
    (key-color key-rainbow rainbow)

    ;; Key usage properties
    (one-use key-red)
    (two-use key-green)
    (one-use key-purple)
    (one-use key-yellow)
    (multi-use key-rainbow)
  )

  ;; Goal: hero must reach loc-3-2 (where the treasure presumably lies).
  (:goal
    (hero-at loc-3-2)
  )
)
