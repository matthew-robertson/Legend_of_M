DECLARE SUB Inv ()
DECLARE SUB Texture (textid$, x1%, y1%)
DECLARE SUB torcht (x1%, y1%)
DECLARE SUB Pglove (x1%, y1%)
DECLARE SUB flippert (x1%, y1%)
DECLARE SUB bombt (x1%, y1%)
DECLARE SUB Linkssw (lpx%, lpy%)
DECLARE SUB Linkws (lpx%, lpy%)
DECLARE SUB Linksw (lpx%, lpy%)
DECLARE SUB LinkRS (lpxr%, lpy%)
DECLARE SUB Room1 (room$())
DECLARE SUB Room2 (room$())
DECLARE SUB room3 (room$())
DECLARE SUB Room4 (room$())
DECLARE SUB room7 (room$())
DECLARE SUB room8 (room$())
DECLARE SUB room9 (room$())
DECLARE SUB room10 (room$())
DECLARE SUB room13 (room$())
DECLARE SUB room14 (room$())
DECLARE SUB room15 (room$())
DECLARE SUB room16 (room$())
DECLARE SUB room19 (room$())
DECLARE SUB room20 (room$())
DECLARE SUB room21 (room$())
DECLARE SUB room22 (room$())
DECLARE SUB room25 (room$())
DECLARE SUB room26 (room$())
DECLARE SUB room27 (room$())
DECLARE SUB room28 (room$())
DECLARE SUB room31 (room$())
DECLARE SUB room32 (room$())
DECLARE SUB room33 (room$())
DECLARE SUB Chests ()
DECLARE SUB text ()
DECLARE SUB rooms ()
DECLARE SUB Textureload ()
DECLARE SUB Link (lpx%, lpy%)
DECLARE SUB LinkR (lpxr%, lpy%)
DECLARE SUB LinkW (lpx%, lpy%)
DECLARE SUB Links (lpx%, lpy%)
DECLARE SUB title ()
DIM rl%(0 TO 4, 0 TO 6), room$(-1 TO 12, -1 TO 10), Gmap%(1 TO 16, 1 TO 16), Bomap%(1 TO 16, 1 TO 16), Flmap%(1 TO 16, 1 TO 16), Tomap%(1 TO 16, 1 TO 16), blmap%(1 TO 32, 1 TO 32), fmap%(1 TO 32, 1 TO 32), rmap%(1 TO 32, 1 TO 32), tmap%(1 TO 32, 1 TO 32), mmap%(1 TO 32, 1 TO 32), wmap%(1 TO 32, 1 TO 32), cmap%(1 TO 32, 1 TO 32)

Torch% = 0
Flipper% = 0
Bomb% = 0
tcount% = 0
bcount% = 0
rpar% = 2
rx% = 1
ry% = 1
lpy% = 4
lpx% = 6
lpxr% = 6
x1% = 0
y1% = 0
r% = 1
grab% = 1

CALL Textureload
SCREEN 13
CALL title
CALL text
CALL Link((lpx% - 1) * 32, (lpy% - 1) * 32)
DO
        key$ = INKEY$
        key$ = LCASE$(key$)
        'If they want to grab a rock
        IF key$ = "g" THEN
            IF room$(lpx%, lpy%) <> "Water3" AND room$(lpx%, lpy%) <> "Water2" AND room$(lpx%, lpy%) <> "Water1" THEN
               IF room$(lpx%, lpy% - 1) = "Rock" OR room$(lpx%, lpy% + 1) = "Rock" OR room$(lpx% + 1, lpy%) = "Rock" OR room$(lpx% - 1, lpy%) = "Rock" THEN
                  grab% = grab% + 1
               END IF
            END IF
        'If they'd like to blow up a block
        ELSEIF key$ = "v" THEN
            IF Bomb% = 1 THEN
                DO
                        key$ = INKEY$
                LOOP UNTIL key$ <> ""
                IF key$ = "w" THEN
                        IF room$(lpx%, lpy% - 1) = "Rock" THEN
                                room$(lpx%, lpy% - 1) = "Bg"
                                LINE ((lpx% - 1) * 32, (lpy% - 2) * 32)-(lpx% * 32, (lpy% - 2) * 32 + 31), 66, BF
                                bcount% = bcount% + 1
                        END IF
                ELSEIF key$ = "s" THEN
                        IF room$(lpx%, lpy% + 1) = "Rock" THEN
                                room$(lpx%, lpy% + 1) = "Bg"
                                LINE ((lpx% - 1) * 32, lpy% * 32)-(lpx% * 32, lpy% * 32 + 31), 66, BF
                                bcount% = bcount% + 1
                        END IF
                ELSEIF key$ = "a" THEN
                        IF room$(lpx% - 1, lpy%) = "Rock" THEN
                                room$(lpx% - 1, lpy%) = "Bg"
                                LINE ((lpx% - 2) * 32, (lpy% - 1) * 32)-((lpx% - 1) * 32, (lpy% - 1) * 32 + 31), 66, BF
                                bcount% = bcount% + 1
                        END IF
                ELSEIF key$ = "d" THEN
                        IF room$(lpx% + 1, lpy%) = "Rock" THEN
                                room$(lpx% + 1, lpy%) = "Bg"
                                LINE (lpx% * 32, (lpy% - 1) * 32)-((lpx% + 1) * 32, (lpy% - 1) * 32 + 31), 66, BF
                                bcount% = bcount% + 1
                        END IF
                END IF
            END IF
        'If they wish to restart the room
        ELSEIF key$ = "r" THEN
            CALL rooms
            lpx% = bx%
            lpy% = by%
            CALL Link((lpx% - 1) * 32, (lpy% - 1) * 32)
            tcount% = 0
        'if they want to open a chest
        ELSEIF key$ = " " THEN
            'if they're next to a chest
            IF room$(lpx%, lpy% - 1) = "Chest" OR room$(lpx%, lpy% + 1) = "Chest" OR room$(lpx% + 1, lpy%) = "Chest" OR room$(lpx% - 1, lpy%) = "Chest" THEN
               IF room$(lpx%, lpy% - 1) = "Chest" THEN
                  room$(lpx%, lpy% - 1) = "Echest"
               ELSEIF room$(lpx%, lpy% + 1) = "Chest" THEN
                  room$(lpx%, lpy% + 1) = "Echest"
               ELSEIF room$(lpx% - 1, lpy%) = "Chest" THEN
                  room$(lpx% - 1, lpy%) = "Echest"
               ELSEIF room$(lpx% + 1, lpy%) = "Chest" THEN
                  room$(lpx% + 1, lpy%) = "Echest"
               END IF
               r% = 0
               CALL Chests
               CALL Link((lpx% - 1) * 32, (lpy% - 1) * 32)
            END IF
        ELSEIF key$ = "i" THEN ' if they select the inventory
            CALL Inv
            CALL Link((lpx% - 1) * 32, (lpy% - 1) * 32)
        ELSEIF key$ = "b" THEN  'If they want to burn
             IF Torch% = 1 THEN 'If they have the torch
               IF tcount% < rpar% THEN 'If they still have a use left
                  DO
                     key$ = INKEY$
                     IF key$ = "" THEN
                        key$ = " "
                     END IF
                  LOOP UNTIL key$ <> " "
                  IF key$ = "w" OR key$ = "8" THEN
                     IF room$(lpx%, lpy% - 1) = "Tree" THEN
                        room$(lpx%, lpy% - 1) = "Bg"
                        LINE ((lpx% - 1) * 32, (lpy% - 2) * 32)-(lpx% * 32, (lpy% - 2) * 32 + 31), 66, BF
                        tcount% = tcount% + 1
                     END IF
                  ELSEIF key$ = "s" OR key$ = "2" THEN
                     IF room$(lpx%, lpy% + 1) = "Tree" THEN
                        room$(lpx%, lpy% + 1) = "Bg"
                        LINE ((lpx% - 1) * 32, lpy% * 32)-(lpx% * 32, lpy% * 32 + 31), 66, BF
                        tcount% = tcount% + 1
                     END IF
                  ELSEIF key$ = "a" OR key$ = "4" THEN
                     IF room$(lpx% - 1, lpy%) = "Tree" THEN
                        room$(lpx% - 1, lpy%) = "Bg"
                        LINE ((lpx% - 2) * 32, (lpy% - 1) * 32)-((lpx% - 1) * 32, (lpy% - 1) * 32 + 31), 66, BF
                        tcount% = tcount% + 1
                     END IF
                  ELSEIF key$ = "d" OR key$ = "6" THEN
                     IF room$(lpx% + 1, lpy%) = "Tree" THEN
                        room$(lpx% + 1, lpy%) = "Bg"
                        LINE (lpx% * 32, (lpy% - 1) * 32)-((lpx% + 1) * 32, (lpy% - 1) * 32 + 31), 66, BF
                        tcount% = tcount% + 1
                     END IF

                  END IF
               END IF
             END IF
        ELSEIF key$ = "w" OR key$ = "8" THEN
                IF lpy% = 1 THEN
                        ry% = ry% - 1
                        CALL rooms
                        lpy% = 7
                        tcount% = 0
                        grab% = 1
                        bx% = lpx%
                        by% = lpy%
                END IF
                IF grab% MOD 2 = 0 THEN
                        IF room$(lpx%, lpy% - 1) = "Bg" THEN
                           LINE ((lpx% - 1) * 32, (lpy% - 1) * 32)-((lpx% - 1) * 32 + 31, (lpy% - 1) * 32 + 31), 66, BF
                           IF room$(lpx%, (lpy% + 1)) = "Rock" THEN
                              LINE ((lpx% - 1) * 32, lpy% * 32)-(lpx% * 32, (lpy% + 1) * 32), 66, BF
                              room$(lpx%, lpy% + 1) = "Bg"
                              room$(lpx%, lpy%) = "Rock"
                              CALL Texture("Rock", lpx% * 32, lpy% * 32)
                           END IF
                           lpy% = lpy% - 1
                        END IF
                ELSE
                        IF room$(lpx%, lpy% - 1) = "Bg" THEN
                           IF room$(lpx%, lpy%) = "Bg" THEN
                              LINE ((lpx% - 1) * 32, (lpy% - 1) * 32)-(lpx% * 32 - 1, (lpy% - 1) * 32 + 31), 66, BF
                           ELSEIF room$(lpx%, lpy%) = "Water1" THEN
                              CALL Texture("Water1", lpx% * 32, lpy% * 32)
                           END IF
                           lpy% = lpy% - 1
                        ELSEIF room$(lpx%, lpy% - 1) = "Water1" AND Flipper% = 1 THEN
                           IF room$(lpx%, lpy%) = "Bg" THEN
                              LINE ((lpx% - 1) * 32, (lpy% - 1) * 32)-(lpx% * 32 - 1, (lpy% - 1) * 32 + 31), 66, BF
                           ELSEIF room$(lpx%, lpy%) = "Water1" THEN
                              CALL Texture("Water1", lpx% * 32, lpy% * 32)
                           END IF
                           lpy% = lpy% - 1
                        ELSE
                           IF room$(lpx%, lpy%) = "Bg" THEN
                              LINE ((lpx% - 1) * 32, (lpy% - 1) * 32)-(lpx% * 32 - 1, (lpy% - 1) * 32 + 31), 66, BF
                           ELSEIF room$(lpx%, lpy%) = "Water1" THEN
                              CALL Texture("Water1", lpx% * 32, lpy% * 32)
                           END IF
                        END IF
                END IF
                IF room$(lpx%, lpy%) = "Bg" THEN
                        CALL LinkW((lpx% - 1) * 32, (lpy% - 1) * 32)
                ELSEIF room$(lpx%, lpy%) = "Water1" THEN
                        CALL Linkws((lpx% - 1) * 32, (lpy% - 1) * 32)
                END IF
        'If they want to move left
        ELSEIF key$ = "a" OR key$ = "4" THEN
                IF lpx% = 1 THEN
                        rx% = rx% - 1
                        CALL rooms
                        lpx% = 10
                        tcount% = 0
                        grab% = 1
                        bx% = lpx%
                        by% = lpy%
                END IF
                IF grab% MOD 2 = 0 THEN
                        IF room$(lpx% - 1, lpy%) = "Bg" THEN
                                LINE ((lpx% - 1) * 32, (lpy% - 1) * 32)-(lpx% * 32 - 1, (lpy% - 1) * 32 + 31), 66, BF
                                IF room$(lpx% + 1, lpy%) = "Rock" THEN
                                        LINE (lpx% * 32, (lpy% - 1) * 32)-((lpx% + 1) * 32, lpy% * 32), 66, BF
                                        room$((lpx% + 1), lpy%) = "Bg"
                                        room$(lpx%, lpy%) = "Rock"
                                        CALL Texture("Rock", lpx% * 32, lpy% * 32)
                                END IF
                                lpx% = lpx% - 1
                        END IF
                ELSE
                        IF room$(lpx% - 1, lpy%) = "Bg" THEN
                           IF room$(lpx%, lpy%) = "Bg" THEN
                              LINE ((lpx% - 1) * 32, (lpy% - 1) * 32)-(lpx% * 32 - 1, (lpy% - 1) * 32 + 31), 66, BF
                           ELSEIF room$(lpx%, lpy%) = "Water1" THEN
                              CALL Texture("Water1", lpx% * 32, lpy% * 32)
                           END IF
                           lpx% = lpx% - 1
                        ELSEIF room$(lpx% - 1, lpy%) = "Water1" AND Flipper% = 1 THEN
                           IF room$(lpx%, lpy%) = "Bg" THEN
                              LINE ((lpx% - 1) * 32, (lpy% - 1) * 32)-(lpx% * 32 - 1, (lpy% - 1) * 32 + 31), 66, BF
                           ELSEIF room$(lpx%, lpy%) = "Water1" THEN
                              CALL Texture("Water1", lpx% * 32, lpy% * 32)
                           END IF
                           lpx% = lpx% - 1
                        ELSE
                           IF room$(lpx%, lpy%) = "Bg" THEN
                              LINE ((lpx% - 1) * 32, (lpy% - 1) * 32)-(lpx% * 32 - 1, (lpy% - 1) * 32 + 31), 66, BF
                           ELSEIF room$(lpx%, lpy%) = "Water1" THEN
                              CALL Texture("Water1", lpx% * 32, lpy% * 32)
                           END IF
                        END IF
                END IF
                IF room$(lpx%, lpy%) = "Bg" THEN
                        CALL Link((lpx% - 1) * 32, (lpy% - 1) * 32)
                ELSEIF room$(lpx%, lpy%) = "Water1" THEN
                        CALL Linksw((lpx% - 1) * 32, (lpy% - 1) * 32)
                END IF
        'If they want to move right
        ELSEIF key$ = "d" OR key$ = "6" THEN
                IF lpx% = 10 THEN
                        rx% = rx% + 1
                        CALL rooms
                        lpx% = 0
                        tcount% = 0
                        grab% = 1
                        bx% = lpx% + 1
                        by% = lpy%
                END IF
                IF grab% MOD 2 = 0 THEN
                        IF room$((lpx% + 1), lpy%) = "Bg" THEN
                                LINE ((lpx% - 1) * 32, (lpy% - 1) * 32)-(lpx% * 32 - 1, (lpy% - 1) * 32 + 31), 66, BF
                                IF room$(lpx% - 1, lpy%) = "Rock" THEN
                                        LINE ((lpx% - 2) * 32, (lpy% - 1) * 32)-((lpx% - 1) * 32, lpy% * 32), 66, BF
                                        room$(lpx% - 1, lpy%) = "Bg"
                                        room$(lpx%, lpy%) = "Rock"
                                        CALL Texture("Rock", lpx% * 32, lpy% * 32)
                                END IF
                                lpx% = lpx% + 1
                        END IF
                ELSE
                        IF room$(lpx% + 1, lpy%) = "Bg" THEN
                           IF room$(lpx%, lpy%) = "Bg" THEN
                              LINE ((lpx% - 1) * 32, (lpy% - 1) * 32)-(lpx% * 32 - 1, (lpy% - 1) * 32 + 31), 66, BF
                           ELSEIF room$(lpx%, lpy%) = "Water1" THEN
                              CALL Texture("Water1", lpx% * 32, lpy% * 32)
                           END IF
                           lpx% = lpx% + 1
                        ELSEIF room$(lpx% + 1, lpy%) = "Water1" AND Flipper% = 1 THEN
                           IF room$(lpx%, lpy%) = "Bg" THEN
                              LINE ((lpx% - 1) * 32, (lpy% - 1) * 32)-(lpx% * 32 - 1, (lpy% - 1) * 32 + 31), 66, BF
                           ELSEIF room$(lpx%, lpy%) = "Water1" THEN
                              CALL Texture("Water1", lpx% * 32, lpy% * 32)
                           END IF
                           lpx% = lpx% + 1
                        ELSE
                           IF room$(lpx%, lpy%) = "Bg" THEN
                              LINE ((lpx% - 1) * 32, (lpy% - 1) * 32)-(lpx% * 32 - 1, (lpy% - 1) * 32 + 31), 66, BF
                           ELSEIF room$(lpx%, lpy%) = "Water1" THEN
                              CALL Texture("Water1", lpx% * 32, lpy% * 32)
                           END IF
                        END IF
                END IF
                IF room$(lpx%, lpy%) = "Bg" THEN
                        CALL LinkR(lpx% * 32, (lpy% - 1) * 32)
                ELSEIF room$(lpx%, lpy%) = "Water1" THEN
                        CALL LinkRS(lpx% * 32, (lpy% - 1) * 32)
                END IF
        'If they want to move down
        ELSEIF key$ = "s" OR key$ = "2" THEN
                IF lpy% = 7 THEN
                        ry% = ry% + 1
                        CALL rooms
                        lpy% = 0
                        tcount% = 0
                        grab% = 1
                        bx% = lpx% + 1
                        by% = lpy%
                END IF

                IF grab% MOD 2 = 0 THEN
                        IF room$(lpx%, lpy% + 1) = "Bg" THEN
                                LINE ((lpx% - 1) * 32, (lpy% - 1) * 32)-(lpx% * 32 - 1, (lpy% - 1) * 32 + 31), 66, BF
                                IF room$(lpx%, lpy% - 1) = "Rock" THEN
                                        LINE ((lpx% - 1) * 32, (lpy% - 2) * 32)-(lpx% * 32, (lpy% - 1) * 32), 66, BF
                                        room$(lpx%, lpy% - 1) = "Bg"
                                        room$(lpx%, lpy%) = "Rock"
                                        CALL Texture("Rock", lpx% * 32, lpy% * 32)
                                END IF
                                lpy% = lpy% + 1
                        END IF
                ELSE
                        IF room$(lpx%, lpy% + 1) = "Bg" THEN
                                IF room$(lpx%, lpy%) = "Bg" THEN
                                        LINE ((lpx% - 1) * 32, (lpy% - 1) * 32)-(lpx% * 32 - 1, (lpy% - 1) * 32 + 31), 66, BF
                                ELSEIF room$(lpx%, lpy%) = "Water1" THEN
                                        CALL Texture("Water1", lpx% * 32, lpy% * 32)
                                END IF
                                lpy% = lpy% + 1
                        ELSEIF room$(lpx%, lpy% + 1) = "Water1" AND Flipper% = 1 THEN
                                IF room$(lpx%, lpy%) = "Bg" THEN
                                        LINE ((lpx% - 1) * 32, (lpy% - 1) * 32)-(lpx% * 32 - 1, (lpy% - 1) * 32 + 31), 66, BF
                                ELSEIF room$(lpx%, lpy%) = "Water1" THEN
                                        CALL Texture("Water1", lpx% * 32, lpy% * 32)
                                END IF
                                lpy% = lpy% + 1
                        ELSE
                           IF room$(lpx%, lpy%) = "Bg" THEN
                              LINE ((lpx% - 1) * 32, (lpy% - 1) * 32)-(lpx% * 32 - 1, (lpy% - 1) * 32 + 31), 66, BF
                           ELSEIF room$(lpx%, lpy%) = "Water1" THEN
                              CALL Texture("Water1", lpx% * 32, lpy% * 32)
                           END IF
                        END IF
                END IF
                IF room$(lpx%, lpy%) = "Bg" THEN
                        CALL Links((lpx% - 1) * 32, (lpy% - 1) * 32)
                ELSEIF room$(lpx%, lpy%) = "Water1" THEN
                        CALL Linkssw((lpx% - 1) * 32, (lpy% - 1) * 32)
                END IF
        END IF
        IF room$(lpx% + 1, lpy%) <> "Rock" AND room$(lpx%, lpy% + 1) <> "Rock" AND room$(lpx% - 1, lpy%) <> "Rock" AND room$(lpx%, lpy% - 1) <> "Rock" THEN
                grab% = 1
        END IF
