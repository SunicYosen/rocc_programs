//
// CNN ISA Functions with rocc
// Sunic Yosen
//

#ifndef ROCC_CNN_H
#define ROCC_CNN_H

#include "xcustom.h"

#define XCUSTOM_ACC 0

// Send rs1_data to rs2_addr of rocc. 
// Funct_value define send value or ISA
// Return rd_value to symbol the send result.
// funct_value=1 : send value
// funct_value=2 : send ISA of simulator Acc

#define rocc_write(rd_value, rs1_value, rs2_value, funct_value) \
  ROCC_INSTRUCTION(XCUSTOM_ACC, rd_value, rs1_value, rs2_value, funct_value);

// read from rs1_addr of rocc to rd_addr of core.
// funct_value=3 : read value from simulator to Rocket core.
#define rocc_read(rd_value, rs1_value, funct_value)    \
  ROCC_INSTRUCTION(XCUSTOM_ACC, rd_value, rs1_value, 0, funct_value);

#endif