From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/4] ARM: Set separate proc-v7 functions for SMP
Date: Tue, 17 Aug 2010 13:53:28 +0300
Message-ID: <20100817105328.19061.98034.stgit@baageli.muru.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55353 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753633Ab0HQKxY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Aug 2010 06:53:24 -0400
In-Reply-To: <20100817104414.19061.38999.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, bryan.wu@canonical.com

Set separate proc-v7 functions for SMP

NOTE: The v7wbi_tlb_flags need to be checked

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/include/asm/tlbflush.h |   10 +++--
 arch/arm/mm/cache-v7.S          |   60 ++++++++++++++++++++++++++++++
 arch/arm/mm/proc-v7.S           |   77 ++++++++++++++++++++++++++++++++++++---
 arch/arm/mm/tlb-v7.S            |   51 ++++++++++++++++++++++++++
 4 files changed, 188 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index 9b310bd..0b2087e 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -191,12 +191,14 @@
 # define v6wbi_always_flags	(-1UL)
 #endif
 
-#ifdef CONFIG_SMP
-#define v7wbi_tlb_flags (TLB_WB | TLB_DCLEAN | TLB_V7_IS_BTB | \
+#define v7wbi_tlb_flags_up (TLB_WB | TLB_DCLEAN | TLB_V7_IS_BTB | \
 			 TLB_V7_UIS_FULL | TLB_V7_UIS_PAGE | TLB_V7_UIS_ASID)
-#else
-#define v7wbi_tlb_flags (TLB_WB | TLB_DCLEAN | TLB_BTB | \
+#define v7wbi_tlb_flags_smp (TLB_WB | TLB_DCLEAN | TLB_BTB | \
 			 TLB_V6_U_FULL | TLB_V6_U_PAGE | TLB_V6_U_ASID)
+#ifdef CONFIG_SMP
+#define v7wbi_tlb_flags	v7wbi_tlb_flags_smp
+#else
+#define v7wbi_tlb_flags	v7wbi_tlb_flags_up
 #endif
 
 #ifdef CONFIG_CPU_TLB_V7
diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index 37c8157..acc889c 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -101,6 +101,19 @@ ENTRY(v7_flush_kern_cache_all)
 	mov	pc, lr
 ENDPROC(v7_flush_kern_cache_all)
 
