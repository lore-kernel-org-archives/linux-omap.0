From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 27/27] clk: ti: move low-level access and init code under clock driver
Date: Mon, 25 May 2015 18:00:32 +0300
Message-ID: <1432566032-10860-28-git-send-email-t-kristo@ti.com>
References: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50084 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752184AbbEYPCE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 May 2015 11:02:04 -0400
In-Reply-To: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, sboyd@codeaurora.org, mturquette@linaro.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

With most of the clock code under clock driver already, the low-level
register access code, and the init code for the same, is no longer
needed outside the clock driver. Thus, these can be moved under clock
driver also.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.c |   84 -------------------------------------------
 arch/arm/mach-omap2/clock.h |    5 ---
 drivers/clk/ti/clk.c        |   75 ++++++++++++++++++++++++++++++++++++--
 include/linux/clk/ti.h      |    7 +++-
 4 files changed, 78 insertions(+), 93 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 79cec5f..4340ba6 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -23,9 +23,7 @@
 #include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/bitops.h>
-#include <linux/regmap.h>
 #include <linux/of_address.h>
-#include <linux/bootmem.h>
 #include <asm/cpu.h>
 
 #include <trace/events/power.h>
@@ -55,41 +53,7 @@ u16 cpu_mask;
 #define OMAP3PLUS_DPLL_FINT_MIN		32000
 #define OMAP3PLUS_DPLL_FINT_MAX		52000000
 
-struct clk_iomap {
-	struct regmap *regmap;
-	void __iomem *mem;
-};
-
-static struct clk_iomap *clk_memmaps[CLK_MAX_MEMMAPS];
-
-static void clk_memmap_writel(u32 val, void __iomem *reg)
-{
-	struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
-	struct clk_iomap *io = clk_memmaps[r->index];
-
-	if (io->regmap)
-		regmap_write(io->regmap, r->offset, val);
-	else
-		writel_relaxed(val, io->mem + r->offset);
-}
-
-static u32 clk_memmap_readl(void __iomem *reg)
-{
-	u32 val;
-	struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
-	struct clk_iomap *io = clk_memmaps[r->index];
-
-	if (io->regmap)
-		regmap_read(io->regmap, r->offset, &val);
-	else
-		val = readl_relaxed(io->mem + r->offset);
-
-	return val;
-}
-
 static struct ti_clk_ll_ops omap_clk_ll_ops = {
-	.clk_readl = clk_memmap_readl,
-	.clk_writel = clk_memmap_writel,
 	.clkdm_clk_enable = clkdm_clk_enable,
 	.clkdm_clk_disable = clkdm_clk_disable,
 	.cm_wait_module_ready = omap_cm_wait_module_ready,
@@ -109,54 +73,6 @@ int __init omap2_clk_setup_ll_ops(void)
 	return ti_clk_setup_ll_ops(&omap_clk_ll_ops);
 }
 
-/**
- * omap2_clk_provider_init - initialize a clock provider
- * @match_table: DT device table to match for devices to init
- * @np: device node pointer for the this clock provider
- * @index: index for the clock provider
- + @syscon: syscon regmap pointer
- * @mem: iomem pointer for the clock provider memory area, only used if
- *	 syscon is not provided
- *
- * Initializes a clock provider module (CM/PRM etc.), registering
- * the memory mapping at specified index and initializing the
- * low level driver infrastructure. Returns 0 in success.
- */
-int __init omap2_clk_provider_init(struct device_node *np, int index,
-				   struct regmap *syscon, void __iomem *mem)
-{
-	struct clk_iomap *io;
-
-	io = kzalloc(sizeof(*io), GFP_KERNEL);
-
-	io->regmap = syscon;
-	io->mem = mem;
-
-	clk_memmaps[index] = io;
-
-	ti_dt_clk_init_provider(np, index);
-
-	return 0;
-}
-
-/**
- * omap2_clk_legacy_provider_init - initialize a legacy clock provider
- * @index: index for the clock provider
- * @mem: iomem pointer for the clock provider memory area
- *
- * Initializes a legacy clock provider memory mapping.
- */
-void __init omap2_clk_legacy_provider_init(int index, void __iomem *mem)
-{
-	struct clk_iomap *io;
-
-	io = memblock_virt_alloc(sizeof(*io), 0);
-
-	io->mem = mem;
-
-	clk_memmaps[index] = io;
-}
-
 /*
  * OMAP2+ specific clock functions
  */
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index f3dc04c..67da640 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -75,11 +75,6 @@ extern const struct clkops clkops_omap2_dflt;
 
 extern struct clk_functions omap2_clk_functions;
 
