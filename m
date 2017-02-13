From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 12/15] clk: ti: divider: add driver internal API for parsing divider data
Date: Mon, 13 Feb 2017 11:35:08 +0200
Message-ID: <1486978511-29668-13-git-send-email-t-kristo@ti.com>
References: <1486978511-29668-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1486978511-29668-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This can be used from the divider itself, and also from the clkctrl
clocks once this is introduced.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clock.h   |  4 +++
 drivers/clk/ti/divider.c | 63 +++++++++++++++++++++++++++++++-----------------
 2 files changed, 45 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index 0f5f6d5..a85f5c0 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -222,6 +222,10 @@ struct clk *ti_clk_register(struct device *dev, struct clk_hw *hw,
 struct clk_hw *ti_clk_build_component_gate(struct ti_clk_gate *setup);
 struct clk_hw *ti_clk_build_component_mux(struct ti_clk_mux *setup);
 
+int ti_clk_parse_divider_data(int *div_table, int num_dividers, int max_div,
+			      u8 flags, u8 *width,
+			      const struct clk_div_table **table);
+
 void ti_clk_patch_legacy_clks(struct ti_clk **patch);
 struct clk *ti_clk_register_clk(struct ti_clk *setup);
 int ti_clk_register_legacy_clks(struct ti_clk_alias *clks);
diff --git a/drivers/clk/ti/divider.c b/drivers/clk/ti/divider.c
index f33f139..219bd7c 100644
--- a/drivers/clk/ti/divider.c
+++ b/drivers/clk/ti/divider.c
@@ -290,20 +290,17 @@ static struct clk *_register_divider(struct device *dev, const char *name,
 	return clk;
 }
 
-static struct clk_div_table *
-_get_div_table_from_setup(struct ti_clk_divider *setup, u8 *width)
+int ti_clk_parse_divider_data(int *div_table, int num_dividers, int max_div,
+			      u8 flags, u8 *width,
+			      const struct clk_div_table **table)
 {
 	int valid_div = 0;
-	struct clk_div_table *table;
-	int i;
-	int div;
 	u32 val;
-	u8 flags;
-
-	if (!setup->num_dividers) {
-		/* Clk divider table not provided, determine min/max divs */
-		flags = setup->flags;
+	int div;
+	int i;
+	struct clk_div_table *tmp;
 
+	if (!div_table) {
 		if (flags & CLKF_INDEX_STARTS_AT_ONE)
 			val = 1;
 		else
@@ -311,7 +308,7 @@ static struct clk *_register_divider(struct device *dev, const char *name,
 
 		div = 1;
 
-		while (div < setup->max_div) {
+		while (div < max_div) {
 			if (flags & CLKF_INDEX_POWER_OF_TWO)
 				div <<= 1;
 			else
@@ -320,30 +317,52 @@ static struct clk *_register_divider(struct device *dev, const char *name,
 		}
 
 		*width = fls(val);
+		*table = NULL;
 
-		return NULL;
+		return 0;
 	}
 
-	for (i = 0; i < setup->num_dividers; i++)
-		if (setup->dividers[i])
+	i = 0;
+
+	while (!num_dividers || i < num_dividers) {
+		if (div_table[i] == -1)
+			break;
+		if (div_table[i])
 			valid_div++;
+		i++;
+	}
 
-	table = kzalloc(sizeof(*table) * (valid_div + 1), GFP_KERNEL);
-	if (!table)
-		return ERR_PTR(-ENOMEM);
+	num_dividers = i;
+
+	tmp = kzalloc(sizeof(*tmp) * (valid_div + 1), GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
 
 	valid_div = 0;
 	*width = 0;
 
-	for (i = 0; i < setup->num_dividers; i++)
-		if (setup->dividers[i]) {
-			table[valid_div].div = setup->dividers[i];
-			table[valid_div].val = i;
+	for (i = 0; i < num_dividers; i++)
+		if (div_table[i] > 0) {
+			tmp[valid_div].div = div_table[i];
+			tmp[valid_div].val = i;
 			valid_div++;
 			*width = i;
 		}
 
 	*width = fls(*width);
+	*table = tmp;
+
+	return 0;
+}
+
+static const struct clk_div_table *
+_get_div_table_from_setup(struct ti_clk_divider *setup, u8 *width)
+{
+	const struct clk_div_table *table = NULL;
+
+	ti_clk_parse_divider_data(setup->dividers, setup->num_dividers,
+				  setup->max_div, setup->flags, width,
+				  &table);
 
 	return table;
 }
@@ -385,7 +404,7 @@ struct clk *ti_clk_register_divider(struct ti_clk *setup)
 	u8 width;
 	u32 flags = 0;
 	u8 div_flags = 0;
-	struct clk_div_table *table;
+	const struct clk_div_table *table;
 	struct clk *clk;
 
 	div = setup->data;
-- 
1.9.1

