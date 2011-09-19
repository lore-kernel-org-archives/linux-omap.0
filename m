From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 3/7] ARM: pm: only use preallocated page table during resume
Date: Mon, 19 Sep 2011 17:39:24 +0100
Message-ID: <E1R5gsO-00050R-3X@rmk-PC.arm.linux.org.uk>
References: <20110919163741.GE16591@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38928 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932085Ab1ISRxJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Sep 2011 13:53:09 -0400
In-Reply-To: <20110919163741.GE16591@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.orglinux-omap@vger.kernel.orglinux-arm-kernel@lists.infradead.org

Only use the preallocated page table during the resume, not while
suspending.  This avoids the overhead of having to switch unnecessarily
to the resume page table in the suspend path.

Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/sleep.S   |   19 +++++++++----------
 arch/arm/kernel/suspend.c |   17 ++++++++++-------
 arch/arm/mm/proc-arm920.S |   17 ++++++++---------
 arch/arm/mm/proc-arm926.S |   17 ++++++++---------
 arch/arm/mm/proc-sa1100.S |   21 ++++++++++-----------
 arch/arm/mm/proc-v6.S     |   31 ++++++++++++++++---------------
 arch/arm/mm/proc-v7.S     |   33 +++++++++++++++++----------------
 arch/arm/mm/proc-xsc3.S   |   22 +++++++++++-----------
 arch/arm/mm/proc-xscale.S |   21 ++++++++++-----------
 9 files changed, 99 insertions(+), 99 deletions(-)

diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index 8cf13de..25d42df 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -9,12 +9,14 @@
 
 /*
  * Save CPU state for a suspend
+ *  r0 = phys addr of temporary page tables
  *  r1 = v:p offset
  *  r2 = suspend function arg0
  *  r3 = suspend function
  */
 ENTRY(__cpu_suspend)
 	stmfd	sp!, {r4 - r11, lr}
+	mov	r4, r0
 #ifdef MULTI_CPU
 	ldr	r10, =processor
 	ldr	r5, [r10, #CPU_SLEEP_SIZE] @ size of CPU sleep state
@@ -27,7 +29,7 @@ ENTRY(__cpu_suspend)
 	sub	sp, sp, r5		@ allocate CPU state on stack
 	mov	r0, sp			@ save pointer to CPU save block
 	add	ip, ip, r1		@ convert resume fn to phys
-	stmfd	sp!, {r6, ip}		@ save virt SP, phys resume fn
+	stmfd	sp!, {r4, r6, ip}	@ save phys pgd, virt SP, phys resume fn
 	ldr	r5, =sleep_save_sp
 	add	r6, sp, r1		@ convert SP to phys
 	stmfd	sp!, {r2, r3}		@ save suspend func arg and pointer
@@ -60,7 +62,7 @@ ENDPROC(__cpu_suspend)
 	.ltorg
 
 cpu_suspend_abort:
-	ldmia	sp!, {r2 - r3}		@ pop virt SP, phys resume fn
+	ldmia	sp!, {r1 - r3}		@ pop phys pgd, virt SP, phys resume fn
 	teq	r0, #0
 	moveq	r0, #1			@ force non-zero value
 	mov	sp, r2
@@ -69,9 +71,6 @@ ENDPROC(cpu_suspend_abort)
 
 /*
  * r0 = control register value
- * r1 = v:p offset (preserved by cpu_do_resume)
- * r2 = phys page table base
- * r3 = L1 section flags
  */
 ENTRY(cpu_resume_mmu)
 	ldr	r3, =cpu_resume_after_mmu
@@ -112,11 +111,11 @@ ENTRY(cpu_resume)
 	ldr	r0, sleep_save_sp	@ stack phys addr
 #endif
 	setmode	PSR_I_BIT | PSR_F_BIT | SVC_MODE, r1  @ set SVC, irqs off
-	@ load stack, resume fn
-  ARM(	ldmia	r0!, {sp, pc}	)
-THUMB(	ldmia	r0!, {r2, r3}	)
-THUMB(	mov	sp, r2		)
-THUMB(	bx	r3		)
+	@ load phys pgd, stack, resume fn
+  ARM(	ldmia	r0!, {r1, sp, pc}	)
+THUMB(	ldmia	r0!, {r1, r2, r3}	)
+THUMB(	mov	sp, r2			)
+THUMB(	bx	r3			)
 ENDPROC(cpu_resume)
 
 sleep_save_sp:
diff --git a/arch/arm/kernel/suspend.c b/arch/arm/kernel/suspend.c
index 0a33f10..2beda56 100644
--- a/arch/arm/kernel/suspend.c
+++ b/arch/arm/kernel/suspend.c
@@ -24,14 +24,17 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 		return -EINVAL;
 
 	/*
-	 * Temporarily switch the page tables to our suspend page
-	 * tables, which contain the temporary identity mapping
-	 * required for resuming.
+	 * Provide a temporary page table with an identity mapping for
+	 * the MMU-enable code, required for resuming.  On successful
+	 * resume (indicated by a zero return code), we need to switch
+	 * back to the correct page tables.
 	 */
-	cpu_switch_mm(suspend_pgd, mm);
-	ret = __cpu_suspend(0, PHYS_OFFSET - PAGE_OFFSET, arg, fn);
-	cpu_switch_mm(mm->pgd, mm);
-	local_flush_tlb_all();
+	ret = __cpu_suspend(virt_to_phys(suspend_pgd),
+			    PHYS_OFFSET - PAGE_OFFSET, arg, fn);
+	if (ret == 0) {
+		cpu_switch_mm(mm->pgd, mm);
+		local_flush_tlb_all();
+	}
 
 	return ret;
 }
