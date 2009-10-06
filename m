From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] OMAP3: DVFS: No sdrc AC timing changes during core dvfs
Date: Tue,  6 Oct 2009 18:50:24 +0530
Message-ID: <1254835224-19500-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60212 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757267AbZJFNVE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Oct 2009 09:21:04 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n96DKP0u024201
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 6 Oct 2009 08:20:27 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

This patch removes the SDRC AC timings changes done during core dvfs.
Updating AC timing CTRL values for SDRC during DVFS is seen to be a risk,
while the RFR CTRL value is safe to be updated.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock34xx.c        |   17 +++++++-----
 arch/arm/mach-omap2/sram34xx.S         |   44 +------------------------------
 arch/arm/plat-omap/include/mach/sram.h |    6 +---
 arch/arm/plat-omap/sram.c              |   18 ++++--------
 4 files changed, 20 insertions(+), 65 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index d6b7eb6..6210200 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -893,19 +893,22 @@ static int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 		 sdrc_cs1->rfr_ctrl, sdrc_cs1->actim_ctrla,
 		 sdrc_cs1->actim_ctrlb, sdrc_cs1->mr);
 
+	/*
+	 * Only the SDRC RFRCTRL value is seen to be safe to be
+	 * changed during dvfs.
+	 * The ACTiming values are left unchanged and should be
+	 * the ones programmed by the bootloader for higher OPP.
+	 */
 	if (sdrc_cs1)
 		omap3_configure_core_dpll(
 				  new_div, unlock_dll, c, rate > clk->rate,
-				  sdrc_cs0->rfr_ctrl, sdrc_cs0->actim_ctrla,
-				  sdrc_cs0->actim_ctrlb, sdrc_cs0->mr,
-				  sdrc_cs1->rfr_ctrl, sdrc_cs1->actim_ctrla,
-				  sdrc_cs1->actim_ctrlb, sdrc_cs1->mr);
+				  sdrc_cs0->rfr_ctrl, sdrc_cs0->mr,
+				  sdrc_cs1->rfr_ctrl, sdrc_cs1->mr);
 	else
 		omap3_configure_core_dpll(
 				  new_div, unlock_dll, c, rate > clk->rate,
-				  sdrc_cs0->rfr_ctrl, sdrc_cs0->actim_ctrla,
-				  sdrc_cs0->actim_ctrlb, sdrc_cs0->mr,
-				  0, 0, 0, 0);
+				  sdrc_cs0->rfr_ctrl, sdrc_cs0->mr,
+				  0, 0);
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
index 82aa4a3..fc84801 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -83,12 +83,8 @@
  *  before use by the code in SRAM (SDRAM is not accessible during SDRC
  *  reconfiguration):
  *  new SDRC_RFR_CTRL_0 register contents
- *  new SDRC_ACTIM_CTRL_A_0 register contents
- *  new SDRC_ACTIM_CTRL_B_0 register contents
  *  new SDRC_MR_0 register value
  *  new SDRC_RFR_CTRL_1 register contents
- *  new SDRC_ACTIM_CTRL_A_1 register contents
- *  new SDRC_ACTIM_CTRL_B_1 register contents
  *  new SDRC_MR_1 register value
  *
  * If the param SDRC_RFR_CTRL_1 is 0, the parameters
