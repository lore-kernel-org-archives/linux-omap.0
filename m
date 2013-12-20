From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv12 09/49] clk: mux: add support for low level ops
Date: Fri, 20 Dec 2013 18:34:27 +0200
Message-ID: <1387557274-22583-9-git-send-email-t-kristo@ti.com>
References: <1387557274-22583-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50854 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755810Ab3LTQfd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Dec 2013 11:35:33 -0500
In-Reply-To: <1387557274-22583-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Multiplexer clock can now be registered to use low level register access ops.
Preferred initialization method is via clock description.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/clk-mux.c        |   24 +++++++++++++++++++++---
 include/linux/clk-provider.h |    4 ++++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 2cbed08..ed3bc36 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -46,7 +46,12 @@ static u8 clk_mux_get_parent(struct clk_hw *hw)
 	 * OTOH, pmd_trace_clk_mux_ck uses a separate bit for each clock, so
 	 * val = 0x4 really means "bit 2, index starts at bit 0"
 	 */
-	val = clk_readl(mux->reg) >> mux->shift;
+	if (mux->ll_ops)
+		val = mux->ll_ops->clk_readl(mux->reg);
+	else
+		val = clk_readl(mux->reg);
+
+	val >>= mux->shift;
 	val &= mux->mask;
 
 	if (mux->table) {
@@ -93,11 +98,19 @@ static int clk_mux_set_parent(struct clk_hw *hw, u8 index)
 	if (mux->flags & CLK_MUX_HIWORD_MASK) {
 		val = mux->mask << (mux->shift + 16);
 	} else {
-		val = clk_readl(mux->reg);
+		if (mux->ll_ops)
+			val = mux->ll_ops->clk_readl(mux->reg);
+		else
+			val = clk_readl(mux->reg);
+
 		val &= ~(mux->mask << mux->shift);
 	}
 	val |= index << mux->shift;
-	clk_writel(val, mux->reg);
+
+	if (mux->ll_ops)
+		mux->ll_ops->clk_writel(val, mux->reg);
+	else
+		clk_writel(val, mux->reg);
 
 	if (mux->lock)
 		spin_unlock_irqrestore(mux->lock, flags);
@@ -159,6 +172,7 @@ struct clk *clk_register_mux_table(struct device *dev, const char *name,
 	mux->lock = lock;
 	mux->table = table;
 	mux->hw.init = &init;
+	mux->ll_ops = &clk_ll_ops_default;
 
 	clk = clk_register(dev, &mux->hw);
 
@@ -201,6 +215,10 @@ struct clk_hw *clk_register_mux_desc(struct device *dev, struct clk_desc *desc)
 	mux->shift = hw_desc->shift;
 	mux->flags = hw_desc->flags;
 	mux->lock = hw_desc->lock;
+	mux->ll_ops = hw_desc->ll_ops;
+
+	if (!mux->ll_ops)
+		mux->ll_ops = &clk_ll_ops_default;
 
 	if (!desc->ops) {
 		if (mux->flags & CLK_MUX_READ_ONLY)
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 3923d46..629163c 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -408,6 +408,7 @@ struct clk *clk_register_divider_table(struct device *dev, const char *name,
  *
  * @hw:		handle between common and hardware-specific interfaces
  * @reg:	register controlling multiplexer
+ * @ll_ops:	low-level ops for accessing the register
  * @shift:	shift to multiplexer bit field
  * @width:	width of mutliplexer bit field
  * @flags:	hardware-specific flags
@@ -427,6 +428,7 @@ struct clk *clk_register_divider_table(struct device *dev, const char *name,
 struct clk_mux {
 	struct clk_hw	hw;
 	void __iomem	*reg;
+	struct clk_ll_ops	*ll_ops;
 	u32		*table;
 	u32		mask;
 	u8		shift;
@@ -438,6 +440,7 @@ struct clk_mux {
  * struct clk_mux_desc - init descriptor for multiplexer clock
  * @desc:	handle between common and hardware-specific interfaces
  * @reg:	register controlling multiplexer
+ * @ll_ops:	low-level ops for accesing the register
  * @shift:	shift to multiplexer bit field
  * @width:	width of multiplexer bit field
  * @flags:	hardware-specific flags
@@ -446,6 +449,7 @@ struct clk_mux {
 struct clk_mux_desc {
 	struct clk_desc	desc;
 	void __iomem	*reg;
+	struct clk_ll_ops	*ll_ops;
 	u32		*table;
 	u32		mask;
 	u8		shift;
-- 
1.7.9.5

