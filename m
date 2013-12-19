From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv11 05/49] clk: gate: add support for registering gate clock from descriptor
Date: Thu, 19 Dec 2013 13:23:36 +0200
Message-ID: <1387452260-23276-6-git-send-email-t-kristo@ti.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38894 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752852Ab3LSLZN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Dec 2013 06:25:13 -0500
In-Reply-To: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

New clk_register_desc() call can be used to register this clock type now.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/clk-gate.c       |   31 +++++++++++++++++++++++++++++++
 include/linux/clk-provider.h |   19 +++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index 4a58c55..3ec61d2 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -26,8 +26,12 @@
  * parent - fixed parent.  No clk_set_parent support
  */
 
+/* resolve struct clk_gate from inner struct clk_hw member */
 #define to_clk_gate(_hw) container_of(_hw, struct clk_gate, hw)
 
+/* resolve struct clk_gate_desc from inner struct clk_desc member */
+#define to_hw_desc(_desc) container_of(_desc, struct clk_gate_desc, desc)
+
 /*
  * It works on following logic:
  *
@@ -162,3 +166,30 @@ struct clk *clk_register_gate(struct device *dev, const char *name,
 	return clk;
 }
 EXPORT_SYMBOL_GPL(clk_register_gate);
+
+struct clk_hw *clk_register_gate_desc(struct device *dev, struct clk_desc *desc)
+{
+	struct clk_gate *gate;
+	struct clk_gate_desc *hw_desc;
+
+	hw_desc = to_hw_desc(desc);
+
+	/* allocate mux clock */
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		return ERR_PTR(-ENOMEM);
+
+	/* populate struct clk_gate assignments */
+	gate->reg = hw_desc->reg;
+	gate->bit_idx = hw_desc->bit_idx;
+	gate->flags = hw_desc->flags;
+	gate->lock = hw_desc->lock;
+
+	if (!desc->ops)
+		desc->ops = &clk_gate_ops;
+
+	desc->flags |= CLK_IS_BASIC;
+
+	return &gate->hw;
+}
+EXPORT_SYMBOL_GPL(clk_register_gate_desc);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 7dd6842..27a9765 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -269,10 +269,29 @@ struct clk_gate {
 	spinlock_t	*lock;
 };
 
+/**
+ * struct clk_gate_desc - init descriptor for gating clock
+ *
+ * @desc:	handle between common and hardware-specific interfaces
+ * @reg:	register controlling gate
+ * @bit_idx:	single bit controlling gate
+ * @flags:	hardware-specific flags
+ * @lock:	register lock
+ */
+struct clk_gate_desc {
+	struct clk_desc	desc;
+	void __iomem	*reg;
+	u8		bit_idx;
+	u8		flags;
+	spinlock_t	*lock;
+};
+
 #define CLK_GATE_SET_TO_DISABLE		BIT(0)
 #define CLK_GATE_HIWORD_MASK		BIT(1)
 
 extern const struct clk_ops clk_gate_ops;
+struct clk_hw *clk_register_gate_desc(struct device *dev,
+				      struct clk_desc *desc);
 struct clk *clk_register_gate(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 bit_idx,
-- 
1.7.9.5