LOOP UNTIL key$ = "q"

END

SUB bombt (x1%, y1%)
        SHARED Bomap%()

        x% = 1
        y% = 1

        WHILE y% <= 14
                WHILE x% <= 13
                        LINE (x1% - 14, y1% - 12)-(x1% - 13, y1% - 11), Bomap%(x%, y%), BF
                        x% = x% + 1
                        x1% = x1% + 2
                WEND
                x% = 1
                x1% = x1% - 26
                y% = y% + 1
                y1% = y1% + 2
        WEND
        y1% = y1% - 30
END SUB

SUB Chests
        SHARED rx%, ry%, room$(), Torch%, Flipper%, Bomb%
        IF rx% = 4 AND ry% = 3 THEN
                CLS
                LOCATE 9, 30
                PRINT "You've found the Torch!"
                LOCATE 11, 15
                PRINT "You can use that to burn trees"
                PRINT "That are in your way with 'b',"
                PRINT "but watch out, you can only use it twice per room."
                DO
                   key$ = INKEY$
                LOOP UNTIL key$ <> ""
                CLS
                CALL torcht(10 * 16 + 6, 2 * 16)
                LOCATE 9, 23
                PRINT "The Torch was put into your inventory."
                LOCATE 10, 20
                PRINT "You can look at your inventory with 'i'"
                Torch% = 1
                DO
                   key$ = INKEY$
                LOOP UNTIL key$ <> ""
                CALL room16(room$())
        ELSEIF rx% = 4 AND ry% = 5 THEN
                CLS
                LOCATE 9, 30
                PRINT "You've found the Flippers!"
                LOCATE 11, 15
                PRINT "These enable you to move through water,"
                LOCATE 12, 15
                PRINT "but you won't be able to bring rocks along."
                DO
                   key$ = INKEY$
                LOOP UNTIL key$ <> ""
                CLS
                CALL flippert(10 * 16 + 6, 2 * 16)
                LOCATE 9, 23
                PRINT "The Flippers were put into your inventory."
                LOCATE 10, 20
                PRINT "You can look at your inventory with 'i'"
                Flipper% = 1
                DO
                   key$ = INKEY$
                LOOP UNTIL key$ <> ""
                CALL room28(room$())
        ELSEIF rx% = 3 AND ry% = 6 THEN
                CLS
                LOCATE 9, 30
                PRINT "You've found the Bomb!"
                LOCATE 11, 15
                PRINT "This will let you destroy rocks with 'v'"
                LOCATE 12, 15
                PRINT "There's no limit, so have fun."
                DO
                   key$ = INKEY$
                LOOP UNTIL key$ <> ""
                CLS
                CALL bombt(10 * 16 + 6, 2 * 16)
                LOCATE 9, 23
                PRINT "The Bomb was put into your inventory."
                LOCATE 10, 20
                PRINT "You can look at your inventory with 'i'"
                Bomb% = 1
                DO
                   key$ = INKEY$
                LOOP UNTIL key$ <> ""
                CALL room33(room$())

        END IF
END SUB

SUB flippert (x1%, y1%)
        SHARED Flmap%()

        x% = 1
        y% = 1

        WHILE y% <= 15
                WHILE x% <= 14
                        LINE (x1% - 14, y1% - 12)-(x1% - 13, y1% - 11), Flmap%(x%, y%), BF
                        x% = x% + 1
                        x1% = x1% + 2
                WEND
                x% = 1
                x1% = x1% - 28
                y% = y% + 1
                y1% = y1% + 2
        WEND
        y1% = y1% - 30

END SUB

SUB Inv
   SHARED r%, Bomb%, Flipper%, Torch%, rx%, ry%, room$()
   CLS
   LOCATE 8, 3
   PRINT "Power Glove"
   CALL Pglove(4 * 16 - 8, 2 * 16)
   IF Torch% = 1 THEN
      LOCATE 8, 19
      PRINT "Torch"
      CALL torcht(10 * 16 + 6, 2 * 16)
   END IF
   IF Flipper% = 1 THEN
      LOCATE 8, 30
      PRINT "Flippers"
      CALL flippert(16 * 16 + 6, 2 * 16)
   END IF
   IF Bomb% = 1 THEN
        LOCATE 18, 6
        PRINT "Bomb"
        CALL bombt(4 * 16 - 8, 6 * 16 + 8)
   END IF
   DO
      key$ = INKEY$
   LOOP UNTIL key$ <> ""
  
   r% = 0
   CALL rooms
END SUB

SUB Link (lpx%, lpy%)
       
        'Row 1
        LINE (lpx% + 12, lpy% + 1)-(lpx% + 20, lpy% + 1), 10
        'Row 2
        LINE (lpx% + 12, lpy% + 2)-(lpx% + 21, lpy% + 2), 10
        'Row 3
        LINE (lpx% + 6, lpy% + 3)-(lpx% + 13, lpy% + 3), 6
        LINE (lpx% + 14, lpy% + 3)-(lpx% + 24, lpy% + 3), 10
        'Row 4
        LINE (lpx% + 5, lpy% + 4)-(lpx% + 14, lpy% + 4), 6
        LINE (lpx% + 15, lpy% + 4)-(lpx% + 25, lpy% + 4), 10
        'Row 5
        LINE (lpx% + 4, lpy% + 5)-(lpx% + 15, lpy% + 5), 6
        LINE (lpx% + 16, lpy% + 5)-(lpx% + 26, lpy% + 5), 10
        LINE (lpx% + 21, lpy% + 5)-(lpx% + 23, lpy% + 5), 67
        'Row 6
        LINE (lpx% + 4, lpy% + 6)-(lpx% + 16, lpy% + 6), 6
        LINE (lpx% + 17, lpy% + 6)-(lpx% + 26, lpy% + 6), 10
        LINE (lpx% + 21, lpy% + 6)-(lpx% + 23, lpy% + 6), 67
        'Row 7
        LINE (lpx% + 5, lpy% + 7)-(lpx% + 18, lpy% + 7), 6
        LINE (lpx% + 19, lpy% + 7)-(lpx% + 23, lpy% + 7), 67
        LINE (lpx% + 24, lpy% + 7)-(lpx% + 26, lpy% + 7), 10
        'Row 8
        PSET (lpx% + 5, lpy% + 8), 67
        LINE (lpx% + 6, lpy% + 8)-(lpx% + 17, lpy% + 8), 6
        LINE (lpx% + 18, lpy% + 8)-(lpx% + 23, lpy% + 8), 67
        LINE (lpx% + 24, lpy% + 8)-(lpx% + 26, lpy% + 8), 10
        'Row 9
        LINE (lpx% + 5, lpy% + 9)-(lpx% + 23, lpy% + 9), 67
        LINE (lpx% + 8, lpy% + 9)-(lpx% + 10, lpy% + 9), 10
        LINE (lpx% + 14, lpy% + 9)-(lpx% + 16, lpy% + 9), 6
        LINE (lpx% + 24, lpy% + 9)-(lpx% + 27, lpy% + 9), 10
        'Row 10
        LINE (lpx% + 5, lpy% + 10)-(lpx% + 22, lpy% + 10), 67
        LINE (lpx% + 8, lpy% + 10)-(lpx% + 10, lpy% + 10), 10
        LINE (lpx% + 14, lpy% + 10)-(lpx% + 16, lpy% + 10), 6
        LINE (lpx% + 24, lpy% + 10)-(lpx% + 28, lpy% + 10), 10
        'Row 11
        LINE (lpx%, lpy% + 11)-(lpx% + 29, lpy% + 11), 10
        LINE (lpx% + 3, lpy% + 11)-(lpx% + 22, lpy% + 11), 67
        LINE (lpx% + 8, lpy% + 11)-(lpx% + 10, lpy% + 11), 6
        LINE (lpx% + 14, lpy% + 11)-(lpx% + 16, lpy% + 11), 6
        LINE (lpx% + 22, lpy% + 11)-(lpx% + 24, lpy% + 11), 6
        'Row 12
        LINE (lpx%, lpy% + 12)-(lpx% + 30, lpy% + 12), 10
        LINE (lpx% + 3, lpy% + 12)-(lpx% + 21, lpy% + 12), 67
        LINE (lpx% + 8, lpy% + 12)-(lpx% + 10, lpy% + 12), 6
        LINE (lpx% + 14, lpy% + 12)-(lpx% + 16, lpy% + 12), 6
        LINE (lpx% + 21, lpy% + 12)-(lpx% + 24, lpy% + 12), 6
        'Row 13
        LINE (lpx%, lpy% + 13)-(lpx% + 30, lpy% + 13), 10
        LINE (lpx% + 3, lpy% + 13)-(lpx% + 20, lpy% + 13), 67
        LINE (lpx% + 8, lpy% + 13)-(lpx% + 10, lpy% + 13), 6
        LINE (lpx% + 13, lpy% + 13)-(lpx% + 16, lpy% + 13), 6
        LINE (lpx% + 20, lpy% + 13)-(lpx% + 24, lpy% + 13), 6
        'Row 14
        LINE (lpx%, lpy% + 14)-(lpx% + 30, lpy% + 14), 10
        LINE (lpx% + 3, lpy% + 14)-(lpx% + 20, lpy% + 14), 67
        LINE (lpx% + 21, lpy% + 14)-(lpx% + 24, lpy% + 14), 6
        'Row 15
        LINE (lpx%, lpy% + 15)-(lpx% + 2, lpy% + 15), 10
        PSET (lpx% + 3, lpy% + 15), 67
        LINE (lpx% + 6, lpy% + 15)-(lpx% + 20, lpy% + 15), 67
        LINE (lpx% + 21, lpy% + 15)-(lpx% + 24, lpy% + 15), 6
        LINE (lpx% + 28, lpy% + 15)-(lpx% + 30, lpy% + 15), 10
        'Row 16
        LINE (lpx%, lpy% + 16)-(lpx% + 24, lpy% + 16), 10
        LINE (lpx% + 3, lpy% + 16)-(lpx% + 14, lpy% + 16), 67
        LINE (lpx% + 28, lpy% + 16)-(lpx% + 30, lpy% + 16), 10
        'Row 17
        LINE (lpx%, lpy% + 17)-(lpx% + 25, lpy% + 17), 10
        LINE (lpx% + 3, lpy% + 17)-(lpx% + 14, lpy% + 17), 67
        'Row 18
        LINE (lpx%, lpy% + 18)-(lpx% + 26, lpy% + 18), 10
        LINE (lpx% + 3, lpy% + 18)-(lpx% + 11, lpy% + 18), 67
        LINE (lpx% + 12, lpy% + 18)-(lpx% + 22, lpy% + 18), 6
        'Row 19
        LINE (lpx%, lpy% + 19)-(lpx% + 26, lpy% + 19), 10
        LINE (lpx% + 3, lpy% + 19)-(lpx% + 11, lpy% + 19), 67
        LINE (lpx% + 12, lpy% + 19)-(lpx% + 23, lpy% + 19), 6
        'Row 20
        LINE (lpx%, lpy% + 20)-(lpx% + 26, lpy% + 20), 10
        LINE (lpx% + 3, lpy% + 20)-(lpx% + 11, lpy% + 20), 67
        LINE (lpx% + 5, lpy% + 20)-(lpx% + 7, lpy% + 20), 10
        LINE (lpx% + 12, lpy% + 20)-(lpx% + 23, lpy% + 20), 6
        'Row 21
        LINE (lpx%, lpy% + 21)-(lpx% + 27, lpy% + 21), 10
        LINE (lpx% + 3, lpy% + 21)-(lpx% + 11, lpy% + 21), 67
        LINE (lpx% + 5, lpy% + 21)-(lpx% + 7, lpy% + 21), 10
        LINE (lpx% + 12, lpy% + 21)-(lpx% + 23, lpy% + 21), 6
        'Row 22
        LINE (lpx%, lpy% + 22)-(lpx% + 3, lpy% + 22), 10
        PSET (lpx% + 8, lpy% + 22), 67
        LINE (lpx% + 9, lpy% + 22)-(lpx% + 28, lpy% + 22), 10
        LINE (lpx% + 11, lpy% + 22)-(lpx% + 23, lpy% + 22), 6
        'Row 23
        LINE (lpx%, lpy% + 23)-(lpx% + 3, lpy% + 23), 10
        PSET (lpx% + 8, lpy% + 23), 67
        LINE (lpx% + 9, lpy% + 23)-(lpx% + 29, lpy% + 23), 10
        LINE (lpx% + 11, lpy% + 23)-(lpx% + 23, lpy% + 23), 6
        'Row 24
        LINE (lpx%, lpy% + 24)-(lpx% + 4, lpy% + 24), 10
        LINE (lpx% + 7, lpy% + 24)-(lpx% + 11, lpy% + 24), 6
        LINE (lpx% + 10, lpy% + 24)-(lpx% + 30, lpy% + 24), 10
        LINE (lpx% + 17, lpy% + 24)-(lpx% + 24, lpy% + 24), 6
        'Row 25
        LINE (lpx%, lpy% + 25)-(lpx% + 4, lpy% + 25), 10
        LINE (lpx% + 7, lpy% + 25)-(lpx% + 11, lpy% + 25), 6
        LINE (lpx% + 11, lpy% + 25)-(lpx% + 31, lpy% + 25), 10
        LINE (lpx% + 17, lpy% + 25)-(lpx% + 23, lpy% + 25), 6
        'Row 26
        LINE (lpx% + 7, lpy% + 26)-(lpx% + 16, lpy% + 26), 6
        LINE (lpx% + 17, lpy% + 26)-(lpx% + 29, lpy% + 26), 10
        LINE (lpx% + 30, lpy% + 26)-(lpx% + 31, lpy% + 26), 6
        'Row 27
        LINE (lpx% + 7, lpy% + 27)-(lpx% + 16, lpy% + 27), 6
        LINE (lpx% + 17, lpy% + 27)-(lpx% + 29, lpy% + 27), 10
        LINE (lpx% + 29, lpy% + 27)-(lpx% + 31, lpy% + 27), 6
        'Row 28
        LINE (lpx% + 5, lpy% + 28)-(lpx% + 31, lpy% + 28), 6
        LINE (lpx% + 9, lpy% + 28)-(lpx% + 27, lpy% + 28), 10
        'Row 29
        LINE (lpx% + 4, lpy% + 29)-(lpx% + 31, lpy% + 29), 6
        LINE (lpx% + 9, lpy% + 29)-(lpx% + 26, lpy% + 29), 10
        'Row 30
        LINE (lpx% + 2, lpy% + 30)-(lpx% + 10, lpy% + 30), 6
        LINE (lpx% + 25, lpy% + 30)-(lpx% + 31, lpy% + 30), 6
        'Line 31
        LINE (lpx% + 2, lpy% + 30)-(lpx% + 10, lpy% + 30), 6
        LINE (lpx% + 25, lpy% + 30)-(lpx% + 30, lpy% + 30), 6


