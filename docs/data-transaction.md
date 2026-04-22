# Data Transaction

## Conventions

- All timestamps use UTC and follow ISO 8601.
- All IBANs follow ISO 13616.
- All currency code follow ISO 4217.
- Monetary amounts are expressed as integers in the smallest currency unit.
- `transactionId` is preserved across raw, validated, and rejected events.
- `metadata` describes the producer of the current event.
- `transaction.sourceMetadata` describes the producer of the original raw transaction.
- Allowed values for `validation.status` are the following : `PENDING` | `VALIDATED` | `REJECTED`.

## Raw Transaction Schema

### transactionId
- Type: string
- Required: yes
- Format: `TXN-<timestamp>-<workerId>-<sequence>`
- Description: unique identifier of the transaction produced by the legacy batch.
- Detail:
    * timestamp: The timestamp format is expected to be in the format : YYYYMMDDHHMMSS
    * workerId: The id of the worker that generated the transaction, it is 3 digits long
    * sequence: The sequence is the internal counter of the worker, it is 9 digit long and incremented each time a new transaction is generated. The counter may roll over after reaching its maximum value, provided uniqueness is preserved. 

### validation.status
- Type: string
- Required: yes
- Allowed values: `PENDING` 
- Description: The current status of the transaction.

### validation.timestamp
- Type: string
- Required: yes
- Description: The exact timestamp at which the raw transaction was created. ( See [Conventions](#Conventions) )

### sourceAccount.iban
- Type: string
- Required: yes

### destinationAccount.iban
- Type: string
- Required: yes

### transfer.amount
- Type: integer
- Required: yes
- Format: Integer amount expressed in the smallest currency unit.
- Description: The amount of money to transfer. ( See [Conventions](#Conventions) )

### transfer.currency
- Type: string
- Required: yes

### metadata.origin
- Type: string
- Required: yes
- Description: The system that originated the transaction.

### metadata.workerId
- Type: integer
- Required: yes
- Description: A 3-digit integer representing the id of the worker that generates the transaction.

### metadata.producer
- Type: string
- Required: yes
- Description: The name of the service that originally produced the transaction.

## Rejected Transaction Schema

### transactionId
- Type: string
- Required: yes
- Format: `TXN-<timestamp>-<workerId>-<sequence>`
- Description: unique identifier of the transaction produced by the legacy batch
- Detail:
    * timestamp: The timestamp format is expected to be in the format : YYYYMMDDHHMMSS
    * workerId: The id of the worker that generated the transaction, it is 3 digits long
    * sequence: The sequence is the internal counter of the worker, it is 9 digit long and incremented each time a new transaction is generated. The counter may roll over after reaching its maximum value, provided uniqueness is preserved. 

### validation.status
- Type: string
- Required: yes
- Allowed values: `REJECTED`
- Description: The current status of the transaction.

### validation.timestamp
- Type: string
- Required: yes
- Description: The exact timestamp the transaction has been rejected. ( See [Conventions](#Conventions) )

### validation.reasonCodes
- Type: Array of string
- Required: yes
- Allowed values: `NEGATIVE_AMOUNT` | `INVALID_COUNTRY_CODE` | `UNKNOWN_COUNTRY_CODE` | `UNABLE_TO_DELIVER_TO_DESTINATION` | `INTERNAL_FAILURE`
- Description: One or more reasons why the transaction failed.

### transaction.transactionTimestamp
- Type: string
- Required: yes
- Description: The timestamp of the raw transaction linked to the rejection. ( See [Conventions](#Conventions) )

### transaction.sourceAccount.iban
- Type: string
- Required: yes

### transaction.destinationAccount.iban
- Type: string
- Required: yes

### transaction.transfer.amount
- Type: integer
- Required: yes
- Description: The amount of currency specified in the raw request.

### transaction.transfer.currency
- Type: string
- Required: yes

### transaction.sourceMetadata.origin
- Type: string
- Required: yes
- Description: The system that originated the raw transaction.

### transaction.sourceMetadata.workerId
- Type: integer
- Required: yes
- Description: A 3-digit integer representing the id of the worker that generates the raw transaction.

### transaction.sourceMetadata.producer
- Type: string
- Required: yes
- Description: The name of the service that originally produced the raw transaction.

### metadata.origin
- Type: string
- Required: yes
- Description: The system that originated the rejection.

### metadata.workerId
- Type: integer
- Required: yes
- Description: A 3-digit integer representing the id of the worker that rejected the transaction.

### metadata.producer
- Type: string
- Required: yes
- Description: The name of the service that rejected the transaction.

## Validated Transaction Schema

### transactionId
- Type: string
- Required: yes
- Format: `TXN-<timestamp>-<workerId>-<sequence>`
- Description: unique identifier of the transaction produced by the legacy batch
- Detail:
    * timestamp: The timestamp format is expected to be in the format : YYYYMMDDHHMMSS
    * workerId: The id of the worker that generated the transaction, it is 3 digits long
    * sequence: The sequence is the internal counter of the worker, it is 9 digit long and incremented each time a new transaction is generated. The counter may roll over after reaching its maximum value, provided uniqueness is preserved. 

### validation.status
- Type: string
- Required: yes
- Allowed values: `VALIDATED`
- Description: The current status of the transaction.

### validation.timestamp
- Type: string
- Required: yes
- Description: The exact timestamp the transaction has been validated. ( See [Conventions](#Conventions) )

### transaction.transactionTimestamp
- Type: string
- Required: yes
- Description: The timestamp of the raw transaction linked to the validation. ( See [Conventions](#Conventions) ) 

### transaction.sourceAccount.iban
- Type: string
- Required: yes

### transaction.destinationAccount.iban
- Type: string
- Required: yes

### transaction.transfer.amount
- Type: integer
- Required: yes
- Format: Integer amount expressed in the smallest currency unit.
- Description: Amount to transfer. 

### transaction.transfer.currency
- Type: string
- Required: yes

### transaction.sourceMetadata.origin
- Type: string
- Required: yes
- Description: The system that originated the raw transaction.

### transaction.sourceMetadata.workerId
- Type: integer
- Required: yes
- Description: A 3-digit integer representing the id of the worker that generates the raw transaction.

### transaction.sourceMetadata.producer
- Type: string
- Required: yes
- Description: The name of the service that originally produced the raw transaction.

### metadata.origin
- Type: string
- Required: yes
- Description: The system that originated the validation.

### metadata.workerId
- Type: integer
- Required: yes
- Description: A 3-digit integer representing the id of the worker that validated the transaction.

### metadata.producer
- Type: string
- Required: yes
- Description: The name of the service that validated the transaction.

