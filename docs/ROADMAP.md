## Phase 0 — Scoping
Objective:

- Choose the transaction format
- Define the Kafka topics
- Freeze the statuses
- Write the JSON schemas

Deliverables:
- `docs/architecture.md`
- `docs/event-flow.md`
- `schemas/*.json`
- `sample-data/transactions_legacy.dat`

## Phase 1 — Standalone COBOL Batch
Objective:
- Read a legacy file
- Produce a normalized file
- Generate a mini-report

Deliverables:
- Compilable COBOL program
- Example input/output
- Component README

Demo:
- Run the batch
- It outputs a clean file

## Phase 2 — Kafka Ingestion
Objective:

- Create the bridge that reads the normalized file and publishes to `transactions.raw`

Deliverables:
- Functional bridge
- Created topic
- Messages visible in Kafka

Demo:
- Batch COBOL
- bridge
- message present on Kafka

## Phase 3 — Scala service
Objective:
- consume `transactions.raw`
- validate
- publish to `validated` or `rejected`

Deliverables:
- Scala consumer
- validation logic
- clean logs

Demo:
- valid transaction passed
- invalid transaction rejected

## Phase 4 — Java persistence
Objective:
- consume `validated` and `flagged`
- store in PostgreSQL
- expose REST API

Deliverables:
- database mounted with Docker
- JPA entities or equivalent
- functional endpoints

Demo:
- `GET /api/transactions`
- `GET /api/dashboard/stats`

## Phase 5 — Phoenix dashboard
Objective:
- display data
- dashboard view
- transaction list
- alerts

Deliverables:
- LiveView page
- statistics Visible
- Regular refresh

Demo:
- Injecting transactions
- Watching the table evolve

## Phase 6 — Polishing
Objective:

- Making the project "portfolio-ready"

Possible additions:
- Clean Dockerfiles
- Demo scripts
- Mermaid diagrams
- Screenshots
- Basic tests
- DLQ
- Minimal observability
