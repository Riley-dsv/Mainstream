      *> File Reader program for COBOL Legacy Batch
       IDENTIFICATION DIVISION.
       PROGRAM-ID. legacy-batch-transaction-reader.
       AUTHOR. Riley.
              DATE-WRITTEN. 23042026.
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
       01  TRANSACTION-RECORD.
           05     TR-TRANSACTION-ID      PIC X(33).
           05     FILLER                 PIC X(1).
           05     TR-OPERATION-DATE      PIC 9(8).
           05     FILLER                 PIC X(1).
           05     TR-OPERATION-TIME      PIC 9(6).
           05     FILLER                 PIC X(1).
           05     TR-TRANSACTION-TYPE    PIC X(3).
           05     FILLER                 PIC X(1).
      * I could store this using PIC 9(10)V99 but virtual coma can fail
      * the program, moreover I should have use a special display
      * function PIC Z(10).99 and in a COMPUTE instruction it can create
      * problems SOOOOO I will avoid that and stick to 9(12).
           05     TR-AMOUNT              PIC 9(12).
           05     FILLER                 PIC X(1).
           05     TR-CURRENCY            PIC X(3).
           05     FILLER                 PIC X(1).
           05     TR-SENDER-IBAN         PIC X(27).
           05     FILLER                 PIC X(1).
           05     TR-RECEIVER-IBAN       PIC X(27).
           05     FILLER                 PIC X(1).
           05     TR-REFERENCE           PIC X(20).
           05     FILLER                 PIC X(1).
           05     TR-SOURCE-SYSTEM       PIC X(8).
       WORKING-STORAGE SECTION.
       01 WS-EOF       PIC X(1) VALUE 'N'.
       01 WS-FILE-PATH PIC X(255) VALUE
                       "../../sample-data/transactions_legacy.dat".
 
       PROCEDURE DIVISION.
       MAIN-PARA.
           OPEN INPUT TRANSACTION-FILE

           READ TRANSACTION-FILE
              AT END MOVE 'Y' TO WS-EOF
           END-READ

           PERFORM UNTIL WS-EOF = 'Y'
              DISPLAY TR-TRANSACTION-ID
              DISPLAY TR-AMOUNT

              READ TRANSACTION-FILE
                 AT END MOVE 'Y' TO WS-EOF
              END-READ
           END-PERFORM

           CLOSE TRANSACTION-FILE
           STOP RUN.

