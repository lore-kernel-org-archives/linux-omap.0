From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 10/34] ARM: OMAP2+: clock: move clock provider infrastructure to clock driver
Date: Tue, 31 Mar 2015 22:14:03 +0300
Message-ID: <1427829267-32077-11-git-send-email-t-kristo@ti.com>
References: <1427829267-32077-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56417 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752715AbbCaTOu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Mar 2015 15:14:50 -0400
In-Reply-To: <1427829267-32077-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Splits the clock provider init out of the PRM driver and moves it to
clock driver. This is needed so that once the PRCM drivers are separated,
they can logically just access the clock driver not needing to go through
common PRM code. This would be wrong in the case of control module for
example.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.c      |   77 +++++++++++++++++++++++++++++++-------
 arch/arm/mach-omap2/clock.h      |    6 ++-
 arch/arm/mach-omap2/prm_common.c |   36 ++++--------------
 3 files changed, 75 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 6124db5..94080fb 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -23,6 +23,7 @@
 #include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/bitops.h>
+#include <linux/of_address.h>
 #include <asm/cpu.h>
 
 #include <trace/events/power.h>
@@ -72,30 +73,78 @@ struct ti_clk_features ti_clk_features;
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
+	if (WARN_ON_ONCE(!(clk->flags & MEMMAP_ADDRESSING)))
 		writel_relaxed(val, reg);
-	}
+	else
+		clk_memmap_writel(val, reg);
 }
 
 u32 omap2_clk_readl(struct clk_hw_omap *clk, void __iomem *reg)
 {
-	u32 val;
+	if (WARN_ON_ONCE(!(clk->flags & MEMMAP_ADDRESSING)))
+		return readl_relaxed(reg);
+	else
+		return clk_memmap_readl(reg);
+}
 
-	if (clk->flags & MEMMAP_ADDRESSING) {
-		struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
-		val = readl_relaxed(clk_memmaps[r->index] + r->offset);
-	} else {
-		val = readl_relaxed(reg);
-	}
+static struct ti_clk_ll_ops omap_clk_ll_ops = {
+	.clk_readl = clk_memmap_readl,
+	.clk_writel = clk_memmap_writel,
+};
+
+/**
+ * omap2_clk_provider_init - initialize a clock provider
+ * @match_table: DT device table to match for devices to init
+ * @np: device node pointer for the this clock provider
+ * @index: index for the clock provider
+ * @mem: iomem pointer for the clock provider memory area
+ *
+ * Initializes a clock provider module (CM/PRM etc.), registering
+ * the memory mapping at specified index and initializing the
+ * low level driver infrastructure. Returns 0 in success.
+ */
+int __init omap2_clk_provider_init(struct device_node *np, int index,
+				   void __iomem *mem)
+{
+	ti_clk_ll_ops = &omap_clk_ll_ops;
+
+	clk_memmaps[index] = mem;
+
+	ti_dt_clk_init_provider(np, index);
+
+	return 0;
+}
+
+/**
+ * omap2_clk_legacy_provider_init - initialize a legacy clock provider
+ * @index: index for the clock provider
+ * @mem: iomem pointer for the clock provider memory area
+ *
+ * Initializes a legacy clock provider memory mapping.
+ */
+void __init omap2_clk_legacy_provider_init(int index, void __iomem *mem)
+{
+	ti_clk_ll_ops = &omap_clk_ll_ops;
 
-	return val;
+	clk_memmaps[index] = mem;
 }
 
 /*
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index a56742f..b6433fc 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -271,10 +271,12 @@ extern const struct clksel_rate div_1_3_rates[];
 extern const struct clksel_rate div_1_4_rates[];
 extern const struct clksel_rate div31_1to31_rates[];
 
-extern void __iomem *clk_memmaps[];
-
 extern int omap2_clkops_enable_clkdm(struct clk_hw *hw);
 extern void omap2_clkops_disable_clkdm(struct clk_hw *hw);
 
+int __init omap2_clk_provider_init(struct device_node *np, int index,
+				   void __iomem *mem);
+void __init omap2_clk_legacy_provider_init(int index, void __iomem *mem);
+
 void __init ti_clk_init_features(void);
 #endif
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 8ec5201..1bfd00e 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -677,25 +677,6 @@ static const struct of_device_id omap_prcm_dt_match_table[] = {
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
 /**
  * omap_prcm_init - low level init for the PRCM drivers
  *
@@ -708,8 +689,7 @@ int __init omap_prcm_init(void)
 	void __iomem *mem;
 	const struct of_device_id *match;
 	const struct omap_prcm_init_data *data;
-
-	ti_clk_ll_ops = &omap_clk_ll_ops;
+	int ret;
 
 	for_each_matching_node_and_match(np, omap_prcm_dt_match_table, &match) {
 		data = match->data;
@@ -718,8 +698,9 @@ int __init omap_prcm_init(void)
 		if (!mem)
 			return -ENOMEM;
 
-		clk_memmaps[data->index] = mem;
-		ti_dt_clk_init_provider(np, data->index);
+		ret = omap2_clk_provider_init(np, data->index, mem);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
@@ -727,11 +708,10 @@ int __init omap_prcm_init(void)
 
 void __init omap3_prcm_legacy_iomaps_init(void)
 {
-	ti_clk_ll_ops = &omap_clk_ll_ops;
-
-	clk_memmaps[TI_CLKM_CM] = cm_base + OMAP3430_IVA2_MOD;
-	clk_memmaps[TI_CLKM_PRM] = prm_base + OMAP3430_IVA2_MOD;
-	clk_memmaps[TI_CLKM_SCRM] = omap_ctrl_base_get();
+	omap2_clk_legacy_provider_init(TI_CLKM_CM, cm_base + OMAP3430_IVA2_MOD);
+	omap2_clk_legacy_provider_init(TI_CLKM_PRM,
+				       prm_base + OMAP3430_IVA2_MOD);
+	omap2_clk_legacy_provider_init(TI_CLKM_SCRM, omap_ctrl_base_get());
 }
 
 static int __init prm_late_init(void)
-- 
1.7.9.5

