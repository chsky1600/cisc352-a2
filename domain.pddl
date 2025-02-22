(define (domain Dungeon)

  (:requirements
    :typing
    :negative-preconditions
    :conditional-effects
    :equality
  )

  ;; Do not modify the types
  (:types
    location colour key corridor
  )

  ;; Do not modify the constants
  (:constants
    red yellow green purple rainbow - colour
  )

  ;; You may introduce whatever predicates you would like to use
  (:predicates

    ;; One predicate given for free!
    (hero-at ?loc - location)

    ;; room and corridor relationships
    (connected ?from ?to - location ?cor - corridor) ; corridor connects 2 locations
    (locked ?cor - corridor)                      ; corridor is locked, ignoring color here
    (corr-colour ?cor - corridor ?col - colour)     ; corridor's color
    (adjacent ?loc - location ?cor - corridor)         ; corridor is adjacent to some location
    (risky ?cor - corridor)                         ; corridor collapses once passed
    (collapsed ?cor - corridor)                  ; corridor has collapsed

    ;; key properties
    (key-at ?k - key ?loc - location)               ; key at some location
    (holding ?k - key)                              ; hero is holding this key
    (key-color ?k - key ?col - colour)              ; key's color

    ;; key usage properties
    (one-use ?k - key)                              ; can only be used once
    (two-use ?k - key)                              ; can be used twice
    (multi-use ?k - key)                            ; can be used infinitely
    (used ?k - key)                                 ; has been used up

    ;; room conditions
    (messy ?loc - location)                   ; room is messy

    (hand-free)                                        ; hero is *not* holding a key

  )

  ;; IMPORTANT: Do not change/add/remove the action names or parameters

  ;; Hero can move if:
  ;;  - The hero is at ?from
  ;;  - Corridor ?cor connects ?from to ?to
  ;;  - The corridor is not locked
  ;;  - The corridor is not collapsed
  ;; Effects:
  ;;  - The hero moves from ?from to ?to
  ;;  - If corridor is risky, it collapses and the destination becomes messy
  (:action move
    :parameters (?from ?to - location ?cor - corridor)
    :precondition (and
      (hero-at ?from)
      (connected ?from ?to ?cor)
      (not (locked ?cor))       ; must not be locked
      (not (collapsed ?cor))    ; must not be collapsed
    )
    :effect (and
      (not (hero-at ?from))
      (hero-at ?to)
      (when (risky ?cor)
        (and
          (collapsed ?cor)
          (messy ?to)
        )
      )
    )
  )

  ;; Hero can pick up a key if:
  ;;  - The hero is at ?loc
  ;;  - The key ?k is at ?loc
  ;;  - The hero is not already holding it
  ;;  - The location is not messy
  ;; Effect:
  ;;  - The hero holds the key
  ;;  - The key is no longer at that location
  (:action pick-up
    :parameters (?loc - location ?k - key)
    :precondition (and
      (hero-at ?loc)
      (key-at ?k ?loc)
      (not (holding ?k))
      (not (messy ?loc))
      (hand-free)
    )
    :effect (and
      (holding ?k)
      (not (key-at ?k ?loc))
      (not (hand-free))
    )
  )

  ;; Hero can drop a key if:
  ;;  - The hero is holding ?k
  ;;  - The hero is at ?loc
  ;; Effect:
  ;;  - The hero no longer holds the key
  ;;  - The key is left in ?loc
  (:action drop
    :parameters (?loc - location ?k - key)
    :precondition (and
      (hero-at ?loc)
      (holding ?k)
    )
    :effect (and
      (not (holding ?k))
      (key-at ?k ?loc)
      (hand-free)
    )
  )

  ;; Hero can unlock a locked corridor if:
  ;;  - The hero is at ?loc
  ;;  - The hero is holding key ?k
  ;;  - Corridor ?cor is locked
  ;;  - Corridor ?cor is associated with colour ?col
  ;;  - Key ?k has colour ?col
  ;;  - Corridor ?cor is adjacent to hero's location ?loc
  ;;  - The key has remaining uses:
  ;;      * multi-use: infinite
  ;;      * two-use: not used yet
  ;;      * one-use: not used yet
  ;; Effect:
  ;;  - The corridor becomes unlocked
  ;;  - If the key is one-use or two-use, update usage
  (:action unlock
    :parameters (?loc - location ?cor - corridor ?col - colour ?k - key)
    :precondition (and
      (hero-at ?loc)
      (holding ?k)
      (locked ?cor)
      (corr-colour ?cor ?col)
      (key-color ?k ?col)
      (adjacent ?loc ?cor) ; adjacency check
      (or
        (multi-use ?k)
        (and (two-use ?k) (not (used ?k)))
        (and (one-use ?k) (not (used ?k)))
      )
    )
    :effect (and
      (not (locked ?cor))  ; corridor is now unlocked

      ;; If key is one-use, it becomes used after 1 unlock
      (when (one-use ?k)
        (used ?k))

      ;; If key is two-use, we transform it into a multi-use key 
      ;; after first use. (A common approach: 2->1->used, or 
      ;; 2->multi. This is your chosen modeling approach.)
      (when (two-use ?k)
        (and
          (not (two-use ?k))
          (multi-use ?k)
        )
      )
    )
  )

  ;; Hero can clean a messy location if:
  ;;  - The hero is at ?loc
  ;;  - ?loc is messy
  ;; Effect:
  ;;  - The location is no longer messy
  (:action clean
    :parameters (?loc - location)
    :precondition (and
      (hero-at ?loc)
      (messy ?loc)
    )
    :effect (and
      (not (messy ?loc))
    )
  )

)