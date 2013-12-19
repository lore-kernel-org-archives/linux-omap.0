From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv11 08/49] clk: gate: add support for low level ops
Date: Thu, 19 Dec 2013 13:23:39 +0200
Message-ID: <1387452260-23276-9-git-send-email-t-kristo@ti.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56728 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753308Ab3LSLZZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Dec 2013 06:25:25 -0500
In-Reply-To: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Gate clock can now be registered to use low level register access ops.
Preferred initialization method is via clock description.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/clk-gate.c       |   11 ++++++++---
 include/linux/clk-provider.h |    4 ++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index 3ec61d2..18731b4 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -62,7 +62,7 @@ static void clk_gate_endisable(struct clk_hw *hw, int enable)
 		if (set)
 			reg |= BIT(gate->bit_idx);
 	} else {
-		reg = clk_readl(gate->reg);
+		reg = gate->ll_ops->clk_readl(gate->reg);
 
 		if (set)
 			reg |= BIT(gate->bit_idx);
@@ -70,7 +70,7 @@ static void clk_gate_endisable(struct clk_hw *hw, int enable)
 			reg &= ~BIT(gate->bit_idx);
 	}
 
-	clk_writel(reg, gate->reg);
+	gate->ll_ops->clk_writel(reg, gate->reg);
 
 	if (gate->lock)
 		spin_unlock_irqrestore(gate->lock, flags);
@@ -93,7 +93,7 @@ static int clk_gate_is_enabled(struct clk_hw *hw)
 	u32 reg;
 	struct clk_gate *gate = to_clk_gate(hw);
 
-	reg = clk_readl(gate->reg);
+	reg = gate->ll_ops->clk_readl(gate->reg);
 
 	/* if a set bit disables this clk, flip it before masking */
 	if (gate->flags & CLK_GATE_SET_TO_DISABLE)
@@ -157,6 +157,7 @@ struct clk *clk_register_gate(struct device *dev, const char *name,
 	gate->flags = clk_gate_flags;
 	gate->lock = lock;
 	gate->hw.init = &init;
+	gate->ll_ops = &clk_ll_ops_default;
 
 	clk = clk_register(dev, &gate->hw);
 
@@ -184,6 +185,10 @@ struct clk_hw *clk_register_gate_desc(struct device *dev, struct clk_desc *desc)
 	gate->bit_idx = hw_desc->bit_idx;
 	gate->flags = hw_desc->flags;
 	gate->lock = hw_desc->lock;
+	gate->ll_ops = hw_desc->ll_ops;
+
+	if (!gate->ll_ops)
+		gate->ll_ops = &clk_ll_ops_default;
 
 	if (!desc->ops)
 		desc->ops = &clk_gate_ops;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 3a88346..0bbf231 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -259,6 +259,7 @@ void of_fixed_clk_setup(struct device_node *np);
  *
  * @hw:		handle between common and hardware-specific interfaces
  * @reg:	register controlling gate
+ * @ll_ops:	low-level ops for accessing the register
  * @bit_idx:	single bit controlling gate
  * @flags:	hardware-specific flags
  * @lock:	register lock
@@ -277,6 +278,7 @@ void of_fixed_clk_setup(struct device_node *np);
 struct clk_gate {
 	struct clk_hw hw;
 	void __iomem	*reg;
+	struct clk_ll_ops	*ll_ops;
 	u8		bit_idx;
 	u8		flags;
 	spinlock_t	*lock;
@@ -287,6 +289,7 @@ struct clk_gate {
  *
  * @desc:	handle between common and hardware-specific interfaces
  * @reg:	register controlling gate
+ * @ll_ops:	low-level ops for accessing the register
  * @bit_idx:	single bit controlling gate
  * @flags:	hardware-specific flags
  * @lock:	register lock
@@ -294,6 +297,7 @@ struct clk_gate {
 struct clk_gate_desc {
 	struct clk_desc	desc;
 	void __iomem	*reg;
+	struct clk_ll_ops	*ll_ops;
 	u8		bit_idx;
 	u8		flags;
 	spinlock_t	*lock;
-- 
1.7.9.5

