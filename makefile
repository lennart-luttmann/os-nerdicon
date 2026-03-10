
# -- project --
NAME=osnerdicon
VERSION=1.0.0
PROJECT_ROOT = $(shell pwd)

# -- directories -- 
BUILD=$(PROJECT_ROOT)/build
INCLUDE=$(PROJECT_ROOT)/include
SRC=$(PROJECT_ROOT)/src
LIB=$(PROJECT_ROOT)/lib

# -- files --
SRC_MAIN=$(SRC)/main.c
LIB_CFFI=$(LIB)/cffi.zig
INCLUDE_H=$(INCLUDE)/osnerdicon.h
BUILD_LIB=$(BUILD)/libosnerdicon.so
BUILD_BIN=$(BUILD)/osnerdicon

# -- compiler --
ZIG=zig build-lib
CC=gcc
ZIG_FLAGS=-dynamic -O ReleaseSafe
CC_FLAGS=-Wall -Wextra -Wl,-rpath,'$$ORIGIN' -I $(INCLUDE)

# -- macros --
ENSURE_ROOT=@[ "$(shell whoami)" = "root" ] || { echo "Error: install must be run as root"; exit 1; }

# -- rules --
.PHONY: all lib proc clean

all: $(BUILD_LIB) $(BUILD_BIN)

lib: $(BUILD_LIB)

proc: $(BUILD_PROC)

clean: 
	rm -rf .cache
	rm -rf $(BUILD)
	rm -f compile_commands.json

$(BUILD):
	mkdir $(BUILD)

$(BUILD_LIB): $(LIB_CFFI) $(wildcard $(LIB)/*) $(wildcard $(LIB)/**/*) | $(BUILD)
	$(ZIG) $< $(ZIG_FLAGS) --name osnerdicon -femit-bin=$@

$(BUILD_BIN): $(SRC_MAIN) $(wildcard $(SRC)/*) $(wildcard $(SRC)/**/*) | $(BUILD)
	$(CC) $(CC_FLAGS) $^ -L $(BUILD) -losnerdicon -o $@
