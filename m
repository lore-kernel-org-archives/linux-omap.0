From: Michael Turquette <mturquette@linaro.org>
Subject: [PATCH 1/3] arm: omap2+ remove dead clock code
Date: Fri, 30 Jan 2015 13:25:11 -0800
Message-ID: <1422653113-32688-2-git-send-email-mturquette@linaro.org>
References: <1422653113-32688-1-git-send-email-mturquette@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:63318 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763008AbbA3VZk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Jan 2015 16:25:40 -0500
Received: by mail-ie0-f181.google.com with SMTP id rp18so6246002iec.12
        for <linux-omap@vger.kernel.org>; Fri, 30 Jan 2015 13:25:39 -0800 (PST)
In-Reply-To: <1422653113-32688-1-git-send-email-mturquette@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@linaro.org>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Remove omap_clocks_register and dummy_ck. The former is not used anymore
now that the statically defined clk stuctures are replaced with proper
descriptors and registered with the framework.

The dummy clock in arch/arm/mach-omap2 is made redundant by the OMAP3+
clock data that migrated to drivers/clk.

An additional benefit to this clean-up is removing the references to
clk-private.h which will be removed.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Michael Turquette <mturquette@linaro.org>
---
Cc: linux-omap@vger.kernel.org
 arch/arm/mach-omap2/clock.c             | 16 ----------------
 arch/arm/mach-omap2/clock.h             |  5 -----
 arch/arm/mach-omap2/clock_common_data.c | 14 --------------
 3 files changed, 35 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 6ad5b4d..d9c128e 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -23,7 +23,6 @@
 #include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/bitops.h>
-#include <linux/clk-private.h>
 #include <asm/cpu.h>
 
 #include <trace/events/power.h>
@@ -630,21 +629,6 @@ const struct clk_hw_omap_ops clkhwops_wait = {
 };
 
 /**
- * omap_clocks_register - register an array of omap_clk
- * @ocs: pointer to an array of omap_clk to register
- */
-void __init omap_clocks_register(struct omap_clk oclks[], int cnt)
-{
-	struct omap_clk *c;
-
-	for (c = oclks; c < oclks + cnt; c++) {
-		clkdev_add(&c->lk);
-		if (!__clk_init(NULL, c->lk.clk))
-			omap2_init_clk_hw_omap_clocks(c->lk.clk);
-	}
-}
-
-/**
  * omap2_clk_switch_mpurate_at_boot - switch ARM MPU rate by boot-time argument
  * @mpurate_ck_name: clk name of the clock to change rate
  *
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index c5b3a7f..6a10ce3 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -245,7 +245,6 @@ struct ti_clk_features {
 extern struct ti_clk_features ti_clk_features;
 
 extern const struct clkops clkops_omap2_dflt_wait;
-extern const struct clkops clkops_dummy;
 extern const struct clkops clkops_omap2_dflt;
 
 extern struct clk_functions omap2_clk_functions;
@@ -254,8 +253,6 @@ extern const struct clksel_rate gpt_32k_rates[];
 extern const struct clksel_rate gpt_sys_rates[];
 extern const struct clksel_rate gfx_l3_rates[];
 extern const struct clksel_rate dsp_ick_rates[];
-extern struct clk_core dummy_ck_core;
-extern struct clk dummy_ck;
 
 extern const struct clk_hw_omap_ops clkhwops_iclk_wait;
 extern const struct clk_hw_omap_ops clkhwops_wait;
@@ -280,7 +277,5 @@ extern void __iomem *clk_memmaps[];
 extern int omap2_clkops_enable_clkdm(struct clk_hw *hw);
 extern void omap2_clkops_disable_clkdm(struct clk_hw *hw);
 
-extern void omap_clocks_register(struct omap_clk *oclks, int cnt);
-
 void __init ti_clk_init_features(void);
 #endif
diff --git a/arch/arm/mach-omap2/clock_common_data.c b/arch/arm/mach-omap2/clock_common_data.c
index febd0a2..61b60df 100644
--- a/arch/arm/mach-omap2/clock_common_data.c
+++ b/arch/arm/mach-omap2/clock_common_data.c
@@ -16,7 +16,6 @@
  * OMAP3xxx clock definition files.
  */
 
-#include <linux/clk-private.h>
 #include "clock.h"
 
 /* clksel_rate data common to 24xx/343x */
@@ -114,16 +113,3 @@ const struct clksel_rate div31_1to31_rates[] = {
 	{ .div = 31, .val = 31, .flags = RATE_IN_4430 | RATE_IN_AM33XX },
 	{ .div = 0 },
 };
-
-/* Clocks shared between various OMAP SoCs */
-
-static struct clk_ops dummy_ck_ops = {};
-
-struct clk_core dummy_ck_core = {
-	.name = "dummy_clk",
-	.ops = &dummy_ck_ops,
-	.flags = CLK_IS_BASIC,
-};
-struct clk dummy_ck = {
-	.core = &dummy_ck_core,
-};
-- 
1.9.1

