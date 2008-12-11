From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 14/23] OMAP3 clock/SDRC: program SDRC_MR register during SDRC clock change
Date: Thu, 11 Dec 2008 17:52:33 +0200
Message-ID: <1229010762-3150-15-git-send-email-tero.kristo@nokia.com>
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
 <1229010762-3150-10-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-11-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-12-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-13-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-14-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:34959 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756167AbYLKP7N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 10:59:13 -0500
In-Reply-To: <1229010762-3150-14-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

From: Paul Walmsley <paul@pwsan.com>

Program the SDRC_MR_0 register as well during SDRC clock changes.
This register allows selection of the memory CAS latency.  Some SDRAM
chips, such as the Qimonda HYB18M512160AF6, have a lower CAS latency
at lower clock rates.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock34xx.c        |    4 ++--
 arch/arm/mach-omap2/sram34xx.S         |    8 +++++++-
 arch/arm/plat-omap/include/mach/sram.h |    2 +-
 arch/arm/plat-omap/sram.c              |    6 +++---
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 8ef0186..47a8465 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -548,10 +548,10 @@ static int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 	/* REVISIT: SRAM code doesn't support other M2 divisors yet */
 	WARN_ON(new_div != 1 && new_div != 2);
 
-	/* REVISIT: Add SDRC_MR changing to this code also */
 	local_irq_disable();
 	omap3_configure_core_dpll(sp->rfr_ctrl, sp->actim_ctrla,
-				  sp->actim_ctrlb, new_div, unlock_dll, c);
+				  sp->actim_ctrlb, new_div, unlock_dll, c,
+				  sp->mr);
 	local_irq_enable();
 
 	omap2_clksel_recalc(clk);
diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
index 8d4a88c..d13f1cc 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -44,12 +44,14 @@
  *      SDRC rates < 83MHz
  * r5 = number of MPU cycles to wait for SDRC to stabilize after
  *      reprogramming the SDRC when switching to a slower MPU speed
+ * r6 = SDRC_MR_0 register value
  *
  */
 ENTRY(omap3_sram_configure_core_dpll)
 	stmfd	sp!, {r1-r12, lr}	@ store regs to stack
 	ldr	r4, [sp, #52]		@ pull extra args off the stack
 	ldr	r5, [sp, #56]		@ load extra args from the stack
+	ldr	r6, [sp, #60]		@ load extra args from the stack
 	dsb				@ flush buffered writes to interconnect
 	cmp	r3, #0x2
 	blne	configure_sdrc
@@ -151,7 +153,9 @@ configure_sdrc:
 	str	r1, [r11]
 	ldr	r11, omap3_sdrc_actim_ctrlb
 	str	r2, [r11]
-	ldr	r2, [r11]		@ posted-write barrier for SDRC
+	ldr	r11, omap3_sdrc_mr_0
+	str	r6, [r11]
+	ldr	r6, [r11]		@ posted-write barrier for SDRC
 	bx	lr
 
 omap3_sdrc_power:
@@ -168,6 +172,8 @@ omap3_sdrc_actim_ctrla:
 	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_A_0)
 omap3_sdrc_actim_ctrlb:
 	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_B_0)
+omap3_sdrc_mr_0:
+	.word OMAP34XX_SDRC_REGADDR(SDRC_MR_0)
 omap3_sdrc_dlla_status:
 	.word OMAP34XX_SDRC_REGADDR(SDRC_DLLA_STATUS)
 omap3_sdrc_dlla_ctrl:
diff --git a/arch/arm/plat-omap/include/mach/sram.h b/arch/arm/plat-omap/include/mach/sram.h
index 54913fc..d07da3b 100644
--- a/arch/arm/plat-omap/include/mach/sram.h
+++ b/arch/arm/plat-omap/include/mach/sram.h
@@ -24,7 +24,7 @@ extern u32 omap2_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val, int bypass);
 extern u32 omap3_configure_core_dpll(u32 sdrc_rfr_ctrl,
 				     u32 sdrc_actim_ctrla,
 				     u32 sdrc_actim_ctrlb, u32 m2,
-				     u32 unlock_dll, u32 f);
+				     u32 unlock_dll, u32 f, u32 sdrc_mr);
 extern void omap3_sram_restore_context(void);
 
 /* Do not use these */
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 8d27e91..68a1f69 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -372,10 +372,10 @@ static u32 (*_omap3_sram_configure_core_dpll)(u32 sdrc_rfr_ctrl,
 					      u32 sdrc_actim_ctrla,
 					      u32 sdrc_actim_ctrlb,
 					      u32 m2, u32 unlock_dll,
-					      u32 f);
+					      u32 f, u32 sdrc_mr);
 u32 omap3_configure_core_dpll(u32 sdrc_rfr_ctrl, u32 sdrc_actim_ctrla,
 			      u32 sdrc_actim_ctrlb, u32 m2, u32 unlock_dll,
-			      u32 f)
+			      u32 f, u32 sdrc_mr)
  {
 	if (!_omap3_sram_configure_core_dpll)
 		omap_sram_error();
@@ -383,7 +383,7 @@ u32 omap3_configure_core_dpll(u32 sdrc_rfr_ctrl, u32 sdrc_actim_ctrla,
 	return _omap3_sram_configure_core_dpll(sdrc_rfr_ctrl,
 					       sdrc_actim_ctrla,
 					       sdrc_actim_ctrlb, m2,
-					       unlock_dll, f);
+					       unlock_dll, f, sdrc_mr);
  }
 
 #ifdef CONFIG_PM
-- 
1.5.4.3