END SUB

SUB LinkR (lpxr%, lpy%)
        'Row 1
        LINE (lpxr% - 12, lpy% + 1)-(lpxr% - 20, lpy% + 1), 10
        'Row 2
        LINE (lpxr% - 12, lpy% + 2)-(lpxr% - 21, lpy% + 2), 10
        'Row 3
        LINE (lpxr% - 6, lpy% + 3)-(lpxr% - 13, lpy% + 3), 6
        LINE (lpxr% - 14, lpy% + 3)-(lpxr% - 24, lpy% + 3), 10
        'Row 4
        LINE (lpxr% - 5, lpy% + 4)-(lpxr% - 14, lpy% + 4), 6
        LINE (lpxr% - 15, lpy% + 4)-(lpxr% - 25, lpy% + 4), 10
        'Row 5
        LINE (lpxr% - 4, lpy% + 5)-(lpxr% - 15, lpy% + 5), 6
        LINE (lpxr% - 16, lpy% + 5)-(lpxr% - 26, lpy% + 5), 10
        LINE (lpxr% - 21, lpy% + 5)-(lpxr% - 23, lpy% + 5), 67
        'Row 6
        LINE (lpxr% - 4, lpy% + 6)-(lpxr% - 16, lpy% + 6), 6
        LINE (lpxr% - 17, lpy% + 6)-(lpxr% - 26, lpy% + 6), 10
        LINE (lpxr% - 21, lpy% + 6)-(lpxr% - 23, lpy% + 6), 67
        'Row 7
        LINE (lpxr% - 5, lpy% + 7)-(lpxr% - 18, lpy% + 7), 6
        LINE (lpxr% - 19, lpy% + 7)-(lpxr% - 23, lpy% + 7), 67
        LINE (lpxr% - 24, lpy% + 7)-(lpxr% - 26, lpy% + 7), 10
        'Row 8
        PSET (lpx% - 5, lpy% + 8), 67
        LINE (lpxr% - 6, lpy% + 8)-(lpxr% - 17, lpy% + 8), 6
        LINE (lpxr% - 18, lpy% + 8)-(lpxr% - 23, lpy% + 8), 67
        LINE (lpxr% - 24, lpy% + 8)-(lpxr% - 26, lpy% + 8), 10
        'Row 9
        LINE (lpxr% - 5, lpy% + 9)-(lpxr% - 23, lpy% + 9), 67
        LINE (lpxr% - 8, lpy% + 9)-(lpxr% - 10, lpy% + 9), 10
        LINE (lpxr% - 14, lpy% + 9)-(lpxr% - 16, lpy% + 9), 6
        LINE (lpxr% - 24, lpy% + 9)-(lpxr% - 27, lpy% + 9), 10
        'Row 10
        LINE (lpxr% - 5, lpy% + 10)-(lpxr% - 22, lpy% + 10), 67
        LINE (lpxr% - 8, lpy% + 10)-(lpxr% - 10, lpy% + 10), 10
        LINE (lpxr% - 14, lpy% + 10)-(lpxr% - 16, lpy% + 10), 6
        LINE (lpxr% - 24, lpy% + 10)-(lpxr% - 28, lpy% + 10), 10
        'Row 11
        LINE (lpxr% - 1, lpy% + 11)-(lpxr% - 29, lpy% + 11), 10
        LINE (lpxr% - 3, lpy% + 11)-(lpxr% - 22, lpy% + 11), 67
        LINE (lpxr% - 8, lpy% + 11)-(lpxr% - 10, lpy% + 11), 6
        LINE (lpxr% - 14, lpy% + 11)-(lpxr% - 16, lpy% + 11), 6
        LINE (lpxr% - 22, lpy% + 11)-(lpxr% - 24, lpy% + 11), 6
        'Row 12
        LINE (lpxr% - 1, lpy% + 12)-(lpxr% - 30, lpy% + 12), 10
        LINE (lpxr% - 3, lpy% + 12)-(lpxr% - 21, lpy% + 12), 67
        LINE (lpxr% - 8, lpy% + 12)-(lpxr% - 10, lpy% + 12), 6
        LINE (lpxr% - 14, lpy% + 12)-(lpxr% - 16, lpy% + 12), 6
        LINE (lpxr% - 21, lpy% + 12)-(lpxr% - 24, lpy% + 12), 6
        'Row 13
        LINE (lpxr% - 1, lpy% + 13)-(lpxr% - 30, lpy% + 13), 10
        LINE (lpxr% - 3, lpy% + 13)-(lpxr% - 20, lpy% + 13), 67
        LINE (lpxr% - 8, lpy% + 13)-(lpxr% - 10, lpy% + 13), 6
        LINE (lpxr% - 13, lpy% + 13)-(lpxr% - 16, lpy% + 13), 6
        LINE (lpxr% - 20, lpy% + 13)-(lpxr% - 24, lpy% + 13), 6
        'Row 14
        LINE (lpxr% - 1, lpy% + 14)-(lpxr% - 30, lpy% + 14), 10
        LINE (lpxr% - 3, lpy% + 14)-(lpxr% - 20, lpy% + 14), 67
        LINE (lpxr% - 21, lpy% + 14)-(lpxr% - 24, lpy% + 14), 6
        'Row 15
        LINE (lpxr% - 1, lpy% + 15)-(lpxr% - 2, lpy% + 15), 10
        PSET (lpxr% - 3, lpy% + 15), 67
        LINE (lpxr% - 6, lpy% + 15)-(lpxr% - 20, lpy% + 15), 67
        LINE (lpxr% - 21, lpy% + 15)-(lpxr% - 24, lpy% + 15), 6
        LINE (lpxr% - 28, lpy% + 15)-(lpxr% - 30, lpy% + 15), 10
        'Row 16
        LINE (lpxr% - 1, lpy% + 16)-(lpxr% - 24, lpy% + 16), 10
        LINE (lpxr% - 3, lpy% + 16)-(lpxr% - 14, lpy% + 16), 67
        LINE (lpxr% - 28, lpy% + 16)-(lpxr% - 30, lpy% + 16), 10
        'Row 17
        LINE (lpxr% - 1, lpy% + 17)-(lpxr% - 25, lpy% + 17), 10
        LINE (lpxr% - 3, lpy% + 17)-(lpxr% - 14, lpy% + 17), 67
        'Row 18
        LINE (lpxr% - 1, lpy% + 18)-(lpxr% - 26, lpy% + 18), 10
        LINE (lpxr% - 3, lpy% + 18)-(lpxr% - 11, lpy% + 18), 67
        LINE (lpxr% - 12, lpy% + 18)-(lpxr% - 22, lpy% + 18), 6
        'Row 19
        LINE (lpxr% - 1, lpy% + 19)-(lpxr% - 26, lpy% + 19), 10
        LINE (lpxr% - 3, lpy% + 19)-(lpxr% - 11, lpy% + 19), 67
        LINE (lpxr% - 12, lpy% + 19)-(lpxr% - 23, lpy% + 19), 6
        'Row 20
        LINE (lpxr% - 1, lpy% + 20)-(lpxr% - 26, lpy% + 20), 10
        LINE (lpxr% - 3, lpy% + 20)-(lpxr% - 11, lpy% + 20), 67
        LINE (lpxr% - 5, lpy% + 20)-(lpxr% - 7, lpy% + 20), 10
        LINE (lpxr% - 12, lpy% + 20)-(lpxr% - 23, lpy% + 20), 6
        'Row 21
        LINE (lpxr% - 1, lpy% + 21)-(lpxr% - 27, lpy% + 21), 10
        LINE (lpxr% - 3, lpy% + 21)-(lpxr% - 11, lpy% + 21), 67
        LINE (lpxr% - 5, lpy% + 21)-(lpxr% - 7, lpy% + 21), 10
        LINE (lpxr% - 12, lpy% + 21)-(lpxr% - 23, lpy% + 21), 6
        'Row 22
        LINE (lpxr% - 1, lpy% + 22)-(lpxr% - 3, lpy% + 22), 10
        PSET (lpxr% - 8, lpy% + 22), 67
        LINE (lpxr% - 9, lpy% + 22)-(lpxr% - 28, lpy% + 22), 10
        LINE (lpxr% - 11, lpy% + 22)-(lpxr% - 23, lpy% + 22), 6
        'Row 23
        LINE (lpxr% - 1, lpy% + 23)-(lpxr% - 3, lpy% + 23), 10
        PSET (lpxr% - 8, lpy% + 23), 67
        LINE (lpxr% - 9, lpy% + 23)-(lpxr% - 29, lpy% + 23), 10
        LINE (lpxr% - 11, lpy% + 23)-(lpxr% - 23, lpy% + 23), 6
        'Row 24
        LINE (lpxr% - 1, lpy% + 24)-(lpxr% - 4, lpy% + 24), 10
        LINE (lpxr% - 7, lpy% + 24)-(lpxr% - 11, lpy% + 24), 6
        LINE (lpxr% - 10, lpy% + 24)-(lpxr% - 30, lpy% + 24), 10
        LINE (lpxr% - 17, lpy% + 24)-(lpxr% - 24, lpy% + 24), 6
        'Row 25
        LINE (lpxr% - 1, lpy% + 25)-(lpxr% - 4, lpy% + 25), 10
        LINE (lpxr% - 7, lpy% + 25)-(lpxr% - 11, lpy% + 25), 6
        LINE (lpxr% - 11, lpy% + 25)-(lpxr% - 31, lpy% + 25), 10
        LINE (lpxr% - 17, lpy% + 25)-(lpxr% - 23, lpy% + 25), 6
        'Row 26
        LINE (lpxr% - 7, lpy% + 26)-(lpxr% - 16, lpy% + 26), 6
        LINE (lpxr% - 17, lpy% + 26)-(lpxr% - 29, lpy% + 26), 10
        LINE (lpxr% - 30, lpy% + 26)-(lpxr% - 32, lpy% + 26), 6
        'Row 27
        LINE (lpxr% - 7, lpy% + 27)-(lpxr% - 16, lpy% + 27), 6
        LINE (lpxr% - 17, lpy% + 27)-(lpxr% - 29, lpy% + 27), 10
        LINE (lpxr% - 29, lpy% + 27)-(lpxr% - 32, lpy% + 27), 6
        'Row 28
        LINE (lpxr% - 5, lpy% + 28)-(lpxr% - 32, lpy% + 28), 6
        LINE (lpxr% - 9, lpy% + 28)-(lpxr% - 27, lpy% + 28), 10
        'Row 29
        LINE (lpxr% - 4, lpy% + 29)-(lpxr% - 32, lpy% + 29), 6
        LINE (lpxr% - 9, lpy% + 29)-(lpxr% - 26, lpy% + 29), 10
        'Row 30
        LINE (lpxr% - 2, lpy% + 30)-(lpxr% - 10, lpy% + 30), 6
        LINE (lpxr% - 25, lpy% + 30)-(lpxr% - 31, lpy% + 30), 6
        'Line 31
        LINE (lpxr% - 2, lpy% + 30)-(lpxr% - 10, lpy% + 30), 6
        LINE (lpxr% - 25, lpy% + 30)-(lpxr% - 30, lpy% + 30), 6



END SUB

SUB LinkRS (lpxr%, lpy%)
        'Row 1
        LINE (lpxr% - 12, lpy% + 1)-(lpxr% - 20, lpy% + 1), 10
        'Row 2
        LINE (lpxr% - 12, lpy% + 2)-(lpxr% - 21, lpy% + 2), 10
        'Row 3
        LINE (lpxr% - 6, lpy% + 3)-(lpxr% - 13, lpy% + 3), 6
        LINE (lpxr% - 14, lpy% + 3)-(lpxr% - 24, lpy% + 3), 10
        'Row 4
        LINE (lpxr% - 5, lpy% + 4)-(lpxr% - 14, lpy% + 4), 6
        LINE (lpxr% - 15, lpy% + 4)-(lpxr% - 25, lpy% + 4), 10
        'Row 5
        LINE (lpxr% - 4, lpy% + 5)-(lpxr% - 15, lpy% + 5), 6
        LINE (lpxr% - 16, lpy% + 5)-(lpxr% - 26, lpy% + 5), 10
        LINE (lpxr% - 21, lpy% + 5)-(lpxr% - 23, lpy% + 5), 67
        'Row 6
        LINE (lpxr% - 4, lpy% + 6)-(lpxr% - 16, lpy% + 6), 6
        LINE (lpxr% - 17, lpy% + 6)-(lpxr% - 26, lpy% + 6), 10
        LINE (lpxr% - 21, lpy% + 6)-(lpxr% - 23, lpy% + 6), 67
        'Row 7
        LINE (lpxr% - 5, lpy% + 7)-(lpxr% - 18, lpy% + 7), 6
        LINE (lpxr% - 19, lpy% + 7)-(lpxr% - 23, lpy% + 7), 67
        LINE (lpxr% - 24, lpy% + 7)-(lpxr% - 26, lpy% + 7), 10
        'Row 8
        PSET (lpx% - 5, lpy% + 8), 67
        LINE (lpxr% - 6, lpy% + 8)-(lpxr% - 17, lpy% + 8), 6
        LINE (lpxr% - 18, lpy% + 8)-(lpxr% - 23, lpy% + 8), 67
        LINE (lpxr% - 24, lpy% + 8)-(lpxr% - 26, lpy% + 8), 10
        'Row 9
        LINE (lpxr% - 5, lpy% + 9)-(lpxr% - 23, lpy% + 9), 67
        LINE (lpxr% - 8, lpy% + 9)-(lpxr% - 10, lpy% + 9), 10
        LINE (lpxr% - 14, lpy% + 9)-(lpxr% - 16, lpy% + 9), 6
        LINE (lpxr% - 24, lpy% + 9)-(lpxr% - 27, lpy% + 9), 10
        'Row 10
        LINE (lpxr% - 5, lpy% + 10)-(lpxr% - 22, lpy% + 10), 67
        LINE (lpxr% - 8, lpy% + 10)-(lpxr% - 10, lpy% + 10), 10
        LINE (lpxr% - 14, lpy% + 10)-(lpxr% - 16, lpy% + 10), 6
        LINE (lpxr% - 24, lpy% + 10)-(lpxr% - 28, lpy% + 10), 10
        'Row 11
        LINE (lpxr% - 1, lpy% + 11)-(lpxr% - 29, lpy% + 11), 10
        LINE (lpxr% - 3, lpy% + 11)-(lpxr% - 22, lpy% + 11), 67
        LINE (lpxr% - 8, lpy% + 11)-(lpxr% - 10, lpy% + 11), 6
        LINE (lpxr% - 14, lpy% + 11)-(lpxr% - 16, lpy% + 11), 6
        LINE (lpxr% - 22, lpy% + 11)-(lpxr% - 24, lpy% + 11), 6
        'Row 12
        LINE (lpxr% - 1, lpy% + 12)-(lpxr% - 30, lpy% + 12), 10
        LINE (lpxr% - 3, lpy% + 12)-(lpxr% - 21, lpy% + 12), 67
        LINE (lpxr% - 8, lpy% + 12)-(lpxr% - 10, lpy% + 12), 6
        LINE (lpxr% - 14, lpy% + 12)-(lpxr% - 16, lpy% + 12), 6
        LINE (lpxr% - 21, lpy% + 12)-(lpxr% - 24, lpy% + 12), 6
        'Row 13
        LINE (lpxr% - 1, lpy% + 13)-(lpxr% - 30, lpy% + 13), 10
        LINE (lpxr% - 3, lpy% + 13)-(lpxr% - 20, lpy% + 13), 67
        LINE (lpxr% - 8, lpy% + 13)-(lpxr% - 10, lpy% + 13), 6
        LINE (lpxr% - 13, lpy% + 13)-(lpxr% - 16, lpy% + 13), 6
        LINE (lpxr% - 20, lpy% + 13)-(lpxr% - 24, lpy% + 13), 6
        'Row 14
        LINE (lpxr% - 1, lpy% + 14)-(lpxr% - 30, lpy% + 14), 10
        LINE (lpxr% - 3, lpy% + 14)-(lpxr% - 20, lpy% + 14), 67
        LINE (lpxr% - 21, lpy% + 14)-(lpxr% - 24, lpy% + 14), 6
