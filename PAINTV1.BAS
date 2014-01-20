DECLARE SUB pal ()
DECLARE SUB Paste (image$)
DECLARE SUB Load (image$)
DECLARE SUB Save ()
DECLARE SUB newimg ()

DIM tint%(1 TO 11, 1 TO 6)

pale% = 0
x% = 1
y% = 1
xmax% = 1
ymax% = 1
px% = 236
py% = 20
pnx% = 1
pny% = 1
pcolor% = 0
pcolor2% = 15

SCREEN 13

PRINT "This is a title screen!"
DO
   INPUT "What would you like to do?", choice$
   choice$ = LCASE$(choice$)
LOOP UNTIL choice$ = "new" OR choice$ = "load"
CLS
IF choice$ = "new" OR choice$ = "new file" OR choice$ = "new photo" THEN
   'create a new image
   DO
      CLS
      INPUT "How tall and how wide is your canvas?", xmax%, ymax% 'Get the max size of the canvas
      IF xmax% > 38 OR ymax% > 32 THEN
        CLS
        PRINT "Sorry, the max size is 32 x 38"
        DO                                                        ' Show the message until a button is pressed
           key$ = INKEY$
           IF key$ <> "" THEN
                key$ = " "
           END IF
        LOOP UNTIL key$ = " "
     END IF
   LOOP UNTIL xmax% <= 40 AND ymax% <= 32                         'Ensure the canvas is an acceptable size
   DIM canvas%(1 TO xmax%, 1 TO ymax%)                            'define the canvas for use
   CALL newimg
ELSEIF choice$ = "load" THEN
   INPUT "What file would you like to call?", image$
   image$ = "c:\img\" + LCASE$(image$) + ".txt" 'Convert the file name to a pathway
   DIM SHARED canvas%(1, 1)
   CALL Load(image$)
END IF
CALL pal
LINE (273, 71)-(287, 84), pcolor2%, BF
LINE (266, 65)-(280, 78), pcolor%, BF

