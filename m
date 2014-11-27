From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 04/23] ARM: OMAP24xx: clock: remove unused apll code
Date: Thu, 27 Nov 2014 17:51:35 +0200
Message-ID: <1417103514-17027-5-git-send-email-t-kristo@ti.com>
References: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38493 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222AbaK0Pvo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Nov 2014 10:51:44 -0500
In-Reply-To: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org

APLL clock type is no longer needed as the legacy clock support is removed.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/Makefile        |    1 -
 arch/arm/mach-omap2/clkt2xxx_apll.c |  142 -----------------------------------
 arch/arm/mach-omap2/clock2xxx.h     |   11 ---
 3 files changed, 154 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/clkt2xxx_apll.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 3b653b3..ba35217 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -181,7 +181,6 @@ obj-$(CONFIG_SOC_DRA7XX)		+= clockdomains7xx_data.o
 obj-$(CONFIG_ARCH_OMAP2)		+= $(clock-common) clock2xxx.o
 obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_dpllcore.o
 obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_virt_prcm_set.o
-obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_apll.o
 obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_dpll.o clkt_iclk.o
 obj-$(CONFIG_SOC_OMAP2430)		+= clock2430.o
 obj-$(CONFIG_ARCH_OMAP3)		+= $(clock-common) clock3xxx.o
