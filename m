From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv9 02/43] clk: divider: add init call which supports regmap
Date: Fri, 25 Oct 2013 18:56:56 +0300
Message-ID: <1382716658-6964-3-git-send-email-t-kristo@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40937 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361Ab3JYP6n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Oct 2013 11:58:43 -0400
In-Reply-To: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Divider clock can now be initialized to use regmap for control register
access.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/clk-divider.c    |   37 ++++++++++++++++++++++++++++++++-----
 include/linux/clk-provider.h |    6 ++++++
 2 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 9c17b1a..3767879 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -251,7 +251,7 @@ EXPORT_SYMBOL_GPL(clk_divider_ops);
 
 static struct clk *_register_divider(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
-		void __iomem *reg, u8 shift, u8 width,
+		void __iomem *reg, struct regmap *regmap, u8 shift, u8 width,
 		u8 clk_divider_flags, const struct clk_div_table *table,
 		spinlock_t *lock)
 {
@@ -281,6 +281,7 @@ static struct clk *_register_divider(struct device *dev, const char *name,
 
 	/* struct clk_divider assignments */
 	div->reg = reg;
+	div->regmap = regmap;
 	div->shift = shift;
 	div->width = width;
 	div->flags = clk_divider_flags;
@@ -314,8 +315,8 @@ struct clk *clk_register_divider(struct device *dev, const char *name,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags, spinlock_t *lock)
 {
-	return _register_divider(dev, name, parent_name, flags, reg, shift,
-			width, clk_divider_flags, NULL, lock);
+	return _register_divider(dev, name, parent_name, flags, reg, NULL,
+			shift, width, clk_divider_flags, NULL, lock);
 }
 EXPORT_SYMBOL_GPL(clk_register_divider);
 
@@ -339,7 +340,33 @@ struct clk *clk_register_divider_table(struct device *dev, const char *name,
 		u8 clk_divider_flags, const struct clk_div_table *table,
 		spinlock_t *lock)
 {
-	return _register_divider(dev, name, parent_name, flags, reg, shift,
-			width, clk_divider_flags, table, lock);
+	return _register_divider(dev, name, parent_name, flags, reg, NULL,
+			shift, width, clk_divider_flags, table, lock);
 }
 EXPORT_SYMBOL_GPL(clk_register_divider_table);
+
+/**
+ * clk_register_divider_table_regmap - register a table based divider clock
+ * with the clock framework
+ * @dev: device registering this clock
+ * @name: name of this clock
+ * @parent_name: name of clock's parent
+ * @flags: framework-specific flags
+ * @reg: register address to adjust divider
+ * @regmap: regmap for accessing the divider register (if any)
+ * @shift: number of bits to shift the bitfield
+ * @width: width of the bitfield
+ * @clk_divider_flags: divider-specific flags for this clock
+ * @table: array of divider/value pairs ending with a div set to 0
+ * @lock: shared register lock for this clock
+ */
+struct clk *clk_register_divider_table_regmap(struct device *dev,
+		const char *name, const char *parent_name, unsigned long flags,
+		void __iomem *reg, struct regmap *regmap, u8 shift, u8 width,
+		u8 clk_divider_flags, const struct clk_div_table *table,
+		spinlock_t *lock)
+{
+	return _register_divider(dev, name, parent_name, flags, reg, regmap,
+			shift, width, clk_divider_flags, table, lock);
+}
+EXPORT_SYMBOL_GPL(clk_register_divider_table_regmap);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 63ff78c..369d7c0 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -306,12 +306,18 @@ struct clk *clk_register_divider_table(struct device *dev, const char *name,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags, const struct clk_div_table *table,
 		spinlock_t *lock);
+struct clk *clk_register_divider_table_regmap(struct device *dev,
+		const char *name, const char *parent_name, unsigned long flags,
+		void __iomem *reg, struct regmap *regmap, u8 shift, u8 width,
+		u8 clk_divider_flags, const struct clk_div_table *table,
+		spinlock_t *lock);
 
 /**
  * struct clk_mux - multiplexer clock
  *
  * @hw:		handle between common and hardware-specific interfaces
  * @reg:	register controlling multiplexer
+ * @regmap:	regmap for accessing the mux register (if any)
  * @shift:	shift to multiplexer bit field
  * @width:	width of mutliplexer bit field
  * @flags:	hardware-specific flags
-- 
1.7.9.5

