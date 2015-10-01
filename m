From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] clk: ti: drop locking code from mux/divider drivers
Date: Thu, 1 Oct 2015 14:20:37 -0500
Message-ID: <1443727237-21809-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

TI's mux and divider clock drivers do not require locking and they do
not initialize internal spinlocks. This code was occasionally
copy-posted from generic mux/divider drivers. So remove it.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/clk/ti/divider.c | 16 +++-------------
 drivers/clk/ti/mux.c     | 15 +++------------
 2 files changed, 6 insertions(+), 25 deletions(-)

diff --git a/drivers/clk/ti/divider.c b/drivers/clk/ti/divider.c
index 5b17268..df25583 100644
--- a/drivers/clk/ti/divider.c
+++ b/drivers/clk/ti/divider.c
@@ -214,7 +214,6 @@ static int ti_clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct clk_divider *divider;
 	unsigned int div, value;
-	unsigned long flags = 0;
 	u32 val;
 
 	if (!hw || !rate)
@@ -228,9 +227,6 @@ static int ti_clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (value > div_mask(divider))
 		value = div_mask(divider);
 
-	if (divider->lock)
-		spin_lock_irqsave(divider->lock, flags);
-
 	if (divider->flags & CLK_DIVIDER_HIWORD_MASK) {
 		val = div_mask(divider) << (divider->shift + 16);
 	} else {
@@ -240,9 +236,6 @@ static int ti_clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 	val |= value << divider->shift;
 	ti_clk_ll_ops->clk_writel(val, divider->reg);
 
-	if (divider->lock)
-		spin_unlock_irqrestore(divider->lock, flags);
-
 	return 0;
 }
 
@@ -256,8 +249,7 @@ static struct clk *_register_divider(struct device *dev, const char *name,
 				     const char *parent_name,
 				     unsigned long flags, void __iomem *reg,
 				     u8 shift, u8 width, u8 clk_divider_flags,
-				     const struct clk_div_table *table,
-				     spinlock_t *lock)
+				     const struct clk_div_table *table)
 {
 	struct clk_divider *div;
 	struct clk *clk;
@@ -288,7 +280,6 @@ static struct clk *_register_divider(struct device *dev, const char *name,
 	div->shift = shift;
 	div->width = width;
 	div->flags = clk_divider_flags;
-	div->lock = lock;
 	div->hw.init = &init;
 	div->table = table;
 
@@ -421,7 +412,7 @@ struct clk *ti_clk_register_divider(struct ti_clk *setup)
 
 	clk = _register_divider(NULL, setup->name, div->parent,
 				flags, (void __iomem *)reg, div->bit_shift,
-				width, div_flags, table, NULL);
+				width, div_flags, table);
 
 	if (IS_ERR(clk))
 		kfree(table);
@@ -584,8 +575,7 @@ static void __init of_ti_divider_clk_setup(struct device_node *node)
 		goto cleanup;
 
 	clk = _register_divider(NULL, node->name, parent_name, flags, reg,
-				shift, width, clk_divider_flags, table,
-				NULL);
+				shift, width, clk_divider_flags, table);
 
 	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
diff --git a/drivers/clk/ti/mux.c b/drivers/clk/ti/mux.c
index 69f08a1..dab9ba8 100644
--- a/drivers/clk/ti/mux.c
+++ b/drivers/clk/ti/mux.c
@@ -69,7 +69,6 @@ static int ti_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 {
 	struct clk_mux *mux = to_clk_mux(hw);
 	u32 val;
-	unsigned long flags = 0;
 
 	if (mux->table) {
 		index = mux->table[index];
@@ -81,9 +80,6 @@ static int ti_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 			index++;
 	}
 
-	if (mux->lock)
-		spin_lock_irqsave(mux->lock, flags);
-
 	if (mux->flags & CLK_MUX_HIWORD_MASK) {
 		val = mux->mask << (mux->shift + 16);
 	} else {
@@ -93,9 +89,6 @@ static int ti_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 	val |= index << mux->shift;
 	ti_clk_ll_ops->clk_writel(val, mux->reg);
 
-	if (mux->lock)
-		spin_unlock_irqrestore(mux->lock, flags);
-
 	return 0;
 }
 
@@ -109,7 +102,7 @@ static struct clk *_register_mux(struct device *dev, const char *name,
 				 const char **parent_names, u8 num_parents,
 				 unsigned long flags, void __iomem *reg,
 				 u8 shift, u32 mask, u8 clk_mux_flags,
-				 u32 *table, spinlock_t *lock)
+				 u32 *table)
 {
 	struct clk_mux *mux;
 	struct clk *clk;
@@ -133,7 +126,6 @@ static struct clk *_register_mux(struct device *dev, const char *name,
 	mux->shift = shift;
 	mux->mask = mask;
 	mux->flags = clk_mux_flags;
-	mux->lock = lock;
 	mux->table = table;
 	mux->hw.init = &init;
 
@@ -175,7 +167,7 @@ struct clk *ti_clk_register_mux(struct ti_clk *setup)
 
 	return _register_mux(NULL, setup->name, mux->parents, mux->num_parents,
 			     flags, (void __iomem *)reg, mux->bit_shift, mask,
-			     mux_flags, NULL, NULL);
+			     mux_flags, NULL);
 }
 
 /**
@@ -227,8 +219,7 @@ static void of_mux_clk_setup(struct device_node *node)
 	mask = (1 << fls(mask)) - 1;
 
 	clk = _register_mux(NULL, node->name, parent_names, num_parents,
-			    flags, reg, shift, mask, clk_mux_flags, NULL,
-			    NULL);
+			    flags, reg, shift, mask, clk_mux_flags, NULL);
 
 	if (!IS_ERR(clk))
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
-- 
2.5.1

