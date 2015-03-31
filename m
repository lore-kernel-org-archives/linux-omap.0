From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 20/34] ARM: OMAP2+: clock: add low-level support for regmap
Date: Tue, 31 Mar 2015 22:14:13 +0300
Message-ID: <1427829267-32077-21-git-send-email-t-kristo@ti.com>
References: <1427829267-32077-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46867 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752746AbbCaTPK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Mar 2015 15:15:10 -0400
In-Reply-To: <1427829267-32077-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Some of the TI clock providers will be converted to use syscon, thus
low-level regmap support is needed for the clock drivers also. This
patch adds this support, which can be enabled for individual drivers
in later patches.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.c      |   48 ++++++++++++++++++++++++++++++++------
 arch/arm/mach-omap2/clock.h      |    4 +++-
 arch/arm/mach-omap2/cm_common.c  |    2 +-
 arch/arm/mach-omap2/control.c    |    2 +-
 arch/arm/mach-omap2/prm_common.c |    2 +-
 5 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 94080fb..a699d71 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -23,7 +23,9 @@
 #include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/bitops.h>
+#include <linux/regmap.h>
 #include <linux/of_address.h>
+#include <linux/bootmem.h>
 #include <asm/cpu.h>
 
 #include <trace/events/power.h>
@@ -73,20 +75,37 @@ struct ti_clk_features ti_clk_features;
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
 
-	return readl_relaxed(clk_memmaps[r->index] + r->offset);
+	if (io->regmap)
+		regmap_read(io->regmap, r->offset, &val);
+	else
+		val = readl_relaxed(io->mem + r->offset);
+
+	return val;
 }
 
 void omap2_clk_writel(u32 val, struct clk_hw_omap *clk, void __iomem *reg)
@@ -115,18 +134,27 @@ static struct ti_clk_ll_ops omap_clk_ll_ops = {
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
 
@@ -142,9 +170,15 @@ int __init omap2_clk_provider_init(struct device_node *np, int index,
  */
 void __init omap2_clk_legacy_provider_init(int index, void __iomem *mem)
 {
+	struct clk_iomap *io;
+
 	ti_clk_ll_ops = &omap_clk_ll_ops;
 
-	clk_memmaps[index] = mem;
+	io = memblock_virt_alloc(sizeof(*io), 0);
+
+	io->mem = mem;
+
+	clk_memmaps[index] = io;
 }
 
 /*
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
index ff24fdf..23e8bce 100644
--- a/arch/arm/mach-omap2/cm_common.c
+++ b/arch/arm/mach-omap2/cm_common.c
@@ -361,7 +361,7 @@ int __init omap_cm_init(void)
 		if (data->flags & CM_NO_CLOCKS)
 			continue;
 
-		ret = omap2_clk_provider_init(np, data->index, data->mem);
+		ret = omap2_clk_provider_init(np, data->index, NULL, data->mem);
 		if (ret)
 			return ret;
 	}
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 21ff32c..4b40946 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -676,7 +676,7 @@ int __init omap_control_init(void)
 	for_each_matching_node_and_match(np, omap_scrm_dt_match_table, &match) {
 		data = match->data;
 
-		ret = omap2_clk_provider_init(np, data->index, data->mem);
+		ret = omap2_clk_provider_init(np, data->index, NULL, data->mem);
 		if (ret)
 			return ret;
 	}
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 6832a31..7add799 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -798,7 +798,7 @@ int __init omap_prcm_init(void)
 	for_each_matching_node_and_match(np, omap_prcm_dt_match_table, &match) {
 		data = match->data;
 
-		ret = omap2_clk_provider_init(np, data->index, data->mem);
+		ret = omap2_clk_provider_init(np, data->index, NULL, data->mem);
 		if (ret)
 			return ret;
 	}
-- 
1.7.9.5

