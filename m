From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 09/23] OMAP3 clock: only unlock SDRC DLL if SDRC clk < 83MHz
Date: Thu, 11 Dec 2008 17:52:28 +0200
Message-ID: <1229010762-3150-10-git-send-email-tero.kristo@nokia.com>
References: <>
 <1229010762-3150-1-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-2-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-3-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-4-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-5-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-6-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-7-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-8-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-9-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:53929 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756161AbYLKP7A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 10:59:00 -0500
In-Reply-To: <1229010762-3150-9-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

From: Paul Walmsley <paul@pwsan.com>

According to the 34xx TRM Rev. K section 11.2.4.4.11.1 "Purpose of the
DLL/CDL Module," the SDRC delay-locked-loop can be locked at any SDRC
clock frequency from 83MHz to 166MHz.  CDP code unconditionally
unlocked the DLL whenever shifting to a lower SDRC speed, but this
seems unnecessary and error-prone, as the DLL is no longer able to
compensate for process, voltage, and temperature variations.  Instead,
only unlock the DLL when the SDRC clock rate would be less than 83MHz.

In situations where the DLL is unlocked, we should probably be
changing the FIXEDDELAY field, but currently we have no information on
how to calculate it.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock34xx.c        |   11 ++++++++++-
 arch/arm/mach-omap2/sram34xx.S         |   13 +++++++------
 arch/arm/plat-omap/include/mach/sram.h |    3 ++-
 arch/arm/plat-omap/sram.c              |    7 ++++---
 4 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 3000c33..efeb9c9 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -48,6 +48,9 @@
 
 #define MAX_DPLL_WAIT_TRIES		1000000
 
+/* Minimum SDRC clock frequency that the SDRC DLL can lock at */
+#define MIN_SDRC_DLL_LOCK_FREQ		83000000
+
 struct omap_opp *curr_vdd1_prcm_set;
 struct omap_opp *curr_vdd2_prcm_set;
 static struct clk *dpll1_clk, *dpll2_clk, *dpll3_clk;
@@ -482,6 +485,7 @@ static int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 static int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 {
 	u32 new_div = 0;
+	u32 unlock_dll = 0;
 	unsigned long validrate, sdrcrate;
 	struct omap_sdrc_params *sp;
 
@@ -508,6 +512,11 @@ static int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 	if (!sp)
 		return -EINVAL;
 
+	if (sdrcrate < MIN_SDRC_DLL_LOCK_FREQ) {
+		pr_debug("clock: will unlock SDRC DLL\n");
+		unlock_dll = 1;
+	}
+
 	pr_info("clock: changing CORE DPLL rate from %lu to %lu\n", clk->rate,
 		validrate);
 	pr_info("clock: SDRC timing params used: %08x %08x %08x\n",
@@ -519,7 +528,7 @@ static int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 	/* REVISIT: Add SDRC_MR changing to this code also */
 	local_irq_disable();
 	omap3_configure_core_dpll(sp->rfr_ctrl, sp->actim_ctrla,
-				  sp->actim_ctrlb, new_div);
+				  sp->actim_ctrlb, new_div, unlock_dll);
 	local_irq_enable();
 
 	omap2_clksel_recalc(clk);
diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
index 35131e5..c080c82 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -40,22 +40,23 @@
 /*
  * Change frequency of core dpll
  * r0 = sdrc_rfr_ctrl r1 = sdrc_actim_ctrla r2 = sdrc_actim_ctrlb r3 = M2
+ * r4 = Unlock SDRC DLL? (1 = yes, 0 = no) -- only unlock DLL for
+ *      SDRC rates < 83MHz
  */
 ENTRY(omap3_sram_configure_core_dpll)
 	stmfd	sp!, {r1-r12, lr}	@ store regs to stack
+	ldr	r4, [sp, #52]		@ pull extra args off the stack
 	dsb				@ flush buffered writes to interconnect
 	cmp	r3, #0x2
 	blne	configure_sdrc
-	cmp	r3, #0x2
+	cmp	r4, #0x1
+	bleq	unlock_dll
 	blne	lock_dll
-	cmp	r3, #0x1
-	blne	unlock_dll
 	bl	sdram_in_selfrefresh	@ put the SDRAM in self refresh
 	bl 	configure_core_dpll
 	bl	enable_sdrc
-	cmp	r3, #0x1
-	blne	wait_dll_unlock
-	cmp	r3, #0x2
+	cmp	r4, #0x1
+	bleq	wait_dll_unlock
 	blne	wait_dll_lock
 	cmp	r3, #0x1
 	blne	configure_sdrc
diff --git a/arch/arm/plat-omap/include/mach/sram.h b/arch/arm/plat-omap/include/mach/sram.h
index 0c0b45f..8ce41e0 100644
--- a/arch/arm/plat-omap/include/mach/sram.h
+++ b/arch/arm/plat-omap/include/mach/sram.h
@@ -23,7 +23,8 @@ extern u32 omap2_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val, int bypass);
 
 extern u32 omap3_configure_core_dpll(u32 sdrc_rfr_ctrl,
 				     u32 sdrc_actim_ctrla,
-				     u32 sdrc_actim_ctrlb, u32 m2);
+				     u32 sdrc_actim_ctrlb, u32 m2,
+				     u32 unlock_dll);
 extern void omap3_sram_restore_context(void);
 
 /* Do not use these */
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 04214e1..65fcfdf 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -371,16 +371,17 @@ static inline int omap243x_sram_init(void)
 static u32 (*_omap3_sram_configure_core_dpll)(u32 sdrc_rfr_ctrl,
 					      u32 sdrc_actim_ctrla,
 					      u32 sdrc_actim_ctrlb,
-					      u32 m2);
+					      u32 m2, u32 unlock_dll);
 u32 omap3_configure_core_dpll(u32 sdrc_rfr_ctrl, u32 sdrc_actim_ctrla,
-			      u32 sdrc_actim_ctrlb, u32 m2)
+			      u32 sdrc_actim_ctrlb, u32 m2, u32 unlock_dll)
  {
 	if (!_omap3_sram_configure_core_dpll)
 		omap_sram_error();
 
 	return _omap3_sram_configure_core_dpll(sdrc_rfr_ctrl,
 					       sdrc_actim_ctrla,
-					       sdrc_actim_ctrlb, m2);
+					       sdrc_actim_ctrlb, m2,
+					       unlock_dll);
  }
 
 #ifdef CONFIG_PM
-- 
1.5.4.3

