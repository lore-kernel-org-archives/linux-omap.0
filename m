From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2] clk: ti: change clock init to use generic of_clk_init
Date: Fri, 12 Sep 2014 15:01:57 +0300
Message-ID: <1410523317-14787-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41314 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753714AbaILMCQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Sep 2014 08:02:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@linaro.org>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>, Stefan Assmann <sassmann@kpanic.de>

Previously, the TI clock driver initialized all the clocks hierarchically
under each separate clock provider node. Now, each clock that requires
IO access will instead check their parent node to find out which IO range
to use.

This patch allows the TI clock driver to use a few new features provided
by the generic of_clk_init, and also allows registration of clock nodes
outside the clock hierarchy (for example, any external clocks.)

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Jyri Sarha <jsarha@ti.com>
Cc: Stefan Assmann <sassmann@kpanic.de>
---
Changes from v1:
  - fixed the retry logic for deferred clock inits, this wasn't working
    properly in v1

 arch/arm/mach-omap2/io.c         |   12 +++++--
 arch/arm/mach-omap2/prm_common.c |    2 --
 drivers/clk/ti/clk.c             |   68 ++++++++++++++++++++++++--------------
 include/linux/clk/ti.h           |    1 +
 4 files changed, 54 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 5d0667c..a1b82a9 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -734,8 +734,16 @@ int __init omap_clk_init(void)
 	ti_clk_init_features();
 
 	ret = of_prcm_init();
-	if (!ret)
-		ret = omap_clk_soc_init();
+	if (ret)
+		return ret;
+
+	of_clk_init(NULL);
+
+	ti_dt_clk_init_retry_clks();
+
+	ti_dt_clockdomains_setup();
+
+	ret = omap_clk_soc_init();
 
 	return ret;
 }
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 76ca320..3b89080 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -525,8 +525,6 @@ int __init of_prcm_init(void)
 		memmap_index++;
 	}
 
-	ti_dt_clockdomains_setup();
-
 	return 0;
 }
 
diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index b1a6f71..337abe5 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -25,8 +25,8 @@
 #undef pr_fmt
 #define pr_fmt(fmt) "%s: " fmt, __func__
 
-static int ti_dt_clk_memmap_index;
 struct ti_clk_ll_ops *ti_clk_ll_ops;
+static struct device_node *clocks_node_ptr[CLK_MAX_MEMMAPS];
 
 /**
  * ti_dt_clocks_register - register DT alias clocks during boot
@@ -108,9 +108,21 @@ void __iomem *ti_clk_get_reg_addr(struct device_node *node, int index)
 	struct clk_omap_reg *reg;
 	u32 val;
 	u32 tmp;
+	int i;
 
 	reg = (struct clk_omap_reg *)&tmp;
-	reg->index = ti_dt_clk_memmap_index;
+
+	for (i = 0; i < CLK_MAX_MEMMAPS; i++) {
+		if (clocks_node_ptr[i] == node->parent)
+			break;
+	}
+
+	if (i == CLK_MAX_MEMMAPS) {
+		pr_err("clk-provider not found for %s!\n", node->name);
+		return NULL;
+	}
+
+	reg->index = i;
 
 	if (of_property_read_u32_index(node, "reg", index, &val)) {
 		pr_err("%s must have reg[%d]!\n", node->name, index);
@@ -127,20 +139,14 @@ void __iomem *ti_clk_get_reg_addr(struct device_node *node, int index)
  * @parent: master node
  * @index: internal index for clk_reg_ops
  *
- * Initializes a master clock IP block and its child clock nodes.
- * Regmap is provided for accessing the register space for the
- * IP block and all the clocks under it.
+ * Initializes a master clock IP block. This basically sets up the
+ * mapping from clocks node to the memory map index. All the clocks
+ * are then initialized through the common of_clk_init call, and the
+ * clocks will access their memory maps based on the node layout.
  */
 void ti_dt_clk_init_provider(struct device_node *parent, int index)
 {
-	const struct of_device_id *match;
-	struct device_node *np;
 	struct device_node *clocks;
-	of_clk_init_cb_t clk_init_cb;
-	struct clk_init_item *retry;
-	struct clk_init_item *tmp;
-
-	ti_dt_clk_memmap_index = index;
 
 	/* get clocks for this parent */
 	clocks = of_get_child_by_name(parent, "clocks");
@@ -149,19 +155,31 @@ void ti_dt_clk_init_provider(struct device_node *parent, int index)
 		return;
 	}
 
-	for_each_child_of_node(clocks, np) {
-		match = of_match_node(&__clk_of_table, np);
-		if (!match)
-			continue;
-		clk_init_cb = (of_clk_init_cb_t)match->data;
-		pr_debug("%s: initializing: %s\n", __func__, np->name);
-		clk_init_cb(np);
-	}
+	/* add clocks node info */
+	clocks_node_ptr[index] = clocks;
+}
 
-	list_for_each_entry_safe(retry, tmp, &retry_list, link) {
-		pr_debug("retry-init: %s\n", retry->node->name);
-		retry->func(retry->hw, retry->node);
-		list_del(&retry->link);
-		kfree(retry);
+/**
+ * ti_dt_clk_init_retry_clks - init clocks from the retry list
+ *
+ * Initializes any clocks that have failed to initialize before,
+ * reasons being missing parent node(s) during earlier init. This
+ * typically happens only for DPLLs which need to have both of their
+ * parent clocks ready during init.
+ */
+void ti_dt_clk_init_retry_clks(void)
+{
+	struct clk_init_item *retry;
+	struct clk_init_item *tmp;
+	int retries = 5;
+
+	while (!list_empty(&retry_list) && retries) {
+		list_for_each_entry_safe(retry, tmp, &retry_list, link) {
+			pr_debug("retry-init: %s\n", retry->node->name);
+			retry->func(retry->hw, retry->node);
+			list_del(&retry->link);
+			kfree(retry);
+		}
+		retries--;
 	}
 }
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index e8d8a35..f75acbf 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -292,6 +292,7 @@ void omap2xxx_clkt_vps_init(void);
 void __iomem *ti_clk_get_reg_addr(struct device_node *node, int index);
 void ti_dt_clocks_register(struct ti_dt_clk *oclks);
 void ti_dt_clk_init_provider(struct device_node *np, int index);
+void ti_dt_clk_init_retry_clks(void);
 void ti_dt_clockdomains_setup(void);
 int ti_clk_retry_init(struct device_node *node, struct clk_hw *hw,
 		      ti_of_clk_init_cb_t func);
-- 
1.7.9.5

