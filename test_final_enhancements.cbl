       IDENTIFICATION DIVISION.
       PROGRAM-ID. ENHANCED-COBOL-TEST.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-VARIABLES.
          05 WS-EMPLOYEE-ID    PIC 9(5).
          05 WS-EMPLOYEE-NAME  PIC X(30).
          05 WS-COUNTER        PIC 9(3).
       01 GROUP-A.
          05 FIELD-A-1         PIC X(10).
          05 FIELD-A-2         PIC 9(5).
       01 GROUP-B.
          05 FIELD-A-1         PIC X(10).
          05 FIELD-A-2         PIC 9(5).

       PROCEDURE DIVISION.
       MAIN-LOGIC.
      *    Enhanced CORRESPONDING operations
           ADD CORRESPONDING GROUP-A TO GROUP-B.
           SUBTRACT CORRESPONDING GROUP-B FROM GROUP-A.
           MOVE CORRESPONDING GROUP-A TO GROUP-B.

      *    Enhanced IF statement with THEN/ELSE/END-IF
           IF WS-COUNTER = 1 THEN
               DISPLAY 'Counter is one'
               MOVE 2 TO WS-COUNTER
           ELSE
               DISPLAY 'Counter is not one'
               ADD 1 TO WS-COUNTER
           END-IF.

      *    SQL processing
           EXEC SQL
               SELECT EMPLOYEE_ID, EMPLOYEE_NAME
               INTO :WS-EMPLOYEE-ID, :WS-EMPLOYEE-NAME
               FROM EMPLOYEE_TABLE
               WHERE ACTIVE_FLAG = 'Y'
           END-EXEC.

      *    IMS DLI processing
           EXEC DLI
               GET UNIQUE PCB-EMPLOYEE SEGMENT-IO-AREA
               USING SSA-EMPLOYEE-KEY
           END-EXEC.

      *    CICS processing
           EXEC CICS
               READ DATASET('EMPLOYEE')
               INTO(WS-VARIABLES)
               RIDFLD(WS-EMPLOYEE-ID)
           END-EXEC.

           STOP RUN. 