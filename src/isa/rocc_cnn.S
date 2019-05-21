#include "riscv_test.h"
#include "test_macros.h"
#include "rocc_cnn.h"
#include "riscv_test_rocc.h"

#define CUSTOM_X 0
#define a0_reg 10
#define a1_reg 11
#define a2_reg 12

RVTEST_WITH_ROCC
start:
RVTEST_CODE_BEGIN

1: 
  li a1,0x00010000 ;
  li a2,0x00000010 ;
  ROCC_INSTRUCTION_RAW_R_R_R(CUSTOM_X, a0_reg, a1_reg, a2_reg, SEND_DATA) ;

  RVTEST_CODE_END

.data
RVTEST_DATA_BEGIN
TEST_DATA
data: 
RVTEST_DATA_END
