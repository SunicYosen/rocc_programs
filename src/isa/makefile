#Makefile for rocc cnn

XLEN ?= 32
NAME ?= rocc_cnn

GCC ?= riscv$(XLEN)-unknown-elf-gcc
OBJCOPY ?= riscv$(XLEN)-unknown-elf-objcopy
OBJDUMP ?= riscv$(XLEN)-unknown-elf-objdump

LINK := link.ld 

all: ${NAME}.rv$(XLEN) ${NAME}.bin$(XLEN) ${NAME}.hex$(XLEN) ${NAME}.dump$(XLEN)

%.bin$(XLEN): %.rv$(XLEN)
	$(OBJCOPY) -O binary --change-addresses=-0x80000000 --only-section .text $< $@

%.rv$(XLEN): %.S $(LINK)
	$(GCC) -T$(LINK) $< -nostdlib -static -o $@

%.dump$(XLEN): %.rv$(XLEN)
	$(OBJDUMP) -d $< > $@

%.hex$(XLEN): %.bin$(XLEN)
	xxd -e $< | xxd -r | xxd -ps | tr -d  "\n" | sed "s/$$/ffffffff/" > $@

.PHONY:clean

clean:
	rm ${NAME}.hex$(XLEN) ${NAME}.bin$(XLEN) ${NAME}.dump$(XLEN) ${NAME}.rv$(XLEN)
