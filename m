From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 2/2] OMAP3: PM: Do not rely on ROM code to restore CM_AUTOIDLE_PLL.AUTO_PERIPH_DPLL
Date: Wed, 13 Apr 2011 18:21:07 +0300
Message-ID: <1302708067-8226-3-git-send-email-eduardo.valentin@ti.com>
References: <1302708067-8226-1-git-send-email-eduardo.valentin@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39940 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756961Ab1DMPVo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Apr 2011 11:21:44 -0400
In-Reply-To: <1302708067-8226-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Linux-ARM <linux-arm-kernel@lists.infradead.org>, Eduardo Valentin <eduardo.valentin@ti.com>

As per OMAP3 erratum (i671), ROM code adds extra latencies while
restoring CM_AUTOIDLE_PLL register, if AUTO_PERIPH_DPLL is equal to 1.

This patch stores 0's in scratchpad content area corresponding to
AUTO_PERIPH_DPLL, to prevent ROM code to try to lock per DPLL, since
it won't respect proper programing scheme.

This register is then stored in prcm context. The saving and restore
is now done by kernel side.

Here follow the erratum description

DESCRIPTION

After OFF mode transition, among many restorations, the ROM Code restores the
CM_AUTOIDLE_PLL register, and after that, it tries to relock the PER DPLL.

In case the restoration data stored in scratchpad memory contains a field
CM_AUTOIDLE_PLL.AUTO_PERIPH_DPLL = 1, then the way the ROM Code restores and
locks the PER DPLL does not respect the PER DPLL programming scheme.

In that case, the DPLL might not lock. Meanwhile, when trying to lock the PER
DPLL, the ROM Code does not hang. Only extra latencies are introduced at
wake-up.

WORKAROUND

When saving the context-restore structure in scratchpad memory, in order to
respect the PER DPLL programming scheme, it is advised to store 0 in the
CM_AUTOIDLE_PLL.AUTO_PERIPH_DPLL field of the saved structure.

After wake-up, the application should store in CM_AUTOIDLE_PLL register the
right desired value.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/mach-omap2/cm2xxx_3xxx.c |   17 +++++++++++++++++
 arch/arm/mach-omap2/control.c     |    8 +++++++-
 2 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx.c b/arch/arm/mach-omap2/cm2xxx_3xxx.c
index 9d0dec8..38830d8 100644
--- a/arch/arm/mach-omap2/cm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx_3xxx.c
@@ -247,6 +247,7 @@ struct omap3_cm_regs {
 	u32 per_cm_clksel;
 	u32 emu_cm_clksel;
 	u32 emu_cm_clkstctrl;
+	u32 pll_cm_autoidle;
 	u32 pll_cm_autoidle2;
 	u32 pll_cm_clksel4;
 	u32 pll_cm_clksel5;
@@ -319,6 +320,15 @@ void omap3_cm_save_context(void)
 		omap2_cm_read_mod_reg(OMAP3430_EMU_MOD, CM_CLKSEL1);
 	cm_context.emu_cm_clkstctrl =
 		omap2_cm_read_mod_reg(OMAP3430_EMU_MOD, OMAP2_CM_CLKSTCTRL);
+	/*
+	 * As per erratum i671, ROM code does not respect the PER DPLL
+	 * programming scheme if CM_AUTOIDLE_PLL.AUTO_PERIPH_DPLL == 1.
+	 * In this case, even though this register has been saved in
+	 * scratchpad contents, we need to restore AUTO_PERIPH_DPLL
+	 * by ourselves. So, we need to save it anyway.
+	 */
+	cm_context.pll_cm_autoidle =
+		omap2_cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE);
 	cm_context.pll_cm_autoidle2 =
 		omap2_cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE2);
 	cm_context.pll_cm_clksel4 =
@@ -441,6 +451,13 @@ void omap3_cm_restore_context(void)
 			       CM_CLKSEL1);
 	omap2_cm_write_mod_reg(cm_context.emu_cm_clkstctrl, OMAP3430_EMU_MOD,
 			       OMAP2_CM_CLKSTCTRL);
+	/*
+	 * As per erratum i671, ROM code does not respect the PER DPLL
+	 * programming scheme if CM_AUTOIDLE_PLL.AUTO_PERIPH_DPLL == 1.
+	 * In this case, we need to restore AUTO_PERIPH_DPLL by ourselves.
+	 */
+	omap2_cm_write_mod_reg(cm_context.pll_cm_autoidle, PLL_MOD,
+			       CM_AUTOIDLE);
 	omap2_cm_write_mod_reg(cm_context.pll_cm_autoidle2, PLL_MOD,
 			       CM_AUTOIDLE2);
 	omap2_cm_write_mod_reg(cm_context.pll_cm_clksel4, PLL_MOD,
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index df0c75c..da53ba3 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -316,8 +316,14 @@ void omap3_save_scratchpad_contents(void)
 			omap2_cm_read_mod_reg(WKUP_MOD, CM_CLKSEL);
 	prcm_block_contents.cm_clken_pll =
 			omap2_cm_read_mod_reg(PLL_MOD, CM_CLKEN);
+	/*
+	 * As per erratum i671, ROM code does not respect the PER DPLL
+	 * programming scheme if CM_AUTOIDLE_PLL..AUTO_PERIPH_DPLL == 1.
+	 * Then,  in anycase, clear these bits to avoid extra latencies.
+	 */
 	prcm_block_contents.cm_autoidle_pll =
-			omap2_cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE);
+			omap2_cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE) &
+			~OMAP3430_AUTO_PERIPH_DPLL_MASK;
 	prcm_block_contents.cm_clksel1_pll =
 			omap2_cm_read_mod_reg(PLL_MOD, OMAP3430_CM_CLKSEL1_PLL);
 	prcm_block_contents.cm_clksel2_pll =
-- 
1.7.5-rc1

