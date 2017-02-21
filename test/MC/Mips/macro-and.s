# RUN: llvm-mc -triple mips64-unknown-freebsd -show-encoding -print-imm-hex %s | FileCheck %s

__start:
# CHECK: __start:
# from FreeBSD mips exception.S:
#and	k0, k0, MIPS_SR_KSU_USER	# test for user mode
#and	k1, k1, MIPS_CR_EXC_CODE	# Mask out the cause bits.
#and	a0, a0, (MIPS_SR_INT_MASK|MIPS_SR_COP_USABILITY)
#and	a1, a1, ~(MIPS_SR_INT_MASK|MIPS_SR_COP_USABILITY)
#and	t0, a0, ~(MIPS_SR_COP_1_BIT | MIPS_SR_EXL | MIPS_SR_KSU_MASK | MIPS_SR_INT_IE)
#and	t0, t0, ~(MIPS_SR_COP_2_BIT)
#and	a0, a0, MIPS_SR_INT_MASK
#and	a1, a1, ~MIPS_SR_INT_MASK
#and	a0, a0, (MIPS_SR_INT_MASK|MIPS_SR_COP_USABILITY)
#and	a1, a1, ~(MIPS_SR_INT_MASK|MIPS_SR_COP_USABILITY)
#and	t0, a0, ~(MIPS_SR_COP_1_BIT | MIPS_SR_EXL | MIPS_SR_INT_IE | MIPS_SR_KSU_MASK)
#and	t0, t0, ~(MIPS_SR_COP_2_BIT)
#and	t0, t0, ~MIPS_SR_COP_1_BIT

# Preprocessed:

#and $k0, $k0, 0x00000010
# CHECK-NEXT: andi    $26, $26, 16            # encoding: [0x33,0x5a,0x00,0x10]
# CHECK-NEXT: andi    $26, $26, 16            # encoding: [0x33,0x5a,0x00,0x10]
# CHECK-NEXT: lui     $1, 61440               # encoding: [0x3c,0x01,0xf0,0x00]
# CHECK-NEXT: ori     $1, $1, 65280           # encoding: [0x34,0x21,0xff,0x00]
# CHECK-NEXT: and     $4, $4, $1              # encoding: [0x00,0x81,0x20,0x24]
and $k1, $k1, 0x0000007C
# CHECK-NEXT: andi    $27, $27, 124           # encoding: [0x33,0x7b,0x00,0x7c]
and $a0, $a0, (0x0000ff00|0xf0000000)
and $a1, ~(0x0000ff00|0xf0000000)
and $t0, $a0, ~(0x20000000 | 0x00000002 | 0x00000018 | 0x00000001)
and $t0, $t0, ~(0x40000000)
and $a0, $a0, 0x0000ff00
and $a1, $a1, ~0x0000ff00
and $a0, $a0, (0x0000ff00|0xf0000000)
and $a1, $a1, ~(0x0000ff00|0xf0000000)
and $t0, $a0, ~(0x20000000 | 0x00000002 | 0x00000001 | 0x00000018)
and $t0, $t0, ~(0x40000000)
and $t0, $t0, ~0x20000000
# rtld-elf/mips/rtld_start.S:
and $a0, $a0, 0x7fffffffffffffff

# This is what GCC generates (some of it better, some worse):
#Disassembly of section .text:
#__start:
#       0:       33 5a 00 10     andi    $26, $26, 16
#       4:       33 7b 00 7c     andi    $27, $27, 124
#       8:       34 01 f0 00     ori     $1, $zero, 61440
#       c:       00 01 0c 38     dsll    $1, $1, 16
#      10:       34 21 ff 00     ori     $1, $1, 65280
#      14:       00 81 20 24     and     $4, $4, $1
#      18:       24 01 ff ff     addiu   $1, $zero, -1
#      1c:       00 01 0c 38     dsll    $1, $1, 16
#      20:       34 21 0f ff     ori     $1, $1, 4095
#      24:       00 01 0c 38     dsll    $1, $1, 16
#      28:       34 21 00 ff     ori     $1, $1, 255
#      2c:       00 a1 28 24     and     $5, $5, $1
#      30:       3c 01 df ff     lui     $1, 57343
#      34:       34 21 ff e4     ori     $1, $1, 65508
#      38:       00 81 60 24     and     $12, $4, $1
#      3c:       3c 01 bf ff     lui     $1, 49151
#      40:       34 21 ff ff     ori     $1, $1, 65535
#      44:       01 81 60 24     and     $12, $12, $1
#      48:       30 84 ff 00     andi    $4, $4, 65280
#      4c:       3c 01 ff ff     lui     $1, 65535
#      50:       34 21 00 ff     ori     $1, $1, 255
#      54:       00 a1 28 24     and     $5, $5, $1
#      58:       34 01 f0 00     ori     $1, $zero, 61440
#      5c:       00 01 0c 38     dsll    $1, $1, 16
#      60:       34 21 ff 00     ori     $1, $1, 65280
#      64:       00 81 20 24     and     $4, $4, $1
#      68:       24 01 ff ff     addiu   $1, $zero, -1
#      6c:       00 01 0c 38     dsll    $1, $1, 16
#      70:       34 21 0f ff     ori     $1, $1, 4095
#      74:       00 01 0c 38     dsll    $1, $1, 16
#      78:       34 21 00 ff     ori     $1, $1, 255
#      7c:       00 a1 28 24     and     $5, $5, $1
#      80:       3c 01 df ff     lui     $1, 57343
#      84:       34 21 ff e4     ori     $1, $1, 65508
#      88:       00 81 60 24     and     $12, $4, $1
#      8c:       3c 01 bf ff     lui     $1, 49151
#      90:       34 21 ff ff     ori     $1, $1, 65535
#      94:       01 81 60 24     and     $12, $12, $1
#      98:       3c 01 df ff     lui     $1, 57343
#      9c:       34 21 ff ff     ori     $1, $1, 65535
#      a0:       01 81 60 24     and     $12, $12, $1
#      a4:       24 01 ff ff     addiu   $1, $zero, -1
#      a8:       00 01 08 7a     dsrl    $1, $1, 1
#      ac:       00 81 20 24     and     $4, $4, $1




