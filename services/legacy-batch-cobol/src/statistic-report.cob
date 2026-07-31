      *> Statistic report generator to have actual insight of what
      * happened 
       IDENTIFICATION DIVISION.
       PROGRAM-ID. insight-report-generator.
       AUTHOR. Riley.
              DATE-WRITTEN. 02052026.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT FORMATTED-REPORT-FILE
                  ASSIGN TO WS-FILE-PATH 
                  ORGANIZATION IS LINE SEQUENTIAL
                  FILE STATUS IS WS-FILE-STATUS.
       DATA DIVISION.
       FILE SECTION.
       FD FORMATTED-REPORT-FILE.
       01 FS-REPORT-LINE PIC X(90).
       WORKING-STORAGE SECTION.
       01 WS-FILE-PATH   PIC X(255) VALUE
                         "../_output/statistics_report.rpts".
       01 WS-FILE-STATUS PIC X(2). 
       LINKAGE SECTION.
       01 LK-TOTAL-READ    PIC 9(10).
       01 LK-TOTAL-WRITTEN PIC 9(10).
       PROCEDURE DIVISION USING LK-TOTAL-READ LK-TOTAL-WRITTEN.
       000-MAIN.
           PERFORM 100-INIT
           PERFORM 200-WRITE
           PERFORM 300-CLEANUP
           GOBACK.
       100-INIT.
           OPEN EXTEND FORMATTED-REPORT-FILE
           PERFORM 400-LOG-ERROR.
       200-WRITE.
           MOVE SPACES TO FS-REPORT-LINE

           STRING "Total-written=" DELIMITED SIZE
                  LK-TOTAL-READ DELIMITED SPACE
                  INTO FS-REPORT-LINE
           WRITE FS-REPORT-LINE 
           PERFORM 400-LOG-ERROR

           MOVE SPACES TO FS-REPORT-LINE
           STRING "Total-read=" DELIMITED SIZE
                  LK-TOTAL-READ DELIMITED SPACE
                  INTO FS-REPORT-LINE
           WRITE FS-REPORT-LINE
           PERFORM 400-LOG-ERROR
           MOVE SPACES TO FS-REPORT-LINE.

       300-CLEANUP.
           CLOSE FORMATTED-REPORT-FILE.
       400-LOG-ERROR.
           IF WS-FILE-STATUS NOT = "00"
              DISPLAY "Error opening report file: " WS-FILE-STATUS
              MOVE 1 TO RETURN-CODE
              PERFORM 300-CLEANUP
              GOBACK
           END-IF.
