From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 11/15] clk: ti: divider: convert TI divider clock to use its own data representation
Date: Mon, 13 Feb 2017 11:35:07 +0200
Message-ID: <1486978511-29668-12-git-send-email-t-kristo@ti.com>
References: <1486978511-29668-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1486978511-29668-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Instead of using the generic clock driver data struct, use one internal
for the TI clock driver itself. This allows modifying the register access
parts in subsequent patch.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clock.h   | 11 +++++++++++
 drivers/clk/ti/divider.c | 22 +++++++++++-----------
 drivers/clk/ti/gate.c    |  4 ++--
 3 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index 4d0ace2..0f5f6d5 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -18,6 +18,17 @@
 
 #include <linux/clkdev.h>
 
+struct clk_omap_divider {
+	struct clk_hw		hw;
+	void __iomem		*reg;
+	u8			shift;
+	u8			width;
+	u8			flags;
+	const struct clk_div_table	*table;
+};
+
+#define to_clk_omap_divider(_hw) container_of(_hw, struct clk_omap_divider, hw)
+
 struct clk_omap_mux {
 	struct clk_hw		hw;
 	void __iomem		*reg;
diff --git a/drivers/clk/ti/divider.c b/drivers/clk/ti/divider.c
index a6750f8..f33f139 100644
--- a/drivers/clk/ti/divider.c
+++ b/drivers/clk/ti/divider.c
@@ -39,7 +39,7 @@ static unsigned int _get_table_maxdiv(const struct clk_div_table *table)
 	return maxdiv;
 }
 
-static unsigned int _get_maxdiv(struct clk_divider *divider)
+static unsigned int _get_maxdiv(struct clk_omap_divider *divider)
 {
 	if (divider->flags & CLK_DIVIDER_ONE_BASED)
 		return div_mask(divider);
@@ -61,7 +61,7 @@ static unsigned int _get_table_div(const struct clk_div_table *table,
 	return 0;
 }
 
-static unsigned int _get_div(struct clk_divider *divider, unsigned int val)
+static unsigned int _get_div(struct clk_omap_divider *divider, unsigned int val)
 {
 	if (divider->flags & CLK_DIVIDER_ONE_BASED)
 		return val;
@@ -83,7 +83,7 @@ static unsigned int _get_table_val(const struct clk_div_table *table,
 	return 0;
 }
 
-static unsigned int _get_val(struct clk_divider *divider, u8 div)
+static unsigned int _get_val(struct clk_omap_divider *divider, u8 div)
 {
 	if (divider->flags & CLK_DIVIDER_ONE_BASED)
 		return div;
@@ -97,7 +97,7 @@ static unsigned int _get_val(struct clk_divider *divider, u8 div)
 static unsigned long ti_clk_divider_recalc_rate(struct clk_hw *hw,
 						unsigned long parent_rate)
 {
-	struct clk_divider *divider = to_clk_divider(hw);
+	struct clk_omap_divider *divider = to_clk_omap_divider(hw);
 	unsigned int div, val;
 
 	val = ti_clk_ll_ops->clk_readl(divider->reg) >> divider->shift;
@@ -131,7 +131,7 @@ static bool _is_valid_table_div(const struct clk_div_table *table,
 	return false;
 }
 
-static bool _is_valid_div(struct clk_divider *divider, unsigned int div)
+static bool _is_valid_div(struct clk_omap_divider *divider, unsigned int div)
 {
 	if (divider->flags & CLK_DIVIDER_POWER_OF_TWO)
 		return is_power_of_2(div);
@@ -143,7 +143,7 @@ static bool _is_valid_div(struct clk_divider *divider, unsigned int div)
 static int ti_clk_divider_bestdiv(struct clk_hw *hw, unsigned long rate,
 				  unsigned long *best_parent_rate)
 {
-	struct clk_divider *divider = to_clk_divider(hw);
+	struct clk_omap_divider *divider = to_clk_omap_divider(hw);
 	int i, bestdiv = 0;
 	unsigned long parent_rate, best = 0, now, maxdiv;
 	unsigned long parent_rate_saved = *best_parent_rate;
@@ -210,14 +210,14 @@ static long ti_clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
 static int ti_clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 				   unsigned long parent_rate)
 {
-	struct clk_divider *divider;
+	struct clk_omap_divider *divider;
 	unsigned int div, value;
 	u32 val;
 
 	if (!hw || !rate)
 		return -EINVAL;
 
-	divider = to_clk_divider(hw);
+	divider = to_clk_omap_divider(hw);
 
 	div = DIV_ROUND_UP(parent_rate, rate);
 	value = _get_val(divider, div);
@@ -249,7 +249,7 @@ static struct clk *_register_divider(struct device *dev, const char *name,
 				     u8 shift, u8 width, u8 clk_divider_flags,
 				     const struct clk_div_table *table)
 {
-	struct clk_divider *div;
+	struct clk_omap_divider *div;
 	struct clk *clk;
 	struct clk_init_data init;
 
@@ -350,7 +350,7 @@ static struct clk *_register_divider(struct device *dev, const char *name,
 
 struct clk_hw *ti_clk_build_component_div(struct ti_clk_divider *setup)
 {
-	struct clk_divider *div;
+	struct clk_omap_divider *div;
 	struct clk_omap_reg *reg;
 
 	if (!setup)
@@ -588,7 +588,7 @@ static void __init of_ti_divider_clk_setup(struct device_node *node)
 
 static void __init of_ti_composite_divider_clk_setup(struct device_node *node)
 {
-	struct clk_divider *div;
+	struct clk_omap_divider *div;
 	u32 val;
 
 	div = kzalloc(sizeof(*div), GFP_KERNEL);
diff --git a/drivers/clk/ti/gate.c b/drivers/clk/ti/gate.c
index 5ff62e2..a65f082 100644
--- a/drivers/clk/ti/gate.c
+++ b/drivers/clk/ti/gate.c
@@ -62,7 +62,7 @@
  */
 static int omap36xx_gate_clk_enable_with_hsdiv_restore(struct clk_hw *hw)
 {
-	struct clk_divider *parent;
+	struct clk_omap_divider *parent;
 	struct clk_hw *parent_hw;
 	u32 dummy_v, orig_v;
 	int ret;
@@ -72,7 +72,7 @@ static int omap36xx_gate_clk_enable_with_hsdiv_restore(struct clk_hw *hw)
 
 	/* Parent is the x2 node, get parent of parent for the m2 div */
 	parent_hw = clk_hw_get_parent(clk_hw_get_parent(hw));
-	parent = to_clk_divider(parent_hw);
+	parent = to_clk_omap_divider(parent_hw);
 
 	/* Restore the dividers */
 	if (!ret) {
-- 
1.9.1

