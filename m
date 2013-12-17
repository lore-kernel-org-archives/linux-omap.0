From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv10 01/41] clk: add support for platform specific clock
 I/O wrapper functions
Date: Tue, 17 Dec 2013 12:34:45 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1312171212170.14039@utopia.booyaka.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com> <1385453182-24421-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:55176 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929Ab3LQMeq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Dec 2013 07:34:46 -0500
In-Reply-To: <1385453182-24421-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Tue, 26 Nov 2013, Tero Kristo wrote:

> Current clock wrappers assume simple and direct mapped hardware register
> access. Improve this support by adding functionality for registering
> platform specific clock I/O wrappers, which can be used to support
> various features needed like endianess conversions, indexed regmap support,
> etc. Default I/O wrapper provided also which uses the existing direct
> I/O mapped behavior.

I think it makes more sense to define per-SoC register read and write 
functions, for the same reason that I think it makes more sense to define 
clock data as part of the IP blocks that contain the clocks' registers.  
The register read and write functions should be implemented by the drivers 
for the IP blocks that the clocks are contained in.  That way the register 
read and write functions can take whatever steps are necessary to ensure 
that the IP block registers are accessible before performing the 
read/write; can implement non-MMIO register accesses if needed; and can 
operate on register offsets, rather than absolute addresses.

Something like the following draft implementation.  Also needed would be a 
way for clock providers that rely on the common clock providers (e.g., 
divider, mux, etc.) to pass in the struct clk_ll_ops pointer.  I guess the 
simplest way to implement this would be to add another set of registration 
functions - e.g., clk_register_divider_ipb() or clk_register_divider2() or 
something similar.  These functions would be similar to 
clk_register_divider(), but would take a pointer to a struct clk_ll_ops 
and pass that along to the CCF core.


- Paul

---
 drivers/clk/clk-divider.c    |  6 +++---
 drivers/clk/clk-gate.c       |  6 +++---
 drivers/clk/clk-mux.c        |  6 +++---
 drivers/clk/clk.c            | 18 ++++++++++++++++++
 include/linux/clk-provider.h | 28 +++++++++++++---------------
 5 files changed, 40 insertions(+), 24 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 8d3009e44fba..55ad7170a6e2 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -104,7 +104,7 @@ static unsigned long clk_divider_recalc_rate(struct clk_hw *hw,
 	struct clk_divider *divider = to_clk_divider(hw);
 	unsigned int div, val;
 
-	val = clk_readl(divider->reg) >> divider->shift;
+	val = hw->ll_ops->clk_readl(divider->reg) >> divider->shift;
 	val &= div_mask(divider);
 
 	div = _get_div(divider, val);
@@ -230,11 +230,11 @@ static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (divider->flags & CLK_DIVIDER_HIWORD_MASK) {
 		val = div_mask(divider) << (divider->shift + 16);
 	} else {
-		val = clk_readl(divider->reg);
+		val = hw->ll_ops->clk_readl(divider->reg);
 		val &= ~(div_mask(divider) << divider->shift);
 	}
 	val |= value << divider->shift;
-	clk_writel(val, divider->reg);
+	hw->ll_ops->clk_writel(val, divider->reg);
 
 	if (divider->lock)
 		spin_unlock_irqrestore(divider->lock, flags);
diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index 4a58c55255bd..a60177c7f418 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -58,7 +58,7 @@ static void clk_gate_endisable(struct clk_hw *hw, int enable)
 		if (set)
 			reg |= BIT(gate->bit_idx);
 	} else {
-		reg = clk_readl(gate->reg);
+		reg = hw->ll_ops->clk_readl(gate->reg);
 
 		if (set)
 			reg |= BIT(gate->bit_idx);
@@ -66,7 +66,7 @@ static void clk_gate_endisable(struct clk_hw *hw, int enable)
 			reg &= ~BIT(gate->bit_idx);
 	}
 
-	clk_writel(reg, gate->reg);
+	hw->ll_ops->clk_writel(reg, gate->reg);
 
 	if (gate->lock)
 		spin_unlock_irqrestore(gate->lock, flags);
@@ -89,7 +89,7 @@ static int clk_gate_is_enabled(struct clk_hw *hw)
 	u32 reg;
 	struct clk_gate *gate = to_clk_gate(hw);
 
-	reg = clk_readl(gate->reg);
+	reg = hw->ll_ops->clk_readl(gate->reg);
 
 	/* if a set bit disables this clk, flip it before masking */
 	if (gate->flags & CLK_GATE_SET_TO_DISABLE)
diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 4f96ff3ba728..5b808ef5a47b 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -42,7 +42,7 @@ static u8 clk_mux_get_parent(struct clk_hw *hw)
 	 * OTOH, pmd_trace_clk_mux_ck uses a separate bit for each clock, so
 	 * val = 0x4 really means "bit 2, index starts at bit 0"
 	 */
-	val = clk_readl(mux->reg) >> mux->shift;
+	val = hw->ll_ops->clk_readl(mux->reg) >> mux->shift;
 	val &= mux->mask;
 
 	if (mux->table) {
@@ -89,11 +89,11 @@ static int clk_mux_set_parent(struct clk_hw *hw, u8 index)
 	if (mux->flags & CLK_MUX_HIWORD_MASK) {
 		val = mux->mask << (mux->shift + 16);
 	} else {
-		val = clk_readl(mux->reg);
+		val = hw->ll_ops->clk_readl(mux->reg);
 		val &= ~(mux->mask << mux->shift);
 	}
 	val |= index << mux->shift;
-	clk_writel(val, mux->reg);
+	hw->ll_ops->clk_writel(val, mux->reg);
 
 	if (mux->lock)
 		spin_unlock_irqrestore(mux->lock, flags);
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 2cf2ea6b77a1..7f9596469765 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -20,6 +20,7 @@
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/sched.h>
+#include <linux/io.h>
 
 static DEFINE_SPINLOCK(enable_lock);
 static DEFINE_MUTEX(prepare_lock);
@@ -1819,6 +1820,21 @@ struct clk *__clk_register(struct device *dev, struct clk_hw *hw)
 }
 EXPORT_SYMBOL_GPL(__clk_register);
 
+static u32 clk_readl(u32 __iomem *reg)
+{
+	return readl(reg);
+}
+
+static void clk_writel(u32 val, u32 __iomem *reg)
+{
+	writel(val, reg);
+}
+
+static const struct clk_ll_ops clk_ll_ops_default = {
+	.clk_readl = clk_readl,
+	.clk_writel = clk_writel,
+};
+
 static int _clk_register(struct device *dev, struct clk_hw *hw, struct clk *clk)
 {
 	int i, ret;
@@ -1831,6 +1847,8 @@ static int _clk_register(struct device *dev, struct clk_hw *hw, struct clk *clk)
 	}
 	clk->ops = hw->init->ops;
 	clk->hw = hw;
+	if (!clk->hw->ll_ops)
+		clk->hw->ll_ops = &clk_ll_ops_default;
 	clk->flags = hw->init->flags;
 	clk->num_parents = hw->init->num_parents;
 	hw->clk = clk;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 7e59253b8603..1adbc81a3deb 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -143,6 +143,16 @@ struct clk_ops {
 };
 
 /**
+ * struct clk_ll_ops - low-level register operations on the clock's IP block
+ * @clk_readl: fn ptr to a register read function
+ * @clk_writel: fn ptr to a register write function
+ */
+struct clk_ll_ops {
+	u32		(*clk_readl)(u32 __iomem *reg);
+	void		(*clk_writel)(u32 val, u32 __iomem *reg);
+};
+
+/**
  * struct clk_init_data - holds init data that's common to all clocks and is
  * shared between the clock provider and the common clock framework.
  *
@@ -171,10 +181,13 @@ struct clk_init_data {
  *
  * @init: pointer to struct clk_init_data that contains the init data shared
  * with the common clock framework.
+ *
+ * @ll_ops: low-level operations provided by the clock's driver (readl, writel)
  */
 struct clk_hw {
 	struct clk *clk;
 	const struct clk_init_data *init;
+	const struct clk_ll_ops *ll_ops;
 };
 
 /*
@@ -507,20 +520,5 @@ static inline const char *of_clk_get_parent_name(struct device_node *np,
 	{ while (0); }
 #endif /* CONFIG_OF */
 
-/*
- * wrap access to peripherals in accessor routines
- * for improved portability across platforms
- */
-
-static inline u32 clk_readl(u32 __iomem *reg)
-{
-	return readl(reg);
-}
-
-static inline void clk_writel(u32 val, u32 __iomem *reg)
-{
-	writel(val, reg);
-}
-
 #endif /* CONFIG_COMMON_CLK */
 #endif /* CLK_PROVIDER_H */
-- 
1.8.5.1

