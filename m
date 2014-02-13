From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 2/4] clk: add support for default-rate
Date: Thu, 13 Feb 2014 11:00:46 +0200
Message-ID: <1392282048-6284-3-git-send-email-t-kristo@ti.com>
References: <1392282048-6284-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55186 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753423AbaBMJBb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Feb 2014 04:01:31 -0500
In-Reply-To: <1392282048-6284-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

default-rate property can now be used to set initial rates for clocks.
This is added by default for all clocks which get initialized through
of_clk_init().

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../devicetree/bindings/clock/clock-bindings.txt   |    9 ++
 drivers/clk/clk.c                                  |   86 ++++++++++++++++++++
 include/linux/clk-provider.h                       |    2 +
 3 files changed, 97 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/clock-bindings.txt b/Documentation/devicetree/bindings/clock/clock-bindings.txt
index 7c52c29..d676112 100644
--- a/Documentation/devicetree/bindings/clock/clock-bindings.txt
+++ b/Documentation/devicetree/bindings/clock/clock-bindings.txt
@@ -44,6 +44,15 @@ For example:
   clocks by index. The names should reflect the clock output signal
   names for the device.
 
+default-rate:	Sets the rate of the clock during boot to the provided
+		rate.
+
+For example:
+
+    clk-divider {
+        default-rate = <1000000>;
+    };
+
 ==Clock consumers==
 
 Required properties:
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 5517944..cb144e4 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2526,6 +2526,89 @@ const char *of_clk_get_parent_name(struct device_node *np, int index)
 }
 EXPORT_SYMBOL_GPL(of_clk_get_parent_name);
 
+static LIST_HEAD(clk_init_info_list);
+
+struct clk_init_info {
+	struct device_node *node;
+	struct clk *clk;
+	u32 rate;
+	struct list_head link;
+	struct list_head sort_link;
+};
+
+int __init of_clk_parse_init_rate(struct device_node *node, struct clk *clk)
+{
+	u32 rate;
+	struct clk_init_info *cinfo;
+
+	if (of_property_read_u32(node, "default-rate", &rate))
+		return 0;
+
+	cinfo = kzalloc(sizeof(*cinfo), GFP_KERNEL);
+	if (!cinfo)
+		return -ENOMEM;
+
+	cinfo->node = node;
+	cinfo->clk = clk;
+	cinfo->rate = rate;
+	list_add(&cinfo->link, &clk_init_info_list);
+	INIT_LIST_HEAD(&cinfo->sort_link);
+
+	return 0;
+}
+
+int __init of_clk_set_init_rates(void)
+{
+	struct clk_init_info *cinfo, *tmp;
+	struct of_phandle_args clkspec;
+	int ret = 0;
+	struct list_head sorted_list;
+	struct clk *clk;
+
+	INIT_LIST_HEAD(&sorted_list);
+
+	list_for_each_entry(cinfo, &clk_init_info_list, link) {
+		/* Get missing clk pointers */
+		if (!cinfo->clk) {
+			clkspec.np = cinfo->node;
+			cinfo->clk = of_clk_get_from_provider(&clkspec);
+		}
+
+		/* Check if we are the parent of any of the sorted clocks */
+		list_for_each_entry(tmp, &sorted_list, sort_link) {
+			clk = tmp->clk;
+			while (clk && clk != cinfo->clk)
+				clk = clk->parent;
+
+			if (clk == cinfo->clk) {
+				/* Add us before this node in the list */
+				list_add_tail(&cinfo->sort_link,
+					      &tmp->sort_link);
+				break;
+			}
+		}
+
+		if (list_empty(&cinfo->sort_link))
+			list_add_tail(&cinfo->sort_link, &sorted_list);
+	}
+
+	/* Process sorted list and set clk rates */
+	list_for_each_entry_safe(cinfo, tmp, &sorted_list, sort_link) {
+		int r = clk_set_rate(cinfo->clk, cinfo->rate);
+		if (r) {
+			pr_err("%s: clk_set_rate for %s failed: %d\n", __func__,
+			       cinfo->node->name, ret);
+			ret = r;
+		}
+
+		/* Clean up the static list */
+		list_del(&cinfo->link);
+		kfree(cinfo);
+	}
+
+	return ret;
+}
+
 /**
  * of_clk_init() - Scan and init clock providers from the DT
  * @matches: array of compatible values and init functions for providers.
@@ -2544,6 +2627,9 @@ void __init of_clk_init(const struct of_device_id *matches)
 	for_each_matching_node_and_match(np, matches, &match) {
 		of_clk_init_cb_t clk_init_cb = match->data;
 		clk_init_cb(np);
+		of_clk_parse_init_rate(np, NULL);
 	}
+
+	of_clk_set_init_rates();
 }
 #endif
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 939533d..1bbd194 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -506,6 +506,8 @@ struct clk *of_clk_src_simple_get(struct of_phandle_args *clkspec,
 struct clk *of_clk_src_onecell_get(struct of_phandle_args *clkspec, void *data);
 int of_clk_get_parent_count(struct device_node *np);
 const char *of_clk_get_parent_name(struct device_node *np, int index);
+int of_clk_parse_init_rate(struct device_node *node, struct clk *clk);
+int of_clk_set_init_rates(void);
 
 void of_clk_init(const struct of_device_id *matches);
 
-- 
1.7.9.5

