From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 4/5 v3] OMAP3630: PM: Disable L2 cache while invalidating L2 cache
Date: Fri,  3 Dec 2010 11:03:37 -0600
Message-ID: <1291395818-8639-5-git-send-email-nm@ti.com>
References: <1291395818-8639-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52917 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751727Ab0LCRDt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Dec 2010 12:03:49 -0500
In-Reply-To: <1291395818-8639-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This disables L2 cache before invalidating it and reenables it afterwards.
This is be done according to ARM documentation. Currently this is identified
as being needed on OMAP3630 as the disable/enable is done from "public side"
while, on OMAP3430, this is done in the "secure side".

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>

[nm@ti.com: ported to 2.6.37-rc2, added hooks to enable the logic only on 3630]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
v3: collate all silicon specific errata under a single cpu detection code
	making it elegant and more maintainable.
v2: https://patchwork.kernel.org/patch/365232/
	rebased out to this series independent of HS bugfixes
v1: http://marc.info/?l=linux-omap&m=129013171125204&w=2
 arch/arm/mach-omap2/pm.h        |    6 ++++++
 arch/arm/mach-omap2/pm34xx.c    |    5 ++++-
 arch/arm/mach-omap2/sleep34xx.S |   30 ++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 0d75bfd..aff39d0 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -85,4 +85,10 @@ extern unsigned int save_secure_ram_context_sz;
 extern unsigned int omap24xx_cpu_suspend_sz;
 extern unsigned int omap34xx_cpu_suspend_sz;
 
+#if defined(CONFIG_PM)
+extern void enable_omap3630_toggle_l2_on_restore(void);
+#else
+static inline void enable_omap3630_toggle_l2_on_restore(void) { }
+#endif
+
 #endif
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index a89ffc7..b49e02b 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -995,8 +995,11 @@ void omap_push_sram_idle(void)
 
 static void __init pm_errata_configure(void)
 {
-	if (cpu_is_omap3630())
+	if (cpu_is_omap3630()) {
 		pm34xx_errata |= RTA_ERRATUM_i608;
+		/* Enable the l2 cache toggling in sleep logic */
+		enable_omap3630_toggle_l2_on_restore();
+	}
 }
 
 static int __init omap3_pm_init(void)
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index cc3507b..d2eda01 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -111,6 +111,19 @@ ENTRY(get_omap3630_restore_pointer_sz)
         .word   . - get_omap3630_restore_pointer
 
 	.text
+/*
+ * L2 cache needs to be toggled for stable OFF mode functionality on 3630.
+ * This function sets up a fflag that will allow for this toggling to take
+ * place on 3630. Hopefully some version in the future maynot need this
+ */
+ENTRY(enable_omap3630_toggle_l2_on_restore)
+        stmfd   sp!, {lr}     @ save registers on stack
+	/* Setup so that we will disable and enable l2 */
+	mov	r1, #0x1
+	str	r1, l2dis_3630
+        ldmfd   sp!, {pc}     @ restore regs and return
+
+	.text
 /* Function call to get the restore pointer for for ES3 to resume from OFF */
 ENTRY(get_es3_restore_pointer)
 	stmfd	sp!, {lr}	@ save registers on stack
@@ -283,6 +296,14 @@ restore:
         moveq   r9, #0x3        @ MPU OFF => L1 and L2 lost
 	movne	r9, #0x1	@ Only L1 and L2 lost => avoid L2 invalidation
 	bne	logic_l1_restore
+
+	ldr	r0, l2dis_3630
+	cmp	r0, #0x1	@ should we disable L2 on 3630?
+	bne	skipl2dis
+	mrc	p15, 0, r0, c1, c0, 1
+	bic	r0, r0, #2	@ disable L2 cache
+	mcr	p15, 0, r0, c1, c0, 1
+skipl2dis:
 	ldr	r0, control_stat
 	ldr	r1, [r0]
 	and	r1, #0x700
@@ -343,6 +364,13 @@ smi:    .word 0xE1600070		@ Call SMI monitor (smieq)
 	mov	r12, #0x2
 	.word 0xE1600070	@ Call SMI monitor (smieq)
 logic_l1_restore:
+	ldr	r1, l2dis_3630
+	cmp	r1, #0x1	@ Do we need to re-enable L2 on 3630?
+	bne	skipl2reen
+	mrc	p15, 0, r1, c1, c0, 1
+	orr	r1, r1, #2	@ re-enable L2 cache
+	mcr	p15, 0, r1, c1, c0, 1
+skipl2reen:
 	mov	r1, #0
 	/* Invalidate all instruction caches to PoU
 	 * and flush branch target cache */
@@ -678,6 +706,8 @@ control_mem_rta:
 	.word	CONTROL_MEM_RTA_CTRL
 kernel_flush:
 	.word v7_flush_dcache_all
+l2dis_3630:
+	.word 0
 	/* these 2 words need to be at the end !!! */
 kick_counter:
 	.word	0
-- 
1.6.3.3

