From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv11 09/49] clk: mux: add support for low level ops
Date: Thu, 19 Dec 2013 13:23:40 +0200
Message-ID: <1387452260-23276-10-git-send-email-t-kristo@ti.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42450 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753427Ab3LSLZ1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Dec 2013 06:25:27 -0500
In-Reply-To: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Multiplexer clock can now be registered to use low level register access ops.
Preferred initialization method is via clock description.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/clk-mux.c        |   11 ++++++++---
 include/linux/clk-provider.h |    4 ++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 2cbed08..1a603f3 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -46,7 +46,7 @@ static u8 clk_mux_get_parent(struct clk_hw *hw)
 	 * OTOH, pmd_trace_clk_mux_ck uses a separate bit for each clock, so
 	 * val = 0x4 really means "bit 2, index starts at bit 0"
 	 */
-	val = clk_readl(mux->reg) >> mux->shift;
+	val = mux->ll_ops->clk_readl(mux->reg) >> mux->shift;
 	val &= mux->mask;
 
 	if (mux->table) {
@@ -93,11 +93,11 @@ static int clk_mux_set_parent(struct clk_hw *hw, u8 index)
 	if (mux->flags & CLK_MUX_HIWORD_MASK) {
 		val = mux->mask << (mux->shift + 16);
 	} else {
-		val = clk_readl(mux->reg);
+		val = mux->ll_ops->clk_readl(mux->reg);
 		val &= ~(mux->mask << mux->shift);
 	}
 	val |= index << mux->shift;
-	clk_writel(val, mux->reg);
+	mux->ll_ops->clk_writel(val, mux->reg);
 
 	if (mux->lock)
 		spin_unlock_irqrestore(mux->lock, flags);
@@ -159,6 +159,7 @@ struct clk *clk_register_mux_table(struct device *dev, const char *name,
 	mux->lock = lock;
 	mux->table = table;
 	mux->hw.init = &init;
+	mux->ll_ops = &clk_ll_ops_default;
 
 	clk = clk_register(dev, &mux->hw);
 
@@ -201,6 +202,10 @@ struct clk_hw *clk_register_mux_desc(struct device *dev, struct clk_desc *desc)
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
index 0bbf231..8b46a7b 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -407,6 +407,7 @@ struct clk *clk_register_divider_table(struct device *dev, const char *name,
  *
  * @hw:		handle between common and hardware-specific interfaces
  * @reg:	register controlling multiplexer
+ * @ll_ops:	low-level ops for accessing the register
  * @shift:	shift to multiplexer bit field
  * @width:	width of mutliplexer bit field
  * @flags:	hardware-specific flags
@@ -426,6 +427,7 @@ struct clk *clk_register_divider_table(struct device *dev, const char *name,
 struct clk_mux {
 	struct clk_hw	hw;
 	void __iomem	*reg;
+	struct clk_ll_ops	*ll_ops;
 	u32		*table;
 	u32		mask;
 	u8		shift;
@@ -438,6 +440,7 @@ struct clk_mux {
  *
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

