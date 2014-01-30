From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH] ARM: OMAP2+: clock: fix clkoutx2 with CLK_SET_RATE_PARENT
Date: Thu, 30 Jan 2014 13:17:20 +0200
Message-ID: <1391080640-23370-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55315 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752646AbaA3LR5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Jan 2014 06:17:57 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

If CLK_SET_RATE_PARENT is set for a clkoutx2 clock, calling
clk_set_rate() on the clock "skips" the x2 multiplier as there are no
set_rate and round_rate functions defined for the clkoutx2.

This results in getting double the requested clock rates, breaking the
display on omap3430 based devices. This got broken when
d0f58bd3bba3877fb1af4664c4e33273d36f00e4 and related patches were merged
for v3.14, as omapdss driver now relies more on the clk-framework and
CLK_SET_RATE_PARENT.

This patch implements set_rate and round_rate for clkoutx2.

Tested on OMAP3430, OMAP3630, OMAP4460.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/cclock3xxx_data.c |  2 +
 arch/arm/mach-omap2/dpll3xxx.c        | 92 +++++++++++++++++++++++++++++------
 include/linux/clk/ti.h                |  4 ++
 3 files changed, 83 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/cclock3xxx_data.c b/arch/arm/mach-omap2/cclock3xxx_data.c
index 3b05aea56d1f..11ed9152e665 100644
--- a/arch/arm/mach-omap2/cclock3xxx_data.c
+++ b/arch/arm/mach-omap2/cclock3xxx_data.c
@@ -433,7 +433,9 @@ static const struct clk_ops dpll4_m5x2_ck_ops = {
 	.enable		= &omap2_dflt_clk_enable,
 	.disable	= &omap2_dflt_clk_disable,
 	.is_enabled	= &omap2_dflt_clk_is_enabled,
+	.set_rate	= &omap3_clkoutx2_set_rate,
 	.recalc_rate	= &omap3_clkoutx2_recalc,
+	.round_rate	= &omap3_clkoutx2_round_rate,
 };
 
 static const struct clk_ops dpll4_m5x2_ck_3630_ops = {
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index 3185ced807c9..3c418ea54bbe 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -623,6 +623,32 @@ void omap3_dpll_deny_idle(struct clk_hw_omap *clk)
 
 /* Clock control for DPLL outputs */
 
+/* Find the parent DPLL for the given clkoutx2 clock */
+static struct clk_hw_omap *omap3_find_clkoutx2_dpll(struct clk_hw *hw)
+{
+	struct clk_hw_omap *pclk = NULL;
+	struct clk *parent;
+
+	/* Walk up the parents of clk, looking for a DPLL */
+	do {
+		do {
+			parent = __clk_get_parent(hw->clk);
+			hw = __clk_get_hw(parent);
+		} while (hw && (__clk_get_flags(hw->clk) & CLK_IS_BASIC));
+		if (!hw)
+			break;
+		pclk = to_clk_hw_omap(hw);
+	} while (pclk && !pclk->dpll_data);
+
+	/* clk does not have a DPLL as a parent?  error in the clock data */
+	if (!pclk) {
+		WARN_ON(1);
+		return NULL;
+	}
+
+	return pclk;
+}
+
 /**
  * omap3_clkoutx2_recalc - recalculate DPLL X2 output virtual clock rate
  * @clk: DPLL output struct clk
@@ -637,27 +663,14 @@ unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
 	unsigned long rate;
 	u32 v;
 	struct clk_hw_omap *pclk = NULL;
-	struct clk *parent;
 
 	if (!parent_rate)
 		return 0;
 
-	/* Walk up the parents of clk, looking for a DPLL */
-	do {
-		do {
-			parent = __clk_get_parent(hw->clk);
-			hw = __clk_get_hw(parent);
-		} while (hw && (__clk_get_flags(hw->clk) & CLK_IS_BASIC));
-		if (!hw)
-			break;
-		pclk = to_clk_hw_omap(hw);
-	} while (pclk && !pclk->dpll_data);
+	pclk = omap3_find_clkoutx2_dpll(hw);
 
-	/* clk does not have a DPLL as a parent?  error in the clock data */
-	if (!pclk) {
-		WARN_ON(1);
+	if (!pclk)
 		return 0;
-	}
 
 	dd = pclk->dpll_data;
 
@@ -672,6 +685,55 @@ unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
 	return rate;
 }
 
+int omap3_clkoutx2_set_rate(struct clk_hw *hw, unsigned long rate,
+					unsigned long parent_rate)
+{
+	return 0;
+}
+
+long omap3_clkoutx2_round_rate(struct clk_hw *hw, unsigned long rate,
+		unsigned long *prate)
+{
+	const struct dpll_data *dd;
+	u32 v;
+	struct clk_hw_omap *pclk = NULL;
+
+	if (!*prate)
+		return 0;
+
+	pclk = omap3_find_clkoutx2_dpll(hw);
+
+	if (!pclk)
+		return 0;
+
+	dd = pclk->dpll_data;
+
+	/* TYPE J does not have a clkoutx2 */
+	if (dd->flags & DPLL_J_TYPE) {
+		*prate = __clk_round_rate(__clk_get_parent(pclk->hw.clk), rate);
+		return *prate;
+	}
+
+	WARN_ON(!dd->enable_mask);
+
+	v = omap2_clk_readl(pclk, dd->control_reg) & dd->enable_mask;
+	v >>= __ffs(dd->enable_mask);
+
+	/* If in bypass, the rate is fixed to the bypass rate*/
+	if (v != OMAP3XXX_EN_DPLL_LOCKED)
+		return *prate;
+
+	if (__clk_get_flags(hw->clk) & CLK_SET_RATE_PARENT) {
+		unsigned long best_parent;
+
+		best_parent = (rate / 2);
+		*prate = __clk_round_rate(__clk_get_parent(hw->clk),
+				best_parent);
+	}
+
+	return *prate * 2;
+}
+
 /* OMAP3/4 non-CORE DPLL clkops */
 const struct clk_hw_omap_ops clkhwops_omap3_dpll = {
 	.allow_idle	= omap3_dpll_allow_idle,
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 092b64168d7f..4a21a872dbbd 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -245,6 +245,10 @@ long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
 void omap2_init_clk_clkdm(struct clk_hw *clk);
 unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
 				    unsigned long parent_rate);
+int omap3_clkoutx2_set_rate(struct clk_hw *hw, unsigned long rate,
+					unsigned long parent_rate);
+long omap3_clkoutx2_round_rate(struct clk_hw *hw, unsigned long rate,
+		unsigned long *prate);
 int omap2_clkops_enable_clkdm(struct clk_hw *hw);
 void omap2_clkops_disable_clkdm(struct clk_hw *hw);
 int omap2_clk_disable_autoidle_all(void);
-- 
1.8.3.2