'Allow them to maneuver
DO
   'If they aren't making a box
   IF box% = 0 THEN
        'IF they do not have the palette selected
        IF pale% = 0 THEN
           DO
              key$ = INKEY$
              IF key$ <> "q" THEN 'check if they want to quit
                 LINE ((x% * 6) - 6, (y% * 6) - 6)-((x% * 6) - 1, (y% * 6) - 1), canvas%(x%, y%), BF'Flicker the selected pixel
                 start! = TIMER
                 DO
                 LOOP UNTIL TIMER - start! >= .13
                 LINE ((x% * 6) - 6, (y% * 6) - 6)-((x% * 6) - 1, (y% * 6) - 1), 14, BF
                 start! = TIMER
                 DO
                 LOOP UNTIL TIMER - start! >= .13
              END IF
           LOOP UNTIL key$ = "O" OR key$ = "b" OR key$ = "f" OR key$ = "c" OR key$ = "p" OR key$ = " " OR key$ = "e" OR key$ = "a" OR key$ = "s" OR key$ = "S" OR key$ = "d" OR key$ = "w" OR key$ = "q"
           IF key$ = "S" THEN 'Save the image
              CALL Save
           ELSEIF key$ = "O" THEN
               CLS
               INPUT "What file would you like to call?", image$
               image$ = "c:\img\" + LCASE$(image$) + ".txt" 'Convert the file name to a pathway
               CALL Load(image$)
           ELSEIF key$ = "f" THEN
              extra% = pcolor%
              pcolor% = pcolor2%
              pcolor2% = extra%
              LINE (273, 71)-(287, 84), pcolor2%, BF
              LINE (266, 65)-(280, 78), pcolor%, BF
           ELSEIF key$ = "c" THEN
              pcolor% = canvas%(x%, y%)
              LINE (266, 65)-(280, 78), pcolor%, BF
           ELSEIF key$ = "p" THEN 'If they want to select the palette
              pale% = 1
           ELSEIF key$ = " " THEN 'If they'd like to paint a pixel
              canvas%(x%, y%) = pcolor%
              LINE ((x% * 6) - 6, (y% * 6) - 6)-((x% * 6) - 1, (y% * 6) - 1), canvas%(x%, y%), BF
           ELSEIF key$ = "b" THEN
              box% = 1
           ELSEIF key$ = "e" THEN 'If they'd like to erase
              canvas%(x%, y%) = 15
              LINE ((x% * 6) - 6, (y% * 6) - 6)-((x% * 6) - 1, (y% * 6) - 1), canvas%(x%, y%), BF
           ELSEIF key$ = "d" THEN                                         'if they want to move right
              IF x% < xmax% THEN                                          'check if there's room ot the right
                 LINE ((x% * 6) - 6, (y% * 6) - 6)-((x% * 6) - 1, (y% * 6) - 1), canvas%(x%, y%), BF
                 x% = x% + 1
              END IF
           ELSEIF key$ = "a" THEN  'if they want to move right
              IF x% > 1 THEN  'check if there's room to the right
                 LINE ((x% * 6) - 6, (y% * 6) - 6)-((x% * 6) - 1, (y% * 6) - 1), canvas%(x%, y%), BF
                 x% = x% - 1
              END IF
           ELSEIF key$ = "s" THEN 'If they want to go down
              IF y% < ymax% THEN  'check if there's room to the bottom
                 LINE ((x% * 6) - 6, (y% * 6) - 6)-((x% * 6) - 1, (y% * 6) - 1), canvas%(x%, y%), BF
                 y% = y% + 1
              END IF
           ELSEIF key$ = "w" THEN 'If they want to go up
              IF y% > 1 THEN  'check if there's room up there
                 LINE ((x% * 6) - 6, (y% * 6) - 6)-((x% * 6) - 1, (y% * 6) - 1), canvas%(x%, y%), BF
                 y% = y% - 1
              END IF
           END IF
        'if they do have the palette selected
        ELSEIF pale% = 1 THEN
           DO
              key$ = INKEY$
              LINE (273, 71)-(287, 84), pcolor2%, BF
              LINE (266, 65)-(280, 78), pcolor%, BF
              IF key$ <> "q" THEN 'check if they want to quit
                 LINE ((x% * 6) - 6, (y% * 6) - 6)-((x% * 6) - 1, (y% * 6) - 1), canvas%(x%, y%), BF'Flicker the selected pixel
                 LINE (px%, py%)-(px% + 6, py% + 6), tint%(pnx%, pny%), BF'Flicker the selected pixel
                 start! = TIMER
                 DO
                 LOOP UNTIL TIMER - start! >= .13
                 LINE ((x% * 6) - 6, (y% * 6) - 6)-((x% * 6) - 1, (y% * 6) - 1), 14, BF
                 LINE (px%, py%)-(px% + 6, py% + 6), 14, BF
                 start! = TIMER
                 DO
                 LOOP UNTIL TIMER - start! >= .13
              END IF
           LOOP UNTIL key$ = "f" OR key$ = "b" OR key$ = "i" OR key$ = " " OR key$ = "a" OR key$ = "s" OR key$ = "d" OR key$ = "w" OR key$ = "q"
           IF key$ = "d" THEN 'If they want the colour to the right
              IF pnx% < 11 THEN
                 LINE (px%, py%)-(px% + 6, py% + 6), tint%(pnx%, pny%), BF
                 pnx% = pnx% + 1
                 px% = px% + 7
                 pcolor% = tint%(pnx%, pny%)
                 LINE (266, 65)-(280, 78), pcolor%, BF
              END IF
           ELSEIF key$ = "a" THEN 'If they'd like to select the colour to the left
              IF pnx% > 1 THEN
                 LINE (px%, py%)-(px% + 6, py% + 6), tint%(pnx%, pny%), BF
                 pnx% = pnx% - 1
                 px% = px% - 7
                 pcolor% = tint%(pnx%, pny%)
                 LINE (266, 65)-(280, 78), pcolor%(pnx%, pny%), BF
              END IF
           ELSEIF key$ = "s" THEN 'If they want the colour down
              IF pny% < 6 THEN
                 LINE (px%, py%)-(px% + 6, py% + 6), tint%(pnx%, pny%), BF
                 pny% = pny% + 1
                 py% = py% + 7
                 pcolor% = tint%(pnx%, pny%)
                 LINE (266, 65)-(280, 78), pcolor%(pnx%, pny%), BF
              END IF
           ELSEIF key$ = "w" THEN 'If they'd like to select the colour up
              IF pny% > 1 THEN
                 LINE (px%, py%)-(px% + 6, py% + 6), tint%(pnx%, pny%), BF
                 pny% = pny% - 1
                 py% = py% - 7
                 pcolor% = tint%(pnx%, pny%)
                 LINE (266, 65)-(280, 78), pcolor%(pnx%, pny%), BF
              END IF
           ELSEIF key$ = "f" THEN
              extra% = pcolor%
              pcolor% = pcolor2%
              pcolor2% = extra%
              LINE (273, 71)-(287, 84), pcolor2%, BF
              LINE (266, 65)-(280, 78), pcolor%, BF
           ELSEIF key$ = "b" THEN
              box% = 1
              LINE (px%, py%)-(px% + 6, py% + 6), tint%(pnx%, pny%), BF
           ELSEIF key$ = "i" THEN
              LINE (px%, py%)-(px% + 6, py% + 6), tint%(pnx%, pny%), BF
              pale% = 0
           END IF
        END IF
   ELSEIF box% = 1 THEN
        DO
           key$ = INKEY$
           IF key$ <> "q" THEN 'check if they want to quit
              LINE ((x% * 6) - 6, (y% * 6) - 6)-((x% * 6) - 1, (y% * 6) - 1), canvas%(x%, y%), BF'Flicker the selected pixel
              start! = TIMER
              DO
              LOOP UNTIL TIMER - start! >= .13
              LINE ((x% * 6) - 6, (y% * 6) - 6)-((x% * 6) - 1, (y% * 6) - 1), 14, BF
              start! = TIMER
              DO
              LOOP UNTIL TIMER - start! >= .13
           END IF
           LOOP UNTIL key$ = " " OR key$ = "S" OR key$ = "a" OR key$ = "s" OR key$ = "d" OR key$ = "w" OR key$ = "q"
           IF key$ = "S" THEN 'Save the image
              CALL Save
           ELSEIF key$ = " " THEN 'If they'd like to select a corner
              IF bco% = 0 THEN  'If they have to place the first box corner
                 bc1x% = x%
                 bc1y% = y%
                 bco% = bco% + 1
              ELSEIF bco% = 1 THEN
                 bc2x% = x%
                 bc2y% = y%
                 FOR i% = 1 TO ABS(bc2y% - bc1y%) + 1
                    WHILE x% >= bc1x%
                       canvas%(x%, y%) = pcolor%
                       LINE ((x% * 6) - 6, (y% * 6) - 6)-((x% * 6) - 1, (y% * 6) - 1), canvas%(x%, y%), BF
                       x% = x% - 1
                    WEND
                    y% = y% - 1
                    x% = bc2x%
                 NEXT i%
                 x% = bc1x%
                 y% = bc1y%
                 bco% = bco% + 1
                 box% = 0
                 bco% = 0
              END IF
           ELSEIF key$ = "d" THEN                                         'if they want to move right
              IF x% < xmax% THEN                                          'check if there's room ot the right
                 LINE ((x% * 6) - 6, (y% * 6) - 6)-((x% * 6) - 1, (y% * 6) - 1), canvas%(x%, y%), BF
                 x% = x% + 1
              END IF
           ELSEIF key$ = "a" THEN  'if they want to move right
              IF x% > 1 THEN  'check if there's room to the right
                 LINE ((x% * 6) - 6, (y% * 6) - 6)-((x% * 6) - 1, (y% * 6) - 1), canvas%(x%, y%), BF
                 x% = x% - 1
              END IF
           ELSEIF key$ = "s" THEN 'If they want to go down
              IF y% < ymax% THEN  'check if there's room to the bottom
                 LINE ((x% * 6) - 6, (y% * 6) - 6)-((x% * 6) - 1, (y% * 6) - 1), canvas%(x%, y%), BF
                 y% = y% + 1
              END IF
           ELSEIF key$ = "w" THEN 'If they want to go up
              IF y% > 1 THEN  'check if there's room up there
                 LINE ((x% * 6) - 6, (y% * 6) - 6)-((x% * 6) - 1, (y% * 6) - 1), canvas%(x%, y%), BF
                 y% = y% - 1
              END IF
           END IF
  
   END IF
