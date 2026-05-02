.PHONY: all build run clean

COBFLAGS_MAIN = -x -I ./src/copybooks
COBFLAGS_MODULE = -m -I ./src/copybooks

MAIN_SRC = src/main.cob

all: build

build: $(MODULE_OUT)
	cobc $(COBFLAGS_MODULE) src/transaction-reader.cob -o _build/batch-transaction-reader
	cobc $(COBFLAGS_MODULE) src/transaction-formatter.cob -o _build/report-trans-generator
	cobc $(COBFLAGS_MODULE) src/statistic-report.cob -o _build/insight-report-generator
	cobc $(COBFLAGS_MAIN) $(MAIN_SRC) -o _build/legacy-batch-service

run:
	mkdir -p _output
	echo "" > _output/transaction_report.rpts
	echo "" > _output/statistics_report.rpts
	cd _build && ./legacy-batch-service

clean:
	rm -rf _build/