END SUB

SUB Links (lpx%, lpy%)
        'Row 1
        LINE (lpx% + 10, lpy% + 1)-(lpx% + 27, lpy% + 1), 10
        'Row 2
        LINE (lpx% + 9, lpy% + 2)-(lpx% + 28, lpy% + 2), 10
        'Row 3
        LINE (lpx% + 4, lpy% + 3)-(lpx% + 5, lpy% + 3), 67
        LINE (lpx% + 8, lpy% + 3)-(lpx% + 29, lpy% + 3), 10
        LINE (lpx% + 31, lpy% + 3)-(lpx% + 31, lpy% + 3), 67
        'Row 4
        LINE (lpx% + 4, lpy% + 4)-(lpx% + 6, lpy% + 4), 67
        LINE (lpx% + 8, lpy% + 4)-(lpx% + 29, lpy% + 4), 10
        LINE (lpx% + 30, lpy% + 4)-(lpx% + 31, lpy% + 4), 67
        'Row 5
        LINE (lpx% + 4, lpy% + 5)-(lpx% + 31, lpy% + 5), 67
        LINE (lpx% + 8, lpy% + 5)-(lpx% + 28, lpy% + 5), 10
        LINE (lpx% + 10, lpy% + 5)-(lpx% + 25, lpy% + 5), 6
        'Row 6
        LINE (lpx% + 4, lpy% + 6)-(lpx% + 31, lpy% + 6), 67
        LINE (lpx% + 8, lpy% + 6)-(lpx% + 28, lpy% + 6), 10
        LINE (lpx% + 9, lpy% + 6)-(lpx% + 27, lpy% + 6), 6
        'Row 7
        LINE (lpx% + 4, lpy% + 7)-(lpx% + 31, lpy% + 7), 67
        LINE (lpx% + 8, lpy% + 7)-(lpx% + 28, lpy% + 7), 6
        'Row 8
        LINE (lpx% + 4, lpy% + 8)-(lpx% + 31, lpy% + 8), 67
        LINE (lpx% + 8, lpy% + 8)-(lpx% + 11, lpy% + 8), 6
        LINE (lpx% + 24, lpy% + 8)-(lpx% + 28, lpy% + 8), 6
        'Row 9
        LINE (lpx% + 4, lpy% + 9)-(lpx% + 31, lpy% + 9), 67
        LINE (lpx% + 8, lpy% + 9)-(lpx% + 11, lpy% + 9), 6
        LINE (lpx% + 24, lpy% + 9)-(lpx% + 28, lpy% + 9), 6
        'Row 10
        LINE (lpx% + 4, lpy% + 10)-(lpx% + 31, lpy% + 10), 67
        LINE (lpx% + 8, lpy% + 10)-(lpx% + 11, lpy% + 10), 6
        LINE (lpx% + 14, lpy% + 10)-(lpx% + 15, lpy% + 10), 6
        LINE (lpx% + 21, lpy% + 10)-(lpx% + 22, lpy% + 10), 6
        LINE (lpx% + 24, lpy% + 10)-(lpx% + 28, lpy% + 10), 6
        'Row 11
        LINE (lpx% + 5, lpy% + 11)-(lpx% + 31, lpy% + 11), 67
        LINE (lpx% + 8, lpy% + 11)-(lpx% + 11, lpy% + 11), 6
        LINE (lpx% + 14, lpy% + 11)-(lpx% + 15, lpy% + 11), 6
        LINE (lpx% + 21, lpy% + 11)-(lpx% + 22, lpy% + 11), 6
        LINE (lpx% + 31, lpy% + 11)-(lpx% + 31, lpy% + 11), 6
        'Row 12
        LINE (lpx% + 6, lpy% + 12)-(lpx% + 30, lpy% + 12), 67
        PSET (lpx% + 30, lpy% + 12), 10
        LINE (lpx% + 31, lpy% + 12)-(lpx% + 31, lpy% + 12), 6
        'Row 13
        LINE (lpx% + 7, lpy% + 13)-(lpx% + 26, lpy% + 13), 67
        LINE (lpx% + 27, lpy% + 13)-(lpx% + 30, lpy% + 13), 10
        LINE (lpx% + 31, lpy% + 13)-(lpx% + 31, lpy% + 13), 6
        'Row 14
        LINE (lpx% + 8, lpy% + 14)-(lpx% + 24, lpy% + 14), 67
        LINE (lpx% + 17, lpy% + 14)-(lpx% + 20, lpy% + 14), 6
        LINE (lpx% + 25, lpy% + 14)-(lpx% + 30, lpy% + 14), 10
        LINE (lpx% + 31, lpy% + 14)-(lpx% + 31, lpy% + 14), 6
        'Row 15
        LINE (lpx% + 3, lpy% + 15)-(lpx% + 15, lpy% + 15), 6
        LINE (lpx% + 16, lpy% + 15)-(lpx% + 22, lpy% + 15), 67
        LINE (lpx% + 23, lpy% + 15)-(lpx% + 31, lpy% + 15), 10
        'Row 16
        LINE (lpx% + 3, lpy% + 16)-(lpx% + 15, lpy% + 16), 6
        LINE (lpx% + 16, lpy% + 16)-(lpx% + 22, lpy% + 16), 67
        LINE (lpx% + 22, lpy% + 16)-(lpx% + 31, lpy% + 16), 10
        'Row 17
        LINE (lpx%, lpy% + 17)-(lpx% + 15, lpy% + 17), 6
        LINE (lpx% + 6, lpy% + 17)-(lpx% + 7, lpy% + 17), 67
        LINE (lpx% + 16, lpy% + 17)-(lpx% + 31, lpy% + 17), 10
        'Row 18
        LINE (lpx%, lpy% + 18)-(lpx% + 15, lpy% + 18), 6
        LINE (lpx% + 6, lpy% + 18)-(lpx% + 8, lpy% + 18), 67
        LINE (lpx% + 16, lpy% + 18)-(lpx% + 31, lpy% + 18), 10
        'Row 19
        LINE (lpx%, lpy% + 19)-(lpx% + 19, lpy% + 19), 6
        LINE (lpx% + 5, lpy% + 19)-(lpx% + 9, lpy% + 19), 67
        LINE (lpx% + 16, lpy% + 19)-(lpx% + 17, lpy% + 19), 67
        LINE (lpx% + 20, lpy% + 19)-(lpx% + 31, lpy% + 19), 10
        'Row 20
        LINE (lpx%, lpy% + 20)-(lpx% + 23, lpy% + 20), 6
        LINE (lpx% + 1, lpy% + 20)-(lpx% + 11, lpy% + 20), 67
        LINE (lpx% + 16, lpy% + 20)-(lpx% + 17, lpy% + 20), 67
        LINE (lpx% + 24, lpy% + 20)-(lpx% + 31, lpy% + 20), 10
        'Row 21
        LINE (lpx%, lpy% + 21)-(lpx% + 23, lpy% + 21), 6
        LINE (lpx% + 6, lpy% + 21)-(lpx% + 8, lpy% + 21), 67
        LINE (lpx% + 16, lpy% + 21)-(lpx% + 17, lpy% + 21), 67
        LINE (lpx% + 18, lpy% + 21)-(lpx% + 19, lpy% + 21), 10
        LINE (lpx% + 24, lpy% + 21)-(lpx% + 31, lpy% + 21), 10
        'Row 22
        LINE (lpx%, lpy% + 22)-(lpx% + 23, lpy% + 22), 6
        LINE (lpx% + 6, lpy% + 22)-(lpx% + 8, lpy% + 22), 67
        LINE (lpx% + 16, lpy% + 22)-(lpx% + 17, lpy% + 22), 67
        LINE (lpx% + 18, lpy% + 22)-(lpx% + 19, lpy% + 22), 10
        LINE (lpx% + 24, lpy% + 22)-(lpx% + 31, lpy% + 22), 10
        'Row 23
        LINE (lpx%, lpy% + 23)-(lpx% + 23, lpy% + 23), 6
        LINE (lpx% + 6, lpy% + 23)-(lpx% + 8, lpy% + 23), 67
        LINE (lpx% + 16, lpy% + 23)-(lpx% + 17, lpy% + 23), 67
        LINE (lpx% + 18, lpy% + 23)-(lpx% + 19, lpy% + 23), 10
        LINE (lpx% + 24, lpy% + 23)-(lpx% + 31, lpy% + 23), 10
        'Row 24
        LINE (lpx%, lpy% + 24)-(lpx% + 22, lpy% + 24), 6
        LINE (lpx% + 6, lpy% + 24)-(lpx% + 8, lpy% + 24), 67
        LINE (lpx% + 16, lpy% + 24)-(lpx% + 17, lpy% + 24), 67
        LINE (lpx% + 23, lpy% + 24)-(lpx% + 31, lpy% + 24), 10
        LINE (lpx% + 26, lpy% + 24)-(lpx% + 29, lpy% + 24), 6
        'Row 25
        LINE (lpx%, lpy% + 25)-(lpx% + 17, lpy% + 25), 6
        LINE (lpx% + 16, lpy% + 25)-(lpx% + 17, lpy% + 25), 67
        LINE (lpx% + 18, lpy% + 25)-(lpx% + 31, lpy% + 25), 10
        LINE (lpx% + 25, lpy% + 25)-(lpx% + 29, lpy% + 25), 6
        'Row 26
        LINE (lpx%, lpy% + 26)-(lpx% + 17, lpy% + 26), 67
        LINE (lpx% + 24, lpy% + 26)-(lpx% + 29, lpy% + 26), 6
        PSET (lpx% + 30, lpy% + 26), 10
        'Row 27
        LINE (lpx% + 20, lpy% + 27)-(lpx% + 29, lpy% + 27), 6
        'Row 28
        LINE (lpx% + 20, lpy% + 28)-(lpx% + 29, lpy% + 28), 6
        'Row 29
        LINE (lpx% + 19, lpy% + 29)-(lpx% + 29, lpy% + 29), 6
        'Row 30
        LINE (lpx% + 19, lpy% + 30)-(lpx% + 29, lpy% + 30), 6
END SUB

SUB Linkssw (lpx%, lpy%)
        'Row 1
        LINE (lpx% + 10, lpy% + 1)-(lpx% + 27, lpy% + 1), 10
        'Row 2
        LINE (lpx% + 9, lpy% + 2)-(lpx% + 28, lpy% + 2), 10
        'Row 3
        LINE (lpx% + 4, lpy% + 3)-(lpx% + 5, lpy% + 3), 67
        LINE (lpx% + 8, lpy% + 3)-(lpx% + 29, lpy% + 3), 10
        LINE (lpx% + 31, lpy% + 3)-(lpx% + 31, lpy% + 3), 67
        'Row 4
        LINE (lpx% + 4, lpy% + 4)-(lpx% + 6, lpy% + 4), 67
        LINE (lpx% + 8, lpy% + 4)-(lpx% + 29, lpy% + 4), 10
        LINE (lpx% + 30, lpy% + 4)-(lpx% + 31, lpy% + 4), 67
        'Row 5
        LINE (lpx% + 4, lpy% + 5)-(lpx% + 31, lpy% + 5), 67
        LINE (lpx% + 8, lpy% + 5)-(lpx% + 28, lpy% + 5), 10
        LINE (lpx% + 10, lpy% + 5)-(lpx% + 25, lpy% + 5), 6
        'Row 6
        LINE (lpx% + 4, lpy% + 6)-(lpx% + 31, lpy% + 6), 67
        LINE (lpx% + 8, lpy% + 6)-(lpx% + 28, lpy% + 6), 10
        LINE (lpx% + 9, lpy% + 6)-(lpx% + 27, lpy% + 6), 6
        'Row 7
        LINE (lpx% + 4, lpy% + 7)-(lpx% + 31, lpy% + 7), 67
        LINE (lpx% + 8, lpy% + 7)-(lpx% + 28, lpy% + 7), 6
        'Row 8
        LINE (lpx% + 4, lpy% + 8)-(lpx% + 31, lpy% + 8), 67
        LINE (lpx% + 8, lpy% + 8)-(lpx% + 11, lpy% + 8), 6
        LINE (lpx% + 24, lpy% + 8)-(lpx% + 28, lpy% + 8), 6
        'Row 9
        LINE (lpx% + 4, lpy% + 9)-(lpx% + 31, lpy% + 9), 67
        LINE (lpx% + 8, lpy% + 9)-(lpx% + 11, lpy% + 9), 6
        LINE (lpx% + 24, lpy% + 9)-(lpx% + 28, lpy% + 9), 6
        'Row 10
        LINE (lpx% + 4, lpy% + 10)-(lpx% + 31, lpy% + 10), 67
        LINE (lpx% + 8, lpy% + 10)-(lpx% + 11, lpy% + 10), 6
        LINE (lpx% + 14, lpy% + 10)-(lpx% + 15, lpy% + 10), 6
        LINE (lpx% + 21, lpy% + 10)-(lpx% + 22, lpy% + 10), 6
        LINE (lpx% + 24, lpy% + 10)-(lpx% + 28, lpy% + 10), 6
        'Row 11
        LINE (lpx% + 5, lpy% + 11)-(lpx% + 31, lpy% + 11), 67
        LINE (lpx% + 8, lpy% + 11)-(lpx% + 11, lpy% + 11), 6
        LINE (lpx% + 14, lpy% + 11)-(lpx% + 15, lpy% + 11), 6
        LINE (lpx% + 21, lpy% + 11)-(lpx% + 22, lpy% + 11), 6
        LINE (lpx% + 31, lpy% + 11)-(lpx% + 31, lpy% + 11), 6
        'Row 12
        LINE (lpx% + 6, lpy% + 12)-(lpx% + 30, lpy% + 12), 67
        PSET (lpx% + 30, lpy% + 12), 10
        LINE (lpx% + 31, lpy% + 12)-(lpx% + 31, lpy% + 12), 6
        'Row 13
        LINE (lpx% + 7, lpy% + 13)-(lpx% + 26, lpy% + 13), 67
        LINE (lpx% + 27, lpy% + 13)-(lpx% + 30, lpy% + 13), 10
        LINE (lpx% + 31, lpy% + 13)-(lpx% + 31, lpy% + 13), 6
        'Row 14
        LINE (lpx% + 8, lpy% + 14)-(lpx% + 24, lpy% + 14), 67
        LINE (lpx% + 17, lpy% + 14)-(lpx% + 20, lpy% + 14), 6
        LINE (lpx% + 25, lpy% + 14)-(lpx% + 30, lpy% + 14), 10
        LINE (lpx% + 31, lpy% + 14)-(lpx% + 31, lpy% + 14), 6
END SUB

