       identification division.
       program-id. comprehensive-paragraphs.
       data division.
       working-storage section.
       01  ws-counter      pic 9(3) value zero.
       01  ws-total        pic 9(5) value zero.
       procedure division.
       main-000.
           display "Starting program"
           perform main-010 thru main-030
           stop run.
       main-010.
           move 1 to ws-counter
           display "Counter: " ws-counter.
       main-020.
           add ws-counter to ws-total
           add 1 to ws-counter.
       main-030.
           display "Total: " ws-total
           continue.