-struct regmap;
-
-int __init omap2_clk_provider_init(struct device_node *np, int index,
-				   struct regmap *syscon, void __iomem *mem);
-void __init omap2_clk_legacy_provider_init(int index, void __iomem *mem);
 int __init omap2_clk_setup_ll_ops(void);
 
 void __init ti_clk_init_features(void);
diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index dc6b759..786ab59 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -21,6 +21,8 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/list.h>
+#include <linux/regmap.h>
+#include <linux/bootmem.h>
 
 #include "clock.h"
 
@@ -32,6 +34,38 @@ static struct device_node *clocks_node_ptr[CLK_MAX_MEMMAPS];
 
 struct ti_clk_features ti_clk_features;
 
+struct clk_iomap {
+	struct regmap *regmap;
+	void __iomem *mem;
+};
+
+static struct clk_iomap *clk_memmaps[CLK_MAX_MEMMAPS];
+
+static void clk_memmap_writel(u32 val, void __iomem *reg)
+{
+	struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
+	struct clk_iomap *io = clk_memmaps[r->index];
+
+	if (io->regmap)
+		regmap_write(io->regmap, r->offset, val);
+	else
+		writel_relaxed(val, io->mem + r->offset);
+}
+
+static u32 clk_memmap_readl(void __iomem *reg)
+{
+	u32 val;
+	struct clk_omap_reg *r = (struct clk_omap_reg *)&reg;
+	struct clk_iomap *io = clk_memmaps[r->index];
+
+	if (io->regmap)
+		regmap_read(io->regmap, r->offset, &val);
+	else
+		val = readl_relaxed(io->mem + r->offset);
+
+	return val;
+}
+
 /**
  * ti_clk_setup_ll_ops - setup low level clock operations
  * @ops: low level clock ops descriptor
@@ -49,6 +83,8 @@ int ti_clk_setup_ll_ops(struct ti_clk_ll_ops *ops)
 	}
 
 	ti_clk_ll_ops = ops;
+	ops->clk_readl = clk_memmap_readl;
+	ops->clk_writel = clk_memmap_writel;
 
 	return 0;
 }
@@ -161,28 +197,61 @@ void __iomem *ti_clk_get_reg_addr(struct device_node *node, int index)
 }
 
 /**
- * ti_dt_clk_init_provider - init master clock provider
+ * omap2_clk_provider_init - init master clock provider
  * @parent: master node
  * @index: internal index for clk_reg_ops
+ * @syscon: syscon regmap pointer for accessing clock registers
+ * @mem: iomem pointer for the clock provider memory area, only used if
+ *       syscon is not provided
  *
  * Initializes a master clock IP block. This basically sets up the
  * mapping from clocks node to the memory map index. All the clocks
  * are then initialized through the common of_clk_init call, and the
  * clocks will access their memory maps based on the node layout.
+ * Returns 0 in success.
  */
-void ti_dt_clk_init_provider(struct device_node *parent, int index)
+int __init omap2_clk_provider_init(struct device_node *parent, int index,
+				   struct regmap *syscon, void __iomem *mem)
 {
 	struct device_node *clocks;
+	struct clk_iomap *io;
 
 	/* get clocks for this parent */
 	clocks = of_get_child_by_name(parent, "clocks");
 	if (!clocks) {
 		pr_err("%s missing 'clocks' child node.\n", parent->name);
-		return;
+		return -EINVAL;
 	}
 
 	/* add clocks node info */
 	clocks_node_ptr[index] = clocks;
+
+	io = kzalloc(sizeof(*io), GFP_KERNEL);
+
+	io->regmap = syscon;
+	io->mem = mem;
+
+	clk_memmaps[index] = io;
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
+	struct clk_iomap *io;
+
+	io = memblock_virt_alloc(sizeof(*io), 0);
+
+	io->mem = mem;
+
+	clk_memmaps[index] = io;
 }
 
 /**
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 267cca0..f183825 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -250,11 +250,16 @@ void omap2xxx_clkt_dpllcore_init(struct clk_hw *hw);
 void omap2xxx_clkt_vps_init(void);
 unsigned long omap2_get_dpll_rate(struct clk_hw_omap *clk);
 
-void ti_dt_clk_init_provider(struct device_node *np, int index);
 void ti_dt_clk_init_retry_clks(void);
 void ti_dt_clockdomains_setup(void);
 int ti_clk_setup_ll_ops(struct ti_clk_ll_ops *ops);
 
+struct regmap;
+
+int omap2_clk_provider_init(struct device_node *parent, int index,
+			    struct regmap *syscon, void __iomem *mem);
+void omap2_clk_legacy_provider_init(int index, void __iomem *mem);
+
 int omap3430_dt_clk_init(void);
 int omap3630_dt_clk_init(void);
 int am35xx_dt_clk_init(void);
-- 
1.7.9.5

