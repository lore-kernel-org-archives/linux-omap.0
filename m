From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv11 06/49] clk: add support for low level register ops
Date: Thu, 19 Dec 2013 13:23:37 +0200
Message-ID: <1387452260-23276-7-git-send-email-t-kristo@ti.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49916 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752852Ab3LSLZS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Dec 2013 06:25:18 -0500
In-Reply-To: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Low level register ops are needed for providing SoC or IP block specific
access routines to clock registers. Subsequent patches add support for
the low level ops for the individual clock drivers.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/clk.c            |   28 ++++++++++++++++++++++++++++
 include/linux/clk-provider.h |   13 +++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 29281f6..23a742b 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -34,6 +34,34 @@ static HLIST_HEAD(clk_root_list);
 static HLIST_HEAD(clk_orphan_list);
 static LIST_HEAD(clk_notifier_list);
 
+/**
+ * clk_readl_default - default clock register read support function
+ * @reg: register to read
+ *
+ * Default implementation for reading a clock register.
+ */
+static u32 clk_readl_default(u32 __iomem *reg)
+{
+	return readl(reg);
+}
+
+/**
+ * clk_writel_default - default clock register write support function
+ * @val: value to write
+ * @reg: register to write to
+ *
+ * Default implementation for writing a clock register.
+ */
+static void clk_writel_default(u32 val, u32 __iomem *reg)
+{
+	writel(val, reg);
+}
+
+struct clk_ll_ops clk_ll_ops_default = {
+	.clk_readl = clk_readl_default,
+	.clk_writel = clk_writel_default
+};
+
 /***           locking             ***/
 static void clk_prepare_lock(void)
 {
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 27a9765..cc5bee0 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -199,6 +199,24 @@ struct clk_hw {
 	const struct clk_init_data *init;
 };
 
+/**
+ * struct clk_ll_ops - low-level register access ops for a clock
+ *
+ * @clk_readl: pointer to register read function
+ * @clk_writel: pointer to register write function
+ *
+ * Low-level register access ops are generally used by the basic clock types
+ * (clk-gate, clk-mux, clk-divider etc.) to provide support for various
+ * low-level hardware interfaces (direct MMIO, regmap etc.), but can also be
+ * used by other hardware-specific clock drivers if needed.
+ */
+struct clk_ll_ops {
+	u32	(*clk_readl)(u32 __iomem *reg);
+	void	(*clk_writel)(u32 val, u32 __iomem *reg);
+};
+
+extern struct clk_ll_ops clk_ll_ops_default;
+
 /*
  * DOC: Basic clock implementations common to many platforms
  *
-- 
1.7.9.5

