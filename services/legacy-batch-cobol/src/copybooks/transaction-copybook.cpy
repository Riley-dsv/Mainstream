      * Transaction Record Data format.
       01  TRANSACTION-RECORD.
           05     TR-TRANSACTION-ID      PIC X(32).
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
           05     FILLER                 PIC X(2).