LOOP UNTIL key$ = "q"

END

SUB Load (image$)
   CLS
   SHARED canvas%(), xmax%, ymax%, pcolor%, pcolor2%
   OPEN image$ FOR RANDOM AS #1
   z% = 3
   y% = 1
   x% = 1
   GET #1, 1, xmax%
   GET #1, 2, ymax%
   REDIM canvas%(1 TO xmax%, 1 TO ymax%)
   WHILE y% <= ymax%
      WHILE x% <= xmax%
         GET #1, z%, canvas%(x%, y%)
         LINE ((x% * 6) - 6, (y% * 6) - 6)-(x% * 6, y% * 6), canvas%(x%, y%), BF
         x% = x% + 1
         z% = z% + 1
      WEND
      x% = 1
      y% = y% + 1
   WEND
   CLOSE #1
   CALL pal
   LINE (273, 71)-(287, 84), pcolor2%, BF
   LINE (266, 65)-(280, 78), pcolor%, BF
END SUB

SUB newimg
   x% = 1
   y% = 1
   CLS
   SHARED xmax%, ymax%, canvas%()
   LINE (0, 0)-((xmax% * 6) - 1, (ymax% * 6) - 1), 15, BF
   
   WHILE y% <= ymax%                      'Fill in the canvas array with white
      WHILE x% <= xmax%
         canvas%(x%, y%) = 15
         x% = x% + 1
      WEND
      y% = y% + 1
      x% = 1
   WEND
