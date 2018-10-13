; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -instcombine %s | FileCheck %s

define <4 x i8> @add(<2 x i8> %a, <2 x i8> %b, <2 x i8> %c, <2 x i8> %d) {
; CHECK-LABEL: @add(
; CHECK-NEXT:    [[CONCAT1:%.*]] = shufflevector <2 x i8> [[A:%.*]], <2 x i8> [[B:%.*]], <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[CONCAT2:%.*]] = shufflevector <2 x i8> [[C:%.*]], <2 x i8> [[D:%.*]], <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[R:%.*]] = and <4 x i8> [[CONCAT1]], [[CONCAT2]]
; CHECK-NEXT:    ret <4 x i8> [[R]]
;
  %concat1 = shufflevector <2 x i8> %a, <2 x i8> %b, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %concat2 = shufflevector <2 x i8> %c, <2 x i8> %d, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %r = and <4 x i8> %concat1, %concat2
  ret <4 x i8> %r
}

; Flags should propagate.

define <4 x i8> @sub(<2 x i8> %a, <2 x i8> %b, <2 x i8> %c, <2 x i8> %d) {
; CHECK-LABEL: @sub(
; CHECK-NEXT:    [[CONCAT1:%.*]] = shufflevector <2 x i8> [[A:%.*]], <2 x i8> [[B:%.*]], <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[CONCAT2:%.*]] = shufflevector <2 x i8> [[C:%.*]], <2 x i8> [[D:%.*]], <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[R:%.*]] = sub nsw <4 x i8> [[CONCAT1]], [[CONCAT2]]
; CHECK-NEXT:    ret <4 x i8> [[R]]
;
  %concat1 = shufflevector <2 x i8> %a, <2 x i8> %b, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %concat2 = shufflevector <2 x i8> %c, <2 x i8> %d, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %r = sub nsw <4 x i8> %concat1, %concat2
  ret <4 x i8> %r
}

; Flags should propagate.

define <4 x i8> @mul(<2 x i8> %a, <2 x i8> %b, <2 x i8> %c, <2 x i8> %d) {
; CHECK-LABEL: @mul(
; CHECK-NEXT:    [[CONCAT1:%.*]] = shufflevector <2 x i8> [[A:%.*]], <2 x i8> [[B:%.*]], <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[CONCAT2:%.*]] = shufflevector <2 x i8> [[C:%.*]], <2 x i8> [[D:%.*]], <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[R:%.*]] = mul nuw <4 x i8> [[CONCAT1]], [[CONCAT2]]
; CHECK-NEXT:    ret <4 x i8> [[R]]
;
  %concat1 = shufflevector <2 x i8> %a, <2 x i8> %b, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %concat2 = shufflevector <2 x i8> %c, <2 x i8> %d, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %r = mul nuw <4 x i8> %concat1, %concat2
  ret <4 x i8> %r
}

; Undef in shuffle mask does not necessarily propagate.

define <4 x i8> @and(<2 x i8> %a, <2 x i8> %b, <2 x i8> %c, <2 x i8> %d) {
; CHECK-LABEL: @and(
; CHECK-NEXT:    [[CONCAT1:%.*]] = shufflevector <2 x i8> [[A:%.*]], <2 x i8> [[B:%.*]], <4 x i32> <i32 undef, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[CONCAT2:%.*]] = shufflevector <2 x i8> [[C:%.*]], <2 x i8> [[D:%.*]], <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[R:%.*]] = and <4 x i8> [[CONCAT1]], [[CONCAT2]]
; CHECK-NEXT:    ret <4 x i8> [[R]]
;
  %concat1 = shufflevector <2 x i8> %a, <2 x i8> %b, <4 x i32> <i32 undef, i32 1, i32 2, i32 3>
  %concat2 = shufflevector <2 x i8> %c, <2 x i8> %d, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %r = and <4 x i8> %concat1, %concat2
  ret <4 x i8> %r
}

; Undef in shuffle mask does not necessarily propagate.

