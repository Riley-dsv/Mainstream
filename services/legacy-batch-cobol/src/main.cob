       IDENTIFICATION DIVISION.
       PROGRAM-ID. main-cobol-orchestrator.
       AUTHOR. Riley.
              DATE-WRITTEN. 24042026. 
       DATE-MODIFIED. 24042026.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-READER-STATUS PIC 9(1)  VALUE 0.
       01 WS-WRITER-STATUS PIC 9(1)  VALUE 0.
       01 WS-ENTRY-READ    PIC 9(10) VALUE 0.
       01 WS-ENTRY-WRITTEN PIC 9(10) VALUE 0.
       COPY "transaction-copybook".
       PROCEDURE DIVISION.
       000-MAIN.
           DISPLAY "Starting main loop"
           PERFORM UNTIL WS-READER-STATUS = 1
              DISPLAY "Calling reader..."
              CALL "batch-transaction-reader" USING TRANSACTION-RECORD
              DISPLAY "Reader RETURN-CODE: " RETURN-CODE
              MOVE RETURN-CODE TO WS-READER-STATUS
              DISPLAY "WS-READER-STATUS: " WS-READER-STATUS
              COMPUTE WS-ENTRY-READ = WS-ENTRY-READ + 1 
              IF WS-READER-STATUS = 0
                 DISPLAY "Calling formatter..."
                 CALL "report-trans-generator" USING TRANSACTION-RECORD
                 DISPLAY "Formatter RETURN-CODE: " RETURN-CODE
                 MOVE RETURN-CODE TO WS-WRITER-STATUS
                 IF WS-WRITER-STATUS = 1
                    DISPLAY "Error in transaction-formatter.cob"
                 ELSE
                    COMPUTE WS-ENTRY-WRITTEN = WS-ENTRY-WRITTEN + 1
                 END-IF
              END-IF
           END-PERFORM
           DISPLAY "Loop ended"
           CALL 'insight-report-generator' 
                USING BY CONTENT WS-ENTRY-READ 
                BY CONTENT WS-ENTRY-WRITTEN
           MOVE RETURN-CODE TO WS-READER-STATUS
           IF WS-WRITER-STATUS = 1
              DISPLAY "Error while reading final report"
           END-IF
           STOP RUN.
