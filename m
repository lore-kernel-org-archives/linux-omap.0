From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 4/5] ARM: OMAP4: PM: Add support for OMAP4 dpll api's
Date: Tue,  1 Dec 2009 17:57:27 +0530
Message-ID: <1259670448-19840-4-git-send-email-rnayak@ti.com>
References: <1259670448-19840-1-git-send-email-rnayak@ti.com>
 <1259670448-19840-2-git-send-email-rnayak@ti.com>
 <1259670448-19840-3-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59536 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753416AbZLAM1d (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Dec 2009 07:27:33 -0500
In-Reply-To: <1259670448-19840-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

Most of the dpll api's from dpll.c are reused for OMAP4.
This patch does extend a few api's for OMAP4 support.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/Makefile    |    4 +++-
 arch/arm/mach-omap2/clock.c     |    5 +++++
 arch/arm/mach-omap2/clock.h     |    6 ++++++
 arch/arm/mach-omap2/clock44xx.c |   25 -------------------------
 arch/arm/mach-omap2/dpll.c      |   22 ++++++++++++++--------
 5 files changed, 28 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 59a568c..ece0d18 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -7,12 +7,14 @@ obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o prcm.o \
 	 clock.o
 
 omap-2-3-common				= irq.o sdrc.o omap_hwmod.o
+omap-3-4-common				= dpll.o
 prcm-common				= powerdomain.o
 clock-common				= clockdomain.o
 
 obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(prcm-common) $(clock-common)
 obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(prcm-common) $(clock-common) \
-			    dpll.o
+			    $(omap-3-4-common)
+obj-$(CONFIG_ARCH_OMAP4) += $(omap-3-4-common)
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index adf1a78..88b53b9 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -249,6 +249,11 @@ u32 omap2_get_dpll_rate(struct clk *clk)
 		if (v == OMAP3XXX_EN_DPLL_LPBYPASS ||
 		    v == OMAP3XXX_EN_DPLL_FRBYPASS)
 			return dd->clk_bypass->rate;
+	} else if (cpu_is_omap44xx()) {
+		if (v == OMAP4XXX_EN_DPLL_LPBYPASS ||
+		    v == OMAP4XXX_EN_DPLL_FRBYPASS ||
+		    v == OMAP4XXX_EN_DPLL_MNBYPASS)
+			return dd->clk_bypass->rate;
 	}
 
 	v = __raw_readl(dd->mult_div1_reg);
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index bc24687..29e6a1a 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -36,6 +36,12 @@
 #define OMAP3XXX_EN_DPLL_FRBYPASS		0x6
 #define OMAP3XXX_EN_DPLL_LOCKED			0x7
 
+/* OMAP4xxx CM_CLKMODE_DPLL*.EN_*_DPLL bits - for omap2_get_dpll_rate() */
+#define OMAP4XXX_EN_DPLL_MNBYPASS		0x4
+#define OMAP4XXX_EN_DPLL_LPBYPASS		0x5
+#define OMAP4XXX_EN_DPLL_FRBYPASS		0x6
+#define OMAP4XXX_EN_DPLL_LOCKED			0x7
+
 /* CM_CLKEN_PLL*.EN* bit values - not all are available for every DPLL */
 #define DPLL_LOW_POWER_STOP		0x1
 #define DPLL_LOW_POWER_BYPASS		0x5
diff --git a/arch/arm/mach-omap2/clock44xx.c b/arch/arm/mach-omap2/clock44xx.c
index 785cdeb..8b38aa2 100644
--- a/arch/arm/mach-omap2/clock44xx.c
+++ b/arch/arm/mach-omap2/clock44xx.c
@@ -246,31 +246,6 @@ static struct clk_functions omap2_clk_functions = {
 	.clk_disable_unused	= omap2_clk_disable_unused,
 };
 
-/*
- * Dummy functions for DPLL control. Plan is to re-use
- * existing OMAP3 dpll control functions.
- */
-
-unsigned long omap3_dpll_recalc(struct clk *clk)
-{
-	return 0;
-}
-
-int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
-{
-	return 0;
-}
-
-int omap3_noncore_dpll_enable(struct clk *clk)
-{
-	return 0;
-}
-
-void omap3_noncore_dpll_disable(struct clk *clk)
-{
-	return;
-}
-
 static const struct clkops clkops_noncore_dpll_ops = {
 	.enable		= &omap3_noncore_dpll_enable,
 	.disable	= &omap3_noncore_dpll_disable,
diff --git a/arch/arm/mach-omap2/dpll.c b/arch/arm/mach-omap2/dpll.c
index 3e1378f..273348e 100644
--- a/arch/arm/mach-omap2/dpll.c
+++ b/arch/arm/mach-omap2/dpll.c
@@ -318,10 +318,12 @@ int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
 	_omap3_noncore_dpll_bypass(clk);
 
 	/* Set jitter correction */
-	v = __raw_readl(dd->control_reg);
-	v &= ~dd->freqsel_mask;
-	v |= freqsel << __ffs(dd->freqsel_mask);
-	__raw_writel(v, dd->control_reg);
+	if (!cpu_is_omap44xx()) {
+		v = __raw_readl(dd->control_reg);
+		v &= ~dd->freqsel_mask;
+		v |= freqsel << __ffs(dd->freqsel_mask);
+		__raw_writel(v, dd->control_reg);
+	}
 
 	/* Set DPLL multiplier, divider */
 	v = __raw_readl(dd->mult_div1_reg);
@@ -353,7 +355,7 @@ int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
 int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 {
 	struct clk *new_parent = NULL;
-	u16 freqsel;
+	u16 freqsel = 0;
 	struct dpll_data *dd;
 	int ret;
 
@@ -389,9 +391,13 @@ int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 		if (dd->last_rounded_rate == 0)
 			return -EINVAL;
 
-		freqsel = _omap3_dpll_compute_freqsel(clk, dd->last_rounded_n);
-		if (!freqsel)
-			WARN_ON(1);
+		/* No freqsel on OMAP4 */
+		if (!cpu_is_omap44xx()) {
+			freqsel = _omap3_dpll_compute_freqsel(clk,
+						dd->last_rounded_n);
+			if (!freqsel)
+				WARN_ON(1);
+		}
 
 		pr_debug("clock: %s: set rate: locking rate to %lu.\n",
 			 clk->name, rate);
-- 
1.5.4.7

