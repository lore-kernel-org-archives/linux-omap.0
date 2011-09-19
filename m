From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 4/7] ARM: pm: no need to save/restore context ID register
Date: Mon, 19 Sep 2011 17:39:44 +0100
Message-ID: <E1R5gsi-00051z-7Q@rmk-PC.arm.linux.org.uk>
References: <20110919163741.GE16591@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38928 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754870Ab1ISRxF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Sep 2011 13:53:05 -0400
In-Reply-To: <20110919163741.GE16591@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.orglinux-omap@vger.kernel.orglinux-arm-kernel@lists.infradead.org

There is no need to save and restore the context ID register on ARMv6
and ARMv7 with a temporary page table as we write the context ID
register when we switch back to the real page tables for the thread.

Moreover, the temporary page tables do not contain any non-global
mappings, so the context ID value should not be used.  To be safe,
initialize the register to a reserved context ID value.

Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/proc-v6.S |   33 ++++++++++++++++-----------------
 arch/arm/mm/proc-v7.S |   13 ++++++-------
 2 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index 2e27b46..d061d2f 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -128,19 +128,18 @@ ENTRY(cpu_v6_set_pte_ext)
 
 /* Suspend/resume support: taken from arch/arm/mach-s3c64xx/sleep.S */
 .globl	cpu_v6_suspend_size
-.equ	cpu_v6_suspend_size, 4 * 7
+.equ	cpu_v6_suspend_size, 4 * 6
 #ifdef CONFIG_PM_SLEEP
 ENTRY(cpu_v6_do_suspend)
-	stmfd	sp!, {r4 - r10, lr}
+	stmfd	sp!, {r4 - r9, lr}
 	mrc	p15, 0, r4, c13, c0, 0	@ FCSE/PID
-	mrc	p15, 0, r5, c13, c0, 1	@ Context ID
-	mrc	p15, 0, r6, c3, c0, 0	@ Domain ID
-	mrc	p15, 0, r7, c2, c0, 1	@ Translation table base 1
-	mrc	p15, 0, r8, c1, c0, 1	@ auxiliary control register
-	mrc	p15, 0, r9, c1, c0, 2	@ co-processor access control
-	mrc	p15, 0, r10, c1, c0, 0	@ control register
-	stmia	r0, {r4 - r10}
-	ldmfd	sp!, {r4- r10, pc}
+	mrc	p15, 0, r5, c3, c0, 0	@ Domain ID
+	mrc	p15, 0, r6, c2, c0, 1	@ Translation table base 1
+	mrc	p15, 0, r7, c1, c0, 1	@ auxiliary control register
+	mrc	p15, 0, r8, c1, c0, 2	@ co-processor access control
+	mrc	p15, 0, r9, c1, c0, 0	@ control register
+	stmia	r0, {r4 - r9}
+	ldmfd	sp!, {r4- r9, pc}
 ENDPROC(cpu_v6_do_suspend)
 
 ENTRY(cpu_v6_do_resume)
@@ -149,19 +148,19 @@ ENTRY(cpu_v6_do_resume)
 	mcr	p15, 0, ip, c7, c5, 0	@ invalidate I cache
 	mcr	p15, 0, ip, c7, c15, 0	@ clean+invalidate cache
 	mcr	p15, 0, ip, c7, c10, 4	@ drain write buffer
-	ldmia	r0, {r4 - r10}
+	mcr	p15, 0, ip, c13, c0, 1	@ set reserved context ID
+	ldmia	r0, {r4 - r9}
 	mcr	p15, 0, r4, c13, c0, 0	@ FCSE/PID
-	mcr	p15, 0, r5, c13, c0, 1	@ Context ID
-	mcr	p15, 0, r6, c3, c0, 0	@ Domain ID
+	mcr	p15, 0, r5, c3, c0, 0	@ Domain ID
 	ALT_SMP(orr	r1, r1, #TTB_FLAGS_SMP)
 	ALT_UP(orr	r1, r1, #TTB_FLAGS_UP)
 	mcr	p15, 0, r1, c2, c0, 0	@ Translation table base 0
-	mcr	p15, 0, r7, c2, c0, 1	@ Translation table base 1
-	mcr	p15, 0, r8, c1, c0, 1	@ auxiliary control register
-	mcr	p15, 0, r9, c1, c0, 2	@ co-processor access control
+	mcr	p15, 0, r6, c2, c0, 1	@ Translation table base 1
+	mcr	p15, 0, r7, c1, c0, 1	@ auxiliary control register
+	mcr	p15, 0, r8, c1, c0, 2	@ co-processor access control
 	mcr	p15, 0, ip, c2, c0, 2	@ TTB control register
 	mcr	p15, 0, ip, c7, c5, 4	@ ISB
-	mov	r0, r10			@ control register
+	mov	r0, r9			@ control register
 	b	cpu_resume_mmu
 ENDPROC(cpu_v6_do_resume)
 #endif
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index b56004f..6af366c 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -217,14 +217,13 @@ ENDPROC(cpu_v7_set_pte_ext)
 
 /* Suspend/resume support: derived from arch/arm/mach-s5pv210/sleep.S */
 .globl	cpu_v7_suspend_size
-.equ	cpu_v7_suspend_size, 4 * 8
+.equ	cpu_v7_suspend_size, 4 * 7
 #ifdef CONFIG_PM_SLEEP
 ENTRY(cpu_v7_do_suspend)
 	stmfd	sp!, {r4 - r10, lr}
 	mrc	p15, 0, r4, c13, c0, 0	@ FCSE/PID
-	mrc	p15, 0, r5, c13, c0, 1	@ Context ID
-	mrc	p15, 0, r6, c13, c0, 3	@ User r/o thread ID
-	stmia	r0!, {r4 - r6}
+	mrc	p15, 0, r5, c13, c0, 3	@ User r/o thread ID
+	stmia	r0!, {r4 - r5}
 	mrc	p15, 0, r6, c3, c0, 0	@ Domain ID
 	mrc	p15, 0, r7, c2, c0, 1	@ TTB 1
 	mrc	p15, 0, r8, c1, c0, 0	@ Control register
@@ -238,10 +237,10 @@ ENTRY(cpu_v7_do_resume)
 	mov	ip, #0
 	mcr	p15, 0, ip, c8, c7, 0	@ invalidate TLBs
 	mcr	p15, 0, ip, c7, c5, 0	@ invalidate I cache
-	ldmia	r0!, {r4 - r6}
+	mcr	p15, 0, ip, c13, c0, 1	@ set reserved context ID
+	ldmia	r0!, {r4 - r5}
 	mcr	p15, 0, r4, c13, c0, 0	@ FCSE/PID
-	mcr	p15, 0, r5, c13, c0, 1	@ Context ID
-	mcr	p15, 0, r6, c13, c0, 3	@ User r/o thread ID
+	mcr	p15, 0, r5, c13, c0, 3	@ User r/o thread ID
 	ldmia	r0, {r6 - r10}
 	mcr	p15, 0, r6, c3, c0, 0	@ Domain ID
 	ALT_SMP(orr	r1, r1, #TTB_FLAGS_SMP)
-- 
1.7.4.4

