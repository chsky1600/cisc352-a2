(define (domain Dungeon)

    (:requirements
        :typing
        :negative-preconditions
        :conditional-effects
        :equality
    )

    ; Do not modify the types
    (:types
        location colour key corridor
    )

    ; Do not modify the constants
    (:constants
        red yellow green purple rainbow - colour
    )

    ; You may introduce whatever predicates you would like to use
    (:predicates

        ; One predicate given for free!
        (hero-at ?loc - location)

        ; room and corridor relationships
        (connected ?from ?to - location ?cor - corridor) ; corridor connects 2 locations
        (locked ?cor - corridor ?col - colour)  ; corridor is locked, requires key
        (risky ?cor - corridor)  ; corridor collapses once passed through
        (collapsed ?cor - corridor)  ; corridor has collapsed

        ; key properties
        (key-at ?k - key ?loc - location)  ; at some location
        (holding ?k - key)  ; hero is holding this key
        (key-color ?k - key ?col - colour)  ; is a color

        ; key usage properties
        (one-use ?k - key)  ;  can only be used once
        (two-use ?k - key)  ;  can be used twice
        (multi-use ?k - key)  ; can be used infinitely
        (used ?k - key)  ;  has been used up

        ; room conditions
        (messy ?loc - location)  ; Room is messy

    )

    ; IMPORTANT: You should not change/add/remove the action names or parameters

    ;Hero can move if the
    ;    - Hero is at current location ?from,
    ;    - Hero will move to location ?to,
    ;    - Corridor ?cor exists between the ?from and ?to locations
    ;    - There isn't a locked door in corridor ?cor
    ;Effects move the hero, and collapse the corridor if it's "risky" (also causing a mess in the ?to location)
    (:action move

        :parameters (?from ?to - location ?cor - corridor)

        :precondition (and
            (hero-at ?from)
            (connected ?from ?to ?cor)
            (not (locked ?cor ?col))  ; must not be locked
            (not (collapsed ?cor))  ; must not be collapsed
        )

        :effect (and
            (not (hero-at ?from))
            (hero-at ?to)

            ; if corridor is risky --> collapses --> dest. is now messy
            (when (risky ?cor)
                (and
                    (collapsed ?cor)
                    (messy ?to)
                )
            )
        )
    )

    ;Hero can pick up a key if the
    ;    - hero is at current location ?loc,
    ;    - there is a key ?k at location ?loc,
    ;    - the hero's arm is free,
    ;    - the location is not messy
    ;Effect will have the hero holding the key and their arm no longer being free
    (:action pick-up

        :parameters (?loc - location ?k - key)

        :precondition (and
            (hero-at ?loc)
            (key-at ?k ?loc)
            (not (holding ?k))
            (not (messy ?loc))
        )

        :effect (and
            (holding ?k)
            (not (key-at ?k ?loc))
        )
    )

    ;Hero can drop a key if the
    ;    - hero is holding a key ?k,
    ;    - the hero is at location ?loc
    ;Effect will be that the hero is no longer holding the key
    (:action drop

        :parameters (?loc - location ?k - key)

        :precondition (and
            (hero-at ?loc)
            (holding ?k)
        )

        :effect (and
            (not (holding ?k))
            (key-at ?k ?loc)

        )
    )


    ;Hero can use a key for a corridor if
    ;    - the hero is holding a key ?k,
    ;    - the key still has some uses left,
    ;    - the corridor ?cor is locked with colour ?col,
    ;    - the key ?k is if the right colour ?col,
    ;    - the hero is at location ?loc
    ;    - the corridor is connected to the location ?loc
    ;Effect will be that the corridor is unlocked and the key usage will be updated if necessary
    (:action unlock

        :parameters (?loc - location ?cor - corridor ?col - colour ?k - key)

        :precondition (and
            (hero-at ?loc)
            (holding ?k)
            (locked ?cor ?col)
            (key-color ?k ?col)
            (connected ?loc ?other ?cor)
            (or
                (multi-use ?k)
                (and (two-use ?k) (not (used ?k)))  ; if two-use it can be used twice
                (and (one-use ?k) (not (used ?k)))  ; if one-use, it cannot have been used yet
            )
        )

        :effect (and
            (not (locked ?cor ?col))  ; unlock cor

            ; if key is one-use or two-use then mark it as used
            (when (one-use ?k) (used ?k))
            (when (two-use ?k)
                (and
                    (not (two-use ?k))
                    (multi-use ?k)
                )
            )
        )
    )

    ;Hero can clean a location if
    ;    - the hero is at location ?loc,
    ;    - the location is messy
    ;Effect will be that the location is no longer messy
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
