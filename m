From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 03/15] clk: ti: add API for creating aliases automatically for simple clock types
Date: Mon, 13 Feb 2017 11:34:59 +0200
Message-ID: <1486978511-29668-4-git-send-email-t-kristo@ti.com>
References: <1486978511-29668-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1486978511-29668-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This API generates clock aliases automatically for simple clock types
(fixed-clock, fixed-factor-clock), so that we don't need to add the data
for these statically into tables. Shall be called from the SoC specific
clock init.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clk.c   | 26 ++++++++++++++++++++++++++
 drivers/clk/ti/clock.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index 91bad55..193862e 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -355,6 +355,12 @@ struct clk __init *ti_clk_register_clk(struct ti_clk *setup)
 	return clk;
 }
 
+static const struct of_device_id simple_clk_match_table[] __initconst = {
+	{ .compatible = "fixed-clock" },
+	{ .compatible = "fixed-factor-clock" },
+	{ }
+};
+
 int __init ti_clk_register_legacy_clks(struct ti_clk_alias *clks)
 {
 	struct clk *clk;
@@ -409,6 +415,26 @@ int __init ti_clk_register_legacy_clks(struct ti_clk_alias *clks)
 #endif
 
 /**
+ * ti_clk_add_aliases - setup clock aliases
+ *
+ * Sets up any missing clock aliases. No return value.
+ */
+void __init ti_clk_add_aliases(void)
+{
+	struct device_node *np;
+	struct clk *clk;
+
+	for_each_matching_node(np, simple_clk_match_table) {
+		struct of_phandle_args clkspec;
+
+		clkspec.np = np;
+		clk = of_clk_get_from_provider(&clkspec);
+
+		ti_clk_add_alias(NULL, clk, np->name);
+	}
+}
+
+/**
  * ti_clk_setup_features - setup clock features flags
  * @features: features definition to use
  *
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index ac95fda..05381a3 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -194,6 +194,7 @@ struct ti_dt_clk {
 struct clk *ti_clk_register(struct device *dev, struct clk_hw *hw,
 			    const char *con);
 int ti_clk_add_alias(struct device *dev, struct clk *clk, const char *con);
+void ti_clk_add_aliases(void);
 
 struct clk_hw *ti_clk_build_component_div(struct ti_clk_divider *setup);
 struct clk_hw *ti_clk_build_component_gate(struct ti_clk_gate *setup);
-- 
1.9.1

