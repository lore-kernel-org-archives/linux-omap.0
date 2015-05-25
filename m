From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 02/27] clk: ti: move generic OMAP DPLL implementation under drivers/clk
Date: Mon, 25 May 2015 18:00:07 +0300
Message-ID: <1432566032-10860-3-git-send-email-t-kristo@ti.com>
References: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59895 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751989AbbEYPAz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 May 2015 11:00:55 -0400
In-Reply-To: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, sboyd@codeaurora.org, mturquette@linaro.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

With the legacy clock data now gone, we can start moving OMAP clock
type implementations under clock driver. Start this with moving the
generic OMAP DPLL clock type under TI clock driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/Makefile                       |    2 +-
 drivers/clk/ti/Makefile                            |    3 ++-
 .../arm/mach-omap2 => drivers/clk/ti}/clkt_dpll.c  |   13 ++++++-------
 drivers/clk/ti/clock.h                             |    2 ++
 include/linux/clk/ti.h                             |    1 -
 5 files changed, 11 insertions(+), 10 deletions(-)
 rename {arch/arm/mach-omap2 => drivers/clk/ti}/clkt_dpll.c (97%)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index ec002bd..fcb5d47 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -13,7 +13,7 @@ obj-y := id.o io.o control.o mux.o devices.o fb.o serial.o timer.o pm.o \
 hwmod-common				= omap_hwmod.o omap_hwmod_reset.o \
 					  omap_hwmod_common_data.o
 clock-common				= clock.o clock_common_data.o \
-					  clkt_dpll.o clkt_clksel.o
+					  clkt_clksel.o
 secure-common				= omap-smc.o omap-secure.o
 
 obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(hwmod-common)
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index 105ffd0..62dae2a 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -1,6 +1,7 @@
 obj-y					+= clk.o autoidle.o clockdomain.o
 clk-common				= dpll.o composite.o divider.o gate.o \
-					  fixed-factor.o mux.o apll.o
+					  fixed-factor.o mux.o apll.o \
+					  clkt_dpll.o
 obj-$(CONFIG_SOC_AM33XX)		+= $(clk-common) clk-33xx.o
 obj-$(CONFIG_SOC_TI81XX)		+= $(clk-common) fapll.o clk-816x.o
 obj-$(CONFIG_ARCH_OMAP2)		+= $(clk-common) interface.o clk-2xxx.o
diff --git a/arch/arm/mach-omap2/clkt_dpll.c b/drivers/clk/ti/clkt_dpll.c
similarity index 97%
rename from arch/arm/mach-omap2/clkt_dpll.c
rename to drivers/clk/ti/clkt_dpll.c
index 82f0600..a01fc7f 100644
--- a/arch/arm/mach-omap2/clkt_dpll.c
+++ b/drivers/clk/ti/clkt_dpll.c
@@ -18,6 +18,7 @@
 #include <linux/errno.h>
 #include <linux/clk-provider.h>
 #include <linux/io.h>
+#include <linux/clk/ti.h>
 
 #include <asm/div64.h>
 
@@ -211,7 +212,7 @@ u8 omap2_init_dpll_parent(struct clk_hw *hw)
 	if (!dd)
 		return -EINVAL;
 
-	v = omap2_clk_readl(clk, dd->control_reg);
+	v = ti_clk_ll_ops->clk_readl(dd->control_reg);
 	v &= dd->enable_mask;
 	v >>= __ffs(dd->enable_mask);
 
@@ -247,20 +248,20 @@ unsigned long omap2_get_dpll_rate(struct clk_hw_omap *clk)
 		return 0;
 
 	/* Return bypass rate if DPLL is bypassed */
-	v = omap2_clk_readl(clk, dd->control_reg);
+	v = ti_clk_ll_ops->clk_readl(dd->control_reg);
 	v &= dd->enable_mask;
 	v >>= __ffs(dd->enable_mask);
 
 	if (_omap2_dpll_is_in_bypass(v))
 		return __clk_get_rate(dd->clk_bypass);
 
-	v = omap2_clk_readl(clk, dd->mult_div1_reg);
+	v = ti_clk_ll_ops->clk_readl(dd->mult_div1_reg);
 	dpll_mult = v & dd->mult_mask;
 	dpll_mult >>= __ffs(dd->mult_mask);
 	dpll_div = v & dd->div1_mask;
 	dpll_div >>= __ffs(dd->div1_mask);
 
-	dpll_clk = (long long) __clk_get_rate(dd->clk_ref) * dpll_mult;
+	dpll_clk = (long long)__clk_get_rate(dd->clk_ref) * dpll_mult;
 	do_div(dpll_clk, dpll_div + 1);
 
 	return dpll_clk;
@@ -281,7 +282,7 @@ unsigned long omap2_get_dpll_rate(struct clk_hw_omap *clk)
  * be rounded, or the rounded rate upon success.
  */
 long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
-		unsigned long *parent_rate)
+			   unsigned long *parent_rate)
 {
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
 	int m, n, r, scaled_max_m;
@@ -310,7 +311,6 @@ long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
 	dd->last_rounded_rate = 0;
 
 	for (n = dd->min_divider; n <= dd->max_divider; n++) {
-
 		/* Is the (input clk, divider) pair valid for the DPLL? */
 		r = _dpll_test_fint(clk, n);
 		if (r == DPLL_FINT_UNDERFLOW)
@@ -367,4 +367,3 @@ long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
 
 	return dd->last_rounded_rate;
 }
-
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index 404158d..05ed10a 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -169,4 +169,6 @@ void ti_clk_patch_legacy_clks(struct ti_clk **patch);
 struct clk *ti_clk_register_clk(struct ti_clk *setup);
 int ti_clk_register_legacy_clks(struct ti_clk_alias *clks);
 
+u8 omap2_init_dpll_parent(struct clk_hw *hw);
+
 #endif
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index b066835..f2436b2 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -286,7 +286,6 @@ long omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw,
 					unsigned long max_rate,
 					unsigned long *best_parent_rate,
 					struct clk_hw **best_parent_clk);
-u8 omap2_init_dpll_parent(struct clk_hw *hw);
 unsigned long omap3_dpll_recalc(struct clk_hw *hw, unsigned long parent_rate);
 long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
 			   unsigned long *parent_rate);
-- 
1.7.9.5

