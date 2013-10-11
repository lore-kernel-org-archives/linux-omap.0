From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 04/11] ARM: OMAP3: CM/control: move CM scratchpad save to CM driver
Date: Fri, 11 Oct 2013 19:15:34 +0300
Message-ID: <1381508141-15244-5-git-send-email-t-kristo@ti.com>
References: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56922 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754845Ab3JKQQ2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Oct 2013 12:16:28 -0400
In-Reply-To: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@linaro.org, paul@pwsan.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org

OMAP3 PM code for off-mode currently saves the scratchpad contents for CM
registers within OMAP control module driver. However, as we are separating
CM code into its own driver, this must be moved also. This patch adds a
new API for saving the CM scratchpad contents and uses this from the high
level scratchpad save function.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm3xxx.c  |   22 +++++++++++++++++++++
 arch/arm/mach-omap2/cm3xxx.h  |    1 +
 arch/arm/mach-omap2/control.c |   43 ++++-------------------------------------
 3 files changed, 27 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-omap2/cm3xxx.c b/arch/arm/mach-omap2/cm3xxx.c
index 9061c30..f6f0288 100644
--- a/arch/arm/mach-omap2/cm3xxx.c
+++ b/arch/arm/mach-omap2/cm3xxx.c
@@ -636,6 +636,28 @@ void omap3_cm_restore_context(void)
 			       OMAP3_CM_CLKOUT_CTRL_OFFSET);
 }
 
+void omap3_cm_save_scratchpad_contents(u32 *ptr)
+{
+	*ptr++ = omap2_cm_read_mod_reg(CORE_MOD, CM_CLKSEL);
+	*ptr++ = omap2_cm_read_mod_reg(WKUP_MOD, CM_CLKSEL);
+	*ptr++ = omap2_cm_read_mod_reg(PLL_MOD, CM_CLKEN);
+
+	/*
+	 * As per erratum i671, ROM code does not respect the PER DPLL
+	 * programming scheme if CM_AUTOIDLE_PLL..AUTO_PERIPH_DPLL == 1.
+	 * Then,  in anycase, clear these bits to avoid extra latencies.
+	 */
+	*ptr++ = omap2_cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE) &
+		~OMAP3430_AUTO_PERIPH_DPLL_MASK;
+	*ptr++ = omap2_cm_read_mod_reg(PLL_MOD, OMAP3430_CM_CLKSEL1_PLL);
+	*ptr++ = omap2_cm_read_mod_reg(PLL_MOD, OMAP3430_CM_CLKSEL2_PLL);
+	*ptr++ = omap2_cm_read_mod_reg(PLL_MOD, OMAP3430_CM_CLKSEL3);
+	*ptr++ = omap2_cm_read_mod_reg(MPU_MOD, OMAP3430_CM_CLKEN_PLL);
+	*ptr++ = omap2_cm_read_mod_reg(MPU_MOD, OMAP3430_CM_AUTOIDLE_PLL);
+	*ptr++ = omap2_cm_read_mod_reg(MPU_MOD, OMAP3430_CM_CLKSEL1_PLL);
+	*ptr++ = omap2_cm_read_mod_reg(MPU_MOD, OMAP3430_CM_CLKSEL2_PLL);
+}
+
 /*
  *
  */
diff --git a/arch/arm/mach-omap2/cm3xxx.h b/arch/arm/mach-omap2/cm3xxx.h
index e8e146f..8224c91 100644
--- a/arch/arm/mach-omap2/cm3xxx.h
+++ b/arch/arm/mach-omap2/cm3xxx.h
@@ -83,6 +83,7 @@ extern int omap3xxx_cm_split_idlest_reg(void __iomem *idlest_reg,
 
 extern void omap3_cm_save_context(void);
 extern void omap3_cm_restore_context(void);
+extern void omap3_cm_save_scratchpad_contents(u32 *ptr);
 
 extern int __init omap3xxx_cm_init(void);
 
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 31e0dfe..a597114 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -46,17 +46,7 @@ struct omap3_scratchpad {
 struct omap3_scratchpad_prcm_block {
 	u32 prm_clksrc_ctrl;
 	u32 prm_clksel;
-	u32 cm_clksel_core;
-	u32 cm_clksel_wkup;
-	u32 cm_clken_pll;
-	u32 cm_autoidle_pll;
-	u32 cm_clksel1_pll;
-	u32 cm_clksel2_pll;
-	u32 cm_clksel3_pll;
-	u32 cm_clken_pll_mpu;
-	u32 cm_autoidle_pll_mpu;
-	u32 cm_clksel1_pll_mpu;
-	u32 cm_clksel2_pll_mpu;
+	u32 cm_contents[11];
 	u32 prcm_block_size;
 };
 
@@ -347,34 +337,9 @@ void omap3_save_scratchpad_contents(void)
 	prcm_block_contents.prm_clksel =
 		omap2_prm_read_mod_reg(OMAP3430_CCR_MOD,
 				       OMAP3_PRM_CLKSEL_OFFSET);
-	prcm_block_contents.cm_clksel_core =
-			omap2_cm_read_mod_reg(CORE_MOD, CM_CLKSEL);
-	prcm_block_contents.cm_clksel_wkup =
-			omap2_cm_read_mod_reg(WKUP_MOD, CM_CLKSEL);
-	prcm_block_contents.cm_clken_pll =
-			omap2_cm_read_mod_reg(PLL_MOD, CM_CLKEN);
-	/*
-	 * As per erratum i671, ROM code does not respect the PER DPLL
-	 * programming scheme if CM_AUTOIDLE_PLL..AUTO_PERIPH_DPLL == 1.
-	 * Then,  in anycase, clear these bits to avoid extra latencies.
-	 */
-	prcm_block_contents.cm_autoidle_pll =
-			omap2_cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE) &
-			~OMAP3430_AUTO_PERIPH_DPLL_MASK;
-	prcm_block_contents.cm_clksel1_pll =
-			omap2_cm_read_mod_reg(PLL_MOD, OMAP3430_CM_CLKSEL1_PLL);
-	prcm_block_contents.cm_clksel2_pll =
-			omap2_cm_read_mod_reg(PLL_MOD, OMAP3430_CM_CLKSEL2_PLL);
-	prcm_block_contents.cm_clksel3_pll =
-			omap2_cm_read_mod_reg(PLL_MOD, OMAP3430_CM_CLKSEL3);
-	prcm_block_contents.cm_clken_pll_mpu =
-			omap2_cm_read_mod_reg(MPU_MOD, OMAP3430_CM_CLKEN_PLL);
-	prcm_block_contents.cm_autoidle_pll_mpu =
-			omap2_cm_read_mod_reg(MPU_MOD, OMAP3430_CM_AUTOIDLE_PLL);
-	prcm_block_contents.cm_clksel1_pll_mpu =
-			omap2_cm_read_mod_reg(MPU_MOD, OMAP3430_CM_CLKSEL1_PLL);
-	prcm_block_contents.cm_clksel2_pll_mpu =
-			omap2_cm_read_mod_reg(MPU_MOD, OMAP3430_CM_CLKSEL2_PLL);
+
+	omap3_cm_save_scratchpad_contents(prcm_block_contents.cm_contents);
+
 	prcm_block_contents.prcm_block_size = 0x0;
 
 	/* Populate the SDRC block contents */
-- 
1.7.9.5

