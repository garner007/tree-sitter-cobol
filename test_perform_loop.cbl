       identification division.
       program-id. test-perform.
       data division.
       working-storage section.
       01 c PIC 9.
       01 i PIC 9.
       procedure division.
       perform forever
         continue
       end-perform.
       perform 5 times
         continue
       end-perform.
       perform until c > 5
         add 1 to c
       end-perform.
       perform varying i from 1 by 1 until i > 3
         display i
       end-perform.
       stop run.