+#ifdef CONFIG_SMP_ON_UP
+ENTRY(v7_flush_kern_cache_all_up)
+ ARM(	stmfd	sp!, {r4-r5, r7, r9-r11, lr}	)
+ THUMB(	stmfd	sp!, {r4-r7, r9-r11, lr}	)
+	bl	v7_flush_dcache_all
+	mov	r0, #0
+	mcr	p15, 0, r0, c7, c5, 0		@ I+BTB cache invalidate
+ ARM(	ldmfd	sp!, {r4-r5, r7, r9-r11, lr}	)
+ THUMB(	ldmfd	sp!, {r4-r7, r9-r11, lr}	)
+	mov	pc, lr
+ENDPROC(v7_flush_kern_cache_all_up)
+#endif
+
 /*
  *	v7_flush_cache_all()
  *
@@ -193,6 +206,37 @@ ENTRY(v7_coherent_user_range)
 ENDPROC(v7_coherent_kern_range)
 ENDPROC(v7_coherent_user_range)
 
+#ifdef CONFIG_SMP_ON_UP
+ENTRY(v7_coherent_kern_range_up)
+ENTRY(v7_coherent_user_range_up)
+ UNWIND(.fnstart		)
+	dcache_line_size r2, r3
+	sub	r3, r2, #1
+	bic	r0, r0, r3
+1:
+ USER(	mcr	p15, 0, r0, c7, c11, 1	)	@ clean D line to the point of unification
+	dsb
+ USER(	mcr	p15, 0, r0, c7, c5, 1	)	@ invalidate I line
+	add	r0, r0, r2
+2:
+	cmp	r0, r1
+	blo	1b
+	mov	r0, #0
+	mcr	p15, 0, r0, c7, c5, 6		@ invalidate BTB
+	dsb
+	isb
+	mov	pc, lr
+
+9001:
+	mov	r0, r0, lsr #12
+	mov	r0, r0, lsl #12
+	add	r0, r0, #4096
+	b	2b
+ UNWIND(.fnend		)
+ENDPROC(v7_coherent_kern_range_up)
+ENDPROC(v7_coherent_user_range_up)
+#endif
+
 /*
  *	v7_flush_kern_dcache_area(void *addr, size_t size)
  *
@@ -319,3 +363,19 @@ ENTRY(v7_cache_fns)
 	.long	v7_dma_unmap_area
 	.long	v7_dma_flush_range
 	.size	v7_cache_fns, . - v7_cache_fns
+
+#ifdef CONFIG_SMP_ON_UP
+	.type	v7_cache_fns_up, #object
+ENTRY(v7_cache_fns_up)
+	.long	v7_flush_kern_cache_all_up
+	.long	v7_flush_user_cache_all
+	.long	v7_flush_user_cache_range
+	.long	v7_coherent_kern_range_up
+	.long	v7_coherent_user_range_up
+	.long	v7_flush_kern_dcache_area
+	.long	v7_dma_map_area
+	.long	v7_dma_unmap_area
+	.long	v7_dma_flush_range
+	.size	v7_cache_fns_up, . - v7_cache_fns_up
+#endif
+
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 6a8506d..65981c3 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -30,15 +30,13 @@
 #define TTB_IRGN_WT	((1 << 0) | (0 << 6))
 #define TTB_IRGN_WB	((1 << 0) | (1 << 6))
 
-#ifndef CONFIG_SMP
 /* PTWs cacheable, inner WB not shareable, outer WB not shareable */
 #define TTB_FLAGS	TTB_IRGN_WB|TTB_RGN_OC_WB
 #define PMD_FLAGS	PMD_SECT_WB
-#else
+
 /* PTWs cacheable, inner WBWA shareable, outer WBWA not shareable */
-#define TTB_FLAGS	TTB_IRGN_WBWA|TTB_S|TTB_NOS|TTB_RGN_OC_WBWA
-#define PMD_FLAGS	PMD_SECT_WBWA|PMD_SECT_S
-#endif
+#define TTB_FLAGS_SMP	TTB_IRGN_WBWA|TTB_S|TTB_NOS|TTB_RGN_OC_WBWA
+#define PMD_FLAGS_SMP	PMD_SECT_WBWA|PMD_SECT_S
 
 ENTRY(cpu_v7_proc_init)
 	mov	pc, lr