SUB Linksw (lpx%, lpy%)
        'Row 1
        LINE (lpx% + 12, lpy% + 1)-(lpx% + 20, lpy% + 1), 10
        'Row 2
        LINE (lpx% + 12, lpy% + 2)-(lpx% + 21, lpy% + 2), 10
        'Row 3
        LINE (lpx% + 6, lpy% + 3)-(lpx% + 13, lpy% + 3), 6
        LINE (lpx% + 14, lpy% + 3)-(lpx% + 24, lpy% + 3), 10
        'Row 4
        LINE (lpx% + 5, lpy% + 4)-(lpx% + 14, lpy% + 4), 6
        LINE (lpx% + 15, lpy% + 4)-(lpx% + 25, lpy% + 4), 10
        'Row 5
        LINE (lpx% + 4, lpy% + 5)-(lpx% + 15, lpy% + 5), 6
        LINE (lpx% + 16, lpy% + 5)-(lpx% + 26, lpy% + 5), 10
        LINE (lpx% + 21, lpy% + 5)-(lpx% + 23, lpy% + 5), 67
        'Row 6
        LINE (lpx% + 4, lpy% + 6)-(lpx% + 16, lpy% + 6), 6
        LINE (lpx% + 17, lpy% + 6)-(lpx% + 26, lpy% + 6), 10
        LINE (lpx% + 21, lpy% + 6)-(lpx% + 23, lpy% + 6), 67
        'Row 7
        LINE (lpx% + 5, lpy% + 7)-(lpx% + 18, lpy% + 7), 6
        LINE (lpx% + 19, lpy% + 7)-(lpx% + 23, lpy% + 7), 67
        LINE (lpx% + 24, lpy% + 7)-(lpx% + 26, lpy% + 7), 10
        'Row 8
        PSET (lpx% + 5, lpy% + 8), 67
        LINE (lpx% + 6, lpy% + 8)-(lpx% + 17, lpy% + 8), 6
        LINE (lpx% + 18, lpy% + 8)-(lpx% + 23, lpy% + 8), 67
        LINE (lpx% + 24, lpy% + 8)-(lpx% + 26, lpy% + 8), 10
        'Row 9
        LINE (lpx% + 5, lpy% + 9)-(lpx% + 23, lpy% + 9), 67
        LINE (lpx% + 8, lpy% + 9)-(lpx% + 10, lpy% + 9), 10
        LINE (lpx% + 14, lpy% + 9)-(lpx% + 16, lpy% + 9), 6
        LINE (lpx% + 24, lpy% + 9)-(lpx% + 27, lpy% + 9), 10
        'Row 10
        LINE (lpx% + 5, lpy% + 10)-(lpx% + 22, lpy% + 10), 67
        LINE (lpx% + 8, lpy% + 10)-(lpx% + 10, lpy% + 10), 10
        LINE (lpx% + 14, lpy% + 10)-(lpx% + 16, lpy% + 10), 6
        LINE (lpx% + 24, lpy% + 10)-(lpx% + 28, lpy% + 10), 10
        'Row 11
        LINE (lpx%, lpy% + 11)-(lpx% + 29, lpy% + 11), 10
        LINE (lpx% + 3, lpy% + 11)-(lpx% + 22, lpy% + 11), 67
        LINE (lpx% + 8, lpy% + 11)-(lpx% + 10, lpy% + 11), 6
        LINE (lpx% + 14, lpy% + 11)-(lpx% + 16, lpy% + 11), 6
        LINE (lpx% + 22, lpy% + 11)-(lpx% + 24, lpy% + 11), 6
        'Row 12
        LINE (lpx%, lpy% + 12)-(lpx% + 30, lpy% + 12), 10
        LINE (lpx% + 3, lpy% + 12)-(lpx% + 21, lpy% + 12), 67
        LINE (lpx% + 8, lpy% + 12)-(lpx% + 10, lpy% + 12), 6
        LINE (lpx% + 14, lpy% + 12)-(lpx% + 16, lpy% + 12), 6
        LINE (lpx% + 21, lpy% + 12)-(lpx% + 24, lpy% + 12), 6
        'Row 13
        LINE (lpx%, lpy% + 13)-(lpx% + 30, lpy% + 13), 10
        LINE (lpx% + 3, lpy% + 13)-(lpx% + 20, lpy% + 13), 67
        LINE (lpx% + 8, lpy% + 13)-(lpx% + 10, lpy% + 13), 6
        LINE (lpx% + 13, lpy% + 13)-(lpx% + 16, lpy% + 13), 6
        LINE (lpx% + 20, lpy% + 13)-(lpx% + 24, lpy% + 13), 6
        'Row 14
        LINE (lpx%, lpy% + 14)-(lpx% + 30, lpy% + 14), 10
        LINE (lpx% + 3, lpy% + 14)-(lpx% + 20, lpy% + 14), 67
        LINE (lpx% + 21, lpy% + 14)-(lpx% + 24, lpy% + 14), 6
        'Row 15
        LINE (lpx%, lpy% + 15)-(lpx% + 2, lpy% + 15), 10
        PSET (lpx% + 3, lpy% + 15), 67
        LINE (lpx% + 6, lpy% + 15)-(lpx% + 20, lpy% + 15), 67
        LINE (lpx% + 21, lpy% + 15)-(lpx% + 24, lpy% + 15), 6
        LINE (lpx% + 28, lpy% + 15)-(lpx% + 30, lpy% + 15), 10
END SUB

SUB LinkW (lpx%, lpy%)
        'Row 1
        LINE (lpx% + 8, lpy% + 1)-(lpx% + 27, lpy% + 1), 10
        'Row 2
        LINE (lpx% + 6, lpy% + 2)-(lpx% + 28, lpy% + 2), 10
        'Row 3
        LINE (lpx% + 5, lpy% + 3)-(lpx% + 30, lpy% + 3), 10
        'Row 4
        LINE (lpx% + 3, lpy% + 4)-(lpx% + 31, lpy% + 4), 10
        'Row 5
        LINE (lpx% + 2, lpy% + 5)-(lpx% + 31, lpy% + 5), 10
        'Row 6
        LINE (lpx% + 2, lpy% + 6)-(lpx% + 31, lpy% + 6), 10
        'Row 7
        LINE (lpx% + 2, lpy% + 7)-(lpx% + 31, lpy% + 7), 10
        'Row 8
        LINE (lpx% + 2, lpy% + 8)-(lpx% + 31, lpy% + 8), 67
        LINE (lpx% + 3, lpy% + 8)-(lpx% + 30, lpy% + 8), 10
        'Row 9
        LINE (lpx% + 2, lpy% + 9)-(lpx% + 31, lpy% + 9), 67
        LINE (lpx% + 4, lpy% + 9)-(lpx% + 30, lpy% + 9), 10
        'Row 10
        LINE (lpx% + 2, lpy% + 10)-(lpx% + 31, lpy% + 10), 67
        LINE (lpx% + 6, lpy% + 10)-(lpx% + 28, lpy% + 10), 6
        LINE (lpx% + 8, lpy% + 10)-(lpx% + 26, lpy% + 10), 10
        'Row 11
        LINE (lpx% + 2, lpy% + 11)-(lpx% + 31, lpy% + 11), 67
        LINE (lpx% + 6, lpy% + 11)-(lpx% + 28, lpy% + 11), 6
        LINE (lpx% + 9, lpy% + 11)-(lpx% + 24, lpy% + 11), 10
        'Row 12
        PSET (lpx% + 2, lpy% + 12), 6
        LINE (lpx% + 3, lpy% + 12)-(lpx% + 31, lpy% + 12), 67
        LINE (lpx% + 6, lpy% + 12)-(lpx% + 28, lpy% + 12), 6
        LINE (lpx% + 11, lpy% + 12)-(lpx% + 22, lpy% + 12), 10
        'Row 13
        LINE (lpx%, lpy% + 13)-(lpx% + 3, lpy% + 13), 6
        LINE (lpx% + 4, lpy% + 13)-(lpx% + 30, lpy% + 13), 67
        LINE (lpx% + 6, lpy% + 13)-(lpx% + 28, lpy% + 13), 6
        LINE (lpx% + 11, lpy% + 13)-(lpx% + 22, lpy% + 13), 10
        'Row 14
        LINE (lpx%, lpy% + 14)-(lpx% + 4, lpy% + 14), 6
        LINE (lpx% + 5, lpy% + 14)-(lpx% + 29, lpy% + 14), 10
        LINE (lpx% + 10, lpy% + 14)-(lpx% + 12, lpy% + 14), 0
        LINE (lpx% + 21, lpy% + 14)-(lpx% + 23, lpy% + 14), 0
        'Row 15
        LINE (lpx%, lpy% + 15)-(lpx% + 4, lpy% + 15), 6
        LINE (lpx% + 5, lpy% + 15)-(lpx% + 29, lpy% + 15), 10
        LINE (lpx% + 11, lpy% + 15)-(lpx% + 13, lpy% + 15), 0
        LINE (lpx% + 20, lpy% + 15)-(lpx% + 22, lpy% + 15), 0
        'Row 16
        LINE (lpx%, lpy% + 16)-(lpx% + 4, lpy% + 16), 6
        LINE (lpx% + 5, lpy% + 16)-(lpx% + 29, lpy% + 16), 10
        LINE (lpx% + 12, lpy% + 16)-(lpx% + 21, lpy% + 16), 0
        'Row 17
        LINE (lpx%, lpy% + 17)-(lpx% + 30, lpy% + 17), 6
        LINE (lpx% + 5, lpy% + 17)-(lpx% + 29, lpy% + 17), 10
        'Row 18
        LINE (lpx%, lpy% + 18)-(lpx% + 31, lpy% + 18), 6
        LINE (lpx% + 5, lpy% + 18)-(lpx% + 27, lpy% + 18), 10
        'Row 19
        LINE (lpx%, lpy% + 19)-(lpx% + 31, lpy% + 19), 6
        LINE (lpx% + 5, lpy% + 19)-(lpx% + 27, lpy% + 19), 10
        'Row 20
        LINE (lpx% + 3, lpy% + 20)-(lpx% + 31, lpy% + 20), 6
        LINE (lpx% + 5, lpy% + 20)-(lpx% + 27, lpy% + 20), 10
        'Row 21
        LINE (lpx% + 4, lpy% + 21)-(lpx% + 31, lpy% + 21), 6
        LINE (lpx% + 5, lpy% + 21)-(lpx% + 28, lpy% + 21), 10
        'Row 22
        LINE (lpx% + 4, lpy% + 22)-(lpx% + 31, lpy% + 22), 10
        LINE (lpx% + 6, lpy% + 22)-(lpx% + 27, lpy% + 22), 6
        'Row 23
        LINE (lpx% + 4, lpy% + 23)-(lpx% + 31, lpy% + 23), 10
        LINE (lpx% + 8, lpy% + 23)-(lpx% + 25, lpy% + 23), 6
        LINE (lpx% + 31, lpy% + 23)-(lpx% + 31, lpy% + 23), 6
        'Row 24
        LINE (lpx% + 4, lpy% + 24)-(lpx% + 29, lpy% + 24), 10
        LINE (lpx% + 30, lpy% + 24)-(lpx% + 31, lpy% + 24), 6
        'Row 25
        LINE (lpx% + 4, lpy% + 25)-(lpx% + 28, lpy% + 25), 10
        LINE (lpx% + 29, lpy% + 25)-(lpx% + 30, lpy% + 25), 6
        'Row 26
        LINE (lpx% + 3, lpy% + 26)-(lpx% + 29, lpy% + 26), 6
        LINE (lpx% + 9, lpy% + 26)-(lpx% + 27, lpy% + 26), 10
        'Row 27
        LINE (lpx% + 3, lpy% + 27)-(lpx% + 28, lpy% + 27), 6
        LINE (lpx% + 11, lpy% + 27)-(lpx% + 25, lpy% + 27), 10
        'Row 28
        LINE (lpx% + 3, lpy% + 28)-(lpx% + 11, lpy% + 28), 6
        LINE (lpx% + 12, lpy% + 28)-(lpx% + 14, lpy% + 28), 10
        LINE (lpx% + 20, lpy% + 28)-(lpx% + 25, lpy% + 28), 10
        PSET (lpx% + 26, lpy% + 28), 6
        'Row 29
        LINE (lpx% + 3, lpy% + 29)-(lpx% + 13, lpy% + 29), 6
        LINE (lpx% + 20, lpy% + 29)-(lpx% + 25, lpy% + 29), 6
        'Row 30
        LINE (lpx% + 3, lpy% + 30)-(lpx% + 12, lpy% + 30), 6
        'Row 31
        LINE (lpx% + 4, lpy% + 31)-(lpx% + 12, lpy% + 31), 6

END SUB

SUB Linkws (lpx%, lpy%)
        'Row 1
        LINE (lpx% + 8, lpy% + 1)-(lpx% + 27, lpy% + 1), 10
        'Row 2
        LINE (lpx% + 6, lpy% + 2)-(lpx% + 28, lpy% + 2), 10
        'Row 3
        LINE (lpx% + 5, lpy% + 3)-(lpx% + 30, lpy% + 3), 10
        'Row 4
        LINE (lpx% + 3, lpy% + 4)-(lpx% + 31, lpy% + 4), 10
        'Row 5
        LINE (lpx% + 2, lpy% + 5)-(lpx% + 31, lpy% + 5), 10
        'Row 6
        LINE (lpx% + 2, lpy% + 6)-(lpx% + 31, lpy% + 6), 10
        'Row 7
        LINE (lpx% + 2, lpy% + 7)-(lpx% + 31, lpy% + 7), 10
        'Row 8
        LINE (lpx% + 2, lpy% + 8)-(lpx% + 31, lpy% + 8), 67
        LINE (lpx% + 3, lpy% + 8)-(lpx% + 30, lpy% + 8), 10
        'Row 9
        LINE (lpx% + 2, lpy% + 9)-(lpx% + 31, lpy% + 9), 67
        LINE (lpx% + 4, lpy% + 9)-(lpx% + 30, lpy% + 9), 10
        'Row 10
        LINE (lpx% + 2, lpy% + 10)-(lpx% + 31, lpy% + 10), 67
        LINE (lpx% + 6, lpy% + 10)-(lpx% + 28, lpy% + 10), 6
        LINE (lpx% + 8, lpy% + 10)-(lpx% + 26, lpy% + 10), 10
        'Row 11
        LINE (lpx% + 2, lpy% + 11)-(lpx% + 31, lpy% + 11), 67
        LINE (lpx% + 6, lpy% + 11)-(lpx% + 28, lpy% + 11), 6
        LINE (lpx% + 9, lpy% + 11)-(lpx% + 24, lpy% + 11), 10
        'Row 12
        PSET (lpx% + 2, lpy% + 12), 6
        LINE (lpx% + 3, lpy% + 12)-(lpx% + 31, lpy% + 12), 67
        LINE (lpx% + 6, lpy% + 12)-(lpx% + 28, lpy% + 12), 6
        LINE (lpx% + 11, lpy% + 12)-(lpx% + 22, lpy% + 12), 10
        'Row 13
        LINE (lpx%, lpy% + 13)-(lpx% + 3, lpy% + 13), 6
        LINE (lpx% + 4, lpy% + 13)-(lpx% + 30, lpy% + 13), 67
        LINE (lpx% + 6, lpy% + 13)-(lpx% + 28, lpy% + 13), 6
        LINE (lpx% + 11, lpy% + 13)-(lpx% + 22, lpy% + 13), 10
        'Row 14
        LINE (lpx%, lpy% + 14)-(lpx% + 4, lpy% + 14), 6
        LINE (lpx% + 5, lpy% + 14)-(lpx% + 29, lpy% + 14), 10
        LINE (lpx% + 10, lpy% + 14)-(lpx% + 12, lpy% + 14), 0
        LINE (lpx% + 21, lpy% + 14)-(lpx% + 23, lpy% + 14), 0
        'Row 15
        LINE (lpx%, lpy% + 15)-(lpx% + 4, lpy% + 15), 6
        LINE (lpx% + 5, lpy% + 15)-(lpx% + 29, lpy% + 15), 10
        LINE (lpx% + 11, lpy% + 15)-(lpx% + 13, lpy% + 15), 0
        LINE (lpx% + 20, lpy% + 15)-(lpx% + 22, lpy% + 15), 0
        'Row 16
        LINE (lpx%, lpy% + 16)-(lpx% + 4, lpy% + 16), 6
        LINE (lpx% + 5, lpy% + 16)-(lpx% + 29, lpy% + 16), 10
        LINE (lpx% + 12, lpy% + 16)-(lpx% + 21, lpy% + 16), 0
        'Row 17
        LINE (lpx%, lpy% + 17)-(lpx% + 30, lpy% + 17), 6
        LINE (lpx% + 5, lpy% + 17)-(lpx% + 29, lpy% + 17), 10
        'Row 18
        LINE (lpx%, lpy% + 18)-(lpx% + 31, lpy% + 18), 6
        LINE (lpx% + 5, lpy% + 18)-(lpx% + 27, lpy% + 18), 10
END SUB

SUB Pglove (x1%, y1%)
        SHARED Gmap%()

        x% = 1
        y% = 1

        WHILE y% <= 12
                WHILE x% <= 14
                        LINE (x1% - 14, y1% - 12)-(x1% - 13, y1% - 11), Gmap%(x%, y%), BF
                        x% = x% + 1
                        x1% = x1% + 2
                WEND
                x% = 1
                x1% = x1% - 28
                y% = y% + 1
                y1% = y1% + 2
        WEND
        y1% = y1% - 12
END SUB

