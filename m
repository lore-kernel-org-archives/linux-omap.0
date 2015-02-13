From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 22/33] ARM: OMAP2+: clock: convert low-level clock APIs to use regmap
Date: Fri, 13 Feb 2015 18:12:41 +0200
Message-ID: <1423843973-6050-20-git-send-email-t-kristo@ti.com>
References: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46930 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753756AbbBMQOX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Feb 2015 11:14:23 -0500
In-Reply-To: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, tomi.valkeinen@ti.com, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Clock driver will be converted to use regmap, this prepares the low-level
register API to use regmap already. Individual driver inits will be
converted to use regmap / syscon in following patches.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.c      |   26 ++++++++++++++++++++------
 arch/arm/mach-omap2/clock.h      |    4 +++-
 arch/arm/mach-omap2/cm_common.c  |    2 +-
 arch/arm/mach-omap2/control.c    |    2 +-
 arch/arm/mach-omap2/prm_common.c |    2 +-
 5 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 62d1a89..2c6281b 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -24,6 +24,7 @@
 #include <linux/io.h>
 #include <linux/bitops.h>
 #include <linux/clk-private.h>
+#include <linux/regmap.h>
 #include <linux/of_address.h>
 #include <asm/cpu.h>
 
@@ -74,20 +75,23 @@ struct ti_clk_features ti_clk_features;
 static bool clkdm_control = true;
 
 static LIST_HEAD(clk_hw_omap_clocks);
-static void __iomem *clk_memmaps[CLK_MAX_MEMMAPS];
+static struct regmap *clk_memmaps[CLK_MAX_MEMMAPS];
 
 static void clk_memmap_writel(u32 val, void __iomem *reg)
 {
 	struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
 
-	writel_relaxed(val, clk_memmaps[r->index] + r->offset);
+	regmap_write(clk_memmaps[r->index], r->offset, val);
 }
 
 static u32 clk_memmap_readl(void __iomem *reg)
 {
+	u32 val;
 	struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
 
-	return readl_relaxed(clk_memmaps[r->index] + r->offset);
+	regmap_read(clk_memmaps[r->index], r->offset, &val);
+
+	return val;
 }
 
 void omap2_clk_writel(u32 val, struct clk_hw_omap *clk, void __iomem *reg)
@@ -115,18 +119,25 @@ static struct ti_clk_ll_ops omap_clk_ll_ops = {
 	.clk_writel = clk_memmap_writel,
 };
 
+static struct regmap_config clk_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+};
+
 /**
  * omap2_clk_provider_init - initialize a clock provider
  * @np: device node for initializing the clock provider
  * @index: memory map index for the clock provider
- * @mem: iomem pointer for the memory map
+ * @syscon: syscon regmap pointer
+ * @mem: iomem pointer for the memory map, only used if @syscon is not provided
  *
  * Initializes a clock provider module (CM/PRM etc.), registering
  * the iomap and initializing the low level driver infrastructure.
  * Returns 0 in success, -EINVAL if multiple registration is attempted.
  */
 int __init omap2_clk_provider_init(struct device_node *np, int index,
-				   void __iomem *mem)
+				   struct regmap *syscon, void __iomem *mem)
 {
 	ti_clk_ll_ops = &omap_clk_ll_ops;
 
@@ -136,7 +147,10 @@ int __init omap2_clk_provider_init(struct device_node *np, int index,
 		return -EINVAL;
 	}
 
-	clk_memmaps[index] = mem;
+	if (!syscon)
+		syscon = regmap_init_mmio(NULL, mem, &clk_regmap_config);
+
+	clk_memmaps[index] = syscon;
 	ti_dt_clk_init_provider(np, index);
 
 	return 0;
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index a229622..6a4dfe7 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -280,8 +280,10 @@ extern void omap2_clkops_disable_clkdm(struct clk_hw *hw);
 
 extern void omap_clocks_register(struct omap_clk *oclks, int cnt);
 
+struct regmap;
+
 int __init omap2_clk_provider_init(struct device_node *np, int index,
-				   void __iomem *mem);
+				   struct regmap *syscon, void __iomem *mem);
 
 void __init ti_clk_init_features(void);
 #endif
diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm_common.c
index 03a52ca..888ee45 100644
--- a/arch/arm/mach-omap2/cm_common.c
+++ b/arch/arm/mach-omap2/cm_common.c
@@ -332,7 +332,7 @@ int __init omap_cm_init(void)
 		if (data->flags & CM_NO_CLOCKS)
 			continue;
 
-		ret = omap2_clk_provider_init(np, data->index, data->mem);
+		ret = omap2_clk_provider_init(np, data->index, NULL, data->mem);
 		if (ret)
 			return ret;
 	}
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 2b9bced..890c739 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -675,7 +675,7 @@ int __init omap_control_init(void)
 	for_each_matching_node_and_match(np, omap_scrm_dt_match_table, &match) {
 		data = match->data;
 
-		ret = omap2_clk_provider_init(np, data->index, data->mem);
+		ret = omap2_clk_provider_init(np, data->index, NULL, data->mem);
 		if (ret)
 			return ret;
 	}
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 3f26df6..affddb9 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -753,7 +753,7 @@ int __init omap_prcm_init(void)
 	for_each_matching_node_and_match(np, omap_prcm_dt_match_table, &match) {
 		data = match->data;
 
-		ret = omap2_clk_provider_init(np, data->index, data->mem);
+		ret = omap2_clk_provider_init(np, data->index, NULL, data->mem);
 		if (ret)
 			return ret;
 	}
-- 
1.7.9.5

