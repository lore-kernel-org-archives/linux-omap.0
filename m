From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 05/11] clk: ti: divider: add support for legacy divider init
Date: Tue, 16 Dec 2014 18:20:50 +0200
Message-ID: <1418746856-17173-6-git-send-email-t-kristo@ti.com>
References: <1418746856-17173-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37486 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983AbaLPQUL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Dec 2014 11:20:11 -0500
In-Reply-To: <1418746856-17173-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, mturquette@linaro.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Legacy clock data is initialized slightly differently compared to
DT clocks, thus add support for this.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clk.c     |    3 ++
 drivers/clk/ti/clock.h   |    2 +
 drivers/clk/ti/divider.c |  132 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 136 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index 676dbf1..a0475e2 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -214,6 +214,9 @@ struct clk __init *ti_clk_register_clk(struct ti_clk *setup)
 	case TI_CLK_MUX:
 		clk = ti_clk_register_mux(setup);
 		break;
+	case TI_CLK_DIVIDER:
+		clk = ti_clk_register_divider(setup);
+		break;
 	case TI_CLK_FIXED_FACTOR:
 		fixed_factor = setup->data;
 
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index 9430dc6..fe70941 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -156,7 +156,9 @@ struct ti_clk_dpll {
 struct clk *ti_clk_register_gate(struct ti_clk *setup);
 struct clk *ti_clk_register_interface(struct ti_clk *setup);
 struct clk *ti_clk_register_mux(struct ti_clk *setup);
+struct clk *ti_clk_register_divider(struct ti_clk *setup);
 
+struct clk_hw *ti_clk_build_component_div(struct ti_clk_divider *setup);
 struct clk_hw *ti_clk_build_component_gate(struct ti_clk_gate *setup);
 struct clk_hw *ti_clk_build_component_mux(struct ti_clk_mux *setup);
 
diff --git a/drivers/clk/ti/divider.c b/drivers/clk/ti/divider.c
index bff2b5b..6211893 100644
--- a/drivers/clk/ti/divider.c
+++ b/drivers/clk/ti/divider.c
@@ -21,6 +21,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/clk/ti.h>
+#include "clock.h"
 
 #undef pr_fmt
 #define pr_fmt(fmt) "%s: " fmt, __func__
@@ -301,6 +302,134 @@ static struct clk *_register_divider(struct device *dev, const char *name,
 }
 
 static struct clk_div_table *
+_get_div_table_from_setup(struct ti_clk_divider *setup, u8 *width)
+{
+	int valid_div = 0;
+	struct clk_div_table *table;
+	int i;
+	int div;
+	u32 val;
+	u8 flags;
+
+	if (!setup->num_dividers) {
+		/* Clk divider table not provided, determine min/max divs */
+		flags = setup->flags;
+
+		if (flags & CLKF_INDEX_STARTS_AT_ONE)
+			val = 1;
+		else
+			val = 0;
+
+		div = 1;
+
+		while (div < setup->max_div) {
+			if (flags & CLKF_INDEX_POWER_OF_TWO)
+				div <<= 1;
+			else
+				div++;
+			val++;
+		}
+
+		*width = fls(val);
+
+		return NULL;
+	}
+
+	for (i = 0; i < setup->num_dividers; i++)
+		if (setup->dividers[i])
+			valid_div++;
+
+	table = kzalloc(sizeof(*table) * (valid_div + 1), GFP_KERNEL);
+	if (!table)
+		return ERR_PTR(-ENOMEM);
+
+	valid_div = 0;
+	*width = 0;
+
+	for (i = 0; i < setup->num_dividers; i++)
+		if (setup->dividers[i]) {
+			table[valid_div].div = setup->dividers[i];
+			table[valid_div].val = i;
+			valid_div++;
+			*width = i;
+		}
+
+	*width = fls(*width);
+
+	return table;
+}
+
+struct clk_hw *ti_clk_build_component_div(struct ti_clk_divider *setup)
+{
+	struct clk_divider *div;
+	struct clk_omap_reg *reg;
+
+	if (!setup)
+		return NULL;
+
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div)
+		return ERR_PTR(-ENOMEM);
+
+	reg = (struct clk_omap_reg *)&div->reg;
+	reg->index = setup->module;
+	reg->offset = setup->reg;
+
+	if (setup->flags & CLKF_INDEX_STARTS_AT_ONE)
+		div->flags |= CLK_DIVIDER_ONE_BASED;
+
+	if (setup->flags & CLKF_INDEX_POWER_OF_TWO)
+		div->flags |= CLK_DIVIDER_POWER_OF_TWO;
+
+	div->table = _get_div_table_from_setup(setup, &div->width);
+
+	div->shift = setup->bit_shift;
+
+	return &div->hw;
+}
+
+struct clk *ti_clk_register_divider(struct ti_clk *setup)
+{
+	struct ti_clk_divider *div;
+	struct clk_omap_reg *reg_setup;
+	u32 reg;
+	u8 width;
+	u32 flags = 0;
+	u8 div_flags = 0;
+	struct clk_div_table *table;
+	struct clk *clk;
+
+	div = setup->data;
+
+	reg_setup = (struct clk_omap_reg *)&reg;
+
+	reg_setup->index = div->module;
+	reg_setup->offset = div->reg;
+
+	if (div->flags & CLKF_INDEX_STARTS_AT_ONE)
+		div_flags |= CLK_DIVIDER_ONE_BASED;
+
+	if (div->flags & CLKF_INDEX_POWER_OF_TWO)
+		div_flags |= CLK_DIVIDER_POWER_OF_TWO;
+
+	if (div->flags & CLKF_SET_RATE_PARENT)
+		flags |= CLK_SET_RATE_PARENT;
+
+	table = _get_div_table_from_setup(div, &width);
+	if (IS_ERR(table))
+		return (struct clk *)table;
+
+	clk = _register_divider(NULL, setup->name, div->parent,
+				flags, (void __iomem *)reg, div->bit_shift,
+				width, div_flags, table, NULL);
+
+	if (IS_ERR(clk))
+		kfree(table);
+
+	return clk;
+}
+
+static struct clk_div_table *
 __init ti_clk_get_div_table(struct device_node *node)
 {
 	struct clk_div_table *table;
@@ -455,7 +584,8 @@ static void __init of_ti_divider_clk_setup(struct device_node *node)
 		goto cleanup;
 
 	clk = _register_divider(NULL, node->name, parent_name, flags, reg,
-				shift, width, clk_divider_flags, table, NULL);
+				shift, width, clk_divider_flags, table,
+				NULL);
 
 	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
-- 
1.7.9.5

