From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 03/11] CLK: divider: fix table parsing logic for DT
Date: Wed, 19 Jun 2013 16:18:54 +0300
Message-ID: <1371647942-4811-4-git-send-email-t-kristo@ti.com>
References: <1371647942-4811-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46965 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756739Ab3FSNTr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Jun 2013 09:19:47 -0400
In-Reply-To: <1371647942-4811-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, mturquette@linaro.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

The existing implementation had a couple of bugs:

1) table_size was attempted to read improperly, it has to be calculated
   from the 'len' parameter of a property
2) Reading the integer entries from the table was reading only first
   two entries of the DT data

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/clk-divider.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 3413602..2fa7932 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -325,15 +325,18 @@ struct clk *clk_register_divider_table(struct device *dev, const char *name,
 struct clk_div_table *of_clk_get_div_table(struct device_node *node)
 {
 	int i;
-	int table_size = 0;
+	u32 table_size;
 	struct clk_div_table *table;
-	u32 pair[2];
+	const __be32 *tablespec;
+	u32 val;
 
-	table_size = of_count_phandle_with_args(node, "table", "#clock-cells");
+	tablespec = of_get_property(node, "table", &table_size);
 
-	if (table_size < 1)
+	if (!tablespec)
 		return NULL;
 
+	table_size /= sizeof(struct clk_div_table);
+
 	table = kzalloc(sizeof(struct clk_div_table) * table_size, GFP_KERNEL);
 	if (!table) {
 		pr_err("%s: unable to allocate memory for %s table\n", __func__, node->name);
@@ -341,10 +344,10 @@ struct clk_div_table *of_clk_get_div_table(struct device_node *node)
 	}
 
 	for (i = 0; i < table_size; i++) {
-		if (!of_property_read_u32_array(node, "table", pair, ARRAY_SIZE(pair))) {
-			table[i].val = pair[0];
-			table[i].div = pair[1];
-		}
+		of_property_read_u32_index(node, "table", i * 2, &val);
+		table[i].div = val;
+		of_property_read_u32_index(node, "table", i * 2 + 1, &val);
+		table[i].val = val;
 	}
 
 	return table;
-- 
1.7.9.5