SUB Room1 (room$())
        SHARED r%
        x1% = 1
        y1% = 1
        x% = 1
        y% = 1
        z% = 1
        OPEN "C:\rooms\room1.txt" FOR RANDOM AS #1
        'If the room needs to be reset
        IF r% = 1 THEN
            WHILE y1% <= 7
               WHILE x1% <= 10
                  GET #1, z%, room$(x1%, y1%)
                  x1% = x1% + 1
                  z% = z% + 1
               WEND
               x1% = 1
               y1% = y1% + 1
            WEND
        END IF
        LINE (0, 0)-(320, 200), 66, BF

        WHILE y% <= 7
                key$ = INKEY$
                key$ = LCASE$(key$)
                IF key$ = "q" THEN
                        END
                END IF
                WHILE x% <= 10
                        key$ = INKEY$
                        key$ = LCASE$(key$)
                        IF key$ = "q" THEN
                                END
                        END IF
                        IF room$(x%, y%) = "Mountain" THEN
                           CALL Texture("Mountain", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Rock" THEN
                           CALL Texture("Rock", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Tree" THEN
                           CALL Texture("Tree", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Water1" THEN
                           CALL Texture("Water1", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Forest" THEN
                           CALL Texture("Forest", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Chest" OR room$(x%, y%) = "Echest" THEN
                           CALL Texture("Block", x% * 32, y% * 32)
                        END IF
                        x% = x% + 1
                WEND
                x% = 1
                y% = y% + 1
        WEND
        y% = 1
        r% = 1
        CLOSE #1
END SUB

SUB room10 (room$())
        SHARED r%
        x% = 1
        y% = 1
        x1% = 1
        y1% = 1
        z% = 1
        OPEN "C:\rooms\room10.txt" FOR RANDOM AS #1

        'If the room needs to be reset
        IF r% = 1 THEN
            WHILE y1% <= 7
               WHILE x1% <= 10
                  GET #1, z%, room$(x1%, y1%)
                  x1% = x1% + 1
                  z% = z% + 1
               WEND
               x1% = 1
               y1% = y1% + 1
            WEND
        END IF
        LINE (0, 0)-(320, 200), 66, BF

        WHILE y% <= 7
                key$ = INKEY$
                key$ = LCASE$(key$)
                IF key$ = "q" THEN
                        END
                END IF
                WHILE x% <= 10
                        key$ = INKEY$
                        key$ = LCASE$(key$)
                        IF key$ = "q" THEN
                                END
                        END IF
                        IF room$(x%, y%) = "Mountain" THEN
                           CALL Texture("Mountain", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Rock" THEN
                           CALL Texture("Rock", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Tree" THEN
                           CALL Texture("Tree", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Water1" THEN
                           CALL Texture("Water1", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Forest" THEN
                           CALL Texture("Forest", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Chest" OR room$(x%, y%) = "Echest" THEN
                           CALL Texture("Block", x% * 32, y% * 32)
                        END IF
                        x% = x% + 1
                WEND
                x% = 1
                y% = y% + 1
        WEND
        y% = 1
        r% = 1
        CLOSE #1
END SUB

SUB room13 (room$())
        SHARED r%
        x% = 1
        y% = 1
        x1% = 1
        y1% = 1
        z% = 1
        OPEN "C:\rooms\room13.txt" FOR RANDOM AS #1
        'If the room needs to be reset
        IF r% = 1 THEN
            WHILE y1% <= 7
               WHILE x1% <= 10
                  GET #1, z%, room$(x1%, y1%)
                  x1% = x1% + 1
                  z% = z% + 1
               WEND
               x1% = 1
               y1% = y1% + 1
            WEND
        END IF

        LINE (0, 0)-(320, 200), 66, BF

        WHILE y% <= 7
                key$ = INKEY$
                key$ = LCASE$(key$)
                IF key$ = "q" THEN
                        END
                END IF
                WHILE x% <= 10
                        PUT #1, z%, room$(x%, y%)
                        key$ = INKEY$
                        key$ = LCASE$(key$)
                        IF key$ = "q" THEN
                                END
                        END IF
                        IF room$(x%, y%) = "Mountain" THEN
                           CALL Texture("Mountain", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Block" THEN
                           CALL Texture("Forest", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Rock" THEN
                           CALL Texture("Rock", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Tree" THEN
                           CALL Texture("Tree", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Water1" THEN
                           CALL Texture("Water1", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Forest" THEN
                           CALL Texture("Forest", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Chest" OR room$(x%, y%) = "Echest" THEN
                           CALL Texture("Block", x% * 32, y% * 32)
                        END IF
                        x% = x% + 1
                WEND
                x% = 1
                y% = y% + 1
        WEND
        y% = 1
        r% = 1
        CLOSE #1
END SUB

SUB room14 (room$())
        SHARED r%
        x% = 1
        y% = 1
        x1% = 1
        y1% = 1
        z% = 1
        OPEN "C:\rooms\room14.txt" FOR RANDOM AS #1
        'If the room needs to be reset
        IF r% = 1 THEN
            WHILE y1% <= 7
               WHILE x1% <= 10
                  GET #1, z%, room$(x1%, y1%)
                  x1% = x1% + 1
                  z% = z% + 1
               WEND
               x1% = 1
               y1% = y1% + 1
            WEND
        END IF
        LINE (0, 0)-(320, 200), 66, BF

        WHILE y% <= 7
                key$ = INKEY$
                key$ = LCASE$(key$)
                IF key$ = "q" THEN
                        END
                END IF
                WHILE x% <= 10
                        key$ = INKEY$
                        key$ = LCASE$(key$)
                        IF key$ = "q" THEN
                                END
                        END IF
                        IF room$(x%, y%) = "Mountain" THEN
                           CALL Texture("Mountain", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Rock" THEN
                           CALL Texture("Rock", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Tree" THEN
                           CALL Texture("Tree", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Water1" THEN
                           CALL Texture("Water1", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Forest" THEN
                           CALL Texture("Forest", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Chest" OR room$(x%, y%) = "Echest" THEN
                           CALL Texture("Block", x% * 32, y% * 32)
                        END IF
                        x% = x% + 1
                WEND
                x% = 1
                y% = y% + 1
        WEND
        y% = 1
        r% = 1
        CLOSE #1
END SUB

SUB room15 (room$())
        SHARED r%
        x% = 1
        y% = 1
        x1% = 1
        y1% = 1
        z% = 1
        OPEN "C:\rooms\room15.txt" FOR RANDOM AS #1
        'If the room needs to be reset
        IF r% = 1 THEN
            WHILE y1% <= 7
               WHILE x1% <= 10
                  GET #1, z%, room$(x1%, y1%)
                  x1% = x1% + 1
                  z% = z% + 1
               WEND
               x1% = 1
               y1% = y1% + 1
            WEND
        END IF
        LINE (0, 0)-(320, 200), 66, BF

        WHILE y% <= 7
                key$ = INKEY$
                key$ = LCASE$(key$)
                IF key$ = "q" THEN
                        END
                END IF
                WHILE x% <= 10
                        key$ = INKEY$
                        key$ = LCASE$(key$)
                        IF key$ = "q" THEN
                                END
                        END IF
                        IF room$(x%, y%) = "Mountain" THEN
                           CALL Texture("Mountain", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Rock" THEN
                           CALL Texture("Rock", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Tree" THEN
                           CALL Texture("Tree", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Water1" THEN
                           CALL Texture("Water1", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Forest" THEN
                           CALL Texture("Forest", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Chest" OR room$(x%, y%) = "Echest" THEN
                           CALL Texture("Block", x% * 32, y% * 32)
                        END IF
                        x% = x% + 1
                WEND
                x% = 1
                y% = y% + 1
        WEND
        y% = 1
        r% = 1
        CLOSE #1
END SUB

SUB room16 (room$())
        SHARED r%
        x% = 1
        y% = 1
        x1% = 1
        y1% = 1
        z% = 1
        OPEN "C:\rooms\room16.txt" FOR RANDOM AS #1
        'If the room needs to be reset
        IF r% = 1 THEN
            WHILE y1% <= 7
               WHILE x1% <= 10
                  GET #1, z%, room$(x1%, y1%)
                  x1% = x1% + 1
                  z% = z% + 1
               WEND
               x1% = 1
               y1% = y1% + 1
            WEND
        END IF
        LINE (0, 0)-(320, 200), 66, BF

        WHILE y% <= 7
                key$ = INKEY$
                key$ = LCASE$(key$)
                IF key$ = "q" THEN
                        END
                END IF
                WHILE x% <= 10
                        key$ = INKEY$
                        key$ = LCASE$(key$)
                        IF key$ = "q" THEN
                                END
                        END IF
                        IF room$(x%, y%) = "Mountain" THEN
                           CALL Texture("Mountain", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Block" THEN
                           CALL Texture("Block", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Rock" THEN
                           CALL Texture("Rock", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Tree" THEN
                           CALL Texture("Tree", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Water1" THEN
                           CALL Texture("Water1", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Forest" THEN
                           CALL Texture("Forest", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Chest" OR room$(x%, y%) = "Echest" THEN
                           CALL Texture("Block", x% * 32, y% * 32)
                        END IF
                        x% = x% + 1
                WEND
                x% = 1
                y% = y% + 1
        WEND
        y% = 1
        r% = 1
        CLOSE #1
END SUB

SUB room19 (room$())
        SHARED r%
        x% = 1
        y% = 1
        x1% = 1
        y1% = 1
        z% = 1
        OPEN "C:\rooms\room19.txt" FOR RANDOM AS #1
        'If the room needs to be reset
        IF r% = 1 THEN
            WHILE y1% <= 7
               WHILE x1% <= 10
                  GET #1, z%, room$(x1%, y1%)
                  x1% = x1% + 1
                  z% = z% + 1
               WEND
               x1% = 1
               y1% = y1% + 1
            WEND
        END IF
        LINE (0, 0)-(320, 200), 66, BF

        WHILE y% <= 7
                key$ = INKEY$
                key$ = LCASE$(key$)
                IF key$ = "q" THEN
                        END
                END IF
                WHILE x% <= 10
                        key$ = INKEY$
                        key$ = LCASE$(key$)
                        IF key$ = "q" THEN
                                END
                        END IF
                        IF room$(x%, y%) = "Mountain" THEN
                           CALL Texture("Mountain", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Rock" THEN
                           CALL Texture("Rock", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Tree" THEN
                           CALL Texture("Tree", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Water1" THEN
                           CALL Texture("Water1", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Forest" THEN
                           CALL Texture("Forest", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Chest" OR room$(x%, y%) = "Echest" THEN
                           CALL Texture("Block", x% * 32, y% * 32)
                        END IF
                        x% = x% + 1
                WEND
                x% = 1
                y% = y% + 1
        WEND
        CLOSE #1
END SUB

SUB Room2 (room$())
        SHARED r%
        x1% = 1
        y1% = 1
        x% = 1
        y% = 1
        z% = 1
        OPEN "C:\rooms\room2.txt" FOR RANDOM AS #1
        IF r% = 1 THEN
            WHILE y1% <= 7
               WHILE x1% <= 10
                  GET #1, z%, room$(x1%, y1%)
                  x1% = x1% + 1
                  z% = z% + 1
               WEND
               x1% = 1
               y1% = y1% + 1
            WEND
        END IF
        LINE (0, 0)-(320, 200), 66, BF

        WHILE y% <= 7
                key$ = INKEY$
                key$ = LCASE$(key$)
                IF key$ = "q" THEN
                        END
                END IF
                WHILE x% <= 10
                        key$ = INKEY$
                        key$ = LCASE$(key$)
                        IF key$ = "q" THEN
                                END
                        END IF
                        IF room$(x%, y%) = "Mountain" THEN
                           CALL Texture("Mountain", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Rock" THEN
                           CALL Texture("Rock", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Tree" THEN
                           CALL Texture("Tree", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Water1" THEN
                           CALL Texture("Water1", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Forest" THEN
                           CALL Texture("Forest", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Chest" OR room$(x%, y%) = "Echest" THEN
                           CALL Texture("Block", x% * 32, y% * 32)
                        END IF
                        x% = x% + 1
                WEND
                x% = 1
                y% = y% + 1
        WEND
        y% = 1
        r% = 1
        CLOSE #1
END SUB

SUB room20 (room$())
        SHARED r%
        x% = 1
        y% = 1
        x1% = 1
        y1% = 1
        z% = 1
        OPEN "C:\rooms\room20.txt" FOR RANDOM AS #1
        'If the room needs to be reset
        IF r% = 1 THEN
            WHILE y1% <= 7
               WHILE x1% <= 10
                  GET #1, z%, room$(x1%, y1%)
                  x1% = x1% + 1
                  z% = z% + 1
               WEND
               x1% = 1
               y1% = y1% + 1
            WEND
        END IF
        LINE (0, 0)-(320, 200), 66, BF

        WHILE y% <= 7
                key$ = INKEY$
                key$ = LCASE$(key$)
                IF key$ = "q" THEN
                        END
                END IF
                WHILE x% <= 10
                        key$ = INKEY$
                        key$ = LCASE$(key$)
                        IF key$ = "q" THEN
                                END
                        END IF
                        IF room$(x%, y%) = "Mountain" THEN
                           CALL Texture("Mountain", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Block" THEN
                           CALL Texture("Block", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Rock" THEN
                           CALL Texture("Rock", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Tree" THEN
                           CALL Texture("Tree", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Water1" THEN
                           CALL Texture("Water1", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Forest" THEN
                           CALL Texture("Forest", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Chest" OR room$(x%, y%) = "Echest" THEN
                           CALL Texture("Chest", x% * 32, y% * 32)
                        END IF
                        x% = x% + 1
                WEND
                x% = 1
                y% = y% + 1
        WEND
        y% = 1
        r% = 1
        CLOSE #1
END SUB

SUB room21 (room$())
        SHARED r%
        x% = 1
        y% = 1
        x1% = 1
        y1% = 1
        z% = 1
        OPEN "C:\rooms\room21.txt" FOR RANDOM AS #1
        'If the room needs to be reset
        IF r% = 1 THEN
            WHILE y1% <= 7
               WHILE x1% <= 10
                  GET #1, z%, room$(x1%, y1%)
                  x1% = x1% + 1
                  z% = z% + 1
               WEND
               x1% = 1
               y1% = y1% + 1
            WEND
        END IF
        LINE (0, 0)-(320, 200), 66, BF

        WHILE y% <= 7
                key$ = INKEY$
                key$ = LCASE$(key$)
                IF key$ = "q" THEN
                        END
                END IF
                WHILE x% <= 10
                        key$ = INKEY$
                        key$ = LCASE$(key$)
                        IF key$ = "q" THEN
                                END
                        END IF
                        IF room$(x%, y%) = "Mountain" THEN
                           CALL Texture("Mountain", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Rock" THEN
                           CALL Texture("Rock", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Tree" THEN
                           CALL Texture("Tree", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Water1" THEN
                           CALL Texture("Water1", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Forest" THEN
                           CALL Texture("Forest", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Chest" OR room$(x%, y%) = "Echest" THEN
                           CALL Texture("Block", x% * 32, y% * 32)
                        END IF
                        x% = x% + 1
                WEND
                x% = 1
                y% = y% + 1
        WEND
        y% = 1
        r% = 1
        CLOSE #1
END SUB

SUB room22 (room$())
        SHARED r%
        x% = 1
        y% = 1
        x1% = 1
        y1% = 1
        z% = 1
        OPEN "C:\rooms\room22.txt" FOR RANDOM AS #1
        'If the room needs to be reset
        IF r% = 1 THEN
            WHILE y1% <= 7
               WHILE x1% <= 10
                  GET #1, z%, room$(x1%, y1%)
                  x1% = x1% + 1
                  z% = z% + 1
               WEND
               x1% = 1
               y1% = y1% + 1
            WEND
        END IF
        LINE (0, 0)-(320, 200), 66, BF

        WHILE y% <= 7
                key$ = INKEY$
                key$ = LCASE$(key$)
                IF key$ = "q" THEN
                        END
                END IF
                WHILE x% <= 10
                        key$ = INKEY$
                        key$ = LCASE$(key$)
                        IF key$ = "q" THEN
                                END
                        END IF
                        IF room$(x%, y%) = "Mountain" THEN
                           CALL Texture("Mountain", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Rock" THEN
                           CALL Texture("Rock", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Tree" THEN
                           CALL Texture("Tree", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Water1" THEN
                           CALL Texture("Water1", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Forest" THEN
                           CALL Texture("Forest", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Chest" OR room$(x%, y%) = "Echest" THEN
                           CALL Texture("Block", x% * 32, y% * 32)
                        END IF
                        x% = x% + 1
                WEND
                x% = 1
                y% = y% + 1
        WEND
        y% = 1
        r% = 1
        CLOSE #1
END SUB

SUB room25 (room$())
        SHARED r%
        x% = 1
        y% = 1
        x1% = 1
        y1% = 1
        z% = 1
        OPEN "C:\rooms\room25.txt" FOR RANDOM AS #1
        'If the room needs to be reset
        IF r% = 1 THEN
            WHILE y1% <= 7
               WHILE x1% <= 10
                  GET #1, z%, room$(x1%, y1%)
                  x1% = x1% + 1
                  z% = z% + 1
               WEND
               x1% = 1
               y1% = y1% + 1
            WEND
        END IF
        LINE (0, 0)-(320, 200), 66, BF

        WHILE y% <= 7
                key$ = INKEY$
                key$ = LCASE$(key$)
                IF key$ = "q" THEN
                        END
                END IF
                WHILE x% <= 10
                        key$ = INKEY$
                        key$ = LCASE$(key$)
                        IF key$ = "q" THEN
                                END
                        END IF
                        IF room$(x%, y%) = "Mountain" THEN
                           CALL Texture("Mountain", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Rock" THEN
                           CALL Texture("Rock", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Tree" THEN
                           CALL Texture("Tree", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Water1" THEN
                           CALL Texture("Water1", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Forest" THEN
                           CALL Texture("Forest", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Chest" OR room$(x%, y%) = "Echest" THEN
                           CALL Texture("Block", x% * 32, y% * 32)
                        END IF
                        x% = x% + 1
                WEND
                x% = 1
                y% = y% + 1
        WEND
        CLOSE #1
END SUB

SUB room26 (room$())
        SHARED r%
        x% = 1
        y% = 1
        x1% = 1
        y1% = 1
        z% = 1
        OPEN "C:\rooms\room26.txt" FOR RANDOM AS #1
        'If the room needs to be reset            
        IF r% = 1 THEN
            WHILE y1% <= 7
               WHILE x1% <= 10
                  GET #1, z%, room$(x1%, y1%)
                  x1% = x1% + 1
                  z% = z% + 1
               WEND
               x1% = 1
               y1% = y1% + 1
            WEND
        END IF
        LINE (0, 0)-(320, 200), 66, BF

        WHILE y% <= 7
                key$ = INKEY$
                key$ = LCASE$(key$)
                IF key$ = "q" THEN
                        END
                END IF
                WHILE x% <= 10
                        key$ = INKEY$
                        key$ = LCASE$(key$)
                        IF key$ = "q" THEN
                                END
                        END IF
                        IF room$(x%, y%) = "Mountain" THEN
                           CALL Texture("Mountain", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Rock" THEN
                           CALL Texture("Rock", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Tree" THEN
                           CALL Texture("Tree", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Water1" THEN
                           CALL Texture("Water1", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Forest" THEN
                           CALL Texture("Forest", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Chest" OR room$(x%, y%) = "Echest" THEN
                           CALL Texture("Block", x% * 32, y% * 32)
                        END IF
                        x% = x% + 1
                WEND
                x% = 1
                y% = y% + 1
        WEND
        y% = 1
        r% = 1
        CLOSE #1
END SUB

SUB room27 (room$())
        SHARED r%
        x% = 1
        y% = 1
        x1% = 1
        y1% = 1
        z% = 1
        OPEN "C:\rooms\room27.txt" FOR RANDOM AS #1
        'If the room needs to be reset
        IF r% = 1 THEN
            WHILE y1% <= 7
               WHILE x1% <= 10
                  GET #1, z%, room$(x1%, y1%)
                  x1% = x1% + 1
                  z% = z% + 1
               WEND
               x1% = 1
               y1% = y1% + 1
            WEND
        END IF
        LINE (0, 0)-(320, 200), 66, BF

        WHILE y% <= 7
                key$ = INKEY$
                key$ = LCASE$(key$)
                IF key$ = "q" THEN
                        END
                END IF
                WHILE x% <= 10
                        key$ = INKEY$
                        key$ = LCASE$(key$)
                        IF key$ = "q" THEN
                                END
                        END IF
                        IF room$(x%, y%) = "Rock" THEN
                           CALL Texture("Rock", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Mountain" THEN
                           CALL Texture("Mountain", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Block" THEN
                           CALL Texture("Block", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Tree" THEN
                           CALL Texture("Tree", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Water1" THEN
                           CALL Texture("Water1", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Forest" THEN
                           CALL Texture("Forest", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Chest" OR room$(x%, y%) = "Echest" THEN
                           CALL Texture("Block", x% * 32, y% * 32)
                        END IF
                        x% = x% + 1
                WEND
                x% = 1
                y% = y% + 1
        WEND
        y% = 1
        r% = 1
        CLOSE #1
END SUB

SUB room28 (room$())
        SHARED r%
        x% = 1
        y% = 1
        x1% = 1
        y1% = 1
        z% = 1
        OPEN "C:\rooms\room28.txt" FOR RANDOM AS #1
        'If the room needs to be reset
        IF r% = 1 THEN
            WHILE y1% <= 7
               WHILE x1% <= 10
                  GET #1, z%, room$(x1%, y1%)
                  x1% = x1% + 1
                  z% = z% + 1
               WEND
               x1% = 1
               y1% = y1% + 1
            WEND
        END IF
        LINE (0, 0)-(320, 200), 66, BF

        WHILE y% <= 7
                key$ = INKEY$
                key$ = LCASE$(key$)
                IF key$ = "q" THEN
                        END
                END IF
                WHILE x% <= 10
                        key$ = INKEY$
                        key$ = LCASE$(key$)
                        IF key$ = "q" THEN
                                END
                        END IF
                        IF room$(x%, y%) = "Mountain" THEN
                           CALL Texture("Mountain", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Rock" THEN
                           CALL Texture("Rock", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Tree" THEN
                           CALL Texture("Tree", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Water1" THEN
                           CALL Texture("Water1", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Forest" THEN
                           CALL Texture("Forest", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Chest" OR room$(x%, y%) = "Echest" THEN
                           CALL Texture("Block", x% * 32, y% * 32)
                        END IF
                        x% = x% + 1
                WEND
                x% = 1
                y% = y% + 1
        WEND
        y% = 1
        r% = 1
        CLOSE #1
END SUB

SUB room3 (room$())
        SHARED r%
        x% = 1
        y% = 1
        x1% = 1
        y1% = 1
        z% = 1
        OPEN "C:\rooms\room3.txt" FOR RANDOM AS #1
        IF r% = 1 THEN
            WHILE y1% <= 7
               WHILE x1% <= 10
                  GET #1, z%, room$(x1%, y1%)
                  x1% = x1% + 1
                  z% = z% + 1
               WEND
               x1% = 1
               y1% = y1% + 1
            WEND
        END IF

        LINE (0, 0)-(320, 200), 66, BF

        WHILE y% <= 7
                key$ = INKEY$
                key$ = LCASE$(key$)
                IF key$ = "q" THEN
                        END
                END IF
                WHILE x% <= 10
                        key$ = INKEY$
                        key$ = LCASE$(key$)
                        IF key$ = "q" THEN
                                END
                        END IF
                        IF room$(x%, y%) = "Mountain" THEN
                           CALL Texture("Mountain", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Rock" THEN
                           CALL Texture("Rock", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Tree" THEN
                           CALL Texture("Tree", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Water1" THEN
                           CALL Texture("Water1", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Forest" THEN
                           CALL Texture("Forest", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Chest" OR room$(x%, y%) = "Echest" THEN
                           CALL Texture("Block", x% * 32, y% * 32)
                        END IF
                        x% = x% + 1
                        z% = z% + 1
                WEND
                x% = 1
                y% = y% + 1
        WEND
        y% = 1
        r% = 1
        CLOSE #1

END SUB

SUB room31 (room$())
        SHARED r%
        x% = 1
        y% = 1
        x1% = 1
        y1% = 1
        z% = 1
        OPEN "C:\rooms\room31.txt" FOR RANDOM AS #1
        'If the room needs to be reset
        IF r% = 1 THEN
            WHILE y1% <= 7
               WHILE x1% <= 10
                  GET #1, z%, room$(x1%, y1%)
                  x1% = x1% + 1
                  z% = z% + 1
               WEND
               x1% = 1
               y1% = y1% + 1
            WEND
        END IF
        LINE (0, 0)-(320, 200), 66, BF

        WHILE y% <= 7
                key$ = INKEY$
                key$ = LCASE$(key$)
                IF key$ = "q" THEN
                        END
                END IF
                WHILE x% <= 10
                        key$ = INKEY$
                        key$ = LCASE$(key$)
                        IF key$ = "q" THEN
                                END
                        END IF
                        IF room$(x%, y%) = "Mountain" THEN
                           CALL Texture("Mountain", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Rock" THEN
                           CALL Texture("Rock", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Tree" THEN
                           CALL Texture("Tree", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Water1" THEN
                           CALL Texture("Water1", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Forest" THEN
                           CALL Texture("Forest", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Chest" OR room$(x%, y%) = "Echest" THEN
                           CALL Texture("Block", x% * 32, y% * 32)
                        END IF
                        x% = x% + 1
                WEND
                x% = 1
                y% = y% + 1
        WEND
        y% = 1
        r% = 1
        CLOSE #1
END SUB

SUB room32 (room$())
        SHARED r%
        x% = 1
        y% = 1
        x1% = 1
        y1% = 1
        z% = 1
        OPEN "C:\rooms\room32.txt" FOR RANDOM AS #1
        'If the room needs to be reset
        IF r% = 1 THEN
            WHILE y1% <= 7
               WHILE x1% <= 10
                  GET #1, z%, room$(x1%, y1%)
                  x1% = x1% + 1
                  z% = z% + 1
               WEND
               x1% = 1
               y1% = y1% + 1
            WEND
        END IF
        LINE (0, 0)-(320, 200), 66, BF

        WHILE y% <= 7
                key$ = INKEY$
                key$ = LCASE$(key$)
                IF key$ = "q" THEN
                        END
                END IF
                WHILE x% <= 10
                        key$ = INKEY$
                        key$ = LCASE$(key$)
                        IF key$ = "q" THEN
                                END
                        END IF
                        IF room$(x%, y%) = "Mountain" THEN
                           CALL Texture("Mountain", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Rock" THEN
                           CALL Texture("Rock", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Tree" THEN
                           CALL Texture("Tree", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Water1" THEN
                           CALL Texture("Water1", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Forest" THEN
                           CALL Texture("Forest", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Chest" OR room$(x%, y%) = "Echest" THEN
                           CALL Texture("Block", x% * 32, y% * 32)
                        END IF
                        x% = x% + 1
                WEND
                x% = 1
                y% = y% + 1
        WEND
        y% = 1
        r% = 1
        CLOSE #1
END SUB

SUB room33 (room$())
        SHARED r%
        x% = 1
        y% = 1
        x1% = 1
        y1% = 1
        z% = 1
        OPEN "C:\rooms\room33.txt" FOR RANDOM AS #1
        'If the room needs to be reset
        IF r% = 1 THEN
            WHILE y1% <= 7
               WHILE x1% <= 10
                  GET #1, z%, room$(x1%, y1%)
                  x1% = x1% + 1
                  z% = z% + 1
               WEND
               x1% = 1
               y1% = y1% + 1
            WEND
        END IF
        LINE (0, 0)-(320, 200), 66, BF

        WHILE y% <= 7
                key$ = INKEY$
                key$ = LCASE$(key$)
                IF key$ = "q" THEN
                        END
                END IF
                WHILE x% <= 10
                        key$ = INKEY$
                        key$ = LCASE$(key$)
                        IF key$ = "q" THEN
                                END
                        END IF
                        IF room$(x%, y%) = "Mountain" THEN
                           CALL Texture("Mountain", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Rock" THEN
                           CALL Texture("Rock", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Tree" THEN
                           CALL Texture("Tree", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Water1" THEN
                           CALL Texture("Water1", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Forest" THEN
                           CALL Texture("Forest", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Chest" OR room$(x%, y%) = "Echest" THEN
                           CALL Texture("Block", x% * 32, y% * 32)
                        END IF
                        x% = x% + 1
                WEND
                x% = 1
                y% = y% + 1
        WEND
        y% = 1
        r% = 1
        CLOSE #1
END SUB

SUB room7 (room$())
        SHARED r%
        x% = 1
        y% = 1
        x1% = 1
        y1% = 1
        z% = 1
        OPEN "C:\rooms\room7.txt" FOR RANDOM AS #1
        'If the room needs to be reset
        IF r% = 1 THEN
            WHILE y1% <= 7
               WHILE x1% <= 10
                  GET #1, z%, room$(x1%, y1%)
                  x1% = x1% + 1
                  z% = z% + 1
               WEND
               x1% = 1
               y1% = y1% + 1
            WEND
        END IF
        LINE (0, 0)-(320, 200), 66, BF

        WHILE y% <= 7
                key$ = INKEY$
                key$ = LCASE$(key$)
                IF key$ = "q" THEN
                        END
                END IF
                WHILE x% <= 10
                        key$ = INKEY$
                        key$ = LCASE$(key$)
                        IF key$ = "q" THEN
                                END
                        END IF
                        IF room$(x%, y%) = "Mountain" THEN
                           CALL Texture("Mountain", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Block" THEN
                           CALL Texture("Block", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Rock" THEN
                           CALL Texture("Rock", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Tree" THEN
                           CALL Texture("Tree", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Water1" THEN
                           CALL Texture("Water1", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Forest" THEN
                           CALL Texture("Forest", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Chest" OR room$(x%, y%) = "Echest" THEN
                           CALL Texture("Block", x% * 32, y% * 32)
                        END IF
                        x% = x% + 1
                WEND
                x% = 1
                y% = y% + 1
        WEND
        y% = 1
        r% = 1
        CLOSE #1
END SUB

SUB room8 (room$())
        SHARED r%
        x% = 1
        y% = 1
        x1% = 1
        y1% = 1
        z% = 1
        OPEN "C:\rooms\room8.txt" FOR RANDOM AS #1
        'if a reset is neccessary
        IF r% = 1 THEN
            WHILE y1% <= 7
               WHILE x1% <= 10
                  GET #1, z%, room$(x1%, y1%)
                  x1% = x1% + 1
                  z% = z% + 1
               WEND
               x1% = 1
               y1% = y1% + 1
            WEND
        END IF

        LINE (0, 0)-(320, 200), 66, BF

        WHILE y% <= 7
                key$ = INKEY$
                key$ = LCASE$(key$)
                IF key$ = "q" THEN
                        END
                END IF
                WHILE x% <= 10
                        key$ = INKEY$
                        key$ = LCASE$(key$)
                        IF key$ = "q" THEN
                                END
                        END IF
                        IF room$(x%, y%) = "Mountain" THEN
                           CALL Texture("Mountain", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Rock" THEN
                           CALL Texture("Rock", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Tree" THEN
                           CALL Texture("Tree", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Water1" THEN
                           CALL Texture("Water1", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Forest" THEN
                           CALL Texture("Forest", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Chest" OR room$(x%, y%) = "Echest" THEN
                           CALL Texture("Block", x% * 32, y% * 32)
                        END IF
                        x% = x% + 1
                WEND
                x% = 1
                y% = y% + 1
        WEND
        y% = 1
        CLOSE #1
END SUB

SUB room9 (room$())
        SHARED r%
        x% = 1
        y% = 1
        x1% = 1
        y1% = 1
        z% = 1
        OPEN "C:\rooms\room9.txt" FOR RANDOM AS #1
        IF r% = 1 THEN
            WHILE y1% <= 7
               WHILE x1% <= 10
                  GET #1, z%, room$(x1%, y1%)
                  x1% = x1% + 1
                  z% = z% + 1
               WEND
               x1% = 1
               y1% = y1% + 1
            WEND
        END IF

        LINE (0, 0)-(320, 200), 66, BF

        WHILE y% <= 7
                key$ = INKEY$
                key$ = LCASE$(key$)
                IF key$ = "q" THEN
                        END
                END IF
                WHILE x% <= 10
                        key$ = INKEY$
                        key$ = LCASE$(key$)
                        IF key$ = "q" THEN
                                END
                        END IF
                        IF room$(x%, y%) = "Mountain" THEN
                           CALL Texture("Mountain", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Rock" THEN
                           CALL Texture("Rock", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Tree" THEN
                           CALL Texture("Tree", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Water1" THEN
                           CALL Texture("Water1", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Forest" THEN
                           CALL Texture("Forest", x% * 32, y% * 32)
                        ELSEIF room$(x%, y%) = "Chest" OR room$(x%, y%) = "Echest" THEN
                           CALL Texture("Block", x% * 32, y% * 32)
                        END IF
                        x% = x% + 1
                WEND
                x% = 1
                y% = y% + 1
        WEND
        y% = 1
        CLOSE #1
END SUB

SUB rooms
        SHARED rl%(), room$(), rx%, ry%, bx%, by%
       
        'Map first row
        rl%(1, 1) = 1
        rl%(2, 1) = 2
        rl%(3, 1) = 3
        rl%(4, 1) = 4
        'Map second row
        rl%(1, 2) = 7
        rl%(2, 2) = 8
        rl%(3, 2) = 9
        rl%(4, 2) = 10
        'Map third row
        rl%(1, 3) = 13
        rl%(2, 3) = 14
        rl%(3, 3) = 15
        rl%(4, 3) = 16
        'Map fourth row
        rl%(0, 4) = 9001
        rl%(1, 4) = 19
        rl%(2, 4) = 20
        rl%(3, 4) = 21
        rl%(4, 4) = 22
        'Map fifth row
        rl%(1, 5) = 25
        rl%(2, 5) = 26
        rl%(3, 5) = 27
        rl%(4, 5) = 28
        'Map sixth row
        rl%(1, 6) = 31
        rl%(2, 6) = 32
        rl%(3, 6) = 33
        rl%(4, 6) = 34

        IF rl%(rx%, ry%) = 1 THEN
            CALL Room1(room$())
            bx% = 6
            by% = 4
        ELSEIF rl%(rx%, ry%) = 2 THEN
            CALL Room2(room$())
        ELSEIF rl%(rx%, ry%) = 3 THEN
            CALL room3(room$())
        ELSEIF rl%(rx%, ry%) = 7 THEN
            CALL room7(room$())
        ELSEIF rl%(rx%, ry%) = 8 THEN
            CALL room8(room$())
        ELSEIF rl%(rx%, ry%) = 9 THEN
            CALL room9(room$())
        ELSEIF rl%(rx%, ry%) = 10 THEN
            CALL room10(room$())
        ELSEIF rl%(rx%, ry%) = 13 THEN
            CALL room13(room$())
        ELSEIF rl%(rx%, ry%) = 14 THEN
            CALL room14(room$())
        ELSEIF rl%(rx%, ry%) = 15 THEN
            CALL room15(room$())
        ELSEIF rl%(rx%, ry%) = 16 THEN
            CALL room16(room$())
        ELSEIF rl%(rx%, ry%) = 19 THEN
            CALL room19(room$())
        ELSEIF rl%(rx%, ry%) = 20 THEN
            CALL room20(room$())
        ELSEIF rl%(rx%, ry%) = 21 THEN
            CALL room21(room$())
        ELSEIF rl%(rx%, ry%) = 22 THEN
            CALL room22(room$())
        ELSEIF rl%(rx%, ry%) = 25 THEN
            CALL room25(room$())
        ELSEIF rl%(rx%, ry%) = 26 THEN
            CALL room26(room$())
        ELSEIF rl%(rx%, ry%) = 27 THEN
            CALL room27(room$())
        ELSEIF rl%(rx%, ry%) = 28 THEN
            CALL room28(room$())
        ELSEIF rl%(rx%, ry%) = 31 THEN
            CALL room31(room$())
        ELSEIF rl%(rx%, ry%) = 32 THEN
            CALL room32(room$())
        ELSEIF rl%(rx%, ry%) = 33 THEN
            CALL room33(room$())
        ELSEIF rl%(rx%, ry%) = 9001 THEN
            CALL text
        END IF

END SUB

SUB text
        CLS
        SHARED rx%, ry%, room$()
        LOCATE 18, 1
        LINE (0, 275)-(320, 240), 0, BF
        IF rx% = 1 AND ry% = 1 THEN
                PRINT "Welcome to the legend of M"
                PRINT "Allow me to you get started."
                DO
                        key$ = INKEY$
                LOOP UNTIL key$ = " "
                CLS
                LOCATE 18, 1
                PRINT "You may grab onto a rock by pressing 'g'"
                PRINT "Pressing it again will release it."
                PRINT "You may pull rocks, but not push them."
                PRINT "You may open a chest with the space bar."
                DO
                  key$ = INKEY$
                LOOP UNTIL key$ <> ""
                CLS
                LOCATE 18, 1
                PRINT "It may start out easy, but it won't"
                PRINT "remain that way for long."
                PRINT "Move that rock to proceed."
                DO
                        key$ = INKEY$
                LOOP UNTIL key$ = " "
                CALL Room1(room$())
        ELSEIF rx% = 0 AND ry% = 4 THEN
                CLS
                LOCATE 12, 8
                PRINT "Congratulations! You've won!"
                LOCATE 15, 8
                PRINT "You managed to find your way"
                LOCATE 16, 10
                PRINT "through the game!"
                DO
                  key$ = INKEY$
                LOOP UNTIL key$ <> ""
                CLS
                LOCATE 12, 8
                PRINT "I hope you enjoyed your romp."
                DO
                  key$ = INKEY$
                LOOP UNTIL key$ <> ""
                CLS
                LOCATE 12, 8
                PRINT "What is this? A wild princess appears!"
                DO
                  key$ = INKEY$
                LOOP UNTIL key$ <> ""
                CLS
                LOCATE 12, 11
                PRINT "You use Powerglove!"
                LOCATE 14, 9
                PRINT "..It's super effective!"
                LOCATE 15, 9
                PRINT "I love the powerglove! It's soo bad!"
                DO
                  key$ = INKEY$
                LOOP UNTIL key$ <> ""
                CLS
                LOCATE 11, 15
                PRINT "The End."
                END
        END IF

END SUB

SUB Texture (textid$, x1%, y1%)
        SHARED wmap%(), cmap%(), blmap%(), fmap%(), rmap%(), mmap%(), tmap%()
        DIM current%(1 TO 32, 1 TO 32)
        x% = 1
        y% = 1
        x2% = 1
        y2% = 1
        IF textid$ = "Forest" THEN
           WHILE y2% <= 32
               WHILE x2% <= 32
                  current%(x2%, y2%) = fmap%(x2%, y2%)
                  x2% = x2% + 1
               WEND
               x2% = 1
               y2% = y2% + 1
           WEND
           y2% = 1
        ELSEIF textid$ = "Chest" THEN
            WHILE y2% <= 32
               WHILE x2% <= 32
                  current%(x2%, y2%) = cmap%(x2%, y2%)
                  x2% = x2% + 1
               WEND
               x2% = 1
               y2% = y2% + 1
            WEND
            y2% = 1
        ELSEIF textid$ = "Mountain" THEN
            WHILE y2% <= 32
               WHILE x2% <= 32
                  current%(x2%, y2%) = mmap%(x2%, y2%)
                  x2% = x2% + 1
               WEND
               x2% = 1
               y2% = y2% + 1
            WEND
            tamxy% = 1
        ELSEIF textid$ = "Tree" THEN
            WHILE y2% <= 32
               WHILE x2% <= 32
                  current%(x2%, y2%) = tmap%(x2%, y2%)
                  x2% = x2% + 1
               WEND
               x2% = 1
               y2% = y2% + 1
            WEND
            y2% = 1
        ELSEIF textid$ = "Rock" THEN
            WHILE y2% <= 32
               WHILE x2% <= 32
                  current%(x2%, y2%) = rmap%(x2%, y2%)
                  x2% = x2% + 1
               WEND
               x2% = 1
               y2% = y2% + 1
            WEND
            y2% = 1
        ELSEIF textid$ = "Water1" THEN
            WHILE y2% <= 32
               WHILE x2% <= 32
                  current%(x2%, y2%) = wmap%(x2%, y2%)
                  x2% = x2% + 1
               WEND
               x2% = 1
               y2% = y2% + 1
            WEND
            y2% = 1
        ELSEIF textid$ = "Block" THEN
            WHILE y2% <= 32
               WHILE x2% <= 32
                  current%(x2%, y2%) = blmap%(x2%, y2%)
                  x2% = x2% + 1
               WEND
               x2% = 1
               y2% = y2% + 1
            WEND
            y2% = 1
        END IF

        WHILE y% <= 32
                WHILE x% <= 32
                        PSET (x1% - 32, y1% - 32), current%(x%, y%)
                        x% = x% + 1
                        x1% = x1% + 1
                WEND
                x% = 1
                x1% = x1% - 32
                y% = y% + 1
                y1% = y1% + 1
        WEND
        y1% = y1% - 32

END SUB

SUB Textureload
        SHARED Gmap%(), Tomap%(), Bomap%(), Flmap%(), blmap%(), fmap%(), rmap%(), tmap%(), mmap%(), wmap%(), cmap%()

        OPEN "C:\img\Forest.txt" FOR RANDOM AS #1
        OPEN "C:\img\Rock.txt" FOR RANDOM AS #2
        OPEN "C:\img\Tree.txt" FOR RANDOM AS #3
        OPEN "C:\img\MOUNTAIN.TXT" FOR RANDOM AS #4
        OPEN "C:\img\Water.txt" FOR RANDOM AS #5
        OPEN "C:\img\Chest.txt" FOR RANDOM AS #6
        OPEN "C:\img\Block.txt" FOR RANDOM AS #7

        z% = 3
        y% = 1
        x% = 1

        WHILE y% <= 32
                WHILE x% <= 32
                        GET #1, z%, fmap%(x%, y%)
                        GET #2, z%, rmap%(x%, y%)
                        GET #3, z%, tmap%(x%, y%)
                        GET #4, z%, mmap%(x%, y%)
                        GET #5, z%, wmap%(x%, y%)
                        GET #6, z%, cmap%(x%, y%)
                        GET #7, z%, blmap%(x%, y%)
                        x% = x% + 1
                        z% = z% + 1
                WEND
                x% = 1
                y% = y% + 1
        WEND
        CLOSE #1
        CLOSE #2
        CLOSE #3
        CLOSE #4
        CLOSE #5
        CLOSE #6
        CLOSE #7

        OPEN "C:\img\Glove.txt" FOR RANDOM AS #1
        OPEN "C:\img\Flipper.txt" FOR RANDOM AS #2
        OPEN "C:\img\Torch.txt" FOR RANDOM AS #3
        OPEN "C:\img\Bomb.txt" FOR RANDOM AS #4

        z% = 3
        y% = 1
        x% = 1

        WHILE y% <= 14
                WHILE x% <= 12
                        GET #1, z%, Gmap%(x%, y%)
                        x% = x% + 1
                        z% = z% + 1
                WEND
                x% = 1
                y% = y% + 1
        WEND

        z% = 3
        GET #2, 1, xmax%
        GET #2, 2, ymax%
        y% = 1
        x% = 1
        WHILE y% <= ymax%
                WHILE x% <= xmax%
                        GET #2, z%, Flmap%(x%, y%)
                        x% = x% + 1
                        z% = z% + 1
                WEND
                x% = 1
                y% = y% + 1
        WEND
        z% = 3
        GET #3, 1, xmax%
        GET #3, 2, ymax%
        y% = 1
        x% = 1
        WHILE y% <= ymax%
                WHILE x% <= xmax%
                        GET #3, z%, Tomap%(x%, y%)
                        x% = x% + 1
                        z% = z% + 1
                WEND
                x% = 1
                y% = y% + 1
        WEND
        z% = 3
        GET #4, 1, xmax%
        GET #4, 2, ymax%
        y% = 1
        x% = 1
        WHILE y% <= ymax%
                WHILE x% <= xmax%
                        GET #4, z%, Bomap%(x%, y%)
                        x% = x% + 1
                        z% = z% + 1
                WEND
                x% = 1
                y% = y% + 1
        WEND
        CLOSE #1
        CLOSE #2
        CLOSE #3
        CLOSE #4

END SUB

SUB title
'title box
LINE (0, 0)-(320, 200), 0, BF
LINE (4, 7)-(316, 193), 65, BF
'Shadow
LINE (92, 34)-(232, 34), 0
LINE (92, 34)-(167, 162), 0
LINE (232, 34)-(167, 162), 0
PAINT (97, 35), 0, 0
'Triangle
LINE (90, 32)-(230, 32), 66
LINE (90, 32)-(165, 160), 66
LINE (230, 32)-(165, 160), 66
PAINT (95, 33), 66, 66
LINE (182, 40)-(220, 41), 0, BF
LINE (220, 41)-(165, 150), 0
LINE (164, 150)-(219, 41), 0
LINE (164, 150)-(150, 124), 0
'Sword
LINE (280, 132)-(284, 136), 1, BF
LINE (42, 134)-(281, 135), 15, BF
LINE (40, 136)-(283, 137), 15, BF
LINE (46, 138)-(283, 139), 15, BF
LINE (72, 140)-(283, 141), 15, BF
LINE (72, 136)-(279, 137), 100, BF
LINE (280, 140)-(281, 141), 1, BF
LINE (280, 142)-(283, 145), 1, BF
LINE (284, 130)-(290, 147), 100, BF
LINE (286, 128)-(288, 130), 100, BF
LINE (286, 148)-(292, 151), 100, BF
LINE (288, 152)-(294, 156), 100, BF
LINE (290, 154)-(296, 158), 100, BF
LINE (294, 156)-(306, 160), 100, BF
LINE (304, 154)-(310, 158), 100, BF
LINE (308, 152)-(312, 156), 100, BF
LINE (310, 148)-(314, 154), 100, BF
LINE (312, 130)-(316, 147), 100, BF
LINE (312, 128)-(314, 130), 100, BF
LINE (288, 134)-(311, 141), 100, BF
LINE (288, 134)-(290, 144), 15, BF
LINE (292, 132)-(294, 144), 15, BF
LINE (298, 132)-(300, 144), 15, BF
LINE (304, 132)-(306, 144), 15, BF
LINE (310, 132)-(312, 144), 15, BF
'The Legend Of
LINE (62, 36)-(67, 37), 0, BF
LINE (64, 38)-(65, 45), 0, BF
'H
LINE (70, 36)-(71, 45), 0, BF
LINE (70, 40)-(77, 41), 0, BF
LINE (76, 36)-(77, 45), 0, BF
'E
LINE (80, 36)-(81, 45), 0, BF
LINE (80, 36)-(87, 37), 0, BF
LINE (80, 40)-(85, 41), 0, BF
LINE (80, 44)-(87, 45), 0, BF
'L
LINE (96, 36)-(97, 45), 0, BF
LINE (96, 44)-(103, 45), 0, BF
'E
LINE (106, 36)-(107, 45), 0, BF
LINE (106, 36)-(113, 37), 0, BF
LINE (106, 40)-(110, 41), 0, BF
LINE (106, 44)-(113, 45), 0, BF
'G
LINE (118, 36)-(123, 37), 0, BF
LINE (116, 38)-(117, 45), 0, BF
LINE (116, 44)-(123, 45), 0, BF
LINE (122, 40)-(123, 45), 0, BF
LINE (120, 40)-(121, 41), 0, BF
'E
LINE (126, 36)-(127, 45), 0, BF
LINE (126, 36)-(133, 37), 0, BF
LINE (126, 40)-(131, 41), 0, BF
LINE (126, 44)-(133, 45), 0, BF
'N
LINE (136, 36)-(137, 45), 0, BF
LINE (136, 36)-(141, 37), 0, BF
LINE (142, 38)-(143, 45), 0, BF
'D
LINE (146, 36)-(147, 45), 0, BF
LINE (146, 36)-(151, 37), 0, BF
LINE (146, 44)-(151, 45), 0, BF
LINE (152, 38)-(153, 43), 0, BF
'O
LINE (162, 38)-(163, 43), 0, BF
LINE (164, 36)-(167, 37), 0, BF
LINE (168, 38)-(169, 43), 0, BF
LINE (164, 44)-(167, 45), 0, BF
'F
LINE (173, 36)-(174, 45), 0, BF
LINE (173, 36)-(180, 37), 0, BF
LINE (173, 40)-(178, 41), 0, BF

'M shadow
LINE (120, 55)-(120, 58), 0
LINE (120, 55)-(137, 55), 0
LINE (137, 55)-(137, 58), 0
LINE (137, 58)-(149, 93), 0
LINE (149, 93)-(167, 55), 0
LINE (167, 55)-(174, 55), 0
LINE (174, 55)-(174, 58), 0
LINE (172, 58)-(174, 58), 0
LINE (172, 58)-(172, 103), 0
LINE (172, 103)-(178, 103), 0
LINE (178, 103)-(178, 106), 0
LINE (157, 106)-(178, 106), 0
LINE (157, 106)-(157, 103), 0
LINE (157, 103)-(163, 103), 0
LINE (163, 103)-(163, 71), 0
LINE (167, 65)-(153, 94), 0
LINE (142, 94)-(153, 94), 0
LINE (130, 59)-(142, 94), 0
LINE (130, 59)-(130, 103), 0
LINE (130, 103)-(134, 103), 0
LINE (134, 103)-(134, 106), 0
LINE (124, 106)-(134, 106), 0
LINE (124, 106)-(124, 103), 0
LINE (124, 103)-(126, 103), 0
LINE (126, 103)-(126, 58), 0
LINE (120, 58)-(126, 58), 0
PAINT (121, 57), 0, 0
PAINT (172, 104), 0, 0
'M
LINE (122, 53)-(122, 56), 4
LINE (122, 53)-(139, 53), 4
LINE (139, 53)-(139, 56), 4
LINE (139, 56)-(151, 94), 4
LINE (151, 94)-(165, 53), 4
LINE (165, 53)-(180, 53), 4
LINE (180, 53)-(180, 56), 4
LINE (174, 56)-(180, 56), 4
LINE (174, 56)-(174, 101), 4
LINE (174, 101)-(180, 101), 4
LINE (180, 101)-(180, 104), 4
LINE (159, 104)-(180, 104), 4
LINE (159, 104)-(159, 101), 4
LINE (159, 101)-(165, 101), 4
LINE (165, 101)-(165, 63), 4
LINE (165, 63)-(155, 96), 4
LINE (144, 96)-(155, 96), 4
LINE (132, 61)-(144, 96), 4
LINE (132, 61)-(132, 101), 4
LINE (132, 101)-(136, 101), 4
LINE (136, 101)-(136, 104), 4
LINE (126, 104)-(136, 104), 4
LINE (126, 104)-(126, 101), 4
LINE (126, 101)-(128, 101), 4
LINE (128, 101)-(128, 56), 4
LINE (122, 56)-(128, 56), 4
PAINT (123, 55), 4, 4
DO
        key$ = INKEY$
LOOP UNTIL key$ <> ""
END SUB

SUB torcht (x1%, y1%)
        SHARED Tomap%()

        x% = 1
        y% = 1

        WHILE y% <= 14
                WHILE x% <= 10
                        LINE (x1% - 10, y1% - 12)-(x1% - 13, y1% - 11), Tomap%(x%, y%), BF
                        x% = x% + 1
                        x1% = x1% + 2
                WEND
                x% = 1
                x1% = x1% - 20
                y% = y% + 1
                y1% = y1% + 2
        WEND
        y1% = y1% - 30
END SUB

