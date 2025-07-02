       identification division.
       program-id. test-procedure.
       
       procedure division.
       main-section.
           perform 5 times
               display "Loop iteration"
           end-perform.
           
           perform until ws-counter > 10
               add 1 to ws-counter
           end-perform.
           
           perform varying i from 1 by 1 until i > 5
               display "Varying loop: " i
           end-perform.
           
           stop run.