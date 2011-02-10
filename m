From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 6/7] omap4: dpll: Add dpll api to control GATE_CTRL
Date: Thu, 10 Feb 2011 14:46:39 +0530
Message-ID: <1297329400-5936-7-git-send-email-rnayak@ti.com>
References: <1297329400-5936-1-git-send-email-rnayak@ti.com>
 <1297329400-5936-2-git-send-email-rnayak@ti.com>
 <1297329400-5936-3-git-send-email-rnayak@ti.com>
 <1297329400-5936-4-git-send-email-rnayak@ti.com>
 <1297329400-5936-5-git-send-email-rnayak@ti.com>
 <1297329400-5936-6-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46396 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754386Ab1BJJQ6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Feb 2011 04:16:58 -0500
In-Reply-To: <1297329400-5936-6-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, b-cousson@ti.com, khilman@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

On OMAP4, the dpll post divider outputs (MX outputs)
along with clockout_x2 output provide a way to allow/deny
hardware level autogating.
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
 arch/arm/mach-omap2/clock.h             |    3 ++
 arch/arm/mach-omap2/dpll3xxx.c          |   57 +++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/clock.h |    1 +
 3 files changed, 61 insertions(+), 0 deletions(-)

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
index f77022b..18912cf 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -34,6 +34,7 @@
 #include "clock.h"
 #include "cm2xxx_3xxx.h"
 #include "cm-regbits-34xx.h"
+#include "cm-regbits-44xx.h"
 
 /* CM_AUTOIDLE_PLL*.AUTO_* bit values */
 #define DPLL_AUTOIDLE_DISABLE			0x0
@@ -612,3 +613,59 @@ unsigned long omap3_clkoutx2_recalc(struct clk *clk)
 		rate = clk->parent->rate * 2;
 	return rate;
 }
+
+/* Supported only on OMAP4 */
+int omap4_dpllmx_gatectrl_read(struct clk *clk)
+{
+	u32 v;
+	u32 mask;
+
+	if (!clk || !clk->clksel_reg || !cpu_is_omap44xx())
+		return -EINVAL;
+
+	mask = clk->flags & CLOCK_CLKOUTX2 ?
+			OMAP4430_DPLL_CLKOUTX2_GATE_CTRL_MASK :
+			OMAP4430_DPLL_CLKOUT_GATE_CTRL_MASK;
+
+	v = __raw_readl(clk->clksel_reg);
+	v &= mask;
+	v >>= __ffs(mask);
+
+	return v;
+}
+
+void omap4_dpllmx_allow_gatectrl(struct clk *clk)
+{
+	u32 v;
+	u32 mask;
+
+	if (!clk || !clk->clksel_reg || !cpu_is_omap44xx())
+		return;
+
+	mask = clk->flags & CLOCK_CLKOUTX2 ?
+			OMAP4430_DPLL_CLKOUTX2_GATE_CTRL_MASK :
+			OMAP4430_DPLL_CLKOUT_GATE_CTRL_MASK;
+
+	v = __raw_readl(clk->clksel_reg);
+	/* Clear the bit to allow gatectrl */
+	v &= ~mask;
+	__raw_writel(v, clk->clksel_reg);
+}
+
+void omap4_dpllmx_deny_gatectrl(struct clk *clk)
+{
+	u32 v;
+	u32 mask;
+
+	if (!clk || !clk->clksel_reg || !cpu_is_omap44xx())
+		return;
+
+	mask = clk->flags & CLOCK_CLKOUTX2 ?
+			OMAP4430_DPLL_CLKOUTX2_GATE_CTRL_MASK :
+			OMAP4430_DPLL_CLKOUT_GATE_CTRL_MASK;
+
+	v = __raw_readl(clk->clksel_reg);
+	/* Set the bit to deny gatectrl */
+	v |= mask;
+	__raw_writel(v, clk->clksel_reg);
+}
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 167f1e0..f2807dc 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -181,6 +181,7 @@ struct dpll_data {
 #define CLOCK_NO_IDLE_PARENT	(1 << 2)
 #define ENABLE_ON_INIT		(1 << 3)	/* Enable upon framework init */
 #define INVERT_ENABLE		(1 << 4)	/* 0 enables, 1 disables */
+#define CLOCK_CLKOUTX2		(1 << 5)
 
 /**
  * struct clk - OMAP struct clk
-- 
1.7.0.4

