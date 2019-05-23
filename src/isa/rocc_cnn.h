//
// CNN ISA Functions with rocc
// Sunic Yosen
//

#ifndef ROCC_CNN_H
#define ROCC_CNN_H

#include "src/xcustom.h"

#define XCUSTOM_ACC 0
#define SEND_DATA 1
#define SEND_ISA 2
#define GET_FLAG 3
#define IS_ISSUE_FLAG 0

#define CUSTOM_X 0
#define a0_reg 10
#define a1_reg 11
#define a2_reg 12
#define a3_reg 13


#define GET_FLAG_FUNC(flag_reg, flag_type) \
        ROCC_INSTRUCTION_RAW_R_R_R(XCUSTOM_ACC, flag_reg, flag_type, 0, GET_FLAG)

#define SEND_DATA_FUNC(return_state, data_reg, rocc_reg) \
        ROCC_INSTRUCTION_RAW_R_R_R(XCUSTOM_ACC, return_state, data_reg, rocc_reg, SEND_DATA)

#define SEND_ISA_FUNC(return_state, command_reg) \
        ROCC_INSTRUCTION_RAW_R_R_R(XCUSTOM_ACC, return_state, command_reg, 0, SEND_ISA)

#endif