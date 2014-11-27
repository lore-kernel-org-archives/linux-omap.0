From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 01/23] ARM: OMAP2+: clock: move clock provider infrastructure to clock driver
Date: Thu, 27 Nov 2014 17:51:32 +0200
Message-ID: <1417103514-17027-2-git-send-email-t-kristo@ti.com>
References: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37080 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750784AbaK0Pvf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Nov 2014 10:51:35 -0500
In-Reply-To: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Splits the clock provider init out of the PRM driver and moves it to
clock driver. This is needed so that once the PRCM drivers are separated,
they can logically just access the clock driver not needing to go through
common PRM code. This would be wrong in the case of control module for
example.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.c       |   67 +++++++++++++++++++++++++++++++------
 arch/arm/mach-omap2/clock.h       |    4 +--
 arch/arm/mach-omap2/prcm-common.h |    2 ++
 arch/arm/mach-omap2/prm_common.c  |   34 +------------------
 4 files changed, 61 insertions(+), 46 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index ff2eb66..2e8b868 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -24,6 +24,7 @@
 #include <linux/io.h>
 #include <linux/bitops.h>
 #include <linux/clk-private.h>
+#include <linux/of_address.h>
 #include <asm/cpu.h>
 
 #include <trace/events/power.h>
@@ -73,32 +74,76 @@ struct ti_clk_features ti_clk_features;
 static bool clkdm_control = true;
 
 static LIST_HEAD(clk_hw_omap_clocks);
-void __iomem *clk_memmaps[CLK_MAX_MEMMAPS];
+static void __iomem *clk_memmaps[CLK_MAX_MEMMAPS];
+
+static void clk_memmap_writel(u32 val, void __iomem *reg)
+{
+	struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
+
+	writel_relaxed(val, clk_memmaps[r->index] + r->offset);
+}
+
+static u32 clk_memmap_readl(void __iomem *reg)
+{
+	struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
+
+	return readl_relaxed(clk_memmaps[r->index] + r->offset);
+}
 
 void omap2_clk_writel(u32 val, struct clk_hw_omap *clk, void __iomem *reg)
 {
-	if (clk->flags & MEMMAP_ADDRESSING) {
-		struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
-		writel_relaxed(val, clk_memmaps[r->index] + r->offset);
-	} else {
+	if (clk->flags & MEMMAP_ADDRESSING)
+		clk_memmap_writel(val, reg);
+	else
 		writel_relaxed(val, reg);
-	}
 }
 
 u32 omap2_clk_readl(struct clk_hw_omap *clk, void __iomem *reg)
 {
 	u32 val;
 
-	if (clk->flags & MEMMAP_ADDRESSING) {
-		struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
-		val = readl_relaxed(clk_memmaps[r->index] + r->offset);
-	} else {
+	if (clk->flags & MEMMAP_ADDRESSING)
+		val = clk_memmap_readl(reg);
+	else
 		val = readl_relaxed(reg);
-	}
 
 	return val;
 }
 
+static struct ti_clk_ll_ops omap_clk_ll_ops = {
+	.clk_readl = clk_memmap_readl,
+	.clk_writel = clk_memmap_writel,
+};
+
+/**
+ * omap2_clk_provider_init - initialize a clock provider
+ * @match_table: DT device table to match for devices to init
+ *
+ * Initializes a clock provider module (CM/PRM etc.), allocating the
+ * memory mapping, allocating the mapping index and initializing the
+ * low level driver infrastructure. Returns 0 in success, -ENOMEM in
+ * failure.
+ */
+int __init omap2_clk_provider_init(const struct of_device_id *match_table)
+{
+	struct device_node *np;
+	void __iomem *mem;
+	static int memmap_index;
+
+	ti_clk_ll_ops = &omap_clk_ll_ops;
+
+	for_each_matching_node(np, match_table) {
+		mem = of_iomap(np, 0);
+		if (!mem)
+			return -ENOMEM;
+		clk_memmaps[memmap_index] = mem;
+		ti_dt_clk_init_provider(np, memmap_index);
+		memmap_index++;
+	}
+
+	return 0;
+}
+
 /*
  * OMAP2+ specific clock functions
  */
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 4592a27..8f6a0fb 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -267,8 +267,6 @@ extern const struct clksel_rate div_1_3_rates[];
 extern const struct clksel_rate div_1_4_rates[];
 extern const struct clksel_rate div31_1to31_rates[];
 
-extern void __iomem *clk_memmaps[];
-
 extern int am33xx_clk_init(void);
 
 extern int omap2_clkops_enable_clkdm(struct clk_hw *hw);
@@ -276,5 +274,7 @@ extern void omap2_clkops_disable_clkdm(struct clk_hw *hw);
 
 extern void omap_clocks_register(struct omap_clk *oclks, int cnt);
 
+int __init omap2_clk_provider_init(const struct of_device_id *match_table);
+
 void __init ti_clk_init_features(void);
 #endif
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index a8e4b58..22afef0 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -517,6 +517,8 @@ struct omap_prcm_irq_setup {
 	.priority = _priority				\
 	}
 
+struct of_device_id;
+
 extern void omap_prcm_irq_cleanup(void);
 extern int omap_prcm_register_chain_handler(
 	struct omap_prcm_irq_setup *irq_setup);
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 779940c..9f736d2 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -590,41 +590,9 @@ static const struct of_device_id omap_prcm_dt_match_table[] = {
 	{ }
 };
 
-static struct clk_hw_omap memmap_dummy_ck = {
-	.flags = MEMMAP_ADDRESSING,
-};
-
-static u32 prm_clk_readl(void __iomem *reg)
-{
-	return omap2_clk_readl(&memmap_dummy_ck, reg);
-}
-
-static void prm_clk_writel(u32 val, void __iomem *reg)
-{
-	omap2_clk_writel(val, &memmap_dummy_ck, reg);
-}
-
-static struct ti_clk_ll_ops omap_clk_ll_ops = {
-	.clk_readl = prm_clk_readl,
-	.clk_writel = prm_clk_writel,
-};
-
 int __init of_prcm_init(void)
 {
-	struct device_node *np;
-	void __iomem *mem;
-	int memmap_index = 0;
-
-	ti_clk_ll_ops = &omap_clk_ll_ops;
-
-	for_each_matching_node(np, omap_prcm_dt_match_table) {
-		mem = of_iomap(np, 0);
-		clk_memmaps[memmap_index] = mem;
-		ti_dt_clk_init_provider(np, memmap_index);
-		memmap_index++;
-	}
-
-	return 0;
+	return omap2_clk_provider_init(omap_prcm_dt_match_table);
 }
 
 static int __init prm_late_init(void)
-- 
1.7.9.5

