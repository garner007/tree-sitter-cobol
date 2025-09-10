       identification division.
       program-id. test-sections.
       procedure division.
       main-section section.
       para-001.
           display "First paragraph"
           perform para-002
           go to para-003.
       para-002.
           move 1 to ws-counter.
       para-003.
           add 1 to ws-counter
           stop run.