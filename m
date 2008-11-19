From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH] PM: Added three PLL registers to the PRCM context save
Date: Wed, 19 Nov 2008 11:31:56 +0200
Message-ID: <1227087116-16286-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:57965 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688AbYKSJfC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Nov 2008 04:35:02 -0500
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAJ9YeZG024929
	for <linux-omap@vger.kernel.org>; Wed, 19 Nov 2008 11:34:59 +0200
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id mAJ9YrlJ005958
	for <linux-omap@vger.kernel.org>; Wed, 19 Nov 2008 11:34:54 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

These registers are now also saved:
	CM_CLKSEL4
	CM_CLKEN
	CM_CLKEN2

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/prcm.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index d5a1e4b..c64b668 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -46,7 +46,10 @@ struct omap3_prcm_regs {
 	u32 emu_cm_clksel;
 	u32 emu_cm_clkstctrl;
 	u32 pll_cm_autoidle2;
+	u32 pll_cm_clksel4;
 	u32 pll_cm_clksel5;
+	u32 pll_cm_clken;
+	u32 pll_cm_clken2;
 	u32 cm_polctrl;
 	u32 iva2_cm_fclken;
 	u32 core_cm_fclken1;
@@ -233,8 +236,14 @@ void omap3_prcm_save_context(void)
 			 cm_read_mod_reg(OMAP3430_EMU_MOD, CM_CLKSTCTRL);
 	prcm_context.pll_cm_autoidle2 =
 			 cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE2);
+	prcm_context.pll_cm_clksel4 =
+			cm_read_mod_reg(PLL_MOD, OMAP3430ES2_CM_CLKSEL4);
 	prcm_context.pll_cm_clksel5 =
 			 cm_read_mod_reg(PLL_MOD, OMAP3430ES2_CM_CLKSEL5);
+	prcm_context.pll_cm_clken =
+			cm_read_mod_reg(PLL_MOD, CM_CLKEN);
+	prcm_context.pll_cm_clken2 =
+			cm_read_mod_reg(PLL_MOD, OMAP3430ES2_CM_CLKEN2);
 	prcm_context.cm_polctrl = __raw_readl(OMAP3430_CM_POLCTRL);
 	prcm_context.iva2_cm_fclken =
 			 cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_FCLKEN);
@@ -380,8 +389,13 @@ void omap3_prcm_restore_context(void)
 					 CM_CLKSTCTRL);
 	cm_write_mod_reg(prcm_context.pll_cm_autoidle2, PLL_MOD,
 					 CM_AUTOIDLE2);
+	cm_write_mod_reg(prcm_context.pll_cm_clksel4, PLL_MOD,
+					OMAP3430ES2_CM_CLKSEL4);
 	cm_write_mod_reg(prcm_context.pll_cm_clksel5, PLL_MOD,
 					 OMAP3430ES2_CM_CLKSEL5);
+	cm_write_mod_reg(prcm_context.pll_cm_clken, PLL_MOD, CM_CLKEN);
+	cm_write_mod_reg(prcm_context.pll_cm_clken2, PLL_MOD,
+					OMAP3430ES2_CM_CLKEN2);
 	__raw_writel(prcm_context.cm_polctrl, OMAP3430_CM_POLCTRL);
 	cm_write_mod_reg(prcm_context.iva2_cm_fclken, OMAP3430_IVA2_MOD,
 					 CM_FCLKEN);
-- 
1.5.4.3

