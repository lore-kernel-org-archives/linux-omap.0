From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv9 01/43] clk: Add support for regmap register read/write
Date: Fri, 25 Oct 2013 18:56:55 +0300
Message-ID: <1382716658-6964-2-git-send-email-t-kristo@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37531 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751284Ab3JYP6Y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Oct 2013 11:58:24 -0400
In-Reply-To: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Previously, only direct register read/write was supported. Now a per-clock
regmap can be provided for same purpose, which allows the clock drivers
to access clock registers behind e.g. I2C bus.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/clk-divider.c    |    6 +++---
 drivers/clk/clk-gate.c       |    6 +++---
 drivers/clk/clk-mux.c        |    6 +++---
 include/linux/clk-provider.h |   23 +++++++++++++++++++----
 4 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 8d3009e..9c17b1a 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -104,7 +104,7 @@ static unsigned long clk_divider_recalc_rate(struct clk_hw *hw,
 	struct clk_divider *divider = to_clk_divider(hw);
 	unsigned int div, val;
 
-	val = clk_readl(divider->reg) >> divider->shift;
+	val = clk_readl(divider->reg, divider->regmap) >> divider->shift;
 	val &= div_mask(divider);
 
 	div = _get_div(divider, val);
@@ -230,11 +230,11 @@ static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (divider->flags & CLK_DIVIDER_HIWORD_MASK) {
 		val = div_mask(divider) << (divider->shift + 16);
 	} else {
-		val = clk_readl(divider->reg);
+		val = clk_readl(divider->reg, divider->regmap);
 		val &= ~(div_mask(divider) << divider->shift);
 	}
 	val |= value << divider->shift;
-	clk_writel(val, divider->reg);
+	clk_writel(val, divider->reg, divider->regmap);
 
 	if (divider->lock)
 		spin_unlock_irqrestore(divider->lock, flags);
diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index 4a58c55..3c7f686 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -58,7 +58,7 @@ static void clk_gate_endisable(struct clk_hw *hw, int enable)
 		if (set)
 			reg |= BIT(gate->bit_idx);
 	} else {
-		reg = clk_readl(gate->reg);
+		reg = clk_readl(gate->reg, gate->regmap);
 
 		if (set)
 			reg |= BIT(gate->bit_idx);
@@ -66,7 +66,7 @@ static void clk_gate_endisable(struct clk_hw *hw, int enable)
 			reg &= ~BIT(gate->bit_idx);
 	}
 
-	clk_writel(reg, gate->reg);
+	clk_writel(reg, gate->reg, gate->regmap);
 
 	if (gate->lock)
 		spin_unlock_irqrestore(gate->lock, flags);
@@ -89,7 +89,7 @@ static int clk_gate_is_enabled(struct clk_hw *hw)
 	u32 reg;
 	struct clk_gate *gate = to_clk_gate(hw);
 
-	reg = clk_readl(gate->reg);
+	reg = clk_readl(gate->reg, gate->regmap);
 
 	/* if a set bit disables this clk, flip it before masking */
 	if (gate->flags & CLK_GATE_SET_TO_DISABLE)
diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 4f96ff3..68eb8c2 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -42,7 +42,7 @@ static u8 clk_mux_get_parent(struct clk_hw *hw)
 	 * OTOH, pmd_trace_clk_mux_ck uses a separate bit for each clock, so
 	 * val = 0x4 really means "bit 2, index starts at bit 0"
 	 */
-	val = clk_readl(mux->reg) >> mux->shift;
+	val = clk_readl(mux->reg, mux->regmap) >> mux->shift;
 	val &= mux->mask;
 
 	if (mux->table) {
@@ -89,11 +89,11 @@ static int clk_mux_set_parent(struct clk_hw *hw, u8 index)
 	if (mux->flags & CLK_MUX_HIWORD_MASK) {
 		val = mux->mask << (mux->shift + 16);
 	} else {
-		val = clk_readl(mux->reg);
+		val = clk_readl(mux->reg, mux->regmap);
 		val &= ~(mux->mask << mux->shift);
 	}
 	val |= index << mux->shift;
-	clk_writel(val, mux->reg);
+	clk_writel(val, mux->reg, mux->regmap);
 
 	if (mux->lock)
 		spin_unlock_irqrestore(mux->lock, flags);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 7e59253..63ff78c 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -13,6 +13,7 @@
 
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/regmap.h>
 
 #ifdef CONFIG_COMMON_CLK
 
@@ -209,6 +210,7 @@ void of_fixed_clk_setup(struct device_node *np);
  *
  * @hw:		handle between common and hardware-specific interfaces
  * @reg:	register controlling gate
+ * @regmap:	regmap for accessing the gate register (if any)
  * @bit_idx:	single bit controlling gate
  * @flags:	hardware-specific flags
  * @lock:	register lock
@@ -227,6 +229,7 @@ void of_fixed_clk_setup(struct device_node *np);
 struct clk_gate {
 	struct clk_hw hw;
 	void __iomem	*reg;
+	struct regmap	*regmap;
 	u8		bit_idx;
 	u8		flags;
 	spinlock_t	*lock;
@@ -251,6 +254,7 @@ struct clk_div_table {
  *
  * @hw:		handle between common and hardware-specific interfaces
  * @reg:	register containing the divider
+ * @regmap:	regmap for accessing the divider register (if any)
  * @shift:	shift to the divider bit field
  * @width:	width of the divider bit field
  * @table:	array of value/divider pairs, last entry should have div = 0
@@ -279,6 +283,7 @@ struct clk_div_table {
 struct clk_divider {
 	struct clk_hw	hw;
 	void __iomem	*reg;
+	struct regmap	*regmap;
 	u8		shift;
 	u8		width;
 	u8		flags;
@@ -326,6 +331,7 @@ struct clk *clk_register_divider_table(struct device *dev, const char *name,
 struct clk_mux {
 	struct clk_hw	hw;
 	void __iomem	*reg;
+	struct regmap	*regmap;
 	u32		*table;
 	u32		mask;
 	u8		shift;
@@ -512,14 +518,23 @@ static inline const char *of_clk_get_parent_name(struct device_node *np,
  * for improved portability across platforms
  */
 
-static inline u32 clk_readl(u32 __iomem *reg)
+static inline u32 clk_readl(u32 __iomem *reg, struct regmap *regmap)
 {
-	return readl(reg);
+	u32 val;
+
+	if (regmap)
+		regmap_read(regmap, (u32)reg, &val);
+	else
+		val = readl(reg);
+	return val;
 }
 
-static inline void clk_writel(u32 val, u32 __iomem *reg)
+static inline void clk_writel(u32 val, u32 __iomem *reg, struct regmap *regmap)
 {
-	writel(val, reg);
+	if (regmap)
+		regmap_write(regmap, (u32)reg, val);
+	else
+		writel(val, reg);
 }
 
 #endif /* CONFIG_COMMON_CLK */
-- 
1.7.9.5

