COMP=gfortran
SHELL=/bin/bash

CFLAGS= -O2 -Wall -ftree-vectorize -ffast-math
LDFLAGS=

EXEC= Anas
EXEC_TEST=Anas-test

# directories
WORK=$(shell pwd)
SRC=$(WORK)/src/
OBJ=$(WORK)/obj/
BIN=$(WORK)/bin/
RES=$(WORK)/results/

# list of files
sources=$(wildcard $(SRC)*.f90)
objects_all=$(patsubst $(SRC)%.f90, $(OBJ)%.o, $(sources))
objects=$(filter-out $(OBJ)main%.o, $(objects_all))
binaries=$(patsubst $(OBJ)%.o, $(BIN)%.mod, $(objects))

normal: $(filter-out $(OBJ)main_test.o,$(objects_all))
	$(COMP) -o $(EXEC) $^ $(LDFLAGS) -I$(BIN)

test: $(objects) $(OBJ)main_test.o
	$(COMP) -o $(EXEC_TEST) $^ $(LDFLAGS) -I$(BIN)

$(OBJ)main.o: $(SRC)main.f90 $(objects)
	$(COMP) -c $< $(CFLAGS) -I$(BIN) -o $@

$(OBJ)main_test.o: $(SRC)main_test.f90 $(objects)
	$(COMP) -c $< $(CFLAGS) -I$(BIN) -o $@

$(OBJ)parameters.o: $(SRC)parameters.f90
	$(COMP) -c $< $(CFLAGS) -J$(BIN) -I$(BIN) -o $@

$(OBJ)special_type.o: $(SRC)special_type.f90 $(OBJ)parameters.o
	$(COMP) -c $< $(CFLAGS) -J$(BIN) -I$(BIN) -o $@
	
$(OBJ)io.o: $(SRC)io.f90 $(OBJ)parameters.o $(OBJ)special_type.o $(OBJ)utils.o
	$(COMP) -c $< $(CFLAGS) -J$(BIN) -I$(BIN) -o $@

$(OBJ)utils.o: $(SRC)utils.f90 $(OBJ)parameters.o
	$(COMP) -c $< $(CFLAGS) -J$(BIN) -I$(BIN) -o $@

start: normal
	./$(EXEC) < input/feed_me.nml

check: $(EXEC_TEST)
	./$(EXEC_TEST) < input/feed_me.nml

clean:
	@rm -vf $(EXEC) $(EXEC_TEST)
	@rm -vf $(objects_all)
	@rm -vf $(binaries)
