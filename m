From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv13 02/40] CLK: ti: add init support for clock IP blocks
Date: Thu, 9 Jan 2014 16:00:13 +0200
Message-ID: <1389276051-1326-3-git-send-email-t-kristo@ti.com>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38592 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754789AbaAIOBm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Jan 2014 09:01:42 -0500
In-Reply-To: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

ti_dt_clk_init_provider() can now be used to initialize the contents of
a single clock IP block. This parses all the clocks under the IP block
and calls the corresponding init function for them.

This patch also introduces a helper function for the TI clock drivers
to get register info from DT and append the master IP info to this.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/clk.c            |    4 +-
 drivers/clk/ti/clk.c         |  112 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk-provider.h |    2 +
 include/linux/clk/ti.h       |   35 +++++++++++++
 4 files changed, 150 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 2cf2ea6..bbbe799 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2104,8 +2104,6 @@ struct of_clk_provider {
 	void *data;
 };
 
-extern struct of_device_id __clk_of_table[];
-
 static const struct of_device_id __clk_of_table_sentinel
 	__used __section(__clk_of_table_end);
 
@@ -2245,7 +2243,7 @@ void __init of_clk_init(const struct of_device_id *matches)
 	struct device_node *np;
 
 	if (!matches)
-		matches = __clk_of_table;
+		matches = &__clk_of_table;
 
 	for_each_matching_node_and_match(np, matches, &match) {
 		of_clk_init_cb_t clk_init_cb = match->data;
diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index ef1a7cd..b1a6f71 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -19,10 +19,15 @@
 #include <linux/clkdev.h>
 #include <linux/clk/ti.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/list.h>
 
 #undef pr_fmt
 #define pr_fmt(fmt) "%s: " fmt, __func__
 
+static int ti_dt_clk_memmap_index;
+struct ti_clk_ll_ops *ti_clk_ll_ops;
+
 /**
  * ti_dt_clocks_register - register DT alias clocks during boot
  * @oclks: list of clocks to register
@@ -53,3 +58,110 @@ void __init ti_dt_clocks_register(struct ti_dt_clk oclks[])
 		}
 	}
 }
+
+struct clk_init_item {
+	struct device_node *node;
+	struct clk_hw *hw;
+	ti_of_clk_init_cb_t func;
+	struct list_head link;
+};
+
+static LIST_HEAD(retry_list);
+
+/**
+ * ti_clk_retry_init - retries a failed clock init at later phase
+ * @node: device not for the clock
+ * @hw: partially initialized clk_hw struct for the clock
+ * @func: init function to be called for the clock
+ *
+ * Adds a failed clock init to the retry list. The retry list is parsed
+ * once all the other clocks have been initialized.
+ */
+int __init ti_clk_retry_init(struct device_node *node, struct clk_hw *hw,
+			      ti_of_clk_init_cb_t func)
+{
+	struct clk_init_item *retry;
+
+	pr_debug("%s: adding to retry list...\n", node->name);
+	retry = kzalloc(sizeof(*retry), GFP_KERNEL);
+	if (!retry)
+		return -ENOMEM;
+
+	retry->node = node;
+	retry->func = func;
+	retry->hw = hw;
+	list_add(&retry->link, &retry_list);
+
+	return 0;
+}
+
+/**
+ * ti_clk_get_reg_addr - get register address for a clock register
+ * @node: device node for the clock
+ * @index: register index from the clock node
+ *
+ * Builds clock register address from device tree information. This
+ * is a struct of type clk_omap_reg.
+ */
+void __iomem *ti_clk_get_reg_addr(struct device_node *node, int index)
+{
+	struct clk_omap_reg *reg;
+	u32 val;
+	u32 tmp;
+
+	reg = (struct clk_omap_reg *)&tmp;
+	reg->index = ti_dt_clk_memmap_index;
+
+	if (of_property_read_u32_index(node, "reg", index, &val)) {
+		pr_err("%s must have reg[%d]!\n", node->name, index);
+		return NULL;
+	}
+
+	reg->offset = val;
+
+	return (void __iomem *)tmp;
+}
+
+/**
+ * ti_dt_clk_init_provider - init master clock provider
+ * @parent: master node
+ * @index: internal index for clk_reg_ops
+ *
+ * Initializes a master clock IP block and its child clock nodes.
+ * Regmap is provided for accessing the register space for the
+ * IP block and all the clocks under it.
+ */
+void ti_dt_clk_init_provider(struct device_node *parent, int index)
+{
+	const struct of_device_id *match;
+	struct device_node *np;
+	struct device_node *clocks;
+	of_clk_init_cb_t clk_init_cb;
+	struct clk_init_item *retry;
+	struct clk_init_item *tmp;
+
+	ti_dt_clk_memmap_index = index;
+
+	/* get clocks for this parent */
+	clocks = of_get_child_by_name(parent, "clocks");
+	if (!clocks) {
+		pr_err("%s missing 'clocks' child node.\n", parent->name);
+		return;
+	}
+
+	for_each_child_of_node(clocks, np) {
+		match = of_match_node(&__clk_of_table, np);
+		if (!match)
+			continue;
+		clk_init_cb = (of_clk_init_cb_t)match->data;
+		pr_debug("%s: initializing: %s\n", __func__, np->name);
+		clk_init_cb(np);
+	}
+
+	list_for_each_entry_safe(retry, tmp, &retry_list, link) {
+		pr_debug("retry-init: %s\n", retry->node->name);
+		retry->func(retry->hw, retry->node);
+		list_del(&retry->link);
+		kfree(retry);
+	}
+}
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 7e59253..5760dc8 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -458,6 +458,8 @@ struct clk_onecell_data {
 	unsigned int clk_num;
 };
 
+extern struct of_device_id __clk_of_table;
+
 #define CLK_OF_DECLARE(name, compat, fn)			\
 	static const struct of_device_id __clk_of_table_##name	\
 		__used __section(__clk_of_table)		\
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index df94c24..c6eded5 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -36,7 +36,42 @@ struct ti_dt_clk {
 		.node_name = name,	\
 	}
 
+/* Maximum number of clock memmaps */
+#define CLK_MAX_MEMMAPS			4
 
+typedef void (*ti_of_clk_init_cb_t)(struct clk_hw *, struct device_node *);
+
+/**
+ * struct clk_omap_reg - OMAP register declaration
+ * @offset: offset from the master IP module base address
+ * @index: index of the master IP module
+ */
+struct clk_omap_reg {
+	u16 offset;
+	u16 index;
+};
+
+/**
+ * struct ti_clk_ll_ops - low-level register access ops for a clock
+ * @clk_readl: pointer to register read function
+ * @clk_writel: pointer to register write function
+ *
+ * Low-level register access ops are generally used by the basic clock types
+ * (clk-gate, clk-mux, clk-divider etc.) to provide support for various
+ * low-level hardware interfaces (direct MMIO, regmap etc.), but can also be
+ * used by other hardware-specific clock drivers if needed.
+ */
+struct ti_clk_ll_ops {
+	u32	(*clk_readl)(void __iomem *reg);
+	void	(*clk_writel)(u32 val, void __iomem *reg);
+};
+
+extern struct ti_clk_ll_ops *ti_clk_ll_ops;
+
+void __iomem *ti_clk_get_reg_addr(struct device_node *node, int index);
 void ti_dt_clocks_register(struct ti_dt_clk *oclks);
+void ti_dt_clk_init_provider(struct device_node *np, int index);
+int ti_clk_retry_init(struct device_node *node, struct clk_hw *hw,
+		      ti_of_clk_init_cb_t func);
 
 #endif
-- 
1.7.9.5

