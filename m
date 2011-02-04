From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 7/9] omap4: dpll: Add dpll api to control GATE_CTRL
Date: Fri,  4 Feb 2011 15:29:02 +0530
Message-ID: <1296813544-25170-8-git-send-email-santosh.shilimkar@ti.com>
References: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55878 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754850Ab1BDJ7U (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Feb 2011 04:59:20 -0500
In-Reply-To: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

From: Rajendra Nayak <rnayak@ti.com>

On OMAP4, the dpll post divider outputs (MX outputs)
provide a way to allow/deny hardware level autogating.
Allowing autoidle would mean that the hw would autogate
this clock when there is no dependency for it.
Denying idle would mean that this clock output will be
forced to stay enabled.

Add dpll api's to read/allow/deny idle control
for these dpll mx postdividers.

NOTE: The gatectrl bit set to 0 allows gatectrl,
and the bit set to 1 denies gatectrl.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock.h    |    3 ++
 arch/arm/mach-omap2/dpll3xxx.c |   42 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 2a939e5..c450d69 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -65,6 +65,9 @@ u32 omap3_dpll_autoidle_read(struct clk *clk);
 int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate);
 int omap3_noncore_dpll_enable(struct clk *clk);
 void omap3_noncore_dpll_disable(struct clk *clk);
+int omap4_dpllmx_gatectrl_read(struct clk *clk);
+void omap4_dpllmx_allow_gatectrl(struct clk *clk);
+void omap4_dpllmx_deny_gatectrl(struct clk *clk);
 
 #ifdef CONFIG_OMAP_RESET_CLOCKS
 void omap2_clk_disable_unused(struct clk *clk);
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index f77022b..4571e94 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -34,6 +34,7 @@
 #include "clock.h"
 #include "cm2xxx_3xxx.h"
 #include "cm-regbits-34xx.h"
+#include "cm-regbits-44xx.h"
 
 /* CM_AUTOIDLE_PLL*.AUTO_* bit values */
 #define DPLL_AUTOIDLE_DISABLE			0x0
@@ -612,3 +613,44 @@ unsigned long omap3_clkoutx2_recalc(struct clk *clk)
 		rate = clk->parent->rate * 2;
 	return rate;
 }
+
+/* Supported only on OMAP4 */
+int omap4_dpllmx_gatectrl_read(struct clk *clk)
+{
+	u32 v;
+
+	if (!clk || !clk->clksel_reg || !cpu_is_omap44xx())
+		return -EINVAL;
+
+	v = __raw_readl(clk->clksel_reg);
+	v &= OMAP4430_DPLL_CLKOUT_GATE_CTRL_MASK;
+	v >>= __ffs(OMAP4430_DPLL_CLKOUT_GATE_CTRL_MASK);
+
+	return v;
+}
+
+void omap4_dpllmx_allow_gatectrl(struct clk *clk)
+{
+	u32 v;
+
+	if (!clk || !clk->clksel_reg || !cpu_is_omap44xx())
+		return;
+
+	v = __raw_readl(clk->clksel_reg);
+	/* Clear the bit to allow gatectrl */
+	v &= ~OMAP4430_DPLL_CLKOUT_GATE_CTRL_MASK;
+	__raw_writel(v, clk->clksel_reg);
+}
+
+void omap4_dpllmx_deny_gatectrl(struct clk *clk)
+{
+	u32 v;
+
+	if (!clk || !clk->clksel_reg || !cpu_is_omap44xx())
+		return;
+
+	v = __raw_readl(clk->clksel_reg);
+	/* Set the bit to deny gatectrl */
+	v |= OMAP4430_DPLL_CLKOUT_GATE_CTRL_MASK;
+	__raw_writel(v, clk->clksel_reg);
+}
-- 
1.6.0.4

