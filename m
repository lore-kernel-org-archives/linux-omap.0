From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 05/33] CLK: omap: add DT duplicate clock registration mechanism
Date: Tue, 23 Jul 2013 10:20:00 +0300
Message-ID: <1374564028-11352-6-git-send-email-t-kristo@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48622 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753722Ab3GWHWJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Jul 2013 03:22:09 -0400
In-Reply-To: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, nm@ti.com, rnayak@ti.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Some devices require their clocks to be available with a specific
dev-id con-id mapping. With DT, the clocks can be found by default
only with their name, or alternatively through the device node of
the consumer. With drivers, that don't support DT fully yet, add
mechanism to register specific clock names.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/omap/clk.c   |   39 +++++++++++++++++++++++++++++++++++++++
 include/linux/clk/omap.h |   17 +++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/clk/omap/clk.c b/drivers/clk/omap/clk.c
index 1dafdaa..cd31a81 100644
--- a/drivers/clk/omap/clk.c
+++ b/drivers/clk/omap/clk.c
@@ -32,6 +32,45 @@ static const struct of_device_id clk_match[] = {
 	{},
 };
 
+ /**
+ * omap_dt_clocks_register - register DT duplicate clocks during boot
+ * @oclks: list of clocks to register
+ * @cnt: number of clocks
+ *
+ * Register duplicate or non-standard DT clock entries during boot. By
+ * default, DT clocks are found based on their node name. If any
+ * additional con-id / dev-id -> clock mapping is required, use this
+ * function to list these.
+ */
+void __init omap_dt_clocks_register(struct omap_dt_clk oclks[], int cnt)
+{
+	struct omap_dt_clk *c;
+	struct device_node *n;
+	struct clk *clk;
+	struct of_phandle_args clkspec;
+
+	for (c = oclks; c < oclks + cnt; c++) {
+		n = of_find_node_by_name(NULL, c->node_name);
+
+		if (!n) {
+			pr_err("%s: %s not found!\n", __func__, c->node_name);
+			continue;
+		}
+
+		clkspec.np = n;
+
+		clk = of_clk_get_from_provider(&clkspec);
+
+		if (!clk) {
+			pr_err("%s: %s has no clock!\n", __func__,
+				c->node_name);
+			continue;
+		}
+		c->lk.clk = clk;
+		clkdev_add(&c->lk);
+	}
+}
+
 /* FIXME - need to initialize early; skip real driver registration & probe */
 int __init dt_omap_clk_init(void)
 {
diff --git a/include/linux/clk/omap.h b/include/linux/clk/omap.h
index cba892a..c39e775 100644
--- a/include/linux/clk/omap.h
+++ b/include/linux/clk/omap.h
@@ -19,6 +19,8 @@
 #ifndef __LINUX_CLK_OMAP_H_
 #define __LINUX_CLK_OMAP_H_
 
+#include <linux/clkdev.h>
+
 /**
  * struct dpll_data - DPLL registers and integration data
  * @mult_div1_reg: register containing the DPLL M and N bitfields
@@ -146,6 +148,20 @@ struct clk_hw_omap_ops {
 	void			(*deny_idle)(struct clk_hw_omap *oclk);
 };
 
+struct omap_dt_clk {
+	struct clk_lookup		lk;
+	const char			*node_name;
+};
+
+#define DT_CLK(dev, con, name)		\
+	{				\
+		.lk = {			\
+			.dev_id = dev,	\
+			.con_id = con,	\
+		},			\
+		.node_name = name,	\
+	}
+
 void omap2_init_clk_hw_omap_clocks(struct clk *clk);
 int omap3_noncore_dpll_enable(struct clk_hw *hw);
 void omap3_noncore_dpll_disable(struct clk_hw *hw);
@@ -174,6 +190,7 @@ extern const struct clk_hw_omap_ops clkhwops_omap4_dpllmx;
 
 /* DT functions */
 int dt_omap_clk_init(void);
+extern void omap_dt_clocks_register(struct omap_dt_clk *oclks, int cnt);
 void of_omap4_dpll_setup(struct device_node *node);
 
 #endif
-- 
1.7.9.5

