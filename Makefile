PROGRAM=themistake
SRC=$(wildcard *.cob)

all:
	cobc -x -o $(PROGRAM) $(SRC)
run:
	chmod +x $(PROGRAM)
	./$(PROGRAM)
	open output.ppm
clean:
	rm -rf $(PROGRAM)