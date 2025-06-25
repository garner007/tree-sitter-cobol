       IDENTIFICATION DIVISION.
       PROGRAM-ID. TEST-SQL-IMS.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 EMPLOYEE-ID      PIC 9(5).
       01 EMPLOYEE-NAME    PIC X(30).
       01 SQLCODE          PIC S9(9) COMP.
       01 DB-PCB           PIC X(100).
       01 SEGMENT-IO       PIC X(200).
       01 SSA-AREA         PIC X(50).
       01 MESSAGE-AREA     PIC X(1000).
       01 LENGTH-FIELD     PIC 9(4).

       PROCEDURE DIVISION.
       MAIN-PARA.
      *    SQL STATEMENTS
           EXEC SQL
               SELECT EMPLOYEE_ID, EMPLOYEE_NAME
               INTO :EMPLOYEE-ID, :EMPLOYEE-NAME
               FROM EMPLOYEE
               WHERE EMPLOYEE_ID = 12345
           END-EXEC.

           EXEC SQL
               UPDATE EMPLOYEE
               SET EMPLOYEE_NAME = :EMPLOYEE-NAME
               WHERE EMPLOYEE_ID = :EMPLOYEE-ID
           END-EXEC.

           EXEC SQL
               INSERT INTO EMPLOYEE
               (EMPLOYEE_ID, EMPLOYEE_NAME)
               VALUES (:EMPLOYEE-ID, :EMPLOYEE-NAME)
           END-EXEC.

           EXEC SQL
               COMMIT
           END-EXEC.

      *    IMS DL/I STATEMENTS
           EXEC DLI
               GET UNIQUE DB-PCB SEGMENT-IO
               USING SSA-AREA
           END-EXEC.

           EXEC DLI
               GET NEXT DB-PCB SEGMENT-IO
           END-EXEC.

           EXEC DLI
               INSERT DB-PCB SEGMENT-IO
               USING SSA-AREA
           END-EXEC.

           EXEC DLI
               REPLACE DB-PCB SEGMENT-IO
           END-EXEC.

           EXEC DLI
               DELETE DB-PCB
               USING SSA-AREA
           END-EXEC.

      *    IMS Transaction Processing
           EXEC DLI
               GET MESSAGE MESSAGE-AREA
               LENGTH LENGTH-FIELD
           END-EXEC.

           EXEC DLI
               SEND MESSAGE MESSAGE-AREA EMPLOYEE-ID
               LENGTH LENGTH-FIELD
           END-EXEC.

      *    IMS Checkpoint/Restart
           EXEC DLI
               CHECKPOINT EMPLOYEE-ID
               AREAS SEGMENT-IO
           END-EXEC.

           EXEC DLI
               RESTART EMPLOYEE-ID
               AREAS SEGMENT-IO
           END-EXEC.

           EXEC DLI
               ROLLBACK EMPLOYEE-ID
           END-EXEC.

      *    CICS STATEMENTS
           EXEC CICS
               READ DATASET('EMPLOYEE')
               INTO(SEGMENT-IO)
               RIDFLD(EMPLOYEE-ID)
           END-EXEC.

           EXEC CICS
               WRITE DATASET('EMPLOYEE')
               FROM(SEGMENT-IO)
               RIDFLD(EMPLOYEE-ID)
           END-EXEC.

           STOP RUN. 