PROGRAM=themistake
SRC=$(wildcard *.cob)

all:
	cobc -x -o $(PROGRAM) $(SRC)
run:
	chmod +x $(PROGRAM)
	./$(PROGRAM)
clean:
	rm -rf $(PROGRAM)