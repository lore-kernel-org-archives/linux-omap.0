From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 6/6] ARM: pm: allow generic sleep code to be used with SMP CPU idle
Date: Fri, 11 Feb 2011 16:19:15 +0000
Message-ID: <E1PnviF-0002yt-EC@rmk-PC.arm.linux.org.uk>
References: <20110211161626.GA31356@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34520 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756725Ab1BKQTa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Feb 2011 11:19:30 -0500
In-Reply-To: <20110211161626.GA31356@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Allow the generic sleep code to be used with SMP CPU idle by storing
N CPU stack pointers rather than just one.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/sleep.S |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index 9f106fa..e10618f 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -25,7 +25,14 @@ ENTRY(cpu_suspend)
 	stmfd	sp!, {r1, r2, r3, ip}	@ save v:p, virt SP, retfn, phys resume fn
 	ldr	r3, =sleep_save_sp
 	add	r2, sp, r1		@ convert SP to phys
+#ifdef CONFIG_SMP
+	ALT_SMP(mrc p15, 0, lr, c0, c0, 5)
+	ALT_UP(mov lr, #0)
+	and	lr, lr, #15
+	str	r2, [r3, lr, lsl #2]	@ save phys SP
+#else
 	str	r2, [r3]		@ save phys SP
+#endif
 	mov	lr, pc
 	ldr	pc, [r10, #CPU_DO_SUSPEND] @ save CPU state
 #else
@@ -36,7 +43,14 @@ ENTRY(cpu_suspend)
 	stmfd	sp!, {r1, r2, r3}	@ save v:p, virt SP, return fn
 	ldr	r3, =sleep_save_sp
 	add	r2, sp, r1		@ convert SP to phys
+#ifdef CONFIG_SMP
+	ALT_SMP(mrc p15, 0, lr, c0, c0, 5)
+	ALT_UP(mov lr, #0)
+	and	lr, lr, #15
+	str	r2, [r3, lr, lsl #2]	@ save phys SP
+#else
 	str	r2, [r3]		@ save phys SP
+#endif
 	bl	cpu_do_suspend
 #endif
 
@@ -96,7 +110,15 @@ cpu_resume_after_mmu:
 	.data
 	.align
 ENTRY(cpu_resume)
+#ifdef CONFIG_SMP
+	adr	r0, sleep_save_sp
+	ALT_SMP(mrc p15, 0, r1, c0, c0, 5)
+	ALT_UP(mov r1, #0)
+	and	r1, r1, #15
+	ldr	r0, [r0, r1, lsl #2]	@ stack phys addr
+#else
 	ldr	r0, sleep_save_sp	@ stack phys addr
+#endif
 	msr	cpsr_c, #PSR_I_BIT | PSR_F_BIT | SVC_MODE @ set SVC, irqs off
 #ifdef MULTI_CPU
 	ldmia	r0!, {r1, sp, lr, pc}	@ load v:p, stack, return fn, resume fn
@@ -107,4 +129,6 @@ ENTRY(cpu_resume)
 ENDPROC(cpu_resume)
 
 sleep_save_sp:
-	.word	0				@ preserve stack phys ptr here
+	.rept	CONFIG_NR_CPUS
+	.long	0				@ preserve stack phys ptr here
+	.endr
-- 
1.6.2.5

