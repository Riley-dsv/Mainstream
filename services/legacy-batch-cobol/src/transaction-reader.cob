      *> File Reader program for COBOL Legacy Batch
       IDENTIFICATION DIVISION.
       PROGRAM-ID. batch-transaction-reader.
       AUTHOR. Riley.
              DATE-WRITTEN. 23042026.
       DATE-MODIFIED. 25042026.
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
       01 WS-FILE-OPEN PIC X(1) VALUE 'N'.
       01 WS-FILE-PATH PIC X(255) VALUE
                       "../../../sample-data/transactions_legacy.dat".
       LINKAGE SECTION.
       COPY "transaction-copybook"
            REPLACING TRANSACTION-RECORD BY LK-TRANSACTION-RECORD.
       PROCEDURE DIVISION USING LK-TRANSACTION-RECORD.
      *> I learnt that this was the way we used to name function back
      *then
       000-MAIN.
           PERFORM 100-INIT
           PERFORM 200-READ.

       100-INIT.
      *> Same as fopen("filename", "r")
           IF WS-FILE-OPEN = 'N'
              OPEN INPUT TRANSACTION-FILE
              MOVE 'Y' TO WS-FILE-OPEN
           END-IF.

       200-READ.
           READ TRANSACTION-FILE
              AT END
                 PERFORM 300-CLEANUP
                 MOVE 1 TO RETURN-CODE
              NOT AT END
                 MOVE TRANSACTION-RECORD TO LK-TRANSACTION-RECORD
                 MOVE 0 TO RETURN-CODE
           END-READ
           GOBACK.

       300-CLEANUP.
           CLOSE TRANSACTION-FILE.


