From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv11 39/49] ARM: OMAP2+: clock: add support for indexed memmaps
Date: Thu, 19 Dec 2013 13:24:10 +0200
Message-ID: <1387452260-23276-40-git-send-email-t-kristo@ti.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42551 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753367Ab3LSL1K (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Dec 2013 06:27:10 -0500
In-Reply-To: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Using indexed memmaps is required for isolating the actual memory access
from the clock code. Now, the driver providing the support for the clock IP
block provides the low level routines for reading/writing clock registers
also.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.c |   26 +++++++++++++++++++++++++-
 arch/arm/mach-omap2/clock.h |    5 +++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 238be3f..c6da55f 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -26,7 +26,6 @@
 #include <linux/clk-private.h>
 #include <asm/cpu.h>
 
-
 #include <trace/events/power.h>
 
 #include "soc.h"
@@ -56,6 +55,31 @@ u16 cpu_mask;
 static bool clkdm_control = true;
 
 static LIST_HEAD(clk_hw_omap_clocks);
+void __iomem *clk_memmaps[CLK_MAX_MEMMAPS];
+
+void omap2_clk_writel(u32 val, struct clk_hw_omap *clk, void __iomem *reg)
+{
+	if (clk->flags & MEMMAP_ADDRESSING) {
+		struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
+		__raw_writel(val, clk_memmaps[r->index] + r->offset);
+	} else {
+		__raw_writel(val, reg);
+	}
+}
+
+u32 omap2_clk_readl(struct clk_hw_omap *clk, void __iomem *reg)
+{
+	u32 val;
+
+	if (clk->flags & MEMMAP_ADDRESSING) {
+		struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
+		val = __raw_readl(clk_memmaps[r->index] + r->offset);
+	} else {
+		val = __raw_readl(reg);
+	}
+
+	return val;
+}
 
 /*
  * Used for clocks that have the same value as the parent clock,
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index cbe5ff7..bda767a 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -254,6 +254,9 @@ void omap2_clk_print_new_rates(const char *hfclkin_ck_name,
 			       const char *core_ck_name,
 			       const char *mpu_ck_name);
 
+u32 omap2_clk_readl(struct clk_hw_omap *clk, void __iomem *reg);
+void omap2_clk_writel(u32 val, struct clk_hw_omap *clk, void __iomem *reg);
+
 extern u16 cpu_mask;
 
 extern const struct clkops clkops_omap2_dflt_wait;
@@ -288,6 +291,8 @@ extern const struct clksel_rate div_1_3_rates[];
 extern const struct clksel_rate div_1_4_rates[];
 extern const struct clksel_rate div31_1to31_rates[];
 
+extern void __iomem *clk_memmaps[];
+
 extern int am33xx_clk_init(void);
 
 extern int omap2_clkops_enable_clkdm(struct clk_hw *hw);
-- 
1.7.9.5

