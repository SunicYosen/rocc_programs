
#include "riscv_test.h"
#include "riscv-tests/isa/macros/scalar/test_macros.h"
#include "rocc_cnn.h"
#include "src/riscv_test_rocc.h"

; #define GET_FLAG_FUNC(flag_reg, flag_type) \
;         ROCC_INSTRUCTION_RAW_R_R_R(XCUSTOM_ACC, flag_reg, flag_type, 0, GET_FLAG)

; #define SEND_DATA_FUNC(return_state, data_reg, rocc_reg) \
;         ROCC_INSTRUCTION_RAW_R_R_R(XCUSTOM_ACC, return_state, data_reg, rocc_reg, SEND_DATA)

; #define SEND_ISA_FUNC(return_state, command_reg) \
;         ROCC_INSTRUCTION_RAW_R_R_R(XCUSTOM_ACC, return_state, data_reg, 0, SEND_ISA)

  RVTEST_WITH_ROCC

start:
  RVTEST_CODE_BEGIN

  li a6, 0x000000000000001c                  ;// Row & col Nums
  li s4, 0x0000000000000000                  ;// Input addr
  li s5, 0x0000000001000000                  ;// Output addr

  li s2, 0x0000000000000000                  ;// Kernel branch

  li a4, 0x0000000000000000                  ;// Input row branch

input_row_l:
  li a5, 0x0000000000000000                  ;// input col branch
  li s3, 0x0000000000000000                  ;// output col branch

input_col_l:

l_i0:
  li a0, 0x0000000000000000                  ;// Init a0 for result
  li a1, 0x0000000000000001                  ;// load IS_ISSUE_FLAG to a1
  GET_FLAG_FUNC(a0_reg, a1_reg)              ;// Get is_issuable flag
  beq a0, x0, l_i0                           ;// Jump if can't issue                    
  
  ;//li a2, 0x0000000050000000               ;//Load weight ISA CODE
  ;//SEND_ISA_FUNC(a0_reg, a2_reg)           ;//Send Load ISA
    
  mv a1, s4                                  ;// Compute input addr to a1 and sent to reg0 of rocc
  li a2, 0x0000000000000000                  ;// Reg0 addr of rocc write to a2
  SEND_DATA_FUNC(a0_reg, a1_reg, a2_reg)     ;// Send Data to reg0 in rocc
    
  mv a1, s5                                  ;// Compute output addr to a1 and sent to reg1 of rocc
  li a2, 0x0000000000000001                  ;// reg1 addr of rocc write to a2
  SEND_DATA_FUNC(a0_reg, a1_reg, a2_reg)     ;// Sent output addr to rocc reg

  li a3, 0x0000000060100001                  ;// Compuer ISA X-slide
  ;//li a3, 0x0000000060100002               ;// Compuer ISA Y-slide
  SEND_ISA_FUNC(a0_reg, a3_reg)              ;// Send ISA

  addi a5, a5, 3                             ;// Move to Next col input
  addi s3, s3, 3                             ;// Move to Next col output
  addi s4, s4, 3
  addi s5, s5, 3
  blt  a5, a6, input_col_l                   ;// Branch       
 
  addi a4, a4, 3                             ;// input row
  addi s4, a5, 64                            ;// Input addr
  addi s5, s5, 60                            ;// Output addr
  blt  a4, a6, input_row_l                   ;// Branch next row

  
  li a4, 0x0000000000000000                  ;//
  li a5, 0x000000000000a000                  ;//
nop_l:                                       ;//
  nop                                        ;//
  addi a4, a4, 1                             ;//
  blt  a4, a5, nop_l                         ;//
                                             ;//
  RVTEST_PASS                                ;// Test pass

  ;//TEST_PASSFAIL
  
  RVTEST_CODE_END

  .data
  RVTEST_DATA_BEGIN
  TEST_DATA
  RVTEST_DATA_END