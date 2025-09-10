       identification division.
       program-id. test-both-formats.
       
       procedure division.
      *> Proper COBOL formatting (Area A paragraphs, Area B statements)
       main-section.
           display "Proper COBOL formatting"
           perform sub-para-1
           perform sub-para-2
           stop run.
       
       sub-para-1.
           display "Subparagraph 1".
           
       sub-para-2.
           display "Subparagraph 2"
           continue.