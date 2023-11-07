# List of whitelisted TUM modules
DIRS := IN0009_GBS

RESULTS := $(DIRS:=_Result)
ZIPS := $(DIRS:=_cards.zip)

.PHONY: all clean $(DIRS)

all: $(ZIPS)

# Rule to process each directory and zip the results
$(ZIPS): %_cards.zip : %_Result
	mkdir -p build
	zip -rj build/$@ build/$</.

# Rule to create result directories and use mdankideck
$(RESULTS): %_Result : %
	mkdir -p build
	mkdir -p build/$@
	mdankideck $< build/$@

clean:
	rm -r build
