all: os-image

# Run qemu to simulate booting the code.
run: all
	qemu-system-x86_64 -fda os-image

# This is the disk image, which is the combination of the compiled bootsector
# and kernel
os-image: boot_sect.bin kernel.bin
	cat $^ > $@

# This builds the binary of the kernel
kernel.bin: kernel_entry.o kernel.o
	i386-elf-ld -o $@ -Ttext 0x1000 $^ --oformat binary

# Build the kernel object file
kernel.o : kernel.c
	i386-elf-gcc -ffreestanding -c $< -o $@

# Build the kernel entry object file.
kernel_entry.o : kernel_entry.asm
	nasm $< -f elf -o $@

# Assemble the boot sector to raw machine code
boot_sect.bin : boot_sect.asm
	nasm $< -f bin -I '../16-bit-mode/' -I '../32-bit-mode/' -o $@

# Clean all generated files.
clean:
	rm -rf *.bin *.dis *.o os-image *.map

# Disassemble our kernel - might be useful for debugging
kernel.dis : kernel.bin
	ndisasm -b 32 $< > $@
