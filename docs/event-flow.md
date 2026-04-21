## End-to-End Flow

1. Input transaction data is provided to the COBOL batch component.
2. The COBOL batch processes the input and produces normalized transaction output.
3. Transaction events are published to Kafka.
4. The Scala service consumes raw events, validates them, and optionally enriches them.
5. Validated events are republished to Kafka.
6. The Java service consumes validated events and stores them in PostgreSQL.
7. The Phoenix application displays realtime transaction information and alerts using Kafka events and Java API data.
