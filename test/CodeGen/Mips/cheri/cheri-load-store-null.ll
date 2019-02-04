; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: %cheri_purecap_llc -O2 %s -o - -debug-only="mips-isel"
; RUN: %cheri_purecap_llc -O2 %s -o - -debug-only="mips-isel" | FileCheck %s
; RUNs: %cheri_purecap_llc -O2 %s -o - | FileCheck %s -implicit-check-not cgetnull

; struct foo {
;   void* value1;
;   void* value2;
;   void* value3;
; };
;
; void store_null1(struct foo* foo, void* arg) {
;   foo->value3 = (void*)0;
; }
;
; void store_null2(struct foo* foo, void* arg) {
;   foo->value1 = (void*)0;
;   foo->value2 = arg;
;   foo->value3 = (void*)0;
; }
;

%struct.foo = type { i8 addrspace(200)*, i8 addrspace(200)*, i8 addrspace(200)* }

; Function Attrs: norecurse nounwind writeonly
define void @store_null1(%struct.foo addrspace(200)* nocapture %foo, i8 addrspace(200)* nocapture readnone %arg) local_unnamed_addr addrspace(200) #0 {
; CHECK-LABEL: store_null1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cjr $c17
; CHECK-NEXT:    csc $cnull, $zero, 32($c3)
entry:
  %value3 = getelementptr inbounds %struct.foo, %struct.foo addrspace(200)* %foo, i64 0, i32 2
  store i8 addrspace(200)* null, i8 addrspace(200)* addrspace(200)* %value3, align 16
  ret void
}

; Function Attrs: norecurse nounwind writeonly
define void @store_null2(%struct.foo addrspace(200)* nocapture %foo, i8 addrspace(200)* %arg) local_unnamed_addr addrspace(200) #0 {
; CHECK-LABEL: store_null2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    csc $cnull, $zero, 0($c3)
; CHECK-NEXT:    csc $c4, $zero, 16($c3)
; CHECK-NEXT:    cjr $c17
; CHECK-NEXT:    csc $cnull, $zero, 32($c3)
; TODO: this could use $cnull but it doesn't matter since we had to
entry:
  %value1 = getelementptr inbounds %struct.foo, %struct.foo addrspace(200)* %foo, i64 0, i32 0
  store i8 addrspace(200)* null, i8 addrspace(200)* addrspace(200)* %value1, align 16
  %value2 = getelementptr inbounds %struct.foo, %struct.foo addrspace(200)* %foo, i64 0, i32 1
  store i8 addrspace(200)* %arg, i8 addrspace(200)* addrspace(200)* %value2, align 16
  %value3 = getelementptr inbounds %struct.foo, %struct.foo addrspace(200)* %foo, i64 0, i32 2
  store i8 addrspace(200)* null, i8 addrspace(200)* addrspace(200)* %value3, align 16
  ret void
}

; Function Attrs: norecurse nounwind writeonly
define void @store_relative_to_null(%struct.foo addrspace(200)* nocapture %foo, i8 addrspace(200)* nocapture readnone %arg) local_unnamed_addr addrspace(200) #0 {
; CHECK-LABEL: store_relative_to_null:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cgetnull $c1
; CHECK-NEXT:    cjr $c17
; CHECK-NEXT:    csc $c4, $zero, 0($c1)
entry:
  store i8 addrspace(200)* %arg, i8 addrspace(200)* addrspace(200)* null, align 16
  ret void
}

; Function Attrs: norecurse nounwind writeonly
define i8 addrspace(200)* @load_relative_to_null(%struct.foo addrspace(200)* nocapture %foo, i8 addrspace(200)* nocapture readnone %arg) local_unnamed_addr addrspace(200) #0 {
; CHECK-LABEL: load_relative_to_null:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cgetnull $c1
; CHECK-NEXT:    clc $c3, $zero, 0($c1)
; CHECK-NEXT:    cjr $c17
; CHECK-NEXT:    nop
entry:
  %result = load i8 addrspace(200)*, i8 addrspace(200)* addrspace(200)* null, align 16
  ret i8 addrspace(200)* %result
}
