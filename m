From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 5/6] omap4: dpll: Add dpll api to control GATE_CTRL
Date: Fri, 28 Jan 2011 16:34:47 +0530
Message-ID: <1296212688-21951-6-git-send-email-santosh.shilimkar@ti.com>
References: <1296212688-21951-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36248 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754002Ab1A1LFD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Jan 2011 06:05:03 -0500
In-Reply-To: <1296212688-21951-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

From: Rajendra Nayak <rnayak@ti.com>

On OMAP4, the dpll post divider outputs (MX outputs)
provide a way to allow/deny autoidle.
Allowing autoidle would mean that the hw would autogate
this clock when there is no dependency for it.
Denying idle would mean that this clock output will be
forced to stay enabled.

Add dpll api's to read/allow/deny idle control.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock.h             |    3 ++
 arch/arm/mach-omap2/dpll3xxx.c          |   43 +++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/clock.h |    1 +
 3 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 896584e..19617f0 100644
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
index f77022b..4ce06d5 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -34,11 +34,14 @@
 #include "clock.h"
 #include "cm2xxx_3xxx.h"
 #include "cm-regbits-34xx.h"
+#include "cm-regbits-44xx.h"
 
 /* CM_AUTOIDLE_PLL*.AUTO_* bit values */
 #define DPLL_AUTOIDLE_DISABLE			0x0
 #define DPLL_AUTOIDLE_LOW_POWER_STOP		0x1
 
+#define DPLL_GATECTRL_DISABLE			0x0
+
 #define MAX_DPLL_WAIT_TRIES		1000000
 
 /* Private functions */
@@ -612,3 +615,43 @@ unsigned long omap3_clkoutx2_recalc(struct clk *clk)
 		rate = clk->parent->rate * 2;
 	return rate;
 }
+
+int omap4_dpllmx_gatectrl_read(struct clk *clk)
+{
+	u32 v;
+
+	if (!clk || !(clk->flags & CLOCK_MX_IDLE_CONTROL) || !clk->clksel_reg)
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
+	if (!clk || !(clk->flags & CLOCK_MX_IDLE_CONTROL) || !clk->clksel_reg)
+		return;
+
+	v = __raw_readl(clk->clksel_reg);
+	v &= ~OMAP4430_DPLL_CLKOUT_GATE_CTRL_MASK;
+	v |= __ffs(OMAP4430_DPLL_CLKOUT_GATE_CTRL_MASK);
+	__raw_writel(v, clk->clksel_reg);
+}
+
+void omap4_dpllmx_deny_gatectrl(struct clk *clk)
+{
+	u32 v;
+
+	if (!clk || !(clk->flags & CLOCK_MX_IDLE_CONTROL) || !clk->clksel_reg)
+		return;
+
+	v = __raw_readl(clk->clksel_reg);
+	v &= ~OMAP4430_DPLL_CLKOUT_GATE_CTRL_MASK;
+	v |= DPLL_GATECTRL_DISABLE << __ffs(OMAP4430_DPLL_CLKOUT_GATE_CTRL_MASK);
+	__raw_writel(v, clk->clksel_reg);
+}
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 8eb0ada..2937f5d 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -177,6 +177,7 @@ struct dpll_data {
 #define CLOCK_NO_IDLE_PARENT	(1 << 2)
 #define ENABLE_ON_INIT		(1 << 3)	/* Enable upon framework init */
 #define INVERT_ENABLE		(1 << 4)	/* 0 enables, 1 disables */
+#define CLOCK_MX_IDLE_CONTROL	(1 << 5)
 
 /**
  * struct clk - OMAP struct clk
-- 
1.6.0.4

