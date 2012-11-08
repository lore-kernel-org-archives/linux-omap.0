From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 06/26] ARM: OMAP2xxx: clock: add APLL rate recalculation functions
Date: Wed, 7 Nov 2012 17:12:41 -0800
Message-ID: <1352337181-29427-7-git-send-email-mturquette@ti.com>
References: <1352337181-29427-1-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52104 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752935Ab2KHBNc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 20:13:32 -0500
In-Reply-To: <1352337181-29427-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@vger.kernel.org, patches@linaro.org, Mike Turquette <mturquette@ti.com>

From: Paul Walmsley <paul@pwsan.com>

OMAP2420 and OMAP2430 chips each have two on-chip APLLs.  When locked,
one APLL generates a 96 MHz rate; the other, a 54 MHz rate.
Previously we treated these clocks as fixed-rate clocks at the locked
rates, but this isn't quite right.  The locked rate should be returned
when the APLL is locked, and a zero rate should be returned when the
APLL is stopped.  This patch adds the infrastructure that will be used
by the CCF changes.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Mike Turquette <mturquette@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clkt2xxx_apll.c |   35 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/clock2xxx.h     |    4 ++++
 2 files changed, 39 insertions(+)

diff --git a/arch/arm/mach-omap2/clkt2xxx_apll.c b/arch/arm/mach-omap2/clkt2xxx_apll.c
index 83088c4..d8a850b 100644
--- a/arch/arm/mach-omap2/clkt2xxx_apll.c
+++ b/arch/arm/mach-omap2/clkt2xxx_apll.c
@@ -41,6 +41,27 @@ void __iomem *cm_idlest_pll;
 
 /* Private functions */
 
+#ifdef CONFIG_COMMON_CLK
+/**
+ * omap2xxx_clk_apll_locked - is the APLL locked?
+ * @hw: struct clk_hw * of the APLL to check
+ *
+ * If the APLL IP block referred to by @hw indicates that it's locked,
+ * return true; otherwise, return false.
+ */
+static bool omap2xxx_clk_apll_locked(struct clk_hw *hw)
+{
+	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
+	u32 r, apll_mask;
+
+	apll_mask = EN_APLL_LOCKED << clk->enable_bit;
+
+	r = omap2_cm_read_mod_reg(PLL_MOD, CM_CLKEN);
+
+	return ((r & apll_mask) == apll_mask) ? true : false;
+}
+#endif
+
 /* Enable an APLL if off */
 #ifdef CONFIG_COMMON_CLK
 static int omap2_clk_apll_enable(struct clk_hw *hw, u32 status_mask)
@@ -147,6 +168,20 @@ static void omap2_clk_apll_disable(struct clk *clk)
 	omap2_cm_write_mod_reg(cval, PLL_MOD, CM_CLKEN);
 }
 
+#ifdef CONFIG_COMMON_CLK
+unsigned long omap2_clk_apll54_recalc(struct clk_hw *hw,
+				      unsigned long parent_rate)
+{
+	return (omap2xxx_clk_apll_locked(hw)) ? 54000000 : 0;
+}
+
+unsigned long omap2_clk_apll96_recalc(struct clk_hw *hw,
+				      unsigned long parent_rate)
+{
+	return (omap2xxx_clk_apll_locked(hw)) ? 96000000 : 0;
+}
+#endif
+
 /* Public data */
 #ifdef CONFIG_COMMON_CLK
 const struct clk_hw_omap_ops clkhwops_apll54 = {
diff --git a/arch/arm/mach-omap2/clock2xxx.h b/arch/arm/mach-omap2/clock2xxx.h
index 1ce94b6..f2b93e3 100644
--- a/arch/arm/mach-omap2/clock2xxx.h
+++ b/arch/arm/mach-omap2/clock2xxx.h
@@ -27,6 +27,10 @@ unsigned long omap2_dpllcore_recalc(struct clk_hw *hw,
 int omap2_reprogram_dpllcore(struct clk_hw *clk, unsigned long rate,
 			     unsigned long parent_rate);
 unsigned long omap2xxx_clk_get_core_rate(struct clk_hw_omap *clk);
+unsigned long omap2_clk_apll54_recalc(struct clk_hw *hw,
+				      unsigned long parent_rate);
+unsigned long omap2_clk_apll96_recalc(struct clk_hw *hw,
+				      unsigned long parent_rate);
 #else
 unsigned long omap2_table_mpu_recalc(struct clk *clk);
 int omap2_select_table_rate(struct clk *clk, unsigned long rate);
-- 
1.7.9.5