define <4 x i8> @or(<2 x i8> %a, <2 x i8> %b, <2 x i8> %c, <2 x i8> %d) {
; CHECK-LABEL: @or(
; CHECK-NEXT:    [[CONCAT1:%.*]] = shufflevector <2 x i8> [[A:%.*]], <2 x i8> [[B:%.*]], <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[CONCAT2:%.*]] = shufflevector <2 x i8> [[C:%.*]], <2 x i8> [[D:%.*]], <4 x i32> <i32 0, i32 undef, i32 2, i32 3>
; CHECK-NEXT:    [[R:%.*]] = or <4 x i8> [[CONCAT1]], [[CONCAT2]]
; CHECK-NEXT:    ret <4 x i8> [[R]]
;
  %concat1 = shufflevector <2 x i8> %a, <2 x i8> %b, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %concat2 = shufflevector <2 x i8> %c, <2 x i8> %d, <4 x i32> <i32 0, i32 undef, i32 2, i32 3>
  %r = or <4 x i8> %concat1, %concat2
  ret <4 x i8> %r
}

; Undefs in shuffle mask do not necessarily propagate.

define <4 x i8> @xor(<2 x i8> %a, <2 x i8> %b, <2 x i8> %c, <2 x i8> %d) {
; CHECK-LABEL: @xor(
; CHECK-NEXT:    [[CONCAT1:%.*]] = shufflevector <2 x i8> [[A:%.*]], <2 x i8> [[B:%.*]], <4 x i32> <i32 0, i32 undef, i32 2, i32 3>
; CHECK-NEXT:    [[CONCAT2:%.*]] = shufflevector <2 x i8> [[C:%.*]], <2 x i8> [[D:%.*]], <4 x i32> <i32 0, i32 1, i32 undef, i32 3>
; CHECK-NEXT:    [[R:%.*]] = xor <4 x i8> [[CONCAT1]], [[CONCAT2]]
; CHECK-NEXT:    ret <4 x i8> [[R]]
;
  %concat1 = shufflevector <2 x i8> %a, <2 x i8> %b, <4 x i32> <i32 0, i32 undef, i32 2, i32 3>
  %concat2 = shufflevector <2 x i8> %c, <2 x i8> %d, <4 x i32> <i32 0, i32 1, i32 undef, i32 3>
  %r = xor <4 x i8> %concat1, %concat2
  ret <4 x i8> %r
}

define <4 x i8> @shl(<2 x i8> %a, <2 x i8> %b, <2 x i8> %c, <2 x i8> %d) {
; CHECK-LABEL: @shl(
; CHECK-NEXT:    [[CONCAT1:%.*]] = shufflevector <2 x i8> [[A:%.*]], <2 x i8> [[B:%.*]], <4 x i32> <i32 0, i32 1, i32 undef, i32 3>
; CHECK-NEXT:    [[CONCAT2:%.*]] = shufflevector <2 x i8> [[C:%.*]], <2 x i8> [[D:%.*]], <4 x i32> <i32 0, i32 1, i32 undef, i32 3>
; CHECK-NEXT:    [[R:%.*]] = shl nuw <4 x i8> [[CONCAT1]], [[CONCAT2]]
; CHECK-NEXT:    ret <4 x i8> [[R]]
;
  %concat1 = shufflevector <2 x i8> %a, <2 x i8> %b, <4 x i32> <i32 0, i32 1, i32 undef, i32 3>
  %concat2 = shufflevector <2 x i8> %c, <2 x i8> %d, <4 x i32> <i32 0, i32 1, i32 undef, i32 3>
  %r = shl nuw <4 x i8> %concat1, %concat2
  ret <4 x i8> %r
}

define <4 x i8> @lshr(<2 x i8> %a, <2 x i8> %b, <2 x i8> %c, <2 x i8> %d) {
; CHECK-LABEL: @lshr(
; CHECK-NEXT:    [[CONCAT1:%.*]] = shufflevector <2 x i8> [[A:%.*]], <2 x i8> [[B:%.*]], <4 x i32> <i32 0, i32 undef, i32 undef, i32 3>
; CHECK-NEXT:    [[CONCAT2:%.*]] = shufflevector <2 x i8> [[C:%.*]], <2 x i8> [[D:%.*]], <4 x i32> <i32 0, i32 undef, i32 undef, i32 3>
; CHECK-NEXT:    [[R:%.*]] = lshr exact <4 x i8> [[CONCAT1]], [[CONCAT2]]
; CHECK-NEXT:    ret <4 x i8> [[R]]
;
  %concat1 = shufflevector <2 x i8> %a, <2 x i8> %b, <4 x i32> <i32 0, i32 undef, i32 undef, i32 3>
  %concat2 = shufflevector <2 x i8> %c, <2 x i8> %d, <4 x i32> <i32 0, i32 undef, i32 undef, i32 3>
  %r = lshr exact <4 x i8> %concat1, %concat2
  ret <4 x i8> %r
}

; Extra-uses prevent the transform.
declare void @use(<4 x i8>)

define <4 x i8> @ashr(<2 x i8> %a, <2 x i8> %b, <2 x i8> %c, <2 x i8> %d) {
; CHECK-LABEL: @ashr(
; CHECK-NEXT:    [[CONCAT1:%.*]] = shufflevector <2 x i8> [[A:%.*]], <2 x i8> [[B:%.*]], <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    call void @use(<4 x i8> [[CONCAT1]])
; CHECK-NEXT:    [[CONCAT2:%.*]] = shufflevector <2 x i8> [[C:%.*]], <2 x i8> [[D:%.*]], <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[R:%.*]] = ashr <4 x i8> [[CONCAT1]], [[CONCAT2]]
; CHECK-NEXT:    ret <4 x i8> [[R]]
;
  %concat1 = shufflevector <2 x i8> %a, <2 x i8> %b, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  call void @use(<4 x i8> %concat1)
  %concat2 = shufflevector <2 x i8> %c, <2 x i8> %d, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %r = ashr <4 x i8> %concat1, %concat2
  ret <4 x i8> %r
}

define <4 x i8> @sdiv(<2 x i8> %a, <2 x i8> %b, <2 x i8> %c, <2 x i8> %d) {
; CHECK-LABEL: @sdiv(
; CHECK-NEXT:    [[CONCAT1:%.*]] = shufflevector <2 x i8> [[A:%.*]], <2 x i8> [[B:%.*]], <4 x i32> <i32 0, i32 1, i32 undef, i32 3>
; CHECK-NEXT:    [[CONCAT2:%.*]] = shufflevector <2 x i8> [[C:%.*]], <2 x i8> [[D:%.*]], <4 x i32> <i32 0, i32 1, i32 undef, i32 3>
; CHECK-NEXT:    [[R:%.*]] = sdiv exact <4 x i8> [[CONCAT1]], [[CONCAT2]]
; CHECK-NEXT:    ret <4 x i8> [[R]]
;
  %concat1 = shufflevector <2 x i8> %a, <2 x i8> %b, <4 x i32> <i32 0, i32 1, i32 undef, i32 3>
  %concat2 = shufflevector <2 x i8> %c, <2 x i8> %d, <4 x i32> <i32 0, i32 1, i32 undef, i32 3>
  %r = sdiv exact <4 x i8> %concat1, %concat2
  ret <4 x i8> %r
}

define <4 x i8> @srem(<2 x i8> %a, <2 x i8> %b, <2 x i8> %c, <2 x i8> %d) {
; CHECK-LABEL: @srem(
; CHECK-NEXT:    [[CONCAT1:%.*]] = shufflevector <2 x i8> [[A:%.*]], <2 x i8> [[B:%.*]], <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[CONCAT2:%.*]] = shufflevector <2 x i8> [[C:%.*]], <2 x i8> [[D:%.*]], <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[R:%.*]] = srem <4 x i8> [[CONCAT1]], [[CONCAT2]]
; CHECK-NEXT:    ret <4 x i8> [[R]]
;
  %concat1 = shufflevector <2 x i8> %a, <2 x i8> %b, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %concat2 = shufflevector <2 x i8> %c, <2 x i8> %d, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %r = srem <4 x i8> %concat1, %concat2
  ret <4 x i8> %r
}

define <4 x i8> @udiv(<2 x i8> %a, <2 x i8> %b, <2 x i8> %c, <2 x i8> %d) {
; CHECK-LABEL: @udiv(
; CHECK-NEXT:    [[CONCAT1:%.*]] = shufflevector <2 x i8> [[A:%.*]], <2 x i8> [[B:%.*]], <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[CONCAT2:%.*]] = shufflevector <2 x i8> [[C:%.*]], <2 x i8> [[D:%.*]], <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[R:%.*]] = udiv exact <4 x i8> [[CONCAT1]], [[CONCAT2]]
; CHECK-NEXT:    ret <4 x i8> [[R]]
;
  %concat1 = shufflevector <2 x i8> %a, <2 x i8> %b, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %concat2 = shufflevector <2 x i8> %c, <2 x i8> %d, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %r = udiv exact <4 x i8> %concat1, %concat2
  ret <4 x i8> %r
}

define <4 x i8> @urem(<2 x i8> %a, <2 x i8> %b, <2 x i8> %c, <2 x i8> %d) {
; CHECK-LABEL: @urem(
; CHECK-NEXT:    [[CONCAT1:%.*]] = shufflevector <2 x i8> [[A:%.*]], <2 x i8> [[B:%.*]], <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[CONCAT2:%.*]] = shufflevector <2 x i8> [[C:%.*]], <2 x i8> [[D:%.*]], <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[R:%.*]] = urem <4 x i8> [[CONCAT1]], [[CONCAT2]]
; CHECK-NEXT:    ret <4 x i8> [[R]]
;
  %concat1 = shufflevector <2 x i8> %a, <2 x i8> %b, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %concat2 = shufflevector <2 x i8> %c, <2 x i8> %d, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %r = urem <4 x i8> %concat1, %concat2
  ret <4 x i8> %r
}

define <4 x float> @fadd(<2 x float> %a, <2 x float> %b, <2 x float> %c, <2 x float> %d) {
; CHECK-LABEL: @fadd(
; CHECK-NEXT:    [[CONCAT1:%.*]] = shufflevector <2 x float> [[A:%.*]], <2 x float> [[B:%.*]], <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[CONCAT2:%.*]] = shufflevector <2 x float> [[C:%.*]], <2 x float> [[D:%.*]], <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[R:%.*]] = fadd <4 x float> [[CONCAT1]], [[CONCAT2]]
; CHECK-NEXT:    ret <4 x float> [[R]]
;
  %concat1 = shufflevector <2 x float> %a, <2 x float> %b, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %concat2 = shufflevector <2 x float> %c, <2 x float> %d, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %r = fadd <4 x float> %concat1, %concat2
  ret <4 x float> %r
}

