From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 2/6] ARM: pm: add generic CPU suspend/resume support
Date: Fri, 11 Feb 2011 16:17:54 +0000
Message-ID: <E1Pnvgw-0002yZ-M0@rmk-PC.arm.linux.org.uk>
References: <20110211161626.GA31356@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34505 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757677Ab1BKQSU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Feb 2011 11:18:20 -0500
In-Reply-To: <20110211161626.GA31356@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

This adds core support for saving and restoring CPU coprocessor
registers for suspend/resume support.  This contains support for suspend
with ARM920, ARM926, SA11x0, PXA25x, PXA27x, PXA3xx, V6 and V7 CPUs.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/glue-proc.h |    3 +
 arch/arm/include/asm/proc-fns.h  |    7 ++
 arch/arm/kernel/Makefile         |    1 +
 arch/arm/kernel/asm-offsets.c    |    9 +++
 arch/arm/kernel/sleep.S          |  110 ++++++++++++++++++++++++++++++++++++
 arch/arm/mm/proc-arm1020.S       |    3 +
 arch/arm/mm/proc-arm1020e.S      |    3 +
 arch/arm/mm/proc-arm1022.S       |    3 +
 arch/arm/mm/proc-arm1026.S       |    3 +
 arch/arm/mm/proc-arm6_7.S        |    6 ++
 arch/arm/mm/proc-arm720.S        |    3 +
 arch/arm/mm/proc-arm740.S        |    3 +
 arch/arm/mm/proc-arm7tdmi.S      |    3 +
 arch/arm/mm/proc-arm920.S        |   37 ++++++++++++
 arch/arm/mm/proc-arm922.S        |    3 +
 arch/arm/mm/proc-arm925.S        |    3 +
 arch/arm/mm/proc-arm926.S        |   37 ++++++++++++
 arch/arm/mm/proc-arm940.S        |    3 +
 arch/arm/mm/proc-arm946.S        |    3 +
 arch/arm/mm/proc-arm9tdmi.S      |    3 +
 arch/arm/mm/proc-fa526.S         |    3 +
 arch/arm/mm/proc-feroceon.S      |    3 +
 arch/arm/mm/proc-mohawk.S        |    3 +
 arch/arm/mm/proc-sa110.S         |    3 +
 arch/arm/mm/proc-sa1100.S        |   39 +++++++++++++
 arch/arm/mm/proc-v6.S            |   50 ++++++++++++++++
 arch/arm/mm/proc-v7.S            |  116 ++++++++++++++++++++++++++++----------
 arch/arm/mm/proc-xsc3.S          |   48 +++++++++++++++-
 arch/arm/mm/proc-xscale.S        |   45 ++++++++++++++-
 29 files changed, 523 insertions(+), 33 deletions(-)
 create mode 100644 arch/arm/kernel/sleep.S

diff --git a/arch/arm/include/asm/glue-proc.h b/arch/arm/include/asm/glue-proc.h
index e3bf443..6469521 100644
--- a/arch/arm/include/asm/glue-proc.h
+++ b/arch/arm/include/asm/glue-proc.h
@@ -256,6 +256,9 @@
 #define cpu_dcache_clean_area		__glue(CPU_NAME,_dcache_clean_area)
 #define cpu_do_switch_mm		__glue(CPU_NAME,_switch_mm)
 #define cpu_set_pte_ext			__glue(CPU_NAME,_set_pte_ext)
+#define cpu_suspend_size		__glue(CPU_NAME,_suspend_size)
+#define cpu_do_suspend			__glue(CPU_NAME,_do_suspend)
+#define cpu_do_resume			__glue(CPU_NAME,_do_resume)
 #endif
 
 #endif
diff --git a/arch/arm/include/asm/proc-fns.h b/arch/arm/include/asm/proc-fns.h
index 6980215..8ec535e 100644
--- a/arch/arm/include/asm/proc-fns.h
+++ b/arch/arm/include/asm/proc-fns.h
@@ -66,6 +66,11 @@ extern struct processor {
 	 * ignore 'ext'.
 	 */
 	void (*set_pte_ext)(pte_t *ptep, pte_t pte, unsigned int ext);
+
+	/* Suspend/resume */
+	unsigned int suspend_size;
+	void (*do_suspend)(void *);
+	void (*do_resume)(void *);
 } processor;
 
 #ifndef MULTI_CPU
@@ -86,6 +91,8 @@ extern void cpu_reset(unsigned long addr) __attribute__((noreturn));
 #define cpu_do_switch_mm(pgd,mm)	processor.switch_mm(pgd,mm)
 #endif
 
+extern void cpu_resume(void);
+
 #include <asm/memory.h>
 
 #ifdef CONFIG_MMU
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 185ee82..74554f1 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_MODULES)		+= armksyms.o module.o
 obj-$(CONFIG_ARTHUR)		+= arthur.o
 obj-$(CONFIG_ISA_DMA)		+= dma-isa.o
 obj-$(CONFIG_PCI)		+= bios32.o isa.o
+obj-$(CONFIG_PM)		+= sleep.o
 obj-$(CONFIG_HAVE_SCHED_CLOCK)	+= sched_clock.o
 obj-$(CONFIG_SMP)		+= smp.o smp_tlb.o
 obj-$(CONFIG_HAVE_ARM_SCU)	+= smp_scu.o
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 5302a91..927522c 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/dma-mapping.h>
+#include <asm/cacheflush.h>
 #include <asm/glue-df.h>
 #include <asm/glue-pf.h>
 #include <asm/mach/arch.h>
@@ -116,6 +117,14 @@ int main(void)
 #ifdef MULTI_PABORT
   DEFINE(PROCESSOR_PABT_FUNC,	offsetof(struct processor, _prefetch_abort));
 #endif
+#ifdef MULTI_CPU
+  DEFINE(CPU_SLEEP_SIZE,	offsetof(struct processor, suspend_size));
+  DEFINE(CPU_DO_SUSPEND,	offsetof(struct processor, do_suspend));
+  DEFINE(CPU_DO_RESUME,		offsetof(struct processor, do_resume));
+#endif
+#ifdef MULTI_CACHE
+  DEFINE(CACHE_FLUSH_KERN_ALL,	offsetof(struct cpu_cache_fns, flush_kern_all));
+#endif
   BLANK();
   DEFINE(DMA_BIDIRECTIONAL,	DMA_BIDIRECTIONAL);
   DEFINE(DMA_TO_DEVICE,		DMA_TO_DEVICE);
diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
new file mode 100644
index 0000000..9f106fa
--- /dev/null
+++ b/arch/arm/kernel/sleep.S
@@ -0,0 +1,110 @@
+#include <linux/linkage.h>
+#include <asm/asm-offsets.h>
+#include <asm/assembler.h>
+#include <asm/glue-cache.h>
+#include <asm/glue-proc.h>
+	.text
+
+/*
+ * Save CPU state for a suspend
+ *  r1 = v:p offset
+ *  r3 = virtual return function
+ * Note: sp is decremented to allocate space for CPU state on stack
+ * r0-r3,r9,r10,lr corrupted
+ */
+ENTRY(cpu_suspend)
+	mov	r9, lr
+#ifdef MULTI_CPU
+	ldr	r10, =processor
+	mov	r2, sp			@ current virtual SP
+	ldr	r0, [r10, #CPU_SLEEP_SIZE] @ size of CPU sleep state
+	ldr	ip, [r10, #CPU_DO_RESUME] @ virtual resume function
+	sub	sp, sp, r0		@ allocate CPU state on stack
+	mov	r0, sp			@ save pointer
+	add	ip, ip, r1		@ convert resume fn to phys
+	stmfd	sp!, {r1, r2, r3, ip}	@ save v:p, virt SP, retfn, phys resume fn
+	ldr	r3, =sleep_save_sp
+	add	r2, sp, r1		@ convert SP to phys
+	str	r2, [r3]		@ save phys SP
+	mov	lr, pc
+	ldr	pc, [r10, #CPU_DO_SUSPEND] @ save CPU state
+#else
+	mov	r2, sp			@ current virtual SP
+	ldr	r0, =cpu_suspend_size
+	sub	sp, sp, r0		@ allocate CPU state on stack
+	mov	r0, sp			@ save pointer
+	stmfd	sp!, {r1, r2, r3}	@ save v:p, virt SP, return fn
+	ldr	r3, =sleep_save_sp
+	add	r2, sp, r1		@ convert SP to phys
+	str	r2, [r3]		@ save phys SP
+	bl	cpu_do_suspend
+#endif
+
+	@ flush data cache
+#ifdef MULTI_CACHE
+	ldr	r10, =cpu_cache
+	mov	lr, r9
+	ldr	pc, [r10, #CACHE_FLUSH_KERN_ALL]
+#else
+	mov	lr, r9
+	b	__cpuc_flush_kern_all
+#endif
+ENDPROC(cpu_suspend)
+	.ltorg
+
+/*
+ * r0 = control register value
+ * r1 = v:p offset (preserved by cpu_do_resume)
+ * r2 = phys page table base
+ * r3 = L1 section flags
+ */
+ENTRY(cpu_resume_mmu)
+	adr	r4, cpu_resume_turn_mmu_on
+	mov	r4, r4, lsr #20
+	orr	r3, r3, r4, lsl #20
+	ldr	r5, [r2, r4, lsl #2]	@ save old mapping
+	str	r3, [r2, r4, lsl #2]	@ setup 1:1 mapping for mmu code
+	sub	r2, r2, r1
+	ldr	r3, =cpu_resume_after_mmu
+	b	cpu_resume_turn_mmu_on
+ENDPROC(cpu_resume_mmu)
+	.ltorg
+	.align	5
+cpu_resume_turn_mmu_on:
+	mcr	p15, 0, r0, c1, c0, 0	@ turn on MMU, caches, etc
+	mrc	p15, 0, r0, c0, c0, 0	@ read id reg
+	mov	r0, r0
+	mov	r0, r0
+	mov	pc, r3			@ jump to virtual address
+ENDPROC(cpu_resume_turn_mmu_on)
+cpu_resume_after_mmu:
+	str	r5, [r2, r4, lsl #2]	@ restore old mapping
+#ifdef MULTI_CACHE
+	ldr	r10, =cpu_cache
+	ldr	pc, [r10, #CACHE_FLUSH_KERN_ALL]
+#else
+	b	__cpuc_flush_kern_all
+#endif
+
+/*
+ * Note: Yes, part of the following code is located into the .data section.
+ *       This is to allow sleep_save_sp to be accessed with a relative load
+ *       while we can't rely on any MMU translation.  We could have put
+ *       sleep_save_sp in the .text section as well, but some setups might
+ *       insist on it to be truly read-only.
+ */
+	.data
+	.align
+ENTRY(cpu_resume)
+	ldr	r0, sleep_save_sp	@ stack phys addr
+	msr	cpsr_c, #PSR_I_BIT | PSR_F_BIT | SVC_MODE @ set SVC, irqs off
+#ifdef MULTI_CPU
+	ldmia	r0!, {r1, sp, lr, pc}	@ load v:p, stack, return fn, resume fn
+#else
+	ldmia	r0!, {r1, sp, lr}	@ load v:p, stack, return fn
+	b	cpu_do_resume
+#endif
+ENDPROC(cpu_resume)
+
+sleep_save_sp:
+	.word	0				@ preserve stack phys ptr here
diff --git a/arch/arm/mm/proc-arm1020.S b/arch/arm/mm/proc-arm1020.S
index bcf748d..226e3d8 100644
--- a/arch/arm/mm/proc-arm1020.S
+++ b/arch/arm/mm/proc-arm1020.S
@@ -493,6 +493,9 @@ arm1020_processor_functions:
 	.word	cpu_arm1020_dcache_clean_area
 	.word	cpu_arm1020_switch_mm
 	.word	cpu_arm1020_set_pte_ext
+	.word	0
+	.word	0
+	.word	0
 	.size	arm1020_processor_functions, . - arm1020_processor_functions
 
 	.section ".rodata"
diff --git a/arch/arm/mm/proc-arm1020e.S b/arch/arm/mm/proc-arm1020e.S
index ab7ec26..86d9c2c 100644
--- a/arch/arm/mm/proc-arm1020e.S
+++ b/arch/arm/mm/proc-arm1020e.S
@@ -474,6 +474,9 @@ arm1020e_processor_functions:
 	.word	cpu_arm1020e_dcache_clean_area
 	.word	cpu_arm1020e_switch_mm
 	.word	cpu_arm1020e_set_pte_ext
+	.word	0
+	.word	0
+	.word	0
 	.size	arm1020e_processor_functions, . - arm1020e_processor_functions
 
 	.section ".rodata"
diff --git a/arch/arm/mm/proc-arm1022.S b/arch/arm/mm/proc-arm1022.S
index 831c5e5..83d3dd3 100644
--- a/arch/arm/mm/proc-arm1022.S
+++ b/arch/arm/mm/proc-arm1022.S
@@ -457,6 +457,9 @@ arm1022_processor_functions:
 	.word	cpu_arm1022_dcache_clean_area
 	.word	cpu_arm1022_switch_mm
 	.word	cpu_arm1022_set_pte_ext
+	.word	0
+	.word	0
+	.word	0
 	.size	arm1022_processor_functions, . - arm1022_processor_functions
 
 	.section ".rodata"
diff --git a/arch/arm/mm/proc-arm1026.S b/arch/arm/mm/proc-arm1026.S
index e3f7e9a..686043e 100644
--- a/arch/arm/mm/proc-arm1026.S
+++ b/arch/arm/mm/proc-arm1026.S
@@ -452,6 +452,9 @@ arm1026_processor_functions:
 	.word	cpu_arm1026_dcache_clean_area
 	.word	cpu_arm1026_switch_mm
 	.word	cpu_arm1026_set_pte_ext
+	.word	0
+	.word	0
+	.word	0
 	.size	arm1026_processor_functions, . - arm1026_processor_functions
 
 	.section .rodata
diff --git a/arch/arm/mm/proc-arm6_7.S b/arch/arm/mm/proc-arm6_7.S
index 6a7be18..5f79dc4 100644
--- a/arch/arm/mm/proc-arm6_7.S
+++ b/arch/arm/mm/proc-arm6_7.S
@@ -284,6 +284,9 @@ ENTRY(arm6_processor_functions)
 		.word	cpu_arm6_dcache_clean_area
 		.word	cpu_arm6_switch_mm
 		.word	cpu_arm6_set_pte_ext
+		.word	0
+		.word	0
+		.word	0
 		.size	arm6_processor_functions, . - arm6_processor_functions
 
 /*
@@ -301,6 +304,9 @@ ENTRY(arm7_processor_functions)
 		.word	cpu_arm7_dcache_clean_area
 		.word	cpu_arm7_switch_mm
 		.word	cpu_arm7_set_pte_ext
+		.word	0
+		.word	0
+		.word	0
 		.size	arm7_processor_functions, . - arm7_processor_functions
 
 		.section ".rodata"
diff --git a/arch/arm/mm/proc-arm720.S b/arch/arm/mm/proc-arm720.S
index c285395..665266d 100644
--- a/arch/arm/mm/proc-arm720.S
+++ b/arch/arm/mm/proc-arm720.S
@@ -185,6 +185,9 @@ ENTRY(arm720_processor_functions)
 		.word	cpu_arm720_dcache_clean_area
 		.word	cpu_arm720_switch_mm
 		.word	cpu_arm720_set_pte_ext
+		.word	0
+		.word	0
+		.word	0
 		.size	arm720_processor_functions, . - arm720_processor_functions
 
 		.section ".rodata"
diff --git a/arch/arm/mm/proc-arm740.S b/arch/arm/mm/proc-arm740.S
index 38b27dc..6f9d12e 100644
--- a/arch/arm/mm/proc-arm740.S
+++ b/arch/arm/mm/proc-arm740.S
@@ -130,6 +130,9 @@ ENTRY(arm740_processor_functions)
 	.word	cpu_arm740_dcache_clean_area
 	.word	cpu_arm740_switch_mm
 	.word	0			@ cpu_*_set_pte
+	.word	0
+	.word	0
+	.word	0
 	.size	arm740_processor_functions, . - arm740_processor_functions
 
 	.section ".rodata"
diff --git a/arch/arm/mm/proc-arm7tdmi.S b/arch/arm/mm/proc-arm7tdmi.S
index 0c9786d..e4c165c 100644
--- a/arch/arm/mm/proc-arm7tdmi.S
+++ b/arch/arm/mm/proc-arm7tdmi.S
@@ -70,6 +70,9 @@ ENTRY(arm7tdmi_processor_functions)
 		.word	cpu_arm7tdmi_dcache_clean_area
 		.word	cpu_arm7tdmi_switch_mm
 		.word	0		@ cpu_*_set_pte
+		.word	0
+		.word	0
+		.word	0
 		.size	arm7tdmi_processor_functions, . - arm7tdmi_processor_functions
 
 		.section ".rodata"
diff --git a/arch/arm/mm/proc-arm920.S b/arch/arm/mm/proc-arm920.S
index 6109f27..b2705de 100644
--- a/arch/arm/mm/proc-arm920.S
+++ b/arch/arm/mm/proc-arm920.S
@@ -387,6 +387,40 @@ ENTRY(cpu_arm920_set_pte_ext)
 #endif
 	mov	pc, lr
 
+/* Suspend/resume support: taken from arch/arm/plat-s3c24xx/sleep.S */
+.globl	arm920_suspend_size
+.equ	arm920_suspend_size, 4 * 3
+#ifdef CONFIG_PM
+ENTRY(arm920_do_suspend)
+	stmfd	sp!, {r4 - r7, lr}
+	mrc	p15, 0, r4, c13, c0, 0	@ PID
+	mrc	p15, 0, r5, c3, c0, 0	@ Domain ID
+	mrc	p15, 0, r6, c2, c0, 0	@ TTB address
+	mrc	p15, 0, r7, c1, c0, 0	@ Control register
+	stmia	r0, {r4 - r7}
+	ldmfd	sp!, {r4 - r7, pc}
+ENDPROC(arm920_do_suspend)
+
+ENTRY(arm920_do_resume)
+	mov	ip, #0
+	mcr	p15, 0, ip, c8, c7, 0	@ invalidate I+D TLBs
+	mcr	p15, 0, ip, c7, c7, 0	@ invalidate I+D caches
+	ldmia	r0, {r4 - r7}
+	mcr	p15, 0, r4, c13, c0, 0	@ PID
+	mcr	p15, 0, r5, c3, c0, 0	@ Domain ID
+	mcr	p15, 0, r6, c2, c0, 0	@ TTB address
+	mov	r0, r7			@ control register
+	mov	r2, r6, lsr #14		@ get TTB0 base
+	mov	r2, r2, lsl #14
+	ldr	r3, =PMD_TYPE_SECT | PMD_SECT_BUFFERABLE | \
+		     PMD_SECT_CACHEABLE | PMD_BIT4 | PMD_SECT_AP_WRITE
+	b	cpu_resume_mmu
+ENDPROC(arm920_do_resume)
+#else
+#define arm920_do_suspend	0
+#define arm920_do_resume	0
+#endif
+
 	__CPUINIT
 
 	.type	__arm920_setup, #function
@@ -432,6 +466,9 @@ arm920_processor_functions:
 	.word	cpu_arm920_dcache_clean_area
 	.word	cpu_arm920_switch_mm
 	.word	cpu_arm920_set_pte_ext
+	.word	arm920_suspend_size
+	.word	arm920_do_suspend
+	.word	arm920_do_resume
 	.size	arm920_processor_functions, . - arm920_processor_functions
 
 	.section ".rodata"
diff --git a/arch/arm/mm/proc-arm922.S b/arch/arm/mm/proc-arm922.S
index bb2f0f4..36154b1 100644
--- a/arch/arm/mm/proc-arm922.S
+++ b/arch/arm/mm/proc-arm922.S
@@ -436,6 +436,9 @@ arm922_processor_functions:
 	.word	cpu_arm922_dcache_clean_area
 	.word	cpu_arm922_switch_mm
 	.word	cpu_arm922_set_pte_ext
+	.word	0
+	.word	0
+	.word	0
 	.size	arm922_processor_functions, . - arm922_processor_functions
 
 	.section ".rodata"
diff --git a/arch/arm/mm/proc-arm925.S b/arch/arm/mm/proc-arm925.S
index c13e01a..89c5e00 100644
--- a/arch/arm/mm/proc-arm925.S
+++ b/arch/arm/mm/proc-arm925.S
@@ -503,6 +503,9 @@ arm925_processor_functions:
 	.word	cpu_arm925_dcache_clean_area
 	.word	cpu_arm925_switch_mm
 	.word	cpu_arm925_set_pte_ext
+	.word	0
+	.word	0
+	.word	0
 	.size	arm925_processor_functions, . - arm925_processor_functions
 
 	.section ".rodata"
diff --git a/arch/arm/mm/proc-arm926.S b/arch/arm/mm/proc-arm926.S
index 42eb431..3beb784 100644
--- a/arch/arm/mm/proc-arm926.S
+++ b/arch/arm/mm/proc-arm926.S
@@ -401,6 +401,40 @@ ENTRY(cpu_arm926_set_pte_ext)
 #endif
 	mov	pc, lr
 
+/* Suspend/resume support: taken from arch/arm/plat-s3c24xx/sleep.S */
+.globl	arm926_suspend_size
+.equ	arm926_suspend_size, 4 * 3
+#ifdef CONFIG_PM
+ENTRY(arm926_do_suspend)
+	stmfd	sp!, {r4 - r7, lr}
+	mrc	p15, 0, r4, c13, c0, 0	@ PID
+	mrc	p15, 0, r5, c3, c0, 0	@ Domain ID
+	mrc	p15, 0, r6, c2, c0, 0	@ TTB address
+	mrc	p15, 0, r7, c1, c0, 0	@ Control register
+	stmia	r0, {r4 - r7}
+	ldmfd	sp!, {r4 - r7, pc}
+ENDPROC(arm926_do_suspend)
+
+ENTRY(arm926_do_resume)
+	mov	ip, #0
+	mcr	p15, 0, ip, c8, c7, 0	@ invalidate I+D TLBs
+	mcr	p15, 0, ip, c7, c7, 0	@ invalidate I+D caches
+	ldmia	r0, {r4 - r7}
+	mcr	p15, 0, r4, c13, c0, 0	@ PID
+	mcr	p15, 0, r5, c3, c0, 0	@ Domain ID
+	mcr	p15, 0, r6, c2, c0, 0	@ TTB address
+	mov	r0, r7			@ control register
+	mov	r2, r6, lsr #14		@ get TTB0 base
+	mov	r2, r2, lsl #14
+	ldr	r3, =PMD_TYPE_SECT | PMD_SECT_BUFFERABLE | \
+		     PMD_SECT_CACHEABLE | PMD_BIT4 | PMD_SECT_AP_WRITE
+	b	cpu_resume_mmu
+ENDPROC(arm926_do_resume)
+#else
+#define arm926_do_suspend	0
+#define arm926_do_resume	0
+#endif
+
 	__CPUINIT
 
 	.type	__arm926_setup, #function
@@ -456,6 +490,9 @@ arm926_processor_functions:
 	.word	cpu_arm926_dcache_clean_area
 	.word	cpu_arm926_switch_mm
 	.word	cpu_arm926_set_pte_ext
+	.word	arm926_suspend_size
+	.word	arm926_do_suspend
+	.word	arm926_do_resume
 	.size	arm926_processor_functions, . - arm926_processor_functions
 
 	.section ".rodata"
diff --git a/arch/arm/mm/proc-arm940.S b/arch/arm/mm/proc-arm940.S
index 7b11cdb..26aea3f 100644
--- a/arch/arm/mm/proc-arm940.S
+++ b/arch/arm/mm/proc-arm940.S
@@ -363,6 +363,9 @@ ENTRY(arm940_processor_functions)
 	.word	cpu_arm940_dcache_clean_area
 	.word	cpu_arm940_switch_mm
 	.word	0		@ cpu_*_set_pte
+	.word	0
+	.word	0
+	.word	0
 	.size	arm940_processor_functions, . - arm940_processor_functions
 
 	.section ".rodata"
diff --git a/arch/arm/mm/proc-arm946.S b/arch/arm/mm/proc-arm946.S
index 1a5bbf0..8063345 100644
--- a/arch/arm/mm/proc-arm946.S
+++ b/arch/arm/mm/proc-arm946.S
@@ -419,6 +419,9 @@ ENTRY(arm946_processor_functions)
 	.word	cpu_arm946_dcache_clean_area
 	.word	cpu_arm946_switch_mm
 	.word	0		@ cpu_*_set_pte
+	.word	0
+	.word	0
+	.word	0
 	.size	arm946_processor_functions, . - arm946_processor_functions
 
 	.section ".rodata"
diff --git a/arch/arm/mm/proc-arm9tdmi.S b/arch/arm/mm/proc-arm9tdmi.S
index db67e31..7b7ebd4 100644
--- a/arch/arm/mm/proc-arm9tdmi.S
+++ b/arch/arm/mm/proc-arm9tdmi.S
@@ -70,6 +70,9 @@ ENTRY(arm9tdmi_processor_functions)
 		.word	cpu_arm9tdmi_dcache_clean_area
 		.word	cpu_arm9tdmi_switch_mm
 		.word	0		@ cpu_*_set_pte
+		.word	0
+		.word	0
+		.word	0
 		.size	arm9tdmi_processor_functions, . - arm9tdmi_processor_functions
 
 		.section ".rodata"
diff --git a/arch/arm/mm/proc-fa526.S b/arch/arm/mm/proc-fa526.S
index 7c9ad62..fc2a4ae 100644
--- a/arch/arm/mm/proc-fa526.S
+++ b/arch/arm/mm/proc-fa526.S
@@ -195,6 +195,9 @@ fa526_processor_functions:
 	.word	cpu_fa526_dcache_clean_area
 	.word	cpu_fa526_switch_mm
 	.word	cpu_fa526_set_pte_ext
+	.word	0
+	.word	0
+	.word	0
 	.size	fa526_processor_functions, . - fa526_processor_functions
 
 	.section ".rodata"
diff --git a/arch/arm/mm/proc-feroceon.S b/arch/arm/mm/proc-feroceon.S
index b4597ed..d3883ee 100644
--- a/arch/arm/mm/proc-feroceon.S
+++ b/arch/arm/mm/proc-feroceon.S
@@ -554,6 +554,9 @@ feroceon_processor_functions:
 	.word	cpu_feroceon_dcache_clean_area
 	.word	cpu_feroceon_switch_mm
 	.word	cpu_feroceon_set_pte_ext
+	.word	0
+	.word	0
+	.word	0
 	.size	feroceon_processor_functions, . - feroceon_processor_functions
 
 	.section ".rodata"
diff --git a/arch/arm/mm/proc-mohawk.S b/arch/arm/mm/proc-mohawk.S
index 4458ee6..9d4f2ae 100644
--- a/arch/arm/mm/proc-mohawk.S
+++ b/arch/arm/mm/proc-mohawk.S
@@ -388,6 +388,9 @@ mohawk_processor_functions:
 	.word	cpu_mohawk_dcache_clean_area
 	.word	cpu_mohawk_switch_mm
 	.word	cpu_mohawk_set_pte_ext
+	.word	0
+	.word	0
+	.word	0
 	.size	mohawk_processor_functions, . - mohawk_processor_functions
 
 	.section ".rodata"
diff --git a/arch/arm/mm/proc-sa110.S b/arch/arm/mm/proc-sa110.S
index 5aa8d59..46f09ed 100644
--- a/arch/arm/mm/proc-sa110.S
+++ b/arch/arm/mm/proc-sa110.S
@@ -203,6 +203,9 @@ ENTRY(sa110_processor_functions)
 	.word	cpu_sa110_dcache_clean_area
 	.word	cpu_sa110_switch_mm
 	.word	cpu_sa110_set_pte_ext
+	.word	0
+	.word	0
+	.word	0
 	.size	sa110_processor_functions, . - sa110_processor_functions
 
 	.section ".rodata"
diff --git a/arch/arm/mm/proc-sa1100.S b/arch/arm/mm/proc-sa1100.S
index 2ac4e6f..74483d1 100644
--- a/arch/arm/mm/proc-sa1100.S
+++ b/arch/arm/mm/proc-sa1100.S
@@ -169,6 +169,42 @@ ENTRY(cpu_sa1100_set_pte_ext)
 #endif
 	mov	pc, lr
 
+.globl	cpu_sa1100_suspend_size
+.equ	cpu_sa1100_suspend_size, 4*4
+#ifdef CONFIG_PM
+ENTRY(cpu_sa1100_do_suspend)
+	stmfd	sp!, {r4 - r7, lr}
+	mrc	p15, 0, r4, c3, c0, 0		@ domain ID
+	mrc	p15, 0, r5, c2, c0, 0		@ translation table base addr
+	mrc	p15, 0, r6, c13, c0, 0		@ PID
+	mrc	p15, 0, r7, c1, c0, 0		@ control reg
+	stmia	r0, {r4 - r7}			@ store cp regs
+	ldmfd	sp!, {r4 - r7, pc}
+ENDPROC(cpu_sa1100_do_suspend)
+
+ENTRY(cpu_sa1100_do_resume)
+	ldmia	r0, {r4 - r7}			@ load cp regs
+	mov	r1, #0
+	mcr	p15, 0, r1, c8, c7, 0		@ flush I+D TLBs
+	mcr	p15, 0, r1, c7, c7, 0		@ flush I&D cache
+	mcr	p15, 0, r1, c9, c0, 0		@ invalidate RB
+	mcr	p15, 0, r1, c9, c0, 5		@ allow user space to use RB
+
+	mcr	p15, 0, r4, c3, c0, 0		@ domain ID
+	mcr	p15, 0, r5, c2, c0, 0		@ translation table base addr
+	mcr	p15, 0, r6, c13, c0, 0		@ PID
+	mov	r0, r7				@ control register
+	mov	r2, r5, lsr #14			@ get TTB0 base
+	mov	r2, r2, lsl #14
+	ldr	r3, =PMD_TYPE_SECT | PMD_SECT_BUFFERABLE | \
+		     PMD_SECT_CACHEABLE | PMD_SECT_AP_WRITE
+	b	cpu_resume_mmu
+ENDPROC(cpu_sa1100_do_resume)
+#else
+#define cpu_sa1100_do_suspend	0
+#define cpu_sa1100_do_resume	0
+#endif
+
 	__CPUINIT
 
 	.type	__sa1100_setup, #function
@@ -218,6 +254,9 @@ ENTRY(sa1100_processor_functions)
 	.word	cpu_sa1100_dcache_clean_area
 	.word	cpu_sa1100_switch_mm
 	.word	cpu_sa1100_set_pte_ext
+	.word	cpu_sa1100_suspend_size
+	.word	cpu_sa1100_do_suspend
+	.word	cpu_sa1100_do_resume
 	.size	sa1100_processor_functions, . - sa1100_processor_functions
 
 	.section ".rodata"
diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index 59a7e1f..832b6bd 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -121,6 +121,53 @@ ENTRY(cpu_v6_set_pte_ext)
 #endif
 	mov	pc, lr
 
+/* Suspend/resume support: taken from arch/arm/mach-s3c64xx/sleep.S */
+.globl	cpu_v6_suspend_size
+.equ	cpu_v6_suspend_size, 4 * 8
+#ifdef CONFIG_PM
+ENTRY(cpu_v6_do_suspend)
+	stmfd	sp!, {r4 - r11, lr}
+	mrc	p15, 0, r4, c13, c0, 0	@ FCSE/PID
+	mrc	p15, 0, r5, c13, c0, 1	@ Context ID
+	mrc	p15, 0, r6, c3, c0, 0	@ Domain ID
+	mrc	p15, 0, r7, c2, c0, 0	@ Translation table base 0
+	mrc	p15, 0, r8, c2, c0, 1	@ Translation table base 1
+	mrc	p15, 0, r9, c1, c0, 1	@ auxillary control register
+	mrc	p15, 0, r10, c1, c0, 2	@ co-processor access control
+	mrc	p15, 0, r11, c1, c0, 0	@ control register
+	stmia	r0, {r4 - r11}
+	ldmfd	sp!, {r4- r11, pc}
+ENDPROC(cpu_v6_do_suspend)
+
+ENTRY(cpu_v6_do_resume)
+	mov	ip, #0
+	mcr	p15, 0, ip, c7, c14, 0	@ clean+invalidate D cache
+	mcr	p15, 0, ip, c7, c5, 0	@ invalidate I cache
+	mcr	p15, 0, ip, c7, c15, 0	@ clean+invalidate cache
+	mcr	p15, 0, ip, c7, c10, 4	@ drain write buffer
+	ldmia	r0, {r4 - r11}
+	mcr	p15, 0, r4, c13, c0, 0	@ FCSE/PID
+	mcr	p15, 0, r5, c13, c0, 1	@ Context ID
+	mcr	p15, 0, r6, c3, c0, 0	@ Domain ID
+	mcr	p15, 0, r7, c2, c0, 0	@ Translation table base 0
+	mcr	p15, 0, r8, c2, c0, 1	@ Translation table base 1
+	mcr	p15, 0, r9, c1, c0, 1	@ auxillary control register
+	mcr	p15, 0, r10, c1, c0, 2	@ co-processor access control
+	mcr	p15, 0, ip, c2, c0, 2	@ TTB control register
+	mcr	p15, 0, ip, c7, c5, 4	@ ISB
+	mov	r0, r11			@ control register
+	mov	r2, r7, lsr #14		@ get TTB0 base
+	mov	r2, r2, lsl #14
+	ldr	r3, cpu_resume_l1_flags
+	b	cpu_resume_mmu
+ENDPROC(cpu_v6_do_resume)
+cpu_resume_l1_flags:
+	ALT_SMP(.long PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_FLAGS_SMP)
+	ALT_UP(.long  PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_FLAGS_UP)
+#else
+#define cpu_v6_do_suspend 0
+#define cpu_v6_do_resume 0
+#endif
 
 
 	.type	cpu_v6_name, #object
@@ -206,6 +253,9 @@ ENTRY(v6_processor_functions)
 	.word	cpu_v6_dcache_clean_area
 	.word	cpu_v6_switch_mm
 	.word	cpu_v6_set_pte_ext
+	.word	cpu_v6_suspend_size
+	.word	cpu_v6_do_suspend
+	.word	cpu_v6_do_resume
 	.size	v6_processor_functions, . - v6_processor_functions
 
 	.section ".rodata"
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 0c1172b..a5187dd 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -171,6 +171,87 @@ cpu_v7_name:
 	.ascii	"ARMv7 Processor"
 	.align
 
+	/*
+	 * Memory region attributes with SCTLR.TRE=1
+	 *
+	 *   n = TEX[0],C,B
+	 *   TR = PRRR[2n+1:2n]		- memory type
+	 *   IR = NMRR[2n+1:2n]		- inner cacheable property
+	 *   OR = NMRR[2n+17:2n+16]	- outer cacheable property
+	 *
+	 *			n	TR	IR	OR
+	 *   UNCACHED		000	00
+	 *   BUFFERABLE		001	10	00	00
+	 *   WRITETHROUGH	010	10	10	10
+	 *   WRITEBACK		011	10	11	11
+	 *   reserved		110
+	 *   WRITEALLOC		111	10	01	01
+	 *   DEV_SHARED		100	01
+	 *   DEV_NONSHARED	100	01
+	 *   DEV_WC		001	10
+	 *   DEV_CACHED		011	10
+	 *
+	 * Other attributes:
+	 *
+	 *   DS0 = PRRR[16] = 0		- device shareable property
+	 *   DS1 = PRRR[17] = 1		- device shareable property
+	 *   NS0 = PRRR[18] = 0		- normal shareable property
+	 *   NS1 = PRRR[19] = 1		- normal shareable property
+	 *   NOS = PRRR[24+n] = 1	- not outer shareable
+	 */
+.equ	PRRR,	0xff0a81a8
+.equ	NMRR,	0x40e040e0
+
+/* Suspend/resume support: derived from arch/arm/mach-s5pv210/sleep.S */
+.globl	cpu_v7_suspend_size
+.equ	cpu_v7_suspend_size, 4 * 8
+#ifdef CONFIG_PM
+ENTRY(cpu_v7_do_suspend)
+	stmfd	sp!, {r4 - r11, lr}
+	mrc	p15, 0, r4, c13, c0, 0	@ FCSE/PID
+	mrc	p15, 0, r5, c13, c0, 1	@ Context ID
+	mrc	p15, 0, r6, c3, c0, 0	@ Domain ID
+	mrc	p15, 0, r7, c2, c0, 0	@ TTB 0
+	mrc	p15, 0, r8, c2, c0, 1	@ TTB 1
+	mrc	p15, 0, r9, c1, c0, 0	@ Control register
+	mrc	p15, 0, r10, c1, c0, 1	@ Auxiliary control register
+	mrc	p15, 0, r11, c1, c0, 2	@ Co-processor access control
+	stmia	r0, {r4 - r11}
+	ldmfd	sp!, {r4 - r11, pc}
+ENDPROC(cpu_v7_do_suspend)
+
+ENTRY(cpu_v7_do_resume)
+	mov	ip, #0
+	mcr	p15, 0, ip, c8, c7, 0	@ invalidate TLBs
+	mcr	p15, 0, ip, c7, c5, 0	@ invalidate I cache
+	ldmia	r0, {r4 - r11}
+	mcr	p15, 0, r4, c13, c0, 0	@ FCSE/PID
+	mcr	p15, 0, r5, c13, c0, 1	@ Context ID
+	mcr	p15, 0, r6, c3, c0, 0	@ Domain ID
+	mcr	p15, 0, r7, c2, c0, 0	@ TTB 0
+	mcr	p15, 0, r8, c2, c0, 1	@ TTB 1
+	mcr	p15, 0, ip, c2, c0, 2	@ TTB control register
+	mcr	p15, 0, r10, c1, c0, 1	@ Auxillary control register
+	mcr	p15, 0, r11, c1, c0, 2	@ Co-processor access control
+	ldr	r4, =PRRR		@ PRRR
+	ldr	r5, =NMRR		@ NMRR
+	mcr	p15, 0, r4, c10, c2, 0	@ write PRRR
+	mcr	p15, 0, r5, c10, c2, 1	@ write NMRR
+	isb
+	mov	r0, r9			@ control register
+	mov	r2, r7, lsr #14		@ get TTB0 base
+	mov	r2, r2, lsl #14
+	ldr	r3, cpu_resume_l1_flags
+	b	cpu_resume_mmu
+ENDPROC(cpu_v7_do_resume)
+cpu_resume_l1_flags:
+	ALT_SMP(.long PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_FLAGS_SMP)
+	ALT_UP(.long  PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_FLAGS_UP)
+#else
+#define cpu_v7_do_suspend	0
+#define cpu_v7_do_resume	0
+#endif
+
 	__CPUINIT
 
 /*
@@ -276,36 +357,8 @@ __v7_setup:
 	ALT_SMP(orr	r4, r4, #TTB_FLAGS_SMP)
 	ALT_UP(orr	r4, r4, #TTB_FLAGS_UP)
 	mcr	p15, 0, r4, c2, c0, 1		@ load TTB1
-	/*
-	 * Memory region attributes with SCTLR.TRE=1
-	 *
-	 *   n = TEX[0],C,B
-	 *   TR = PRRR[2n+1:2n]		- memory type
-	 *   IR = NMRR[2n+1:2n]		- inner cacheable property
-	 *   OR = NMRR[2n+17:2n+16]	- outer cacheable property
-	 *
-	 *			n	TR	IR	OR
-	 *   UNCACHED		000	00
-	 *   BUFFERABLE		001	10	00	00
-	 *   WRITETHROUGH	010	10	10	10
-	 *   WRITEBACK		011	10	11	11
-	 *   reserved		110
-	 *   WRITEALLOC		111	10	01	01
-	 *   DEV_SHARED		100	01
-	 *   DEV_NONSHARED	100	01
-	 *   DEV_WC		001	10
-	 *   DEV_CACHED		011	10
-	 *
-	 * Other attributes:
-	 *
-	 *   DS0 = PRRR[16] = 0		- device shareable property
-	 *   DS1 = PRRR[17] = 1		- device shareable property
-	 *   NS0 = PRRR[18] = 0		- normal shareable property
-	 *   NS1 = PRRR[19] = 1		- normal shareable property
-	 *   NOS = PRRR[24+n] = 1	- not outer shareable
-	 */
-	ldr	r5, =0xff0a81a8			@ PRRR
-	ldr	r6, =0x40e040e0			@ NMRR
+	ldr	r5, =PRRR			@ PRRR
+	ldr	r6, =NMRR			@ NMRR
 	mcr	p15, 0, r5, c10, c2, 0		@ write PRRR
 	mcr	p15, 0, r6, c10, c2, 1		@ write NMRR
 #endif
@@ -351,6 +404,9 @@ ENTRY(v7_processor_functions)
 	.word	cpu_v7_dcache_clean_area
 	.word	cpu_v7_switch_mm
 	.word	cpu_v7_set_pte_ext
+	.word	0
+	.word	0
+	.word	0
 	.size	v7_processor_functions, . - v7_processor_functions
 
 	.section ".rodata"
diff --git a/arch/arm/mm/proc-xsc3.S b/arch/arm/mm/proc-xsc3.S
index ec26355..63d8b20 100644
--- a/arch/arm/mm/proc-xsc3.S
+++ b/arch/arm/mm/proc-xsc3.S
@@ -413,9 +413,52 @@ ENTRY(cpu_xsc3_set_pte_ext)
 	mov	pc, lr
 
 	.ltorg
-
 	.align
 
+.globl	cpu_xsc3_suspend_size
+.equ	cpu_xsc3_suspend_size, 4 * 8
+#ifdef CONFIG_PM
+ENTRY(cpu_xsc3_do_suspend)
+	stmfd	sp!, {r4 - r10, lr}
+	mrc	p14, 0, r4, c6, c0, 0	@ clock configuration, for turbo mode
+	mrc	p15, 0, r5, c15, c1, 0	@ CP access reg
+	mrc	p15, 0, r6, c13, c0, 0	@ PID
+	mrc 	p15, 0, r7, c3, c0, 0	@ domain ID
+	mrc 	p15, 0, r8, c2, c0, 0	@ translation table base addr
+	mrc	p15, 0, r9, c1, c0, 1	@ auxiliary control reg
+	mrc 	p15, 0, r10, c1, c0, 0	@ control reg
+	bic	r4, r4, #2		@ clear frequency change bit
+	stmia	r0, {r1, r4 - r10}	@ store v:p offset + cp regs
+	ldmia	sp!, {r4 - r10, pc}
+ENDPROC(cpu_xsc3_do_suspend)
+
+ENTRY(cpu_xsc3_do_resume)
+	ldmia	r0, {r1, r4 - r10}	@ load v:p offset + cp regs
+	mov	ip, #0
+	mcr	p15, 0, ip, c7, c7, 0	@ invalidate I & D caches, BTB
+	mcr	p15, 0, ip, c7, c10, 4	@ drain write (&fill) buffer
+	mcr	p15, 0, ip, c7, c5, 4	@ flush prefetch buffer
+	mcr	p15, 0, ip, c8, c7, 0	@ invalidate I & D TLBs
+	mcr	p14, 0, r4, c6, c0, 0	@ clock configuration, turbo mode.
+	mcr	p15, 0, r5, c15, c1, 0	@ CP access reg
+	mcr	p15, 0, r6, c13, c0, 0	@ PID
+	mcr	p15, 0, r7, c3, c0, 0	@ domain ID
+	mcr	p15, 0, r8, c2, c0, 0	@ translation table base addr
+	mcr	p15, 0, r9, c1, c0, 1	@ auxiliary control reg
+
+	@ temporarily map resume_turn_on_mmu into the page table,
+	@ otherwise prefetch abort occurs after MMU is turned on
+	mov	r0, r10			@ control register
+	mov	r2, r8, lsr #14		@ get TTB0 base
+	mov	r2, r2, lsl #14
+	ldr	r3, =0x542e		@ section flags
+	b	cpu_resume_mmu
+ENDPROC(cpu_xsc3_do_resume)
+#else
+#define cpu_xsc3_do_suspend	0
+#define cpu_xsc3_do_resume	0
+#endif
+
 	__CPUINIT
 
 	.type	__xsc3_setup, #function
@@ -476,6 +519,9 @@ ENTRY(xsc3_processor_functions)
 	.word	cpu_xsc3_dcache_clean_area
 	.word	cpu_xsc3_switch_mm
 	.word	cpu_xsc3_set_pte_ext
+	.word	cpu_xsc3_suspend_size
+	.word	cpu_xsc3_do_suspend
+	.word	cpu_xsc3_do_resume
 	.size	xsc3_processor_functions, . - xsc3_processor_functions
 
 	.section ".rodata"
diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
index 5a37c5e..086038c 100644
--- a/arch/arm/mm/proc-xscale.S
+++ b/arch/arm/mm/proc-xscale.S
@@ -513,11 +513,49 @@ ENTRY(cpu_xscale_set_pte_ext)
 	xscale_set_pte_ext_epilogue
 	mov	pc, lr
 
-
 	.ltorg
-
 	.align
 
+.globl	cpu_xscale_suspend_size
+.equ	cpu_xscale_suspend_size, 4 * 7
+#ifdef CONFIG_PM
+ENTRY(cpu_xscale_do_suspend)
+	stmfd	sp!, {r4 - r10, lr}
+	mrc	p14, 0, r4, c6, c0, 0	@ clock configuration, for turbo mode
+	mrc	p15, 0, r5, c15, c1, 0	@ CP access reg
+	mrc	p15, 0, r6, c13, c0, 0	@ PID
+	mrc	p15, 0, r7, c3, c0, 0	@ domain ID
+	mrc	p15, 0, r8, c2, c0, 0	@ translation table base addr
+	mrc	p15, 0, r9, c1, c1, 0	@ auxiliary control reg
+	mrc	p15, 0, r10, c1, c0, 0	@ control reg
+	bic	r4, r4, #2		@ clear frequency change bit
+	stmia	r0, {r4 - r10}		@ store cp regs
+	ldmfd	sp!, {r4 - r10, pc}
+ENDPROC(cpu_xscale_do_suspend)
+
+ENTRY(cpu_xscale_do_resume)
+	ldmia	r0, {r4 - r10}		@ load cp regs
+	mov	ip, #0
+	mcr	p15, 0, ip, c8, c7, 0	@ invalidate I & D TLBs
+	mcr	p15, 0, ip, c7, c7, 0	@ invalidate I & D caches, BTB
+	mcr	p14, 0, r4, c6, c0, 0	@ clock configuration, turbo mode.
+	mcr	p15, 0, r5, c15, c1, 0	@ CP access reg
+	mcr	p15, 0, r6, c13, c0, 0	@ PID
+	mcr	p15, 0, r7, c3, c0, 0	@ domain ID
+	mcr	p15, 0, r8, c2, c0, 0	@ translation table base addr
+	mcr	p15, 0, r9, c1, c1, 0	@ auxiliary control reg
+	mov	r0, r10			@ control register
+	mov	r2, r8, lsr #14		@ get TTB0 base
+	mov	r2, r2, lsl #14
+	ldr	r3, =PMD_TYPE_SECT | PMD_SECT_BUFFERABLE | \
+		     PMD_SECT_CACHEABLE | PMD_SECT_AP_WRITE
+	b	cpu_resume_mmu
+ENDPROC(cpu_xscale_do_resume)
+#else
+#define cpu_xscale_do_suspend	0
+#define cpu_xscale_do_resume	0
+#endif
+
 	__CPUINIT
 
 	.type	__xscale_setup, #function
@@ -565,6 +603,9 @@ ENTRY(xscale_processor_functions)
 	.word	cpu_xscale_dcache_clean_area
 	.word	cpu_xscale_switch_mm
 	.word	cpu_xscale_set_pte_ext
+	.word	cpu_xscale_suspend_size
+	.word	cpu_xscale_do_suspend
+	.word	cpu_xscale_do_resume
 	.size	xscale_processor_functions, . - xscale_processor_functions
 
 	.section ".rodata"
-- 
1.6.2.5