diff --git a/arch/arm/mm/proc-arm920.S b/arch/arm/mm/proc-arm920.S
index 035d57b..88fb3d9 100644
--- a/arch/arm/mm/proc-arm920.S
+++ b/arch/arm/mm/proc-arm920.S
@@ -379,27 +379,26 @@ ENTRY(cpu_arm920_set_pte_ext)
 
 /* Suspend/resume support: taken from arch/arm/plat-s3c24xx/sleep.S */
 .globl	cpu_arm920_suspend_size
-.equ	cpu_arm920_suspend_size, 4 * 4
+.equ	cpu_arm920_suspend_size, 4 * 3
 #ifdef CONFIG_PM_SLEEP
 ENTRY(cpu_arm920_do_suspend)
-	stmfd	sp!, {r4 - r7, lr}
+	stmfd	sp!, {r4 - r6, lr}
 	mrc	p15, 0, r4, c13, c0, 0	@ PID
 	mrc	p15, 0, r5, c3, c0, 0	@ Domain ID
-	mrc	p15, 0, r6, c2, c0, 0	@ TTB address
-	mrc	p15, 0, r7, c1, c0, 0	@ Control register
-	stmia	r0, {r4 - r7}
-	ldmfd	sp!, {r4 - r7, pc}
+	mrc	p15, 0, r6, c1, c0, 0	@ Control register
+	stmia	r0, {r4 - r6}
+	ldmfd	sp!, {r4 - r6, pc}
 ENDPROC(cpu_arm920_do_suspend)
 
 ENTRY(cpu_arm920_do_resume)
 	mov	ip, #0
 	mcr	p15, 0, ip, c8, c7, 0	@ invalidate I+D TLBs
 	mcr	p15, 0, ip, c7, c7, 0	@ invalidate I+D caches
-	ldmia	r0, {r4 - r7}
+	ldmia	r0, {r4 - r6}
 	mcr	p15, 0, r4, c13, c0, 0	@ PID
 	mcr	p15, 0, r5, c3, c0, 0	@ Domain ID
