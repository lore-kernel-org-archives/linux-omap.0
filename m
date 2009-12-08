From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 4/5] ARM: OMAP4: PM: Add support for OMAP4 dpll api's
Date: Wed,  9 Dec 2009 00:01:46 +0530
Message-ID: <1260297107-28833-4-git-send-email-rnayak@ti.com>
References: <1260297107-28833-1-git-send-email-rnayak@ti.com>
 <1260297107-28833-2-git-send-email-rnayak@ti.com>
 <1260297107-28833-3-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48065 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754289AbZLHScA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Dec 2009 13:32:00 -0500
In-Reply-To: <1260297107-28833-3-git-send-email-rnayak@ti.com>
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
 arch/arm/mach-omap2/Makefile    |    5 +++--
 arch/arm/mach-omap2/clock.c     |    5 +++++
 arch/arm/mach-omap2/clock.h     |    6 ++++++
 arch/arm/mach-omap2/clock44xx.c |   25 -------------------------
 arch/arm/mach-omap2/dpll.c      |   28 +++++++++++++++++-----------
 5 files changed, 31 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index e5946c1..6925a78 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -6,13 +6,14 @@
 obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o
 
 omap-2-3-common				= irq.o sdrc.o omap_hwmod.o
+omap-3-4-common				= dpll.o
 prcm-common				= prcm.o powerdomain.o
 clock-common				= clock.o clock_common_data.o clockdomain.o
 
 obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(prcm-common) $(clock-common)
 obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(prcm-common) $(clock-common) \
-			    dpll.o
-obj-$(CONFIG_ARCH_OMAP4) += prcm.o clock.o
+			    $(omap-3-4-common)
+obj-$(CONFIG_ARCH_OMAP4) += $(omap-3-4-common) prcm.o clock.o
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 5cb2dcb..61ee235 100644
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
index 4df7aa4..8418f3a 100644
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
 #define DPLL_LOW_POWER_STOP	0x1
 #define DPLL_LOW_POWER_BYPASS	0x5
diff --git a/arch/arm/mach-omap2/clock44xx.c b/arch/arm/mach-omap2/clock44xx.c
index 5b25d38..e370868 100644
--- a/arch/arm/mach-omap2/clock44xx.c
+++ b/arch/arm/mach-omap2/clock44xx.c
@@ -22,31 +22,6 @@ struct clk_functions omap2_clk_functions = {
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
 const struct clkops clkops_noncore_dpll_ops = {
 	.enable		= &omap3_noncore_dpll_enable,
 	.disable	= &omap3_noncore_dpll_disable,
diff --git a/arch/arm/mach-omap2/dpll.c b/arch/arm/mach-omap2/dpll.c
index d55f8df..36ea1dc 100644
--- a/arch/arm/mach-omap2/dpll.c
+++ b/arch/arm/mach-omap2/dpll.c
@@ -26,9 +26,9 @@
 #include <linux/limits.h>
 #include <linux/bitops.h>
 
-#include <mach/cpu.h>
-#include <mach/clock.h>
-#include <mach/sram.h>
+#include <plat/cpu.h>
+#include <plat/clock.h>
+#include <plat/sram.h>
 #include <asm/div64.h>
 #include <asm/clkdev.h>
 
@@ -311,10 +311,12 @@ int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
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
@@ -346,7 +348,7 @@ int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
 int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 {
 	struct clk *new_parent = NULL;
-	u16 freqsel;
+	u16 freqsel = 0;
 	struct dpll_data *dd;
 	int ret;
 
@@ -382,9 +384,13 @@ int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
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

