//
// CNN Programs with rocc
// Sunic Yosen

// #include <assert.h>
#include <stdint.h>
// #include <stdio.h>

#include "rocc_cnn.h"

#define SEND_DATA 1
#define SEND_ISA 2
#define GET_FLAG 3
#define IS_ISSUE_FLAG 1

int main()
{
  // Define RoCC Accelerator Reg
  int64_t r0 = 0;
  int64_t r1 = 1;
  int64_t r2 = 2;
  int64_t r3 = 3;

  int64_t is_issue_flag = 0;  //read rd val
  int64_t issue_state = 0;    //issue command state
  int64_t rs1_value = 0x0000000000100000;

  rocc_read(is_issue_flag, IS_ISSUE_FLAG, GET_FLAG);
  while(!is_issue_flag)
  {
    rocc_read(is_issue_flag, IS_ISSUE_FLAG, GET_FLAG); 
    //printf("[+] is_issue: %d", is_issue_flag);
  }
  rocc_write(issue_state, rs1_value, r0, SEND_DATA);

  return 0;
}
