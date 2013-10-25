From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv9 03/43] clk: mux: add init call which supports regmap
Date: Fri, 25 Oct 2013 18:56:57 +0300
Message-ID: <1382716658-6964-4-git-send-email-t-kristo@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53302 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751963Ab3JYP6a (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Oct 2013 11:58:30 -0400
In-Reply-To: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Multiplexer clock can now be initialized to use regmap for control register
access.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/clk-mux.c        |   17 +++++++++++++++--
 include/linux/clk-provider.h |    4 ++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 68eb8c2..2cf7d59 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -113,9 +113,9 @@ const struct clk_ops clk_mux_ro_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_mux_ro_ops);
 
-struct clk *clk_register_mux_table(struct device *dev, const char *name,
+struct clk *clk_register_mux_table_regmap(struct device *dev, const char *name,
 		const char **parent_names, u8 num_parents, unsigned long flags,
-		void __iomem *reg, u8 shift, u32 mask,
+		void __iomem *reg, struct regmap *regmap, u8 shift, u32 mask,
 		u8 clk_mux_flags, u32 *table, spinlock_t *lock)
 {
 	struct clk_mux *mux;
@@ -149,6 +149,7 @@ struct clk *clk_register_mux_table(struct device *dev, const char *name,
 
 	/* struct clk_mux assignments */
 	mux->reg = reg;
+	mux->regmap = regmap;
 	mux->shift = shift;
 	mux->mask = mask;
 	mux->flags = clk_mux_flags;
@@ -163,6 +164,18 @@ struct clk *clk_register_mux_table(struct device *dev, const char *name,
 
 	return clk;
 }
+EXPORT_SYMBOL_GPL(clk_register_mux_table_regmap);
+
+struct clk *clk_register_mux_table(struct device *dev, const char *name,
+		const char **parent_names, u8 num_parents, unsigned long flags,
+		void __iomem *reg, u8 shift, u32 mask,
+		u8 clk_mux_flags, u32 *table, spinlock_t *lock)
+{
+	return clk_register_mux_table_regmap(dev, name, parent_names,
+					     num_parents, flags, reg, NULL,
+					     shift, mask, clk_mux_flags, table,
+					     lock);
+}
 EXPORT_SYMBOL_GPL(clk_register_mux_table);
 
 struct clk *clk_register_mux(struct device *dev, const char *name,
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 369d7c0..9a1423e 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -362,6 +362,10 @@ struct clk *clk_register_mux_table(struct device *dev, const char *name,
 		const char **parent_names, u8 num_parents, unsigned long flags,
 		void __iomem *reg, u8 shift, u32 mask,
 		u8 clk_mux_flags, u32 *table, spinlock_t *lock);
+struct clk *clk_register_mux_table_regmap(struct device *dev, const char *name,
+		const char **parent_names, u8 num_parents, unsigned long flags,
+		void __iomem *reg, struct regmap *regmap, u8 shift, u32 mask,
+		u8 clk_mux_flags, u32 *table, spinlock_t *lock);
 
 void of_fixed_factor_clk_setup(struct device_node *node);
 
-- 
1.7.9.5

