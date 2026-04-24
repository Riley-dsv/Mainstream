# Polyglot Financial Pipeline

A small distributed platform simulating financial transaction processing across a legacy COBOL batch system and modern event-driven services.

## Stack
- COBOL
- Kafka
- Scala
- Java / Spring Boot
- PostgreSQL
- Elixir / Phoenix LiveView

## Architecture
                                                                                                                                                                                                                                                              + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -+
                                                                                                                                                                                                                                                              '                                    Modern Service Layer                                    '
                                                                                                                                                                                                                                                              '                                                                                            '
                                                                                                                                                                                                                                                              '                                  HTTP REST requests                                        '
                                                                                                                                                                                                                                                              '   +-------------------------------------------------------+                                '
                                                                                                                                                                                                                                                              '   |                                                       |                                '
+ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -+                         +- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +             '   |                                                       |                                '
'                                  Legacy Boundary                                           '                         '                                       Event-Driven Core                                                                '             '   |                                                       |                                '
'                                                                                            '                         '                                                                                                                        '             '   v                                                       |                                '
' +------------------------------+                 +---------------------------------------+ '                         ' +------------------+             +--------------------------+                               +------------------------+ '             ' +------------------------------+                        +--------------------------------+ '
' |    Input Transaction File    |  reads          |              COBOL Batch              | '  publishes raw events   ' |   Kafka Topic    |  consumes   | Scala Validation Service |  publishes validated events   |      Kafka Topic       | '  consumes   ' | Java Persistence/API Service |   JSON responses       |       Client / Developer       | '
' | (Fixed-format / batch input) | --------------> | Legacy parsing   batch transformation | ' ----------------------> ' | transactions.raw | ----------> | Validation   enrichment  | ----------------------------> | transactions.validated | ' ----------> ' |     Consumer   REST API      | ---------------------> | Reads transaction data via API | '
' +------------------------------+                 +---------------------------------------+ '                         ' +------------------+             +--------------------------+                               +------------------------+ '             ' +------------------------------+                        +--------------------------------+ '
'                                                                                            '                         '                                                                                                                        '             '   |                                                                                        '
+ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -+                         +- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +             '   |                               - - - - - - - - - - - - - - - - - - - - - - - - - - - - -+
                                                                                                                                                                                                                                                              '   |                              '
                                                                                                                                                                                                                                                              '   | writes transactions          '
                                                                                                                                                                                                                                                              '   v                              '
                                                                                                                                                                                                                                                              ' +------------------------------+ '
                                                                                                                                                                                                                                                              ' |          PostgreSQL          | '
                                                                                                                                                                                                                                                              ' | Durable transaction storage  | '
                                                                                                                                                                                                                                                              ' +------------------------------+ '
                                                                                                                                                                                                                                                              '                                  '
                                                                                                                                                                                                                                                              + - - - - - - - - - - - - - - - - -+

## Event Flow
1. COBOL batch reads legacy transaction file
2. Bridge publishes transactions to Kafka
3. Scala validates and enriches
4. Java persists and exposes REST API
5. Phoenix displays real-time dashboard

## Current Phase 1: Standalone COBOL Batch

- [x] Read A legacy file
- [ ] Produce normalised file
- [ ] Generate a mini-report
