From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 12/15] clk: ti: divider: add driver internal API for parsing divider data
Date: Sat, 11 Mar 2017 14:50:03 +0200
Message-ID: <1489236606-24023-13-git-send-email-t-kristo@ti.com>
References: <1489236606-24023-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1489236606-24023-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, tony@atomide.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This can be used from the divider itself, and also from the clkctrl
clocks once this is introduced.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/clk/ti/clock.h   |  4 +++
 drivers/clk/ti/divider.c | 63 +++++++++++++++++++++++++++++++-----------------
 2 files changed, 45 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index 11d3f6a..bdfdf26 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -220,6 +220,10 @@ struct clk *ti_clk_register(struct device *dev, struct clk_hw *hw,
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
index a07652e..1cc0242 100644
--- a/drivers/clk/ti/divider.c
+++ b/drivers/clk/ti/divider.c
@@ -319,20 +319,17 @@ static struct clk *_register_divider(struct device *dev, const char *name,
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
@@ -340,7 +337,7 @@ static struct clk *_register_divider(struct device *dev, const char *name,
 
 		div = 1;
 
-		while (div < setup->max_div) {
+		while (div < max_div) {
 			if (flags & CLKF_INDEX_POWER_OF_TWO)
 				div <<= 1;
 			else
@@ -349,30 +346,52 @@ static struct clk *_register_divider(struct device *dev, const char *name,
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
@@ -414,7 +433,7 @@ struct clk *ti_clk_register_divider(struct ti_clk *setup)
 	u8 width;
 	u32 flags = 0;
 	u8 div_flags = 0;
-	struct clk_div_table *table;
+	const struct clk_div_table *table;
 	struct clk *clk;
 
 	div = setup->data;
-- 
1.9.1

