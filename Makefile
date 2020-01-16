# Automatically generate lists of sources using wildcards
C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)
LIBS = -Ikernel/ -Idrivers/
CFLAGS = -g
GDB = /usr/local/i386elfgcc/bin/i386-elf-gdb

# Convert the *.c filenames to *.o to give a list of object files to build
OBJ = ${C_SOURCES:.c=.o}

# Default build target
all: os-image

# Run qemu to simulate booting the code.
run: all
	qemu-system-i386 -fda os-image

# This is the disk image, which is the combination of the compiled bootsector
# and kernel
os-image: boot/boot_sect.bin kernel.bin
	cat $^ > $@

# This builds the binary of the kernel
kernel.bin: kernel/kernel_entry.o ${OBJ}
	i386-elf-ld -o $@ -Ttext 0x1000 $^ --oformat binary

# Used for debugging purposes
kernel.elf: kernel/kernel_entry.o ${OBJ}
	i386-elf-ld -o $@ -Ttext 0x1000 $^

# Open the connection to qemu and load our kernel-object file with symbols
debug: os-image kernel.elf
	qemu-system-i386 -gdb tcp::9010 -fda os-image &
	${GDB} -ex "target remote localhost:9010" -ex "symbol-file kernel.elf"

# Generic rule for compiling C code to an object file
# For simplicity, the Cfiles depnd on all header files.
%.o : %.c ${HEADERS}
	i386-elf-gcc $(CFLAGS) -ffreestanding $(LIBS) -c $< -o $@

# Assemble the kernel entry object file.
%.o : %.asm
	nasm $< -f elf -o $@

%.bin : %.asm
	nasm $< -f bin -I 'boot/' -o $@

clean:
	rm -rf *.bin *.dis *.o os-image *.map
	rm -rf kernel/*.o boot/*.bin drivers/*.o

# Disassemble our kernel - might be useful for debugging
kernel.dis : kernel.bin
	ndisasm -b 32 $< > $@
