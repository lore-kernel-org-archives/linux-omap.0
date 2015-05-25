From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 07/27] ARM: OMAP2+: clock: remove clock_common_data.c file
Date: Mon, 25 May 2015 18:00:12 +0300
Message-ID: <1432566032-10860-8-git-send-email-t-kristo@ti.com>
References: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50044 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752020AbbEYPBJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 May 2015 11:01:09 -0400
In-Reply-To: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, sboyd@codeaurora.org, mturquette@linaro.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

This only contains clksel tables that were used with the legacy clock data.
Now that legacy clock data is completely gone, this file can be removed
also.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/Makefile            |    2 +-
 arch/arm/mach-omap2/clock.h             |   14 ----
 arch/arm/mach-omap2/clock_common_data.c |  115 -------------------------------
 3 files changed, 1 insertion(+), 130 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/clock_common_data.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index d03bc21..98d5030 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -12,7 +12,7 @@ obj-y := id.o io.o control.o mux.o devices.o fb.o serial.o timer.o pm.o \
 
 hwmod-common				= omap_hwmod.o omap_hwmod_reset.o \
 					  omap_hwmod_common_data.o
-clock-common				= clock.o clock_common_data.o
+clock-common				= clock.o
 secure-common				= omap-smc.o omap-secure.o
 
 obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(hwmod-common)
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 9efff4b..b71d430 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -204,11 +204,6 @@ extern const struct clkops clkops_omap2_dflt;
 
 extern struct clk_functions omap2_clk_functions;
 
-extern const struct clksel_rate gpt_32k_rates[];
-extern const struct clksel_rate gpt_sys_rates[];
-extern const struct clksel_rate gfx_l3_rates[];
-extern const struct clksel_rate dsp_ick_rates[];
-
 extern const struct clk_hw_omap_ops clkhwops_wait;
 extern const struct clk_hw_omap_ops clkhwops_omap3430es2_ssi_wait;
 extern const struct clk_hw_omap_ops clkhwops_omap3430es2_dss_usbhost_wait;
@@ -217,15 +212,6 @@ extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_module_wait;
 extern const struct clk_hw_omap_ops clkhwops_apll54;
 extern const struct clk_hw_omap_ops clkhwops_apll96;
 
-/* clksel_rate blocks shared between OMAP44xx and AM33xx */
-extern const struct clksel_rate div_1_0_rates[];
-extern const struct clksel_rate div3_1to4_rates[];
-extern const struct clksel_rate div_1_1_rates[];
-extern const struct clksel_rate div_1_2_rates[];
-extern const struct clksel_rate div_1_3_rates[];
-extern const struct clksel_rate div_1_4_rates[];
-extern const struct clksel_rate div31_1to31_rates[];
-
 extern int omap2_clkops_enable_clkdm(struct clk_hw *hw);
 extern void omap2_clkops_disable_clkdm(struct clk_hw *hw);
 
diff --git a/arch/arm/mach-omap2/clock_common_data.c b/arch/arm/mach-omap2/clock_common_data.c
deleted file mode 100644
index 61b60df..0000000
--- a/arch/arm/mach-omap2/clock_common_data.c
+++ /dev/null
@@ -1,115 +0,0 @@
-/*
- *  linux/arch/arm/mach-omap2/clock_common_data.c
- *
- *  Copyright (C) 2005-2009 Texas Instruments, Inc.
- *  Copyright (C) 2004-2009 Nokia Corporation
- *
- *  Contacts:
- *  Richard Woodruff <r-woodruff2@ti.com>
- *  Paul Walmsley
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This file contains clock data that is common to both the OMAP2xxx and
- * OMAP3xxx clock definition files.
- */
-
-#include "clock.h"
-
-/* clksel_rate data common to 24xx/343x */
-const struct clksel_rate gpt_32k_rates[] = {
-	 { .div = 1, .val = 0, .flags = RATE_IN_24XX | RATE_IN_3XXX },
-	 { .div = 0 }
-};
-
-const struct clksel_rate gpt_sys_rates[] = {
-	 { .div = 1, .val = 1, .flags = RATE_IN_24XX | RATE_IN_3XXX },
-	 { .div = 0 }
-};
-
-const struct clksel_rate gfx_l3_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | RATE_IN_3XXX },
-	{ .div = 2, .val = 2, .flags = RATE_IN_24XX | RATE_IN_3XXX },
-	{ .div = 3, .val = 3, .flags = RATE_IN_243X | RATE_IN_3XXX },
-	{ .div = 4, .val = 4, .flags = RATE_IN_243X | RATE_IN_3XXX },
-	{ .div = 0 }
-};
-
-const struct clksel_rate dsp_ick_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
-	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
-	{ .div = 3, .val = 3, .flags = RATE_IN_243X },
-	{ .div = 0 },
-};
-
-
-/* clksel_rate blocks shared between OMAP44xx and AM33xx */
-
-const struct clksel_rate div_1_0_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 0 },
-};
-
-const struct clksel_rate div3_1to4_rates[] = {
-	{ .div = 1, .val = 0, .flags = RATE_IN_4430 },
-	{ .div = 2, .val = 1, .flags = RATE_IN_4430 },
-	{ .div = 4, .val = 2, .flags = RATE_IN_4430 },
-	{ .div = 0 },
-};
-
-const struct clksel_rate div_1_1_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 0 },
-};
-
-const struct clksel_rate div_1_2_rates[] = {
-	{ .div = 1, .val = 2, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 0 },
-};
-
-const struct clksel_rate div_1_3_rates[] = {
-	{ .div = 1, .val = 3, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 0 },
-};
-
-const struct clksel_rate div_1_4_rates[] = {
-	{ .div = 1, .val = 4, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 0 },
-};
-
-const struct clksel_rate div31_1to31_rates[] = {
-	{ .div = 1, .val = 1, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 2, .val = 2, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 3, .val = 3, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 4, .val = 4, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 5, .val = 5, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 6, .val = 6, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 7, .val = 7, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 8, .val = 8, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 9, .val = 9, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 10, .val = 10, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 11, .val = 11, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 12, .val = 12, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 13, .val = 13, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 14, .val = 14, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 15, .val = 15, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 16, .val = 16, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 17, .val = 17, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 18, .val = 18, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 19, .val = 19, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 20, .val = 20, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 21, .val = 21, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 22, .val = 22, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 23, .val = 23, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 24, .val = 24, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 25, .val = 25, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 26, .val = 26, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 27, .val = 27, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 28, .val = 28, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 29, .val = 29, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 30, .val = 30, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 31, .val = 31, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
-	{ .div = 0 },
-};
-- 
1.7.9.5

