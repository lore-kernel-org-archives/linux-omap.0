From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM: OMAP2+: clock: allow omap2_dpll_round_rate() to round
 to next-lowest rate
Date: Wed, 23 Jul 2014 10:44:33 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1407231043230.32419@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:34075 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756014AbaGWKoe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jul 2014 06:44:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tomi.valkeinen@ti.com, mturquette@linaro.org


Change the behavior of omap2_dpll_round_rate() to round to either the
exact rate requested, or the next lowest rate that the clock is able to
provide.

This is not an ideal fix, but is intended to provide a relatively safe
way for drivers to set PLL rates, until a better solution can be
implemented.

For the time being, omap3_noncore_dpll_set_rate() is still allowed to
set its rate to something other than what the caller requested; but will
warn when this occurs.

Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clkt_dpll.c | 28 +++++++++++++++++++++-------
 arch/arm/mach-omap2/dpll3xxx.c  | 12 ++++++++++--
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt_dpll.c b/arch/arm/mach-omap2/clkt_dpll.c
index 332af927f4d3..85701142c5fc 100644
--- a/arch/arm/mach-omap2/clkt_dpll.c
+++ b/arch/arm/mach-omap2/clkt_dpll.c
@@ -293,10 +293,13 @@ long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
 {
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
 	int m, n, r, scaled_max_m;
+	int min_delta_m = INT_MAX, min_delta_n = INT_MAX;
 	unsigned long scaled_rt_rp;
 	unsigned long new_rate = 0;
 	struct dpll_data *dd;
 	unsigned long ref_rate;
+	long delta;
+	long prev_min_delta = LONG_MAX;
 	const char *clk_name;
 
 	if (!clk || !clk->dpll_data)
@@ -342,23 +345,34 @@ long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
 		if (r == DPLL_MULT_UNDERFLOW)
 			continue;
 
+		/* skip rates above our target rate */
+		delta = target_rate - new_rate;
+		if (delta < 0)
+			continue;
+
+		if (delta < prev_min_delta) {
+			prev_min_delta = delta;
+			min_delta_m = m;
+			min_delta_n = n;
+		}
+
 		pr_debug("clock: %s: m = %d: n = %d: new_rate = %lu\n",
 			 clk_name, m, n, new_rate);
 
-		if (target_rate == new_rate) {
-			dd->last_rounded_m = m;
-			dd->last_rounded_n = n;
-			dd->last_rounded_rate = target_rate;
+		if (delta == 0)
 			break;
-		}
 	}
 
-	if (target_rate != new_rate) {
+	if (prev_min_delta == LONG_MAX) {
 		pr_debug("clock: %s: cannot round to rate %lu\n",
 			 clk_name, target_rate);
 		return ~0;
 	}
 
-	return target_rate;
+	dd->last_rounded_m = min_delta_m;
+	dd->last_rounded_n = min_delta_n;
+	dd->last_rounded_rate = target_rate - prev_min_delta;
+
+	return dd->last_rounded_rate;
 }
 
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index fcd8036af910..839a13e1208b 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -469,6 +469,7 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
 	struct clk *new_parent = NULL;
+	unsigned long rrate;
 	u16 freqsel = 0;
 	struct dpll_data *dd;
 	int ret;
@@ -496,8 +497,15 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
 		__clk_prepare(dd->clk_ref);
 		clk_enable(dd->clk_ref);
 
-		if (dd->last_rounded_rate != rate)
-			rate = __clk_round_rate(hw->clk, rate);
+		if (dd->last_rounded_rate != rate) {
+			rrate = __clk_round_rate(hw->clk, rate);
+			if (rrate != rate) {
+				pr_warn("%s: %s: final rate %lu does not match desired rate %lu\n",
+					__func__, __clk_get_name(hw->clk),
+					rrate, rate);
+				rate = rrate;
+			}
+		}
 
 		if (dd->last_rounded_rate == 0)
 			return -EINVAL;
-- 
2.0.1

