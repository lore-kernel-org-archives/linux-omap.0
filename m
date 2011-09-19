From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 2/7] ARM: pm: preallocate a page table for suspend/resume
Date: Mon, 19 Sep 2011 17:39:03 +0100
Message-ID: <E1R5gs3-0004zF-W3@rmk-PC.arm.linux.org.uk>
References: <20110919163741.GE16591@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47031 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099Ab1ISQjI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Sep 2011 12:39:08 -0400
In-Reply-To: <20110919163741.GE16591@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.orglinux-omap@vger.kernel.orglinux-arm-kernel@lists.infradead.org

Preallocate a page table and setup an identity mapping for the MMU
enable code.  This means we don't have to "borrow" a page table to
do this, avoiding complexities with L2 cache coherency.

Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/suspend.h |   17 +-------------
 arch/arm/kernel/Makefile       |    2 +-
 arch/arm/kernel/sleep.S        |   33 ++++++++++-----------------
 arch/arm/kernel/suspend.c      |   48 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/mm/proc-arm920.S      |    4 ---
 arch/arm/mm/proc-arm926.S      |    4 ---
 arch/arm/mm/proc-sa1100.S      |    4 ---
 arch/arm/mm/proc-v6.S          |    6 -----
 arch/arm/mm/proc-v7.S          |    6 -----
 arch/arm/mm/proc-xsc3.S        |    6 -----
 arch/arm/mm/proc-xscale.S      |    4 ---
 11 files changed, 62 insertions(+), 72 deletions(-)
 create mode 100644 arch/arm/kernel/suspend.c

diff --git a/arch/arm/include/asm/suspend.h b/arch/arm/include/asm/suspend.h
index b0e4e1a..1c0a551 100644
--- a/arch/arm/include/asm/suspend.h
+++ b/arch/arm/include/asm/suspend.h
@@ -1,22 +1,7 @@
 #ifndef __ASM_ARM_SUSPEND_H
 #define __ASM_ARM_SUSPEND_H
 
-#include <asm/memory.h>
-#include <asm/tlbflush.h>
-
 extern void cpu_resume(void);
-
-/*
- * Hide the first two arguments to __cpu_suspend - these are an implementation
- * detail which platform code shouldn't have to know about.
- */
-static inline int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
-{
-	extern int __cpu_suspend(int, long, unsigned long,
-				 int (*)(unsigned long));
-	int ret = __cpu_suspend(0, PHYS_OFFSET - PAGE_OFFSET, arg, fn);
-	flush_tlb_all();
-	return ret;
-}
+extern int cpu_suspend(unsigned long, int (*)(unsigned long));
 
 #endif
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index f7887dc..787b888 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -29,7 +29,7 @@ obj-$(CONFIG_MODULES)		+= armksyms.o module.o
 obj-$(CONFIG_ARTHUR)		+= arthur.o
 obj-$(CONFIG_ISA_DMA)		+= dma-isa.o
 obj-$(CONFIG_PCI)		+= bios32.o isa.o
-obj-$(CONFIG_PM_SLEEP)		+= sleep.o
+obj-$(CONFIG_PM_SLEEP)		+= sleep.o suspend.o
 obj-$(CONFIG_HAVE_SCHED_CLOCK)	+= sched_clock.o
 obj-$(CONFIG_SMP)		+= smp.o smp_tlb.o
 obj-$(CONFIG_HAVE_ARM_SCU)	+= smp_scu.o
diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index 46a9f46..8cf13de 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -27,7 +27,7 @@ ENTRY(__cpu_suspend)
 	sub	sp, sp, r5		@ allocate CPU state on stack
 	mov	r0, sp			@ save pointer to CPU save block
 	add	ip, ip, r1		@ convert resume fn to phys
