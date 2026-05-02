# legacy batch

Written entirely in COBOL *trust me, this was fun*, this component is responsible to retrieve transaction data of the raw transaction file and format it to a ready to parse file with specific fields. It also output a report containing insight of what have been done.

The legacy file is called [transactions_legacy.dat](https://github.com/Riley-dsv/Mainstream/blob/main/sample-data/transactions_legacy.dat) it is composed of the following fields : 

- transaction-id
- transaction-type
- date / time
- amount
- currency
- iBANs
- Batch ID
- A reference text

For more information about exact data format and size refer to [transaction_legacy_format](https://github.com/Riley-dsv/Mainstream/blob/main/docs/transaction_legacy_format.md) file.

The output file is formated using `key=value` pair and each entries are separated with the `---` delimiter. The fields kept by the final report are the following :

- transaction-id
- date
- time
- currency
- amount
- iBANs
- Batch ID

## Compilation and run

To compile just use the `make` and the Makefile will make the rest :

```bash
make
```

And to run just use :

```sh
make run
```

every files ends up in the `_output` directory.

## Limitations

- Silently skip erros in record, but this is planed to change
- Do not give much detail in the reporting.
- Do not do any business validation and will never do, This is Scala problem.
