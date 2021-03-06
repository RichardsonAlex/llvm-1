; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown-unknown -mattr=+sse2 | FileCheck %s

; Without any typed operations, always use the smaller xorps.
define <2 x double> @test() {
; CHECK-LABEL: test:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xorps %xmm0, %xmm0
; CHECK-NEXT:    retl
	ret <2 x double> zeroinitializer
}

; Prefer a constant pool load here.
define <4 x i32> @test2() nounwind  {
; CHECK-LABEL: test2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movaps {{.*#+}} xmm0 = [0,0,1,0]
; CHECK-NEXT:    retl
	ret <4 x i32> < i32 0, i32 0, i32 1, i32 0 >
}