END SUB

SUB pal
   SHARED tint%()
   tx% = 1
   ty% = 1
   col% = 16
   num% = 1
   x% = 236
   y% = 20
   WHILE col% <= 79
      WHILE x% < 311
         LINE (x%, y%)-(x% + 6, y% + 6), col%, BF
         tint%(tx%, ty%) = col%
         tx% = tx% + 1
         x% = x% + 7
         col% = col% + 1
      WEND
      tx% = 1
      ty% = ty% + 1
      x% = 236
      y% = y% + 7
   WEND
END SUB

SUB Save
   SHARED canvas%(), xmax%, ymax%, pcolor%, pcolor2%
   CLS
   INPUT "What do you want to save the file as?", image$
   image$ = "C:\img\" + image$ + ".txt"
   OPEN image$ FOR RANDOM AS #1
   z% = 3
   y% = 1
   x% = 1
   PUT #1, 1, xmax%
   PUT #1, 2, ymax%
   WHILE y% <= ymax%
      WHILE x% <= xmax%
         PUT #1, z%, canvas%(x%, y%)
         x% = x% + 1
         z% = z% + 1
      WEND
      y% = y% + 1
      x% = 1
   WEND
   CLOSE #1
   CLS
   CALL pal
   LINE (273, 71)-(287, 84), pcolor2%, BF
   LINE (266, 65)-(280, 78), pcolor%, BF
   sy% = 1
   sx% = 1
   WHILE sy% <= ymax%
      WHILE sx% <= xmax%
         LINE ((sx% * 6) - 6, (sy% * 6) - 6)-(sx% * 6, sy% * 6), canvas%(sx%, sy%), BF
         sx% = sx% + 1
      WEND
      sx% = 1
      sy% = sy% + 1
   WEND
END SUB

