From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] OMAP3: PM: remove save/restore of exception handler state
Date: Tue, 19 May 2009 10:24:38 -0700
Message-ID: <1242753878-28325-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f202.google.com ([209.85.222.202]:58078 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbZESRYj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 13:24:39 -0400
Received: by pzk40 with SMTP id 40so322772pzk.33
        for <linux-omap@vger.kernel.org>; Tue, 19 May 2009 10:24:41 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The exception handler state for the various modes of the processor
(FIQ, IRQ, ABORT, UNDEF, SYSTEM) does not need a full context
save/restore.  Only the stack pointers for the used modes need a
save/restore and this is done already in the ARM-generic cpu_init()
function.

So, this patch drops the full save/restore and calls cpu_init()
immiediately after returning from SRAM.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
Applies on current PM branch.

 arch/arm/mach-omap2/pm34xx.c    |    1 +
 arch/arm/mach-omap2/sleep34xx.S |  113 +-------------------------------------
 2 files changed, 4 insertions(+), 110 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index a32b18f..80992c5 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -420,6 +420,7 @@ void omap_sram_idle(void)
 	 * location and restores them back.
 	 */
 	_omap_sram_idle(omap3_arm_context, save_state);
+	cpu_init();
 
 	/* Restore normal SDRAM settings */
 	if (omap_rev() >= OMAP3430_REV_ES3_0 &&
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index e8b5d5a..38aa3fd 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -335,58 +335,6 @@ logic_l1_restore:
 	/*normal memory remap register */
 	MCR p15, 0, r5, c10, c2, 1
 
-	/* Restore registers for other modes from SDRAM */
-	/* Save current mode */
-	mrs	r7, cpsr
-
-	/* FIQ mode */
-	bic	r0, r7, #0x1F
-	orr	r0, r0, #0x11
-	msr	cpsr, r0
-	ldmia	r3!, {r8-r12}
-	/* load the SP and LR from SDRAM */
-	ldmia  r3!,{r4-r6}
-	mov    sp, r4	/*update the SP */
-	mov    lr, r5	/*update the LR */
-	msr    spsr, r6	/*update the SPSR*/
-
-	/* IRQ mode */
-	bic    r0, r7, #0x1F
-	orr    r0, r0, #0x12
-	msr    cpsr, r0	/*go into IRQ mode*/
-	ldmia  r3!,{r4-r6}	/*load the SP and LR from SDRAM*/
-	mov    sp, r4	/*update the SP */
-	mov    lr, r5	/*update the LR */
-	msr    spsr, r6	/*update the SPSR */
-
-	/* ABORT mode */
-	bic    r0, r7, #0x1F
-	orr    r0, r0, #0x17
-	msr    cpsr, r0	/* go into ABORT mode */
-	ldmia  r3!,{r4-r6}	/*load the SP and LR from SDRAM */
-	mov    sp, r4		/*update the SP */
-	mov    lr, r5		/*update the LR */
-	msr    spsr, r6		/*update the SPSR */
-
-	/* UNDEEF mode */
-	bic    r0, r7, #0x1F
-	orr    r0, r0, #0x1B
-	msr    cpsr, r0		/*go into UNDEF mode */
-	ldmia  r3!,{r4-r6}	/*load the SP and LR from SDRAM */
-	mov    sp, r4		/*update the SP*/
-	mov    lr, r5		/*update the LR*/
-	msr    spsr, r6		/*update the SPSR*/
-
-	/* SYSTEM (USER) mode */
-	bic    r0, r7, #0x1F
-	orr    r0, r0, #0x1F
-	msr    cpsr, r0		/*go into USR mode */
-	ldmia  r3!,{r4-r6}	/*load the SP and LR from SDRAM*/
-	mov    sp, r4		/*update the SP */
-	mov    lr, r5		/*update the LR */
-	msr    spsr, r6		/*update the SPSR */
-	msr    cpsr, r7		/*back to original mode*/
-
 	/* Restore cpsr */
 	ldmia	r3!,{r4}	/*load CPSR from SDRAM*/
 	msr	cpsr, r4	/*store cpsr */
@@ -502,69 +450,14 @@ l1_logic_lost:
 	mrc	p15, 0, r4, c10, c2, 0
 	mrc	p15, 0, r5, c10, c2, 1
 	stmia	r8!,{r4-r5}
-	/* Store SP, LR, SPSR registers for SUP, FIQ, IRQ, ABORT and USER
-	modes into SDRAM */
-
-	/* move SDRAM address to r7 as r8 is banked in FIQ*/
-	mov	r7, r8
-
-	/* Save current mode */
-	mrs	r2, cpsr
-	/* FIQ mode */
-	bic	r0, r2, #0x1F
-	orr	r0, r0, #0x11
-	msr	cpsr, r0 /* go to FIQ mode */
-	stmia	r7!, {r8-r12}
-	mov	r4, r13 /* move SP into r4*/
-	mov	r5, r14
-	mrs	r6, spsr
-	stmia	r7!, {r4-r6}
-
-	/* IRQ mode */
-	bic	r0, r2, #0x1F
-	orr	r0, r0, #0x12
-	msr	cpsr, r0
-	mov	r4, r13
-	mov	r5, r14
-	mrs	r6, spsr
-	stmia	r7!, {r4-r6}
-
-	/* Abort mode */
-	bic	r0, r2, #0x1F
-	orr	r0, r0, #0x17
-	msr	cpsr, r0
-	mov	r4, r13
-	mov	r5, r14
-	mrs	r6, spsr
-	stmia	r7!, {r4-r6}
-
-	/* UNDEF mode */
-	bic	r0, r2, #0x1F
-	orr	r0, r0, #0x1B
-	msr	cpsr, r0
-	mov	r4, r13
-	mov	r5, r14
-	mrs	r6, spsr
-	stmia	r7!, {r4-r6}
-
-	/* System (USER mode) */
-	bic	r0, r2, #0x1F
-	orr	r0, r0, #0x1F
-	msr	cpsr, r0
-	mov	r4, r13
-	mov	r5, r14
-	mrs	r6, spsr
-	stmia	r7!, {r4-r6}
-
-	/* Back to original mode */
-	msr	cpsr, r2
 
 	/* Store current cpsr*/
-	stmia	r7!, {r2}
+	mrs	r2, cpsr
+	stmia	r8!, {r2}
 
 	mrc	p15, 0, r4, c1, c0, 0
 	/* save control register */
-	stmia	r7!, {r4}
+	stmia	r8!, {r4}
 clean_caches:
 	/* Clean Data or unified cache to POU*/
 	/* How to invalidate only L1 cache???? - #FIX_ME# */
-- 
1.6.2.2

