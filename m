From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 14/15] clk: ti: dpll44xx: fix clksel register initialization
Date: Sat, 11 Mar 2017 14:50:05 +0200
Message-ID: <1489236606-24023-15-git-send-email-t-kristo@ti.com>
References: <1489236606-24023-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1489236606-24023-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, tony@atomide.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

clksel register pointer should be used for the DPLL-MX autoidle handling.
Currently this is not setup at all. Fix by adding proper handling for the
register.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/clk/ti/dpll.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
index c149bd1..778bc90 100644
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -319,6 +319,7 @@ static void _register_dpll_x2(struct device_node *node,
 	struct clk_hw_omap *clk_hw;
 	const char *name = node->name;
 	const char *parent_name;
+	int ret;
 
 	parent_name = of_clk_get_parent_name(node, 0);
 	if (!parent_name) {
@@ -338,6 +339,20 @@ static void _register_dpll_x2(struct device_node *node,
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
 
+	if (hw_ops == &clkhwops_omap4_dpllmx) {
+		/* Check if register defined, if not, drop hw-ops */
+		ret = of_property_count_elems_of_size(node, "reg", 1);
+		if (ret <= 0) {
+			hw_ops = NULL;
+		} else {
+			clk_hw->clksel_reg = ti_clk_get_reg_addr(node, 0);
+			if (IS_ERR(clk_hw->clksel_reg)) {
+				kfree(clk_hw);
+				return;
+			}
+		}
+	}
+
 	/* register the clock */
 	clk = ti_clk_register(NULL, &clk_hw->hw, name);
 
-- 
1.9.1

