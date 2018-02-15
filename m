From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 4/5] clk: ti: add support for clock latching to divider clocks
Date: Thu, 15 Feb 2018 14:49:50 +0200
Message-ID: <1518698991-10099-5-git-send-email-t-kristo@ti.com>
References: <1518698991-10099-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1518698991-10099-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sboyd-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Latching the clock settings is needed with certain clocks, where
the setting is "cached" in HW before doing the actual re-programming
of the clock source. This patch adds support for clock latching to
the divider clock.

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 drivers/clk/ti/clock.h   |  1 +
 drivers/clk/ti/divider.c | 26 ++++++++++++++++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index 2f8af8f..62b108c 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -22,6 +22,7 @@ struct clk_omap_divider {
 	u8			shift;
 	u8			width;
 	u8			flags;
+	s8			latch;
 	const struct clk_div_table	*table;
 };
 
diff --git a/drivers/clk/ti/divider.c b/drivers/clk/ti/divider.c
index 77f93f6..aaa277d 100644
--- a/drivers/clk/ti/divider.c
+++ b/drivers/clk/ti/divider.c
@@ -263,6 +263,8 @@ static int ti_clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 	val |= value << divider->shift;
 	ti_clk_ll_ops->clk_writel(val, &divider->reg);
 
+	ti_clk_latch(&divider->reg, divider->latch);
+
 	return 0;
 }
 
@@ -276,7 +278,8 @@ static struct clk *_register_divider(struct device *dev, const char *name,
 				     const char *parent_name,
 				     unsigned long flags,
 				     struct clk_omap_reg *reg,
-				     u8 shift, u8 width, u8 clk_divider_flags,
+				     u8 shift, u8 width, s8 latch,
+				     u8 clk_divider_flags,
 				     const struct clk_div_table *table)
 {
 	struct clk_omap_divider *div;
@@ -305,6 +308,7 @@ static struct clk *_register_divider(struct device *dev, const char *name,
 	memcpy(&div->reg, reg, sizeof(*reg));
 	div->shift = shift;
 	div->width = width;
+	div->latch = latch;
 	div->flags = clk_divider_flags;
 	div->hw.init = &init;
 	div->table = table;
@@ -420,6 +424,7 @@ struct clk_hw *ti_clk_build_component_div(struct ti_clk_divider *setup)
 	div->table = _get_div_table_from_setup(setup, &div->width);
 
 	div->shift = setup->bit_shift;
+	div->latch = -EINVAL;
 
 	return &div->hw;
 }
@@ -452,7 +457,7 @@ struct clk *ti_clk_register_divider(struct ti_clk *setup)
 
 	clk = _register_divider(NULL, setup->name, div->parent,
 				flags, &reg, div->bit_shift,
-				width, div_flags, table);
+				width, -EINVAL, div_flags, table);
 
 	if (IS_ERR(clk))
 		kfree(table);
@@ -556,7 +561,7 @@ static int _get_divider_width(struct device_node *node,
 
 static int __init ti_clk_divider_populate(struct device_node *node,
 	struct clk_omap_reg *reg, const struct clk_div_table **table,
-	u32 *flags, u8 *div_flags, u8 *width, u8 *shift)
+	u32 *flags, u8 *div_flags, u8 *width, u8 *shift, s8 *latch)
 {
 	u32 val;
 	int ret;
@@ -570,6 +575,13 @@ static int __init ti_clk_divider_populate(struct device_node *node,
 	else
 		*shift = 0;
 
+	if (latch) {
+		if (!of_property_read_u32(node, "ti,latch-bit", &val))
+			*latch = val;
+		else
+			*latch = -EINVAL;
+	}
+
 	*flags = 0;
 	*div_flags = 0;
 
@@ -606,17 +618,18 @@ static void __init of_ti_divider_clk_setup(struct device_node *node)
 	u8 clk_divider_flags = 0;
 	u8 width = 0;
 	u8 shift = 0;
+	s8 latch = -EINVAL;
 	const struct clk_div_table *table = NULL;
 	u32 flags = 0;
 
 	parent_name = of_clk_get_parent_name(node, 0);
 
 	if (ti_clk_divider_populate(node, &reg, &table, &flags,
-				    &clk_divider_flags, &width, &shift))
+				    &clk_divider_flags, &width, &shift, &latch))
 		goto cleanup;
 
 	clk = _register_divider(NULL, node->name, parent_name, flags, &reg,
-				shift, width, clk_divider_flags, table);
+				shift, width, latch, clk_divider_flags, table);
 
 	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
@@ -639,7 +652,8 @@ static void __init of_ti_composite_divider_clk_setup(struct device_node *node)
 		return;
 
 	if (ti_clk_divider_populate(node, &div->reg, &div->table, &val,
-				    &div->flags, &div->width, &div->shift) < 0)
+				    &div->flags, &div->width, &div->shift,
+				    NULL) < 0)
 		goto cleanup;
 
 	if (!ti_clk_add_component(node, &div->hw, CLK_COMPONENT_TYPE_DIVIDER))
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
