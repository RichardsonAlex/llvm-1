; RUsN: %cheri_purecap_llc -cheri-cap-table-abi=plt %s -O0 -o - -print-after-all
; RUN: %cheri_purecap_llc -cheri-cap-table-abi=plt %s -O2 -o - -stop-after=expand-isel-pseudos
; RUN: %cheri_purecap_llc -cheri-cap-table-abi=plt %s -O2 -o - -stop-after=postrapseudos
; RUN: %cheri_purecap_llc -cheri-cap-table-abi=plt %s -o - -mxcaptable | %cheri_FileCheck %s
; ModuleID = '/Users/alex/cheri/llvm/tools/clang/test/CodeGen/CHERI/cap-table-call-extern.c'

; Function Attrs: nounwind
define preserve_allcc i32 @a() local_unnamed_addr #0 {
entry:
  %call = call i32 (...) @external_fn1()
  %call2 = call i32 @external_fn2()
  %result = add i32 %call, %call2
  ret i32 %result
; Make sure we don't use $gp
; CHECK: 	    cincoffset	$c11, $c11, -[[$CAP_SIZE]]
; CHECK-NEXT:	csc	$c17, $zero, 0($c11)    # [[$CAP_SIZE]]-byte Folded Spill
; CHECK-NEXT:	lui	$1, %capcall_hi(b)
; CHECK-NEXT:	daddiu	$1, $1, %capcall_lo(b)
; CHECK-NEXT:	clc	$c12, $1, 0($c26)
; CHECK-NEXT:	cjalr	$c12, $c17
; CHECK-NEXT:	nop
; CHECK-NEXT:	clc	$c17, $zero, 0($c11)    # [[$CAP_SIZE]]-byte Folded Reload
; CHECK-NEXT:	cjr	$c17
; CHECK-NEXT:	cincoffset	$c11, $c11, [[$CAP_SIZE]]
}

declare i32 @external_fn1(...)
declare i32 @external_fn2()