-	stmfd	sp!, {r1, r6, ip}	@ save v:p, virt SP, phys resume fn
+	stmfd	sp!, {r6, ip}		@ save virt SP, phys resume fn
 	ldr	r5, =sleep_save_sp
 	add	r6, sp, r1		@ convert SP to phys
 	stmfd	sp!, {r2, r3}		@ save suspend func arg and pointer
@@ -60,7 +60,7 @@ ENDPROC(__cpu_suspend)
 	.ltorg
 
 cpu_suspend_abort:
-	ldmia	sp!, {r1 - r3}		@ pop v:p, virt SP, phys resume fn
+	ldmia	sp!, {r2 - r3}		@ pop virt SP, phys resume fn
 	teq	r0, #0
 	moveq	r0, #1			@ force non-zero value
 	mov	sp, r2
@@ -74,28 +74,19 @@ ENDPROC(cpu_suspend_abort)
  * r3 = L1 section flags
  */
 ENTRY(cpu_resume_mmu)
-	adr	r4, cpu_resume_turn_mmu_on
-	mov	r4, r4, lsr #20
-	orr	r3, r3, r4, lsl #20
-	ldr	r5, [r2, r4, lsl #2]	@ save old mapping
-	str	r3, [r2, r4, lsl #2]	@ setup 1:1 mapping for mmu code
-	sub	r2, r2, r1
 	ldr	r3, =cpu_resume_after_mmu
-	bic	r1, r0, #CR_C		@ ensure D-cache is disabled
 	b	cpu_resume_turn_mmu_on
 ENDPROC(cpu_resume_mmu)
 	.ltorg
 	.align	5
-cpu_resume_turn_mmu_on:
-	mcr	p15, 0, r1, c1, c0, 0	@ turn on MMU, I-cache, etc
-	mrc	p15, 0, r1, c0, c0, 0	@ read id reg
-	mov	r1, r1
-	mov	r1, r1
+ENTRY(cpu_resume_turn_mmu_on)
+	mcr	p15, 0, r0, c1, c0, 0	@ turn on MMU, I-cache, etc
+	mrc	p15, 0, r0, c0, c0, 0	@ read id reg
+	mov	r0, r0
+	mov	r0, r0
 	mov	pc, r3			@ jump to virtual address
 ENDPROC(cpu_resume_turn_mmu_on)
 cpu_resume_after_mmu:
-	str	r5, [r2, r4, lsl #2]	@ restore old mapping
-	mcr	p15, 0, r0, c1, c0, 0	@ turn on D-cache
 	bl	cpu_init		@ restore the und/abt/irq banked regs
 	mov	r0, #0			@ return zero on success
 	ldmfd	sp!, {r4 - r11, pc}
@@ -121,11 +112,11 @@ ENTRY(cpu_resume)
 	ldr	r0, sleep_save_sp	@ stack phys addr
 #endif
 	setmode	PSR_I_BIT | PSR_F_BIT | SVC_MODE, r1  @ set SVC, irqs off
-	@ load v:p, stack, resume fn
-  ARM(	ldmia	r0!, {r1, sp, pc}	)
-THUMB(	ldmia	r0!, {r1, r2, r3}	)
-THUMB(	mov	sp, r2			)
-THUMB(	bx	r3			)
+	@ load stack, resume fn
+  ARM(	ldmia	r0!, {sp, pc}	)
+THUMB(	ldmia	r0!, {r2, r3}	)
+THUMB(	mov	sp, r2		)
+THUMB(	bx	r3		)
 ENDPROC(cpu_resume)
 
 sleep_save_sp:
diff --git a/arch/arm/kernel/suspend.c b/arch/arm/kernel/suspend.c
new file mode 100644
index 0000000..0a33f10
--- /dev/null
+++ b/arch/arm/kernel/suspend.c
@@ -0,0 +1,48 @@
+#include <linux/init.h>
+
+#include <asm/pgalloc.h>
+#include <asm/pgtable.h>
+#include <asm/memory.h>
+#include <asm/suspend.h>
+#include <asm/tlbflush.h>
+
+static pgd_t *suspend_pgd;
+
+extern int __cpu_suspend(int, long, unsigned long, int (*)(unsigned long));
+extern void cpu_resume_turn_mmu_on(void);
+
+/*
+ * Hide the first two arguments to __cpu_suspend - these are an implementation
+ * detail which platform code shouldn't have to know about.
+ */
+int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
+{
+	struct mm_struct *mm = current->active_mm;
+	int ret;
+
+	if (!suspend_pgd)
+		return -EINVAL;
+
+	/*
+	 * Temporarily switch the page tables to our suspend page
+	 * tables, which contain the temporary identity mapping
+	 * required for resuming.
+	 */
+	cpu_switch_mm(suspend_pgd, mm);
+	ret = __cpu_suspend(0, PHYS_OFFSET - PAGE_OFFSET, arg, fn);
+	cpu_switch_mm(mm->pgd, mm);
+	local_flush_tlb_all();
+
+	return ret;
+}
+
+static int __init cpu_suspend_init(void)
+{
+	suspend_pgd = pgd_alloc(&init_mm);
+	if (suspend_pgd) {
+		unsigned long addr = virt_to_phys(cpu_resume_turn_mmu_on);
+		identity_mapping_add(suspend_pgd, addr, addr + SECTION_SIZE);
+	}
+	return suspend_pgd ? 0 : -ENOMEM;
+}
+core_initcall(cpu_suspend_init);
diff --git a/arch/arm/mm/proc-arm920.S b/arch/arm/mm/proc-arm920.S
index 2e6849b..035d57b 100644
--- a/arch/arm/mm/proc-arm920.S
+++ b/arch/arm/mm/proc-arm920.S
@@ -400,10 +400,6 @@ ENTRY(cpu_arm920_do_resume)
 	mcr	p15, 0, r5, c3, c0, 0	@ Domain ID
 	mcr	p15, 0, r6, c2, c0, 0	@ TTB address
 	mov	r0, r7			@ control register
-	mov	r2, r6, lsr #14		@ get TTB0 base
-	mov	r2, r2, lsl #14
-	ldr	r3, =PMD_TYPE_SECT | PMD_SECT_BUFFERABLE | \
-		     PMD_SECT_CACHEABLE | PMD_BIT4 | PMD_SECT_AP_WRITE
 	b	cpu_resume_mmu
 ENDPROC(cpu_arm920_do_resume)
 #endif
diff --git a/arch/arm/mm/proc-arm926.S b/arch/arm/mm/proc-arm926.S
index cd8f79c..48add84 100644
--- a/arch/arm/mm/proc-arm926.S
+++ b/arch/arm/mm/proc-arm926.S
@@ -415,10 +415,6 @@ ENTRY(cpu_arm926_do_resume)
 	mcr	p15, 0, r5, c3, c0, 0	@ Domain ID
 	mcr	p15, 0, r6, c2, c0, 0	@ TTB address
 	mov	r0, r7			@ control register
-	mov	r2, r6, lsr #14		@ get TTB0 base
-	mov	r2, r2, lsl #14
-	ldr	r3, =PMD_TYPE_SECT | PMD_SECT_BUFFERABLE | \
-		     PMD_SECT_CACHEABLE | PMD_BIT4 | PMD_SECT_AP_WRITE
 	b	cpu_resume_mmu
 ENDPROC(cpu_arm926_do_resume)
 #endif
diff --git a/arch/arm/mm/proc-sa1100.S b/arch/arm/mm/proc-sa1100.S
index 69e7f2e..52f73fb 100644
--- a/arch/arm/mm/proc-sa1100.S
+++ b/arch/arm/mm/proc-sa1100.S
@@ -192,10 +192,6 @@ ENTRY(cpu_sa1100_do_resume)
 	mcr	p15, 0, r5, c2, c0, 0		@ translation table base addr
 	mcr	p15, 0, r6, c13, c0, 0		@ PID
 	mov	r0, r7				@ control register
-	mov	r2, r5, lsr #14			@ get TTB0 base
-	mov	r2, r2, lsl #14
-	ldr	r3, =PMD_TYPE_SECT | PMD_SECT_BUFFERABLE | \
-		     PMD_SECT_CACHEABLE | PMD_SECT_AP_WRITE
 	b	cpu_resume_mmu
 ENDPROC(cpu_sa1100_do_resume)
 #endif
diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index a923aa0..414e369 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -161,14 +161,8 @@ ENTRY(cpu_v6_do_resume)
 	mcr	p15, 0, ip, c2, c0, 2	@ TTB control register
 	mcr	p15, 0, ip, c7, c5, 4	@ ISB
 	mov	r0, r11			@ control register
-	mov	r2, r7, lsr #14		@ get TTB0 base
-	mov	r2, r2, lsl #14
-	ldr	r3, cpu_resume_l1_flags
 	b	cpu_resume_mmu
 ENDPROC(cpu_v6_do_resume)
-cpu_resume_l1_flags:
-	ALT_SMP(.long PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_FLAGS_SMP)
-	ALT_UP(.long  PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_FLAGS_UP)
 #endif
 
 	string	cpu_v6_name, "ARMv6-compatible processor"
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 9049c07..21d6910 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -259,14 +259,8 @@ ENTRY(cpu_v7_do_resume)
 	isb
 	dsb
 	mov	r0, r9			@ control register
-	mov	r2, r7, lsr #14		@ get TTB0 base
-	mov	r2, r2, lsl #14
-	ldr	r3, cpu_resume_l1_flags
 	b	cpu_resume_mmu
 ENDPROC(cpu_v7_do_resume)
-cpu_resume_l1_flags:
-	ALT_SMP(.long PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_FLAGS_SMP)
-	ALT_UP(.long  PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_FLAGS_UP)
 #endif
 
 	__CPUINIT
diff --git a/arch/arm/mm/proc-xsc3.S b/arch/arm/mm/proc-xsc3.S
index 755e1bf..efd4949 100644
--- a/arch/arm/mm/proc-xsc3.S
+++ b/arch/arm/mm/proc-xsc3.S
@@ -435,13 +435,7 @@ ENTRY(cpu_xsc3_do_resume)
 	mcr	p15, 0, r7, c3, c0, 0	@ domain ID
 	mcr	p15, 0, r8, c2, c0, 0	@ translation table base addr
 	mcr	p15, 0, r9, c1, c0, 1	@ auxiliary control reg
-
-	@ temporarily map resume_turn_on_mmu into the page table,
-	@ otherwise prefetch abort occurs after MMU is turned on
 	mov	r0, r10			@ control register
-	mov	r2, r8, lsr #14		@ get TTB0 base
-	mov	r2, r2, lsl #14
-	ldr	r3, =0x542e		@ section flags
 	b	cpu_resume_mmu
 ENDPROC(cpu_xsc3_do_resume)
 #endif
diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
index fbc06e5..37dbada 100644
--- a/arch/arm/mm/proc-xscale.S
+++ b/arch/arm/mm/proc-xscale.S
@@ -548,10 +548,6 @@ ENTRY(cpu_xscale_do_resume)
 	mcr	p15, 0, r8, c2, c0, 0	@ translation table base addr
 	mcr	p15, 0, r9, c1, c1, 0	@ auxiliary control reg
 	mov	r0, r10			@ control register
-	mov	r2, r8, lsr #14		@ get TTB0 base
-	mov	r2, r2, lsl #14
-	ldr	r3, =PMD_TYPE_SECT | PMD_SECT_BUFFERABLE | \
-		     PMD_SECT_CACHEABLE | PMD_SECT_AP_WRITE
 	b	cpu_resume_mmu
 ENDPROC(cpu_xscale_do_resume)
 #endif
-- 
1.7.4.4