@@ -102,20 +98,12 @@ ENTRY(omap3_sram_configure_core_dpll)
 	ldr	r4, [sp, #52]
 	str     r4, omap_sdrc_rfr_ctrl_0_val
 	ldr	r4, [sp, #56]
-	str     r4, omap_sdrc_actim_ctrl_a_0_val
-	ldr	r4, [sp, #60]
-	str     r4, omap_sdrc_actim_ctrl_b_0_val
-	ldr	r4, [sp, #64]
 	str     r4, omap_sdrc_mr_0_val
-	ldr	r4, [sp, #68]
+	ldr	r4, [sp, #60]
 	str     r4, omap_sdrc_rfr_ctrl_1_val
 	cmp	r4, #0			@ if SDRC_RFR_CTRL_1 is 0,
 	beq	skip_cs1_params		@  do not use cs1 params
-	ldr	r4, [sp, #72]
-	str     r4, omap_sdrc_actim_ctrl_a_1_val
-	ldr	r4, [sp, #76]
-	str     r4, omap_sdrc_actim_ctrl_b_1_val
-	ldr	r4, [sp, #80]
+	ldr	r4, [sp, #64]
 	str     r4, omap_sdrc_mr_1_val
 skip_cs1_params:
 	dsb				@ flush buffered writes to interconnect
@@ -219,12 +207,6 @@ configure_sdrc:
 	ldr	r12, omap_sdrc_rfr_ctrl_0_val	@ fetch value from SRAM
 	ldr	r11, omap3_sdrc_rfr_ctrl_0	@ fetch addr from SRAM
 	str	r12, [r11]			@ store
-	ldr	r12, omap_sdrc_actim_ctrl_a_0_val
-	ldr	r11, omap3_sdrc_actim_ctrl_a_0
-	str	r12, [r11]
-	ldr	r12, omap_sdrc_actim_ctrl_b_0_val
-	ldr	r11, omap3_sdrc_actim_ctrl_b_0
-	str	r12, [r11]
 	ldr	r12, omap_sdrc_mr_0_val
 	ldr	r11, omap3_sdrc_mr_0
 	str	r12, [r11]
@@ -233,12 +215,6 @@ configure_sdrc:
 	beq	skip_cs1_prog		@  do not program cs1 params
 	ldr	r11, omap3_sdrc_rfr_ctrl_1
 	str	r12, [r11]
-	ldr	r12, omap_sdrc_actim_ctrl_a_1_val
-	ldr	r11, omap3_sdrc_actim_ctrl_a_1
-	str	r12, [r11]
-	ldr	r12, omap_sdrc_actim_ctrl_b_1_val
-	ldr	r11, omap3_sdrc_actim_ctrl_b_1
-	str	r12, [r11]
 	ldr	r12, omap_sdrc_mr_1_val
 	ldr	r11, omap3_sdrc_mr_1
 	str	r12, [r11]
@@ -259,14 +235,6 @@ omap3_sdrc_rfr_ctrl_0:
 	.word OMAP34XX_SDRC_REGADDR(SDRC_RFR_CTRL_0)
 omap3_sdrc_rfr_ctrl_1:
 	.word OMAP34XX_SDRC_REGADDR(SDRC_RFR_CTRL_1)
-omap3_sdrc_actim_ctrl_a_0:
-	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_A_0)
-omap3_sdrc_actim_ctrl_a_1:
-	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_A_1)
-omap3_sdrc_actim_ctrl_b_0:
-	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_B_0)
-omap3_sdrc_actim_ctrl_b_1:
-	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_B_1)
 omap3_sdrc_mr_0:
 	.word OMAP34XX_SDRC_REGADDR(SDRC_MR_0)
 omap3_sdrc_mr_1:
@@ -275,14 +243,6 @@ omap_sdrc_rfr_ctrl_0_val:
 	.word 0xDEADBEEF
 omap_sdrc_rfr_ctrl_1_val:
 	.word 0xDEADBEEF
-omap_sdrc_actim_ctrl_a_0_val:
-	.word 0xDEADBEEF
-omap_sdrc_actim_ctrl_a_1_val:
-	.word 0xDEADBEEF
-omap_sdrc_actim_ctrl_b_0_val:
-	.word 0xDEADBEEF
-omap_sdrc_actim_ctrl_b_1_val:
-	.word 0xDEADBEEF
 omap_sdrc_mr_0_val:
 	.word 0xDEADBEEF
 omap_sdrc_mr_1_val:
diff --git a/arch/arm/plat-omap/include/mach/sram.h b/arch/arm/plat-omap/include/mach/sram.h
index 16a1b45..52e3cec 100644
--- a/arch/arm/plat-omap/include/mach/sram.h
+++ b/arch/arm/plat-omap/include/mach/sram.h
@@ -23,10 +23,8 @@ extern u32 omap2_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val, int bypass);
 
 extern u32 omap3_configure_core_dpll(
 			u32 m2, u32 unlock_dll, u32 f, u32 inc,
-			u32 sdrc_rfr_ctrl_0, u32 sdrc_actim_ctrl_a_0,
-			u32 sdrc_actim_ctrl_b_0, u32 sdrc_mr_0,
-			u32 sdrc_rfr_ctrl_1, u32 sdrc_actim_ctrl_a_1,
-			u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1);
+			u32 sdrc_rfr_ctrl_0, u32 sdrc_mr_0,
+			u32 sdrc_rfr_ctrl_1, u32 sdrc_mr_1);
 extern void omap3_sram_restore_context(void);
 
 /* Do not use these */
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index f2b0fa6..3705387 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -375,24 +375,18 @@ static inline int omap243x_sram_init(void)
 
 static u32 (*_omap3_sram_configure_core_dpll)(
 			u32 m2, u32 unlock_dll, u32 f, u32 inc,
-			u32 sdrc_rfr_ctrl_0, u32 sdrc_actim_ctrl_a_0,
-			u32 sdrc_actim_ctrl_b_0, u32 sdrc_mr_0,
-			u32 sdrc_rfr_ctrl_1, u32 sdrc_actim_ctrl_a_1,
-			u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1);
+			u32 sdrc_rfr_ctrl_0, u32 sdrc_mr_0,
+			u32 sdrc_rfr_ctrl_1, u32 sdrc_mr_1);
 
 u32 omap3_configure_core_dpll(u32 m2, u32 unlock_dll, u32 f, u32 inc,
-			u32 sdrc_rfr_ctrl_0, u32 sdrc_actim_ctrl_a_0,
-			u32 sdrc_actim_ctrl_b_0, u32 sdrc_mr_0,
-			u32 sdrc_rfr_ctrl_1, u32 sdrc_actim_ctrl_a_1,
-			u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1)
+			u32 sdrc_rfr_ctrl_0, u32 sdrc_mr_0,
+			u32 sdrc_rfr_ctrl_1, u32 sdrc_mr_1)
 {
 	BUG_ON(!_omap3_sram_configure_core_dpll);
 	return _omap3_sram_configure_core_dpll(
 			m2, unlock_dll, f, inc,
-			sdrc_rfr_ctrl_0, sdrc_actim_ctrl_a_0,
-			sdrc_actim_ctrl_b_0, sdrc_mr_0,
-			sdrc_rfr_ctrl_1, sdrc_actim_ctrl_a_1,
-			sdrc_actim_ctrl_b_1, sdrc_mr_1);
+			sdrc_rfr_ctrl_0, sdrc_mr_0,
+			sdrc_rfr_ctrl_1, sdrc_mr_1);
 }
 
 #ifdef CONFIG_PM
-- 
1.5.4.7

