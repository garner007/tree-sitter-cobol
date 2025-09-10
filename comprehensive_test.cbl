       identification division.
       program-id. comprehensive-test.
       
       environment division.
       configuration section.
       source-computer. linux.
       object-computer. linux.
       
       input-output section.
       file-control.
           select employee-file assign to "employee.dat"
               organization is sequential
               access mode is sequential.
       
       data division.
       file section.
       fd  employee-file.
       01  employee-record.
           05  emp-id          pic 9(5).
           05  emp-name        pic x(30).
           05  emp-salary      pic 9(7)v99.
           05  emp-department  pic x(15).
       
       working-storage section.
       01  work-variables.
           05  ws-counter      pic 9(3) value zero.
           05  ws-total        pic 9(9)v99 value zero.
           05  ws-average      pic 9(7)v99 value zero.
           05  ws-flag         pic x value 'N'.
           05  ws-temp         pic x(50).
           05  ws-index        pic 9(3).
           05  ws-result       pic 9(5).
       
       01  constants.
           05  max-employees   pic 9(3) value 100.
           05  min-salary      pic 9(7)v99 value 25000.00.
       
       procedure division.
       
       main-000.
           display "Starting comprehensive COBOL test program".
           
       main-001.
           open input employee-file.
           
       main-002.
           initialize work-variables.
           
       main-003.
           move zero to ws-counter ws-total.
           
       main-004.
           perform main-010 thru main-015.
           
       main-005.
           if ws-counter > zero
               compute ws-average = ws-total / ws-counter
           else
               move zero to ws-average
           end-if.
           
       main-006.
           perform varying ws-index from 1 by 1 
               until ws-index > 10
               display "Processing index: " ws-index
           end-perform.
           
       main-007.
           perform 5 times
               add 1 to ws-counter
               display "Loop iteration: " ws-counter
           end-perform.
           
       main-008.
           perform until ws-flag = 'Y'
               accept ws-temp from console
               if ws-temp = "EXIT"
                   move 'Y' to ws-flag
               end-if
           end-perform.
           
       main-009.
           close employee-file.
           
       main-010.
           read employee-file
               at end
                   move 'Y' to ws-flag
               not at end
                   perform main-020
           end-read.
           
       main-011.
           add emp-salary to ws-total.
           
       main-012.
           add 1 to ws-counter.
           
       main-013.
           if emp-salary < min-salary
               display "Low salary employee: " emp-name
           end-if.
           
       main-014.
           string emp-id delimited by size
               " - " delimited by size
               emp-name delimited by space
               into ws-temp
           end-string.
           
       main-015.
           go to main-010.
           
       main-016.
           evaluate emp-department
               when "SALES"
                   add 1000 to emp-salary
               when "MARKETING"
                   add 800 to emp-salary
               when "IT"
                   add 1200 to emp-salary
               when other
                   add 500 to emp-salary
           end-evaluate.
           
       main-017.
           search ws-temp varying ws-index
               at end
                   move zero to ws-result
               when ws-temp(ws-index:1) = "A"
                   move ws-index to ws-result
           end-search.
           
       main-018.
           sort employee-file
               ascending key emp-salary
               using employee-file
               giving employee-file.
           
       main-019.
           call "SUBPROGRAM" using emp-record ws-result.
           
       main-020.
           inspect emp-name replacing all spaces by "-".
           
       main-021.
           unstring emp-name delimited by "-"
               into ws-temp(1:15) ws-temp(16:15).
           
       main-022.
           multiply emp-salary by 1.05 giving emp-salary
               on size error
                   display "Salary calculation overflow"
               not on size error
                   display "Salary updated successfully"
           end-multiply.
           
       main-023.
           divide ws-total by ws-counter giving ws-average
               remainder ws-result
               on size error
                   display "Division error occurred"
           end-divide.
           
       main-024.
           subtract 500 from emp-salary
               on size error
                   display "Subtraction overflow"
           end-subtract.
           
       main-025.
           write employee-record
               invalid key
                   display "Write failed for: " emp-id
               not invalid key
                   display "Record written successfully"
           end-write.
           
       main-026.
           rewrite employee-record
               invalid key
                   display "Rewrite failed"
           end-rewrite.
           
       main-027.
           delete employee-file record
               invalid key
                   display "Delete failed"
           end-delete.
           
       main-028.
           start employee-file
               key is equal to emp-id
               invalid key
                   display "Start position not found"
           end-start.
           
       main-029.
           continue.
           
       main-030.
           stop run.