@@ -105,7 +103,11 @@ ENTRY(cpu_v7_switch_mm)
 #ifdef CONFIG_MMU
 	mov	r2, #0
 	ldr	r1, [r1, #MM_CONTEXT_ID]	@ get mm->context.id
+#ifdef CONFIG_SMP
+	orr	r0, r0, #TTB_FLAGS_SMP
+#else
 	orr	r0, r0, #TTB_FLAGS
+#endif
 #ifdef CONFIG_ARM_ERRATA_430973
 	mcr	p15, 0, r2, c7, c5, 6		@ flush BTAC/BTB
 #endif
@@ -119,6 +121,31 @@ ENTRY(cpu_v7_switch_mm)
 	mov	pc, lr
 ENDPROC(cpu_v7_switch_mm)
 
+#ifdef CONFIG_SMP_ON_UP
+/*
+ *	cpu_v7_switch_mm_up(pgd_phys, tsk)
+ *
+ *	For booting SMP kerner on uniprocessor system
+ */
+ENTRY(cpu_v7_switch_mm_up)
+#ifdef CONFIG_MMU
+	mov	r2, #0
+	ldr	r1, [r1, #MM_CONTEXT_ID]	@ get mm->context.id
+	orr	r0, r0, #TTB_FLAGS
+#ifdef CONFIG_ARM_ERRATA_430973
+	mcr	p15, 0, r2, c7, c5, 6		@ flush BTAC/BTB
+#endif
+	mcr	p15, 0, r2, c13, c0, 1		@ set reserved context ID
+	isb
+1:	mcr	p15, 0, r0, c2, c0, 0		@ set TTB 0
+	isb
+	mcr	p15, 0, r1, c13, c0, 1		@ set context ID
+	isb
+#endif
+	mov	pc, lr
+ENDPROC(cpu_v7_switch_mm_up)
+#endif
+
 /*
  *	cpu_v7_set_pte_ext(ptep, pte)
  *
@@ -188,10 +215,17 @@ cpu_v7_name:
  */
 __v7_setup:
 #ifdef CONFIG_SMP
+	mrc	p15, 0, r0, c0, c0, 5		@ read MPIDR
+	mov	r0, r0, lsr #30			@ get processor format and U bit
+	cmp	r0, #0				@ old style MPIDR?
+	beq	1f				@ yes, cortex-A8, uniprocessor
+	cmp	r0, #3				@ new style MPIDR uniprocessor?
+	beq	1f				@ yes, not SMP
 	mrc	p15, 0, r0, c1, c0, 1
 	tst	r0, #(1 << 6)			@ SMP/nAMP mode enabled?
 	orreq	r0, r0, #(1 << 6) | (1 << 0)	@ Enable SMP/nAMP mode and
 	mcreq	p15, 0, r0, c1, c0, 1		@ TLB ops broadcasting
+1:
 #endif
 	adr	r12, __v7_setup_stack		@ the local stack
 	stmia	r12, {r0-r5, r7, r9, r11, lr}
@@ -235,7 +269,18 @@ __v7_setup:
 #ifdef CONFIG_MMU
 	mcr	p15, 0, r10, c8, c7, 0		@ invalidate I + D TLBs
 	mcr	p15, 0, r10, c2, c0, 2		@ TTB control register
+#ifdef CONFIG_SMP
+	mrc	p15, 0, r10, c0, c0, 5		@ read MPIDR
+	mov	r10, r10, lsr #30		@ processor format and U bit
+	cmp	r10, #0				@ old style MPIDR?
+	orreq	r4, r4, #TTB_FLAGS		@ yes, cortex-A8, uniprocessor
+	cmpne	r10, #3				@ new style MPIDR uniprocessor?
+	orreq	r4, r4, #TTB_FLAGS		@ yes, uniprocessor mode
+	orrne	r4, r4, #TTB_FLAGS_SMP		@ in SMP mode
+	mov	r10, #0
+#else
 	orr	r4, r4, #TTB_FLAGS
+#endif
 	mcr	p15, 0, r4, c2, c0, 1		@ load TTB1
 	mov	r10, #0x1f			@ domains 0, 1 = manager
 	mcr	p15, 0, r10, c3, c0, 0		@ load domain access register
@@ -310,6 +355,21 @@ ENTRY(v7_processor_functions)
 	.word	cpu_v7_set_pte_ext
 	.size	v7_processor_functions, . - v7_processor_functions
 
+#ifdef CONFIG_SMP_ON_UP
+	.type	v7_processor_functions_up, #object
+ENTRY(v7_processor_functions_up)
+	.word	v7_early_abort
+	.word	v7_pabort
+	.word	cpu_v7_proc_init
+	.word	cpu_v7_proc_fin
+	.word	cpu_v7_reset
+	.word	cpu_v7_do_idle
+	.word	cpu_v7_dcache_clean_area
+	.word	cpu_v7_switch_mm_up
+	.word	cpu_v7_set_pte_ext
+	.size	v7_processor_functions_up, . - v7_processor_functions_up
+#endif
+
 	.type	cpu_arch_name, #object
 cpu_arch_name:
 	.asciz	"armv7"
@@ -333,7 +393,7 @@ __v7_proc_info:
 	.long   PMD_TYPE_SECT | \
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ | \
-		PMD_FLAGS
+		PMD_FLAGS		@ UP flags on SMP during initial setup
 	.long   PMD_TYPE_SECT | \
 		PMD_SECT_XN | \
 		PMD_SECT_AP_WRITE | \
@@ -347,4 +407,9 @@ __v7_proc_info:
 	.long	v7wbi_tlb_fns
 	.long	v6_user_fns
 	.long	v7_cache_fns
+#ifdef CONFIG_SMP_ON_UP
+	.long	v7_processor_functions_up
+	.long	v7wbi_tlb_fns_up
+	.long	v7_cache_fns_up
+#endif
 	.size	__v7_proc_info, . - __v7_proc_info
diff --git a/arch/arm/mm/tlb-v7.S b/arch/arm/mm/tlb-v7.S
index f3f288a..9e40b03 100644
--- a/arch/arm/mm/tlb-v7.S
+++ b/arch/arm/mm/tlb-v7.S
@@ -59,6 +59,28 @@ ENTRY(v7wbi_flush_user_tlb_range)
 	mov	pc, lr
 ENDPROC(v7wbi_flush_user_tlb_range)
 
+#ifdef CONFIG_SMP_ON_UP
+ENTRY(v7wbi_flush_user_tlb_range_up)
+	vma_vm_mm r3, r2			@ get vma->vm_mm
+	mmid	r3, r3				@ get vm_mm->context.id
+	dsb
+	mov	r0, r0, lsr #PAGE_SHIFT		@ align address
+	mov	r1, r1, lsr #PAGE_SHIFT
+	asid	r3, r3				@ mask ASID
+	orr	r0, r3, r0, lsl #PAGE_SHIFT	@ Create initial MVA
+	mov	r1, r1, lsl #PAGE_SHIFT
+1:
+	mcr	p15, 0, r0, c8, c7, 1		@ TLB invalidate U MVA
+	add	r0, r0, #PAGE_SZ
+	cmp	r0, r1
+	blo	1b
+	mov	ip, #0
+	mcr	p15, 0, ip, c7, c5, 6		@ flush BTAC/BTB
+	dsb
+	mov	pc, lr
+ENDPROC(v7wbi_flush_user_tlb_range_up)
+#endif
+
 /*
  *	v7wbi_flush_kern_tlb_range(start,end)
  *
@@ -93,6 +115,26 @@ ENTRY(v7wbi_flush_kern_tlb_range)
 	mov	pc, lr
 ENDPROC(v7wbi_flush_kern_tlb_range)
 
+#ifdef CONFIG_SMP_ON_UP
+ENTRY(v7wbi_flush_kern_tlb_range_up)
+	dsb
+	mov	r0, r0, lsr #PAGE_SHIFT		@ align address
+	mov	r1, r1, lsr #PAGE_SHIFT
+	mov	r0, r0, lsl #PAGE_SHIFT
+	mov	r1, r1, lsl #PAGE_SHIFT
+1:
+	mcr	p15, 0, r0, c8, c7, 1		@ TLB invalidate U MVA
+	add	r0, r0, #PAGE_SZ
+	cmp	r0, r1
+	blo	1b
+	mov	r2, #0
+	mcr	p15, 0, r2, c7, c5, 6		@ flush BTAC/BTB
+	dsb
+	isb
+	mov	pc, lr
+ENDPROC(v7wbi_flush_kern_tlb_range_up)
+#endif
+
 	__INIT
 
 	.type	v7wbi_tlb_fns, #object
@@ -101,3 +143,12 @@ ENTRY(v7wbi_tlb_fns)
 	.long	v7wbi_flush_kern_tlb_range
 	.long	v7wbi_tlb_flags
 	.size	v7wbi_tlb_fns, . - v7wbi_tlb_fns
+
+#ifdef CONFIG_SMP_ON_UP
+	.type	v7wbi_tlb_fns_up, #object
+ENTRY(v7wbi_tlb_fns_up)
+	.long	v7wbi_flush_user_tlb_range_up
+	.long	v7wbi_flush_kern_tlb_range_up
+	.long	v7wbi_tlb_flags_up
+	.size	v7wbi_tlb_fns_up, . - v7wbi_tlb_fns_up
+#endif

