From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv11 04/49] clk: mux: add support for registering mux clock from descriptor
Date: Thu, 19 Dec 2013 13:23:35 +0200
Message-ID: <1387452260-23276-5-git-send-email-t-kristo@ti.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38888 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752852Ab3LSLZJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Dec 2013 06:25:09 -0500
In-Reply-To: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

New clk_register_desc() call can be used to register this clock type now.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/clk-mux.c        |   37 +++++++++++++++++++++++++++++++++++++
 include/linux/clk-provider.h |   21 +++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 4f96ff3..2cbed08 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -27,8 +27,12 @@
  * parent - parent is adjustable through clk_set_parent
  */
 
+/* resolve struct clk_mux from inner struct clk_hw member */
 #define to_clk_mux(_hw) container_of(_hw, struct clk_mux, hw)
 
+/* resolve struct clk_mux_desc from inner struct clk_desc member */
+#define to_hw_desc(_desc) container_of(_desc, struct clk_mux_desc, desc)
+
 static u8 clk_mux_get_parent(struct clk_hw *hw)
 {
 	struct clk_mux *mux = to_clk_mux(hw);
@@ -177,3 +181,36 @@ struct clk *clk_register_mux(struct device *dev, const char *name,
 				      NULL, lock);
 }
 EXPORT_SYMBOL_GPL(clk_register_mux);
+
+struct clk_hw *clk_register_mux_desc(struct device *dev, struct clk_desc *desc)
+{
+	struct clk_mux *mux;
+	struct clk_mux_desc *hw_desc;
+
+	hw_desc = to_hw_desc(desc);
+
+	/* allocate mux clock */
+	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		return ERR_PTR(-ENOMEM);
+
+	/* populate struct clk_mux assignments */
+	mux->reg = hw_desc->reg;
+	mux->table = hw_desc->table;
+	mux->mask = hw_desc->mask;
+	mux->shift = hw_desc->shift;
+	mux->flags = hw_desc->flags;
+	mux->lock = hw_desc->lock;
+
+	if (!desc->ops) {
+		if (mux->flags & CLK_MUX_READ_ONLY)
+			desc->ops = &clk_mux_ro_ops;
+		else
+			desc->ops = &clk_mux_ops;
+	}
+
+	desc->flags |= CLK_IS_BASIC;
+
+	return &mux->hw;
+}
+EXPORT_SYMBOL_GPL(clk_register_mux_desc);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 9fa279d..7dd6842 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -393,6 +393,26 @@ struct clk_mux {
 	spinlock_t	*lock;
 };
 
+/**
+ * struct clk_mux_desc - init descriptor for multiplexer clock
+ *
+ * @desc:	handle between common and hardware-specific interfaces
+ * @reg:	register controlling multiplexer
+ * @shift:	shift to multiplexer bit field
+ * @width:	width of multiplexer bit field
+ * @flags:	hardware-specific flags
+ * @lock:	register lock
+ */
+struct clk_mux_desc {
+	struct clk_desc	desc;
+	void __iomem	*reg;
+	u32		*table;
+	u32		mask;
+	u8		shift;
+	u8		flags;
+	spinlock_t	*lock;
+};
+
 #define CLK_MUX_INDEX_ONE		BIT(0)
 #define CLK_MUX_INDEX_BIT		BIT(1)
 #define CLK_MUX_HIWORD_MASK		BIT(2)
@@ -401,6 +421,7 @@ struct clk_mux {
 extern const struct clk_ops clk_mux_ops;
 extern const struct clk_ops clk_mux_ro_ops;
 
+struct clk_hw *clk_register_mux_desc(struct device *dev, struct clk_desc *desc);
 struct clk *clk_register_mux(struct device *dev, const char *name,
 		const char **parent_names, u8 num_parents, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
-- 
1.7.9.5

