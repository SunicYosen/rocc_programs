#Makefile for rocc cnn

XLEN     ?= 64
NAME     ?= rocc_cnn
CODETYPE ?= isa

GCC     ?= riscv$(XLEN)-unknown-elf-gcc
OBJCOPY ?= riscv$(XLEN)-unknown-elf-objcopy
OBJDUMP ?= riscv$(XLEN)-unknown-elf-objdump

EXETYPE  := $(CODETYPE).rv$(XLEN)
BINTYPE  := $(CODETYPE).bin$(XLEN)
DUMPTYPE := $(CODETYPE).dump$(XLEN)
HEXTYPE  := $(CODETYPE).hex$(XLEN)

LINK := link.ld 

all: ${NAME}.$(EXETYPE) ${NAME}.$(BINTYPE) ${NAME}.$(HEXTYPE) ${NAME}.$(DUMPTYPE)

%.$(BINTYPE): %.$(EXETYPE)
	$(OBJCOPY) -O binary --change-addresses=-0x80000000 --only-section .text $< $@

%.$(EXETYPE): %.S $(LINK)
	$(GCC) -T$(LINK) $< -nostdlib -static -o $@

%.$(DUMPTYPE): %.$(EXETYPE)
	$(OBJDUMP) -d $< > $@

%.$(HEXTYPE): %.$(BINTYPE)
	xxd -e $< | xxd -r | xxd -ps | tr -d  "\n" | sed "s/$$/ffffffff/" > $@

.PHONY:clean

clean:
	rm -f ${NAME}.$(EXETYPE) ${NAME}.$(BINTYPE) ${NAME}.$(DUMPTYPE) ${NAME}.$(HEXTYPE)
