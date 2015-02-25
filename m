From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 21/35] ARM: OMAP2+: clock: add low-level support for regmap
Date: Wed, 25 Feb 2015 21:04:31 +0200
Message-ID: <1424891085-10392-22-git-send-email-t-kristo@ti.com>
References: <1424891085-10392-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54381 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753554AbbBYTFZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Feb 2015 14:05:25 -0500
In-Reply-To: <1424891085-10392-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Some of the TI clock providers will be converted to use syscon, thus
low-level regmap support is needed for the clock drivers also. This
patch adds this support, which can be enabled for individual drivers
in later patches.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.c      |   39 ++++++++++++++++++++++++++++++++------
 arch/arm/mach-omap2/clock.h      |    4 +++-
 arch/arm/mach-omap2/cm_common.c  |    2 +-
 arch/arm/mach-omap2/control.c    |    2 +-
 arch/arm/mach-omap2/prm_common.c |    2 +-
 5 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 3327128..d9885b8 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -23,6 +23,7 @@
 #include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/bitops.h>
+#include <linux/regmap.h>
 #include <linux/of_address.h>
 #include <asm/cpu.h>
 
@@ -73,20 +74,37 @@ struct ti_clk_features ti_clk_features;
 static bool clkdm_control = true;
 
 static LIST_HEAD(clk_hw_omap_clocks);
-static void __iomem *clk_memmaps[CLK_MAX_MEMMAPS];
+
+struct clk_iomap {
+	struct regmap *regmap;
+	void __iomem *mem;
+};
+
+static struct clk_iomap *clk_memmaps[CLK_MAX_MEMMAPS];
 
 static void clk_memmap_writel(u32 val, void __iomem *reg)
 {
 	struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
+	struct clk_iomap *io = clk_memmaps[r->index];
 
-	writel_relaxed(val, clk_memmaps[r->index] + r->offset);
+	if (io->regmap)
+		regmap_write(io->regmap, r->offset, val);
+	else
+		writel_relaxed(val, io->mem + r->offset);
 }
 
 static u32 clk_memmap_readl(void __iomem *reg)
 {
+	u32 val;
 	struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
+	struct clk_iomap *io = clk_memmaps[r->index];
+
+	if (io->regmap)
+		regmap_read(io->regmap, r->offset, &val);
+	else
+		val = readl_relaxed(io->mem + r->offset);
 
-	return readl_relaxed(clk_memmaps[r->index] + r->offset);
+	return val;
 }
 
 void omap2_clk_writel(u32 val, struct clk_hw_omap *clk, void __iomem *reg)
@@ -119,18 +137,27 @@ static struct ti_clk_ll_ops omap_clk_ll_ops = {
  * @match_table: DT device table to match for devices to init
  * @np: device node pointer for the this clock provider
  * @index: index for the clock provider
- * @mem: iomem pointer for the clock provider memory area
+ + @syscon: syscon regmap pointer
+ * @mem: iomem pointer for the clock provider memory area, only used if
+ *	 syscon is not provided
  *
  * Initializes a clock provider module (CM/PRM etc.), registering
  * the memory mapping at specified index and initializing the
  * low level driver infrastructure. Returns 0 in success.
  */
 int __init omap2_clk_provider_init(struct device_node *np, int index,
-				   void __iomem *mem)
+				   struct regmap *syscon, void __iomem *mem)
 {
+	struct clk_iomap *io;
+
 	ti_clk_ll_ops = &omap_clk_ll_ops;
 
-	clk_memmaps[index] = mem;
+	io = kzalloc(sizeof(*io), GFP_KERNEL);
+
+	io->regmap = syscon;
+	io->mem = mem;
+
+	clk_memmaps[index] = io;
 
 	ti_dt_clk_init_provider(np, index);
 
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index b6433fc..652ed0a 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -274,8 +274,10 @@ extern const struct clksel_rate div31_1to31_rates[];
 extern int omap2_clkops_enable_clkdm(struct clk_hw *hw);
 extern void omap2_clkops_disable_clkdm(struct clk_hw *hw);
 
+struct regmap;
+
 int __init omap2_clk_provider_init(struct device_node *np, int index,
-				   void __iomem *mem);
+				   struct regmap *syscon, void __iomem *mem);
 void __init omap2_clk_legacy_provider_init(int index, void __iomem *mem);
 
 void __init ti_clk_init_features(void);
diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm_common.c
index 0845194..2582651 100644
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
index 074c333..2b54250 100644
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
index 44221fe..eb9e0c2 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -766,7 +766,7 @@ int __init omap_prcm_init(void)
 	for_each_matching_node_and_match(np, omap_prcm_dt_match_table, &match) {
 		data = match->data;
 
-		ret = omap2_clk_provider_init(np, data->index, data->mem);
+		ret = omap2_clk_provider_init(np, data->index, NULL, data->mem);
 		if (ret)
 			return ret;
 	}
-- 
1.7.9.5