-	mcr	p15, 0, r6, c2, c0, 0	@ TTB address
-	mov	r0, r7			@ control register
+	mcr	p15, 0, r1, c2, c0, 0	@ TTB address
+	mov	r0, r6			@ control register
 	b	cpu_resume_mmu
 ENDPROC(cpu_arm920_do_resume)
 #endif
diff --git a/arch/arm/mm/proc-arm926.S b/arch/arm/mm/proc-arm926.S
index 48add84..9f8fd91 100644
--- a/arch/arm/mm/proc-arm926.S
+++ b/arch/arm/mm/proc-arm926.S
@@ -394,27 +394,26 @@ ENTRY(cpu_arm926_set_pte_ext)
 
 /* Suspend/resume support: taken from arch/arm/plat-s3c24xx/sleep.S */
 .globl	cpu_arm926_suspend_size
-.equ	cpu_arm926_suspend_size, 4 * 4
+.equ	cpu_arm926_suspend_size, 4 * 3
 #ifdef CONFIG_PM_SLEEP
 ENTRY(cpu_arm926_do_suspend)
-	stmfd	sp!, {r4 - r7, lr}
+	stmfd	sp!, {r4 - r6, lr}
 	mrc	p15, 0, r4, c13, c0, 0	@ PID
 	mrc	p15, 0, r5, c3, c0, 0	@ Domain ID
-	mrc	p15, 0, r6, c2, c0, 0	@ TTB address
-	mrc	p15, 0, r7, c1, c0, 0	@ Control register
-	stmia	r0, {r4 - r7}
-	ldmfd	sp!, {r4 - r7, pc}
+	mrc	p15, 0, r6, c1, c0, 0	@ Control register
+	stmia	r0, {r4 - r6}
+	ldmfd	sp!, {r4 - r6, pc}
 ENDPROC(cpu_arm926_do_suspend)
 
 ENTRY(cpu_arm926_do_resume)
 	mov	ip, #0
 	mcr	p15, 0, ip, c8, c7, 0	@ invalidate I+D TLBs
 	mcr	p15, 0, ip, c7, c7, 0	@ invalidate I+D caches
-	ldmia	r0, {r4 - r7}
+	ldmia	r0, {r4 - r6}
 	mcr	p15, 0, r4, c13, c0, 0	@ PID
 	mcr	p15, 0, r5, c3, c0, 0	@ Domain ID
-	mcr	p15, 0, r6, c2, c0, 0	@ TTB address
-	mov	r0, r7			@ control register
+	mcr	p15, 0, r1, c2, c0, 0	@ TTB address
+	mov	r0, r6			@ control register
 	b	cpu_resume_mmu
 ENDPROC(cpu_arm926_do_resume)
 #endif
diff --git a/arch/arm/mm/proc-sa1100.S b/arch/arm/mm/proc-sa1100.S
index 52f73fb..7d91545 100644
--- a/arch/arm/mm/proc-sa1100.S
+++ b/arch/arm/mm/proc-sa1100.S
@@ -168,20 +168,19 @@ ENTRY(cpu_sa1100_set_pte_ext)
 	mov	pc, lr
 
 .globl	cpu_sa1100_suspend_size
-.equ	cpu_sa1100_suspend_size, 4*4
+.equ	cpu_sa1100_suspend_size, 4 * 3
 #ifdef CONFIG_PM_SLEEP
 ENTRY(cpu_sa1100_do_suspend)
-	stmfd	sp!, {r4 - r7, lr}
+	stmfd	sp!, {r4 - r6, lr}
 	mrc	p15, 0, r4, c3, c0, 0		@ domain ID
-	mrc	p15, 0, r5, c2, c0, 0		@ translation table base addr
-	mrc	p15, 0, r6, c13, c0, 0		@ PID
-	mrc	p15, 0, r7, c1, c0, 0		@ control reg
-	stmia	r0, {r4 - r7}			@ store cp regs
-	ldmfd	sp!, {r4 - r7, pc}
+	mrc	p15, 0, r5, c13, c0, 0		@ PID
+	mrc	p15, 0, r6, c1, c0, 0		@ control reg
+	stmia	r0, {r4 - r6}			@ store cp regs
+	ldmfd	sp!, {r4 - r6, pc}
 ENDPROC(cpu_sa1100_do_suspend)
 
 ENTRY(cpu_sa1100_do_resume)
