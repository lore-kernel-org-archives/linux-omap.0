From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv10 31/41] ARM: OMAP2+: clock: add support for regmap
Date: Tue, 26 Nov 2013 10:06:12 +0200
Message-ID: <1385453182-24421-32-git-send-email-t-kristo@ti.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47876 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754812Ab3KZIKe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Nov 2013 03:10:34 -0500
In-Reply-To: <1385453182-24421-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Using regmap is required for isolating the actual memory access from
the clock code. Now, the driver providing the support for the clock IP
block can provide a regmap for this purpose.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.c |   27 ++++++++++++++++++++++++++-
 arch/arm/mach-omap2/clock.h |    3 +++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 238be3f..1ef6df8 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -25,7 +25,7 @@
 #include <linux/bitops.h>
 #include <linux/clk-private.h>
 #include <asm/cpu.h>
-
+#include <linux/regmap.h>
 
 #include <trace/events/power.h>
 
@@ -56,6 +56,31 @@ u16 cpu_mask;
 static bool clkdm_control = true;
 
 static LIST_HEAD(clk_hw_omap_clocks);
+struct regmap *clk_regmaps[CLK_MAX_REGMAPS];
+
+void omap2_clk_writel(u32 val, struct clk_hw_omap *clk, void __iomem *reg)
+{
+	if (clk->flags & REGMAP_ADDRESSING) {
+		struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
+		regmap_write(clk_regmaps[r->index], r->offset, val);
+	} else {
+		__raw_writel(val, reg);
+	}
+}
+
+u32 omap2_clk_readl(struct clk_hw_omap *clk, void __iomem *reg)
+{
+	u32 val;
+
+	if (clk->flags & REGMAP_ADDRESSING) {
+		struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
+		regmap_read(clk_regmaps[r->index], r->offset, &val);
+	} else {
+		val = __raw_readl(reg);
+	}
+
+	return val;
+}
 
 /*
  * Used for clocks that have the same value as the parent clock,
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index cbe5ff7..9595d72 100644
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
-- 
1.7.9.5

