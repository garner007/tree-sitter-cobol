       IDENTIFICATION DIVISION.
       PROGRAM-ID. TEST-ENHANCEMENTS.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 GROUP-1.
          05 FIELD-A PIC X(10).
          05 FIELD-B PIC 9(5).
       01 GROUP-2.
          05 FIELD-A PIC X(10).
          05 FIELD-B PIC 9(5).
       01 TEST-VAR PIC 9.

       PROCEDURE DIVISION.
       MAIN-PARA.
           ADD CORRESPONDING GROUP-1 TO GROUP-2.
           SUBTRACT CORRESPONDING GROUP-2 FROM GROUP-1.
           MOVE CORRESPONDING GROUP-1 TO GROUP-2.
           
           IF TEST-VAR = 1 THEN
               DISPLAY 'Equal to one'
           ELSE
               DISPLAY 'Not equal to one'
           END-IF.
           
           EXEC SQL
               SELECT EMPLOYEE_ID
               FROM EMPLOYEE
               WHERE EMPLOYEE_NAME = 'SMITH'
           END-EXEC.
           
           STOP RUN. 