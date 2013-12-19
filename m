From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv11 03/49] clk: divider: add support for registering divider clock from descriptor
Date: Thu, 19 Dec 2013 13:23:34 +0200
Message-ID: <1387452260-23276-4-git-send-email-t-kristo@ti.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38889 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752961Ab3LSLZJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Dec 2013 06:25:09 -0500
In-Reply-To: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

New clk_register_desc() call can be used to register this clock type now.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/clk-divider.c    |   34 ++++++++++++++++++++++++++++++++++
 include/linux/clk-provider.h |   23 +++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 8d3009e..8cfed5c 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -28,8 +28,12 @@
  * parent - fixed parent.  No clk_set_parent support
  */
 
+/* resolve struct clk_divider from inner struct clk_hw member */
 #define to_clk_divider(_hw) container_of(_hw, struct clk_divider, hw)
 
+/* resolve struct clk_divider_desc from inner struct clk_desc member */
+#define to_hw_desc(_desc) container_of(_desc, struct clk_divider_desc, desc)
+
 #define div_mask(d)	((1 << ((d)->width)) - 1)
 
 static unsigned int _get_table_maxdiv(const struct clk_div_table *table)
@@ -343,3 +347,33 @@ struct clk *clk_register_divider_table(struct device *dev, const char *name,
 			width, clk_divider_flags, table, lock);
 }
 EXPORT_SYMBOL_GPL(clk_register_divider_table);
+
+struct clk_hw *clk_register_divider_desc(struct device *dev,
+					 struct clk_desc *desc)
+{
+	struct clk_divider *divider;
+	struct clk_divider_desc *hw_desc;
+
+	hw_desc = to_hw_desc(desc);
+
+	/* allocate divider clock */
+	divider = kzalloc(sizeof(*divider), GFP_KERNEL);
+	if (!divider)
+		return ERR_PTR(-ENOMEM);
+
+	/* populate struct clk_divider assignments */
+	divider->reg = hw_desc->reg;
+	divider->shift = hw_desc->shift;
+	divider->width = hw_desc->width;
+	divider->flags = hw_desc->flags;
+	divider->table = hw_desc->table;
+	divider->lock = hw_desc->lock;
+
+	if (!desc->ops)
+		desc->ops = &clk_divider_ops;
+
+	desc->flags |= CLK_IS_BASIC;
+
+	return &divider->hw;
+}
+EXPORT_SYMBOL_GPL(clk_register_divider_desc);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 82dfe84..9fa279d 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -323,11 +323,34 @@ struct clk_divider {
 	spinlock_t	*lock;
 };
 
+/**
+ * struct clk_divider_desc - init descriptor for divider clock
+ *
+ * @desc:	handle between common and hardware-specific interfaces
+ * @reg:	register containing the divider
+ * @shift:	shift to the divider bit field
+ * @width:	width of the divider bit field
+ * @table:	array of value/divider pairs, last entry should have div = 0
+ * @lock:	register lock
+ */
+struct clk_divider_desc {
+	struct clk_desc	desc;
+	void __iomem	*reg;
+	u8		shift;
+	u8		width;
+	u8		flags;
+	const struct clk_div_table	*table;
+	spinlock_t	*lock;
+};
+
 #define CLK_DIVIDER_ONE_BASED		BIT(0)
 #define CLK_DIVIDER_POWER_OF_TWO	BIT(1)
 #define CLK_DIVIDER_ALLOW_ZERO		BIT(2)
 #define CLK_DIVIDER_HIWORD_MASK		BIT(3)
 
+struct clk_hw *clk_register_divider_desc(struct device *dev,
+					 struct clk_desc *desc);
+
 extern const struct clk_ops clk_divider_ops;
 struct clk *clk_register_divider(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
-- 
1.7.9.5

