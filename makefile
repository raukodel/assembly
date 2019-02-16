program: utils.o $(arg1).o
	ld -o program utils.o $(arg1).o

utils.o: utils.asm
	nasm -felf64 -o utils.o utils.asm

$(arg1).o: $(arg1).asm
	nasm -felf64 -o $(arg1).o $(arg1).asm

clean:
	rm utils.o $(arg1).o program