diff --git a/arch/arm/mach-omap2/clkt2xxx_apll.c b/arch/arm/mach-omap2/clkt2xxx_apll.c
deleted file mode 100644
index c78e893..0000000
--- a/arch/arm/mach-omap2/clkt2xxx_apll.c
+++ /dev/null
@@ -1,142 +0,0 @@
-/*
- * OMAP2xxx APLL clock control functions
- *
- * Copyright (C) 2005-2008 Texas Instruments, Inc.
- * Copyright (C) 2004-2010 Nokia Corporation
- *
- * Contacts:
- * Richard Woodruff <r-woodruff2@ti.com>
- * Paul Walmsley
- *
- * Based on earlier work by Tuukka Tikkanen, Tony Lindgren,
- * Gordon McNutt and RidgeRun, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#undef DEBUG
-
-#include <linux/kernel.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-
-
-#include "clock.h"
-#include "clock2xxx.h"
-#include "cm2xxx.h"
-#include "cm-regbits-24xx.h"
-
-/* CM_CLKEN_PLL.EN_{54,96}M_PLL options (24XX) */
-#define EN_APLL_STOPPED			0
-#define EN_APLL_LOCKED			3
-
-/* CM_CLKSEL1_PLL.APLLS_CLKIN options (24XX) */
-#define APLLS_CLKIN_19_2MHZ		0
-#define APLLS_CLKIN_13MHZ		2
-#define APLLS_CLKIN_12MHZ		3
-
-/* Private functions */
-
-/**
- * omap2xxx_clk_apll_locked - is the APLL locked?
- * @hw: struct clk_hw * of the APLL to check
- *
- * If the APLL IP block referred to by @hw indicates that it's locked,
- * return true; otherwise, return false.
- */
-static bool omap2xxx_clk_apll_locked(struct clk_hw *hw)
-{
-	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
-	u32 r, apll_mask;
-
-	apll_mask = EN_APLL_LOCKED << clk->enable_bit;
-
-	r = omap2xxx_cm_get_pll_status();
-
-	return ((r & apll_mask) == apll_mask) ? true : false;
-}
-
-int omap2_clk_apll96_enable(struct clk_hw *hw)
-{
-	return omap2xxx_cm_apll96_enable();
-}
-
-int omap2_clk_apll54_enable(struct clk_hw *hw)
-{
-	return omap2xxx_cm_apll54_enable();
-}
-
-static void _apll96_allow_idle(struct clk_hw_omap *clk)
-{
-	omap2xxx_cm_set_apll96_auto_low_power_stop();
-}
-
-static void _apll96_deny_idle(struct clk_hw_omap *clk)
-{
-	omap2xxx_cm_set_apll96_disable_autoidle();
-}
-
-static void _apll54_allow_idle(struct clk_hw_omap *clk)
-{
-	omap2xxx_cm_set_apll54_auto_low_power_stop();
-}
-
-static void _apll54_deny_idle(struct clk_hw_omap *clk)
-{
-	omap2xxx_cm_set_apll54_disable_autoidle();
-}
-
-void omap2_clk_apll96_disable(struct clk_hw *hw)
-{
-	omap2xxx_cm_apll96_disable();
-}
-
-void omap2_clk_apll54_disable(struct clk_hw *hw)
-{
-	omap2xxx_cm_apll54_disable();
-}
-
-unsigned long omap2_clk_apll54_recalc(struct clk_hw *hw,
-				      unsigned long parent_rate)
-{
-	return (omap2xxx_clk_apll_locked(hw)) ? 54000000 : 0;
-}
-
-unsigned long omap2_clk_apll96_recalc(struct clk_hw *hw,
-				      unsigned long parent_rate)
-{
-	return (omap2xxx_clk_apll_locked(hw)) ? 96000000 : 0;
-}
-
-/* Public data */
-const struct clk_hw_omap_ops clkhwops_apll54 = {
-	.allow_idle	= _apll54_allow_idle,
-	.deny_idle	= _apll54_deny_idle,
-};
-
-const struct clk_hw_omap_ops clkhwops_apll96 = {
-	.allow_idle	= _apll96_allow_idle,
-	.deny_idle	= _apll96_deny_idle,
-};
-
-/* Public functions */
-
-u32 omap2xxx_get_apll_clkin(void)
-{
-	u32 aplls, srate = 0;
-
-	aplls = omap2xxx_cm_get_pll_config();
-	aplls &= OMAP24XX_APLLS_CLKIN_MASK;
-	aplls >>= OMAP24XX_APLLS_CLKIN_SHIFT;
-
-	if (aplls == APLLS_CLKIN_19_2MHZ)
-		srate = 19200000;
-	else if (aplls == APLLS_CLKIN_13MHZ)
-		srate = 13000000;
-	else if (aplls == APLLS_CLKIN_12MHZ)
-		srate = 12000000;
-
-	return srate;
-}
-
diff --git a/arch/arm/mach-omap2/clock2xxx.h b/arch/arm/mach-omap2/clock2xxx.h
index a090225..125c376 100644
--- a/arch/arm/mach-omap2/clock2xxx.h
+++ b/arch/arm/mach-omap2/clock2xxx.h
@@ -22,12 +22,7 @@ unsigned long omap2xxx_sys_clk_recalc(struct clk_hw *clk,
 unsigned long omap2_osc_clk_recalc(struct clk_hw *clk,
 				   unsigned long parent_rate);
 void omap2xxx_clkt_dpllcore_init(struct clk_hw *hw);
-unsigned long omap2_clk_apll54_recalc(struct clk_hw *hw,
-				      unsigned long parent_rate);
-unsigned long omap2_clk_apll96_recalc(struct clk_hw *hw,
-				      unsigned long parent_rate);
 unsigned long omap2xxx_clk_get_core_rate(void);
-u32 omap2xxx_get_apll_clkin(void);
 u32 omap2xxx_get_sysclkdiv(void);
 void omap2xxx_clk_prepare_for_reboot(void);
 void omap2xxx_clkt_vps_check_bootloader_rates(void);
@@ -46,11 +41,5 @@ int omap2430_clk_init(void);
 #endif
 
 extern struct clk_hw *dclk_hw;
-int omap2_enable_osc_ck(struct clk_hw *hw);
-void omap2_disable_osc_ck(struct clk_hw *hw);
-int omap2_clk_apll96_enable(struct clk_hw *hw);
-int omap2_clk_apll54_enable(struct clk_hw *hw);
-void omap2_clk_apll96_disable(struct clk_hw *hw);
-void omap2_clk_apll54_disable(struct clk_hw *hw);
 
 #endif
-- 
1.7.9.5

