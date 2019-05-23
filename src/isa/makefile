#Makefile for rocc cnn
TYPE           ?= kernel_f_p
BASE_DIR       := $(abspath ../..)
SRC_DIR        := $(abspath ..)
ISA_DIR        := $(SRC_DIR)/isa
ROCC_SOFTWARE  := $(SRC_DIR)/rocc-software
RISCVTOOLS     ?= /home/SoftwareI/RISCV/riscv64
SIMULATOR_DIR  ?= /home/sun/File/RISCV/Projects/rocket-chip/vsim
SIMULATOR_NAME ?= simv-freechips.rocketchip.system-RoCCInterfaceConfig-debug

TIME_NAME := $(shell date +%y%m%d%02k%M)

XLEN     ?= 64
NAME     ?= rocc_cnn
CODETYPE ?= isa

TARGET ?= riscv$(XLEN)-unknown-elf-
CC := $(TARGET)gcc
LD := $(CC)
OBJCOPY := $(TARGET)objcopy
OBJDUMP := $(TARGET)objdump

ENV_P = $(RISCVTOOLS)/riscv-tests/env/p
ENV_V = $(RISCVTOOLS)/riscv-tests/env/v

tests_p = $(addprefix _p_, $(CODETYPE))
tests_v = $(addprefix _v_, $(CODETYPE))

kernel_f_tests_p = $(addprefix _kernel_f_p_, $(CODETYPE))
kernel_f_tests_v = $(addprefix _kernel_f_v_, $(CODETYPE))

input_f_tests_p = $(addprefix _kernel_f_p_, $(CODETYPE))
input_f_tests_v = $(addprefix _kernel_f_v_, $(CODETYPE))

EXETYPE  := rv$(XLEN)
BINTYPE  := bin$(XLEN)
DUMPTYPE := dump$(XLEN)
HEXTYPE  := hex$(XLEN)

OUTPUT_REDIRECT ?= 2>&1   #Error

CFLAGS := $(CFLAGS) \
					-static \
					-mcmodel=medany \
					-fvisibility=hidden \
					-nostdlib \
					-nostartfiles \
					-I$(RISCVTOOLS) \
					-I$(ROCC_SOFTWARE) \
					-DID_STRING=$(ID_STRING)

            # +permissive -q +ntb_random_seed_automatic +permissive-off \
            #  3>&1 1>&2 2>&3
RUNFLAGS := +permissive -q +ntb_random_seed_automatic +permissive-off \
            +permissive +verbose +max-cycles=100000000 +permissive-off \
						+permissive +vcs+vcdpluson +vcdplusfile=$(BASE_DIR)/output/$(NAME)_$(TYPE)_$(CODETYPE)_$(TIME_NAME).vpd +permissive-off \
	          $(NAME)_$(TYPE)_$(CODETYPE).$(EXETYPE) 2>&1 | $(RISCVTOOLS)/bin/spike-dasm > $(BASE_DIR)/output/$(NAME)_$(TYPE)_$(CODETYPE)_$(TIME_NAME).log && [ $$pipestatus -eq 0 ] \

defualt: $(TYPE)

kernel_f_p: $(NAME)$(kernel_f_tests_p).$(EXETYPE)
kernel_f_v: $(NAME)$(kernel_f_tests_v).$(EXETYPE)
input_f_p:  $(NAME)$(input_f_tests_p).$(EXETYPE)
input_f_v:  $(NAME)$(input_f_tests_v).$(EXETYPE)

%$(tests_p).$(EXETYPE): %.S
	$(CC) $(CFLAGS) -I$(ENV_P) -T$(ENV_P)/link.ld $< $(LFLAGS) -o $@ $(LIBS)

%$(tests_v).$(EXETYPE): %.S
	$(CC) $(CFLAGS) -I$(ENV_V) -T$(ENV_V)/link.ld $< $(LFLAGS) -o $@ $(LIBS)

%.$(DUMPTYPE): %.$(EXETYPE)
	$(OBJDUMP) -d $< > $@

%.$(BINTYPE): %.$(EXETYPE)
	$(OBJCOPY) -O binary --change-addresses=-0x80000000 --only-section .text $< $@

%.$(HEXTYPE): %.$(BINTYPE)
	xxd -e $< | xxd -r | xxd -ps | tr -d  "\n" | sed "s/$$/ffffffff/" > $@

.PHONY:run

run:
	mkdir -p $(BASE_DIR)/output && \
  $(SIMULATOR_DIR)/$(SIMULATOR_NAME) $(RUNFLAGS)

.PHONY:clean
clean:
	rm -f *$(EXETYPE) *.$(BINTYPE) *.$(DUMPTYPE) *.$(HEXTYPE) *.key

.PHONY:clean-log
clean-log:
	rm -rf $(BASE_DIR)/output/