; Fast-math-flags propagate.

define <4 x float> @fsub(<2 x float> %a, <2 x float> %b, <2 x float> %c, <2 x float> %d) {
; CHECK-LABEL: @fsub(
; CHECK-NEXT:    [[CONCAT1:%.*]] = shufflevector <2 x float> [[A:%.*]], <2 x float> [[B:%.*]], <4 x i32> <i32 0, i32 1, i32 undef, i32 3>
; CHECK-NEXT:    [[CONCAT2:%.*]] = shufflevector <2 x float> [[C:%.*]], <2 x float> [[D:%.*]], <4 x i32> <i32 0, i32 1, i32 undef, i32 3>
; CHECK-NEXT:    [[R:%.*]] = fsub fast <4 x float> [[CONCAT1]], [[CONCAT2]]
; CHECK-NEXT:    ret <4 x float> [[R]]
;
  %concat1 = shufflevector <2 x float> %a, <2 x float> %b, <4 x i32> <i32 0, i32 1, i32 undef, i32 3>
  %concat2 = shufflevector <2 x float> %c, <2 x float> %d, <4 x i32> <i32 0, i32 1, i32 undef, i32 3>
  %r = fsub fast <4 x float> %concat1, %concat2
  ret <4 x float> %r
}

; Extra-uses prevent the transform.
declare void @use2(<4 x float>)

define <4 x float> @fmul(<2 x float> %a, <2 x float> %b, <2 x float> %c, <2 x float> %d) {
; CHECK-LABEL: @fmul(
; CHECK-NEXT:    [[CONCAT1:%.*]] = shufflevector <2 x float> [[A:%.*]], <2 x float> [[B:%.*]], <4 x i32> <i32 undef, i32 1, i32 undef, i32 3>
; CHECK-NEXT:    [[CONCAT2:%.*]] = shufflevector <2 x float> [[C:%.*]], <2 x float> [[D:%.*]], <4 x i32> <i32 undef, i32 1, i32 undef, i32 3>
; CHECK-NEXT:    call void @use2(<4 x float> [[CONCAT2]])
; CHECK-NEXT:    [[R:%.*]] = fmul nnan <4 x float> [[CONCAT1]], [[CONCAT2]]
; CHECK-NEXT:    ret <4 x float> [[R]]
;
  %concat1 = shufflevector <2 x float> %a, <2 x float> %b, <4 x i32> <i32 undef, i32 1, i32 undef, i32 3>
  %concat2 = shufflevector <2 x float> %c, <2 x float> %d, <4 x i32> <i32 undef, i32 1, i32 undef, i32 3>
  call void @use2(<4 x float> %concat2)
  %r = fmul nnan <4 x float> %concat1, %concat2
  ret <4 x float> %r
}

; Fast-math-flags propagate.

define <4 x float> @fdiv(<2 x float> %a, <2 x float> %b, <2 x float> %c, <2 x float> %d) {
; CHECK-LABEL: @fdiv(
; CHECK-NEXT:    [[CONCAT1:%.*]] = shufflevector <2 x float> [[A:%.*]], <2 x float> [[B:%.*]], <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[CONCAT2:%.*]] = shufflevector <2 x float> [[C:%.*]], <2 x float> [[D:%.*]], <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[R:%.*]] = fdiv ninf arcp <4 x float> [[CONCAT1]], [[CONCAT2]]
; CHECK-NEXT:    ret <4 x float> [[R]]
;
  %concat1 = shufflevector <2 x float> %a, <2 x float> %b, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %concat2 = shufflevector <2 x float> %c, <2 x float> %d, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %r = fdiv ninf arcp <4 x float> %concat1, %concat2
  ret <4 x float> %r
}

define <4 x float> @frem(<2 x float> %a, <2 x float> %b, <2 x float> %c, <2 x float> %d) {
; CHECK-LABEL: @frem(
; CHECK-NEXT:    [[CONCAT1:%.*]] = shufflevector <2 x float> [[A:%.*]], <2 x float> [[B:%.*]], <4 x i32> <i32 0, i32 undef, i32 2, i32 3>
; CHECK-NEXT:    [[CONCAT2:%.*]] = shufflevector <2 x float> [[C:%.*]], <2 x float> [[D:%.*]], <4 x i32> <i32 0, i32 undef, i32 2, i32 3>
; CHECK-NEXT:    [[R:%.*]] = frem <4 x float> [[CONCAT1]], [[CONCAT2]]
; CHECK-NEXT:    ret <4 x float> [[R]]
;
  %concat1 = shufflevector <2 x float> %a, <2 x float> %b, <4 x i32> <i32 0, i32 undef, i32 2, i32 3>
  %concat2 = shufflevector <2 x float> %c, <2 x float> %d, <4 x i32> <i32 0, i32 undef, i32 2, i32 3>
  %r = frem <4 x float> %concat1, %concat2
  ret <4 x float> %r
}

; https://bugs.llvm.org/show_bug.cgi?id=33026 - all of the shuffles can be eliminated.

define <4 x i32> @PR33026(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c, <4 x i32> %d) {
; CHECK-LABEL: @PR33026(
; CHECK-NEXT:    [[CONCAT1:%.*]] = shufflevector <4 x i32> [[A:%.*]], <4 x i32> [[B:%.*]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:    [[CONCAT2:%.*]] = shufflevector <4 x i32> [[C:%.*]], <4 x i32> [[D:%.*]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:    [[AND:%.*]] = and <8 x i32> [[CONCAT1]], [[CONCAT2]]
; CHECK-NEXT:    [[EXTRACT1:%.*]] = shufflevector <8 x i32> [[AND]], <8 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[EXTRACT2:%.*]] = shufflevector <8 x i32> [[AND]], <8 x i32> undef, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:    [[SUB:%.*]] = sub <4 x i32> [[EXTRACT1]], [[EXTRACT2]]
; CHECK-NEXT:    ret <4 x i32> [[SUB]]
;
  %concat1 = shufflevector <4 x i32> %a, <4 x i32> %b, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %concat2 = shufflevector <4 x i32> %c, <4 x i32> %d, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %and = and <8 x i32> %concat1, %concat2
  %extract1 = shufflevector <8 x i32> %and, <8 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %extract2 = shufflevector <8 x i32> %and, <8 x i32> undef, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
  %sub = sub <4 x i32> %extract1, %extract2
  ret <4 x i32> %sub
}
