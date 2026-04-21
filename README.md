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

## Event Flow
1. COBOL batch reads legacy transaction file
2. Bridge publishes transactions to Kafka
3. Scala validates and enriches
4. Java persists and exposes REST API
5. Phoenix displays real-time dashboard

## Current Phase : 0 Scoping

- [ ] Choose the transaction format
- [x] Define the Kafka topics
- [x] Freeze the statuses
- [x] Write the JSON schemas
