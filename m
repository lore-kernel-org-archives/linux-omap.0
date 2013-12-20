From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv12 06/49] clk: add support for low level register ops
Date: Fri, 20 Dec 2013 18:34:24 +0200
Message-ID: <1387557274-22583-6-git-send-email-t-kristo@ti.com>
References: <1387557274-22583-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51652 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755789Ab3LTQf3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Dec 2013 11:35:29 -0500
In-Reply-To: <1387557274-22583-1-git-send-email-t-kristo@ti.com>
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
 include/linux/clk-provider.h |   17 +++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 29281f6..8bcd1e0 100644
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
+static u32 clk_readl_default(void __iomem *reg)
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
+static void clk_writel_default(u32 val, void __iomem *reg)
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
index a4f14ae..671dff4 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -198,6 +198,23 @@ struct clk_hw {
 	const struct clk_init_data *init;
 };
 
+/**
+ * struct clk_ll_ops - low-level register access ops for a clock
+ * @clk_readl: pointer to register read function
+ * @clk_writel: pointer to register write function
+ *
+ * Low-level register access ops are generally used by the basic clock types
+ * (clk-gate, clk-mux, clk-divider etc.) to provide support for various
+ * low-level hardware interfaces (direct MMIO, regmap etc.), but can also be
+ * used by other hardware-specific clock drivers if needed.
+ */
+struct clk_ll_ops {
+	u32	(*clk_readl)(void __iomem *reg);
+	void	(*clk_writel)(u32 val, void __iomem *reg);
+};
+
+extern struct clk_ll_ops clk_ll_ops_default;
+
 /*
  * DOC: Basic clock implementations common to many platforms
  *
-- 
1.7.9.5