-	ldmia	r0, {r4 - r7}			@ load cp regs
+	ldmia	r0, {r4 - r6}			@ load cp regs
 	mov	ip, #0
 	mcr	p15, 0, ip, c8, c7, 0		@ flush I+D TLBs
 	mcr	p15, 0, ip, c7, c7, 0		@ flush I&D cache
@@ -189,9 +188,9 @@ ENTRY(cpu_sa1100_do_resume)
 	mcr	p15, 0, ip, c9, c0, 5		@ allow user space to use RB
 
 	mcr	p15, 0, r4, c3, c0, 0		@ domain ID
-	mcr	p15, 0, r5, c2, c0, 0		@ translation table base addr
-	mcr	p15, 0, r6, c13, c0, 0		@ PID
-	mov	r0, r7				@ control register
+	mcr	p15, 0, r1, c2, c0, 0		@ translation table base addr
+	mcr	p15, 0, r5, c13, c0, 0		@ PID
+	mov	r0, r6				@ control register
 	b	cpu_resume_mmu
 ENDPROC(cpu_sa1100_do_resume)
 #endif
diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index 414e369..2e27b46 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -128,20 +128,19 @@ ENTRY(cpu_v6_set_pte_ext)
 
 /* Suspend/resume support: taken from arch/arm/mach-s3c64xx/sleep.S */
 .globl	cpu_v6_suspend_size
-.equ	cpu_v6_suspend_size, 4 * 8
+.equ	cpu_v6_suspend_size, 4 * 7
 #ifdef CONFIG_PM_SLEEP
 ENTRY(cpu_v6_do_suspend)
-	stmfd	sp!, {r4 - r11, lr}
+	stmfd	sp!, {r4 - r10, lr}
 	mrc	p15, 0, r4, c13, c0, 0	@ FCSE/PID
 	mrc	p15, 0, r5, c13, c0, 1	@ Context ID
 	mrc	p15, 0, r6, c3, c0, 0	@ Domain ID
-	mrc	p15, 0, r7, c2, c0, 0	@ Translation table base 0
-	mrc	p15, 0, r8, c2, c0, 1	@ Translation table base 1
-	mrc	p15, 0, r9, c1, c0, 1	@ auxiliary control register
-	mrc	p15, 0, r10, c1, c0, 2	@ co-processor access control
-	mrc	p15, 0, r11, c1, c0, 0	@ control register
-	stmia	r0, {r4 - r11}
-	ldmfd	sp!, {r4- r11, pc}
+	mrc	p15, 0, r7, c2, c0, 1	@ Translation table base 1
+	mrc	p15, 0, r8, c1, c0, 1	@ auxiliary control register
+	mrc	p15, 0, r9, c1, c0, 2	@ co-processor access control
+	mrc	p15, 0, r10, c1, c0, 0	@ control register
+	stmia	r0, {r4 - r10}
+	ldmfd	sp!, {r4- r10, pc}
 ENDPROC(cpu_v6_do_suspend)
 
 ENTRY(cpu_v6_do_resume)
@@ -150,17 +149,19 @@ ENTRY(cpu_v6_do_resume)
 	mcr	p15, 0, ip, c7, c5, 0	@ invalidate I cache
 	mcr	p15, 0, ip, c7, c15, 0	@ clean+invalidate cache
 	mcr	p15, 0, ip, c7, c10, 4	@ drain write buffer
-	ldmia	r0, {r4 - r11}
+	ldmia	r0, {r4 - r10}
 	mcr	p15, 0, r4, c13, c0, 0	@ FCSE/PID
 	mcr	p15, 0, r5, c13, c0, 1	@ Context ID
 	mcr	p15, 0, r6, c3, c0, 0	@ Domain ID
