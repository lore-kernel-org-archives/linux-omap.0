From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv9 06/43] CLK: ti: add init support for clock IP blocks
Date: Fri, 25 Oct 2013 18:57:00 +0300
Message-ID: <1382716658-6964-7-git-send-email-t-kristo@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40929 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313Ab3JYP6j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Oct 2013 11:58:39 -0400
In-Reply-To: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

ti_dt_clk_init_provider() can now be used to initialize the contents of
a single clock IP block. This parses all the clocks under the IP block
and calls the corresponding init function for them.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clk.c   |   59 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk/ti.h |    1 +
 2 files changed, 60 insertions(+)

diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index ad58b01..7f030d7 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -19,6 +19,9 @@
 #include <linux/clkdev.h>
 #include <linux/clk/ti.h>
 #include <linux/of.h>
+#include <linux/list.h>
+
+extern struct of_device_id __clk_of_table[];
 
 /**
  * ti_dt_clocks_register - register DT duplicate clocks during boot
@@ -50,3 +53,59 @@ void __init ti_dt_clocks_register(struct ti_dt_clk oclks[])
 		}
 	}
 }
+
+typedef int (*ti_of_clk_init_cb_t)(struct device_node *, struct regmap *);
+
+struct clk_init_item {
+	struct regmap *regmap;
+	struct device_node *np;
+	ti_of_clk_init_cb_t init_cb;
+	struct list_head node;
+};
+
+static LIST_HEAD(retry_list);
+
+void __init ti_dt_clk_init_provider(struct device_node *parent,
+				    struct regmap *regmap)
+{
+	const struct of_device_id *match;
+	struct device_node *np;
+	ti_of_clk_init_cb_t clk_init_cb;
+	struct clk_init_item *retry;
+	struct clk_init_item *tmp;
+	int ret;
+
+	for_each_child_of_node(parent, np) {
+		match = of_match_node(__clk_of_table, np);
+		if (!match)
+			continue;
+		clk_init_cb = match->data;
+		pr_debug("%s: initializing: %s\n", __func__, np->name);
+		ret = clk_init_cb(np, regmap);
+		if (ret == -EAGAIN) {
+			pr_debug("%s: adding to again list...\n", np->name);
+			retry = kzalloc(sizeof(*retry), GFP_KERNEL);
+			retry->np = np;
+			retry->regmap = regmap;
+			retry->init_cb = clk_init_cb;
+			list_add(&retry->node, &retry_list);
+		} else if (ret) {
+			pr_err("%s: clock init failed for %s (%d)!\n", __func__,
+			       np->name, ret);
+		}
+	}
+
+	list_for_each_entry_safe(retry, tmp, &retry_list, node) {
+		pr_debug("%s: retry-init: %s\n", __func__, retry->np->name);
+		ret = retry->init_cb(retry->np, retry->regmap);
+		if (ret == -EAGAIN) {
+			pr_debug("%s failed again?\n", retry->np->name);
+		} else {
+			if (ret)
+				pr_err("%s: clock init failed for %s (%d)!\n",
+				       __func__, retry->np->name, ret);
+			list_del(&retry->node);
+			kfree(retry);
+		}
+	}
+}
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 9786752..7ab02fa 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -177,6 +177,7 @@ int omap3_dpll4_set_rate(struct clk_hw *clk, unsigned long rate,
 			 unsigned long parent_rate);
 
 void ti_dt_clocks_register(struct ti_dt_clk *oclks);
+void ti_dt_clk_init_provider(struct device_node *np, struct regmap *regmap);
 
 extern const struct clk_hw_omap_ops clkhwops_omap3_dpll;
 extern const struct clk_hw_omap_ops clkhwops_omap4_dpllmx;
-- 
1.7.9.5

