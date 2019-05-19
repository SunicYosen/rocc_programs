//
// CNN Programs with rocc
// Sunic Yosen

#include <assert.h>
#include <stdint.h>
#include <stdio.h>

#include "rocc_cnn.h"

#define SEND_DATA 1
#define SEND_ISA 2
#define GET_FLAG 3
#define IS_ISSUE_FLAG 0

int main()
{
  // Define RoCC Accelerator Reg
  int32_t r0 = 0;
  int32_t r1 = 1;
  int32_t r2 = 2;
  int32_t r3 = 3;

  int32_t is_issue_flag = 0;  //read rd val
  int32_t issue_statue = 0;   //issue command statue
  int32_t rs1_value = 0x00100000;


  rocc_read(is_issue_flag, IS_ISSUE_FLAG, GET_FLAG);
  while(!is_issue_flag)
  {
    rocc_read(is_issue_flag, IS_ISSUE_FLAG, GET_FLAG); 
    printf("[+] is_issue: %d", is_issue_flag);
  }
  rocc_write(issue_statue, rs1_value, r0, SEND_DATA);

  return 0;
}