-	mcr	p15, 0, r7, c2, c0, 0	@ Translation table base 0
-	mcr	p15, 0, r8, c2, c0, 1	@ Translation table base 1
-	mcr	p15, 0, r9, c1, c0, 1	@ auxiliary control register
-	mcr	p15, 0, r10, c1, c0, 2	@ co-processor access control
+	ALT_SMP(orr	r1, r1, #TTB_FLAGS_SMP)
+	ALT_UP(orr	r1, r1, #TTB_FLAGS_UP)
+	mcr	p15, 0, r1, c2, c0, 0	@ Translation table base 0
+	mcr	p15, 0, r7, c2, c0, 1	@ Translation table base 1
+	mcr	p15, 0, r8, c1, c0, 1	@ auxiliary control register
+	mcr	p15, 0, r9, c1, c0, 2	@ co-processor access control
 	mcr	p15, 0, ip, c2, c0, 2	@ TTB control register
 	mcr	p15, 0, ip, c7, c5, 4	@ ISB
-	mov	r0, r11			@ control register
+	mov	r0, r10			@ control register
 	b	cpu_resume_mmu
 ENDPROC(cpu_v6_do_resume)
 #endif
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 21d6910..b56004f 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -217,22 +217,21 @@ ENDPROC(cpu_v7_set_pte_ext)
 
 /* Suspend/resume support: derived from arch/arm/mach-s5pv210/sleep.S */
 .globl	cpu_v7_suspend_size
-.equ	cpu_v7_suspend_size, 4 * 9
+.equ	cpu_v7_suspend_size, 4 * 8
 #ifdef CONFIG_PM_SLEEP
 ENTRY(cpu_v7_do_suspend)
-	stmfd	sp!, {r4 - r11, lr}
+	stmfd	sp!, {r4 - r10, lr}
 	mrc	p15, 0, r4, c13, c0, 0	@ FCSE/PID
 	mrc	p15, 0, r5, c13, c0, 1	@ Context ID
 	mrc	p15, 0, r6, c13, c0, 3	@ User r/o thread ID
 	stmia	r0!, {r4 - r6}
 	mrc	p15, 0, r6, c3, c0, 0	@ Domain ID
-	mrc	p15, 0, r7, c2, c0, 0	@ TTB 0
-	mrc	p15, 0, r8, c2, c0, 1	@ TTB 1
-	mrc	p15, 0, r9, c1, c0, 0	@ Control register
-	mrc	p15, 0, r10, c1, c0, 1	@ Auxiliary control register
-	mrc	p15, 0, r11, c1, c0, 2	@ Co-processor access control
-	stmia	r0, {r6 - r11}
-	ldmfd	sp!, {r4 - r11, pc}
+	mrc	p15, 0, r7, c2, c0, 1	@ TTB 1
+	mrc	p15, 0, r8, c1, c0, 0	@ Control register
+	mrc	p15, 0, r9, c1, c0, 1	@ Auxiliary control register
+	mrc	p15, 0, r10, c1, c0, 2	@ Co-processor access control
+	stmia	r0, {r6 - r10}
+	ldmfd	sp!, {r4 - r10, pc}
 ENDPROC(cpu_v7_do_suspend)
 
 ENTRY(cpu_v7_do_resume)
@@ -243,22 +242,24 @@ ENTRY(cpu_v7_do_resume)
 	mcr	p15, 0, r4, c13, c0, 0	@ FCSE/PID
 	mcr	p15, 0, r5, c13, c0, 1	@ Context ID
 	mcr	p15, 0, r6, c13, c0, 3	@ User r/o thread ID
-	ldmia	r0, {r6 - r11}
+	ldmia	r0, {r6 - r10}
 	mcr	p15, 0, r6, c3, c0, 0	@ Domain ID
-	mcr	p15, 0, r7, c2, c0, 0	@ TTB 0
-	mcr	p15, 0, r8, c2, c0, 1	@ TTB 1
+	ALT_SMP(orr	r1, r1, #TTB_FLAGS_SMP)
+	ALT_UP(orr	r1, r1, #TTB_FLAGS_UP)
+	mcr	p15, 0, r1, c2, c0, 0	@ TTB 0
+	mcr	p15, 0, r7, c2, c0, 1	@ TTB 1
 	mcr	p15, 0, ip, c2, c0, 2	@ TTB control register
 	mrc	p15, 0, r4, c1, c0, 1	@ Read Auxiliary control register
-	teq	r4, r10			@ Is it already set?
-	mcrne	p15, 0, r10, c1, c0, 1	@ No, so write it
-	mcr	p15, 0, r11, c1, c0, 2	@ Co-processor access control
+	teq	r4, r9			@ Is it already set?
+	mcrne	p15, 0, r9, c1, c0, 1	@ No, so write it
+	mcr	p15, 0, r10, c1, c0, 2	@ Co-processor access control
 	ldr	r4, =PRRR		@ PRRR
 	ldr	r5, =NMRR		@ NMRR
 	mcr	p15, 0, r4, c10, c2, 0	@ write PRRR
 	mcr	p15, 0, r5, c10, c2, 1	@ write NMRR
 	isb
 	dsb
-	mov	r0, r9			@ control register
+	mov	r0, r8			@ control register
 	b	cpu_resume_mmu
 ENDPROC(cpu_v7_do_resume)
 #endif
diff --git a/arch/arm/mm/proc-xsc3.S b/arch/arm/mm/proc-xsc3.S
index efd4949..abf0507 100644
--- a/arch/arm/mm/proc-xsc3.S
+++ b/arch/arm/mm/proc-xsc3.S
@@ -406,24 +406,23 @@ ENTRY(cpu_xsc3_set_pte_ext)
 	.align
 
 .globl	cpu_xsc3_suspend_size
-.equ	cpu_xsc3_suspend_size, 4 * 7
+.equ	cpu_xsc3_suspend_size, 4 * 6
 #ifdef CONFIG_PM_SLEEP
 ENTRY(cpu_xsc3_do_suspend)
-	stmfd	sp!, {r4 - r10, lr}
+	stmfd	sp!, {r4 - r9, lr}
 	mrc	p14, 0, r4, c6, c0, 0	@ clock configuration, for turbo mode
 	mrc	p15, 0, r5, c15, c1, 0	@ CP access reg
 	mrc	p15, 0, r6, c13, c0, 0	@ PID
 	mrc 	p15, 0, r7, c3, c0, 0	@ domain ID
-	mrc 	p15, 0, r8, c2, c0, 0	@ translation table base addr
-	mrc	p15, 0, r9, c1, c0, 1	@ auxiliary control reg
-	mrc 	p15, 0, r10, c1, c0, 0	@ control reg
+	mrc	p15, 0, r8, c1, c0, 1	@ auxiliary control reg
+	mrc 	p15, 0, r9, c1, c0, 0	@ control reg
 	bic	r4, r4, #2		@ clear frequency change bit
-	stmia	r0, {r4 - r10}		@ store cp regs
-	ldmia	sp!, {r4 - r10, pc}
+	stmia	r0, {r4 - r9}		@ store cp regs
+	ldmia	sp!, {r4 - r9, pc}
 ENDPROC(cpu_xsc3_do_suspend)
 
 ENTRY(cpu_xsc3_do_resume)
-	ldmia	r0, {r4 - r10}		@ load cp regs
+	ldmia	r0, {r4 - r9}		@ load cp regs
 	mov	ip, #0
 	mcr	p15, 0, ip, c7, c7, 0	@ invalidate I & D caches, BTB
 	mcr	p15, 0, ip, c7, c10, 4	@ drain write (&fill) buffer
@@ -433,9 +432,10 @@ ENTRY(cpu_xsc3_do_resume)
 	mcr	p15, 0, r5, c15, c1, 0	@ CP access reg
 	mcr	p15, 0, r6, c13, c0, 0	@ PID
 	mcr	p15, 0, r7, c3, c0, 0	@ domain ID
-	mcr	p15, 0, r8, c2, c0, 0	@ translation table base addr
-	mcr	p15, 0, r9, c1, c0, 1	@ auxiliary control reg
-	mov	r0, r10			@ control register
+	orr	r1, r1, #0x18		@ cache the page table in L2
+	mcr	p15, 0, r1, c2, c0, 0	@ translation table base addr
+	mcr	p15, 0, r8, c1, c0, 1	@ auxiliary control reg
+	mov	r0, r9			@ control register
 	b	cpu_resume_mmu
 ENDPROC(cpu_xsc3_do_resume)
 #endif
diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
index 37dbada..3277904 100644
--- a/arch/arm/mm/proc-xscale.S
+++ b/arch/arm/mm/proc-xscale.S
@@ -520,24 +520,23 @@ ENTRY(cpu_xscale_set_pte_ext)
 	.align
 
 .globl	cpu_xscale_suspend_size
-.equ	cpu_xscale_suspend_size, 4 * 7
+.equ	cpu_xscale_suspend_size, 4 * 6
 #ifdef CONFIG_PM_SLEEP
 ENTRY(cpu_xscale_do_suspend)
-	stmfd	sp!, {r4 - r10, lr}
+	stmfd	sp!, {r4 - r9, lr}
 	mrc	p14, 0, r4, c6, c0, 0	@ clock configuration, for turbo mode
 	mrc	p15, 0, r5, c15, c1, 0	@ CP access reg
 	mrc	p15, 0, r6, c13, c0, 0	@ PID
 	mrc	p15, 0, r7, c3, c0, 0	@ domain ID
-	mrc	p15, 0, r8, c2, c0, 0	@ translation table base addr
-	mrc	p15, 0, r9, c1, c1, 0	@ auxiliary control reg
-	mrc	p15, 0, r10, c1, c0, 0	@ control reg
+	mrc	p15, 0, r8, c1, c1, 0	@ auxiliary control reg
+	mrc	p15, 0, r9, c1, c0, 0	@ control reg
 	bic	r4, r4, #2		@ clear frequency change bit
-	stmia	r0, {r4 - r10}		@ store cp regs
-	ldmfd	sp!, {r4 - r10, pc}
+	stmia	r0, {r4 - r9}		@ store cp regs
+	ldmfd	sp!, {r4 - r9, pc}
 ENDPROC(cpu_xscale_do_suspend)
 
 ENTRY(cpu_xscale_do_resume)
-	ldmia	r0, {r4 - r10}		@ load cp regs
+	ldmia	r0, {r4 - r9}		@ load cp regs
 	mov	ip, #0
 	mcr	p15, 0, ip, c8, c7, 0	@ invalidate I & D TLBs
 	mcr	p15, 0, ip, c7, c7, 0	@ invalidate I & D caches, BTB
@@ -545,9 +544,9 @@ ENTRY(cpu_xscale_do_resume)
 	mcr	p15, 0, r5, c15, c1, 0	@ CP access reg
 	mcr	p15, 0, r6, c13, c0, 0	@ PID
 	mcr	p15, 0, r7, c3, c0, 0	@ domain ID
-	mcr	p15, 0, r8, c2, c0, 0	@ translation table base addr
-	mcr	p15, 0, r9, c1, c1, 0	@ auxiliary control reg
-	mov	r0, r10			@ control register
+	mcr	p15, 0, r1, c2, c0, 0	@ translation table base addr
+	mcr	p15, 0, r8, c1, c1, 0	@ auxiliary control reg
+	mov	r0, r9			@ control register
 	b	cpu_resume_mmu
 ENDPROC(cpu_xscale_do_resume)
 #endif
-- 
1.7.4.4

