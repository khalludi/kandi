kernel.bin: kernel_entry.o kernel.o
	i386-elf-ld -o kernel.bin -Ttext 0x1000 kernel_entry.o kernel.o --oformat binary

kernel.o : kernel.c
	i386-elf-gcc -ffreestanding -c kernel.c -o kernel.o

kernel_entry.o : kernel_entry.asm
	nasm kernel_entry.asm -f elf -o kernel_entry.o
