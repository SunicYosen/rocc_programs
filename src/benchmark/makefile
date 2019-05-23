#Makefile for rocc cnn
XLEN ?= 64
NAME ?= rocc_cnn
EXETYPE ?= rv$(XLEN)
DUMPOUT ?= $(EXETYPE).dump

CC = riscv$(XLEN)-unknown-elf-gcc
CXX = riscv$(XLEN)-unknown-elf-g++
OBJDUMP = riscv$(XLEN)-unknown-elf-objdump
CCFLAGS := -static

SRCDIR = .
SRC = $(SRCDIR)/$(NAME).c
SRCHEADER = $(SRCDIR)/$(NAME).h

default: $(NAME).$(EXETYPE)

%.$(EXETYPE): $(SRCHEADER) $(SRC)
	$(CC) -C $(SRC) $(CCFLAGS) -o $(NAME).$(EXETYPE)

dump: $(NAME).$(EXETYPE)
	$(OBJDUMP) -D $(NAME).$(EXETYPE) > $(NAME).$(DUMPOUT)

.PHONY:clean

clean:
	rm -f *.${EXETYPE} *.${DUMPOUT}