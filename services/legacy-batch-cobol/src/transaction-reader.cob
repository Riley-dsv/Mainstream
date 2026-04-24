      *> File Reader program for COBOL Legacy Batch
       IDENTIFICATION DIVISION.
       PROGRAM-ID. legacy-batch-transaction-reader.
       AUTHOR. Riley.
              DATE-WRITTEN. 23042026.
       DATE-MODIFIED. 24042026.
              DATE-COMPILED. 23042026.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT TRANSACTION-FILE
                  ASSIGN TO WS-FILE-PATH 
                  ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD TRANSACTION-FILE.    
       COPY "transaction-copybook". 
       WORKING-STORAGE SECTION.
       01 WS-EOF       PIC X(1) VALUE 'N'.
       01 WS-FILE-PATH PIC X(255) VALUE
                       "../../sample-data/transactions_legacy.dat".
       PROCEDURE DIVISION.
      *> I learnt that this was the way we used to name function back
      *then
       000-MAIN.
           PERFORM 100-INIT
           PERFORM 200-PROCESS
           PERFORM 300-CLEANUP
           STOP RUN.

       100-INIT.
      *> Same as fopen("filename", "r")
           OPEN INPUT TRANSACTION-FILE.

       200-PROCESS.
      *> priming read pattern .
      *> Quite common in COBOL : Read once to have something in the
      *buffer before going in PERFORM. 
      *> If the file is empty, AT END is triggered and we never reach the
      *PEROFRM loop. 
           READ TRANSACTION-FILE
              AT END MOVE 'Y' TO WS-EOF
           END-READ

           PERFORM UNTIL WS-EOF = 'Y'
              DISPLAY TR-TRANSACTION-ID
              DISPLAY TR-AMOUNT

              READ TRANSACTION-FILE
                 AT END MOVE 'Y' TO WS-EOF
              END-READ
           END-PERFORM.

       300-CLEANUP.
           CLOSE TRANSACTION-FILE.


