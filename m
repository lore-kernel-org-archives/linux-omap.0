From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] clk: ti: fix linker error with !SOC_OMAP4
Date: Wed, 19 Apr 2017 23:43:10 +0200
Message-ID: <20170419214318.1605787-1-arnd@arndb.de>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Richard Watts <rrw@kynesim.co.uk>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

When none of the OMAP4-generation SoCs are enabled, we run into a link
error for am43xx/am43xx:

drivers/clk/ti/dpll.o: In function `of_ti_am3_dpll_x2_setup':
dpll.c:(.init.text+0xd8): undefined reference to `clkhwops_omap4_dpllmx'

This is easily fixed by adding another #ifdef.

While looking at the code, I also spotted another problem with the
assignment of hw_ops variable that is not used again later. I'm
changing this to setting clk_hw->ops instead, which I guess is what
was intended here.

Fixes: 0565fb168d63 ("clk: ti: dpll: move omap3 DPLL functionality to clock driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/ti/dpll.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
index 96d84888c6c5..fcf297fd2233 100644
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -312,7 +312,6 @@ static void _register_dpll_x2(struct device_node *node,
 	struct clk_hw_omap *clk_hw;
 	const char *name = node->name;
 	const char *parent_name;
-	int ret;
 
 	parent_name = of_clk_get_parent_name(node, 0);
 	if (!parent_name) {
@@ -332,16 +331,21 @@ static void _register_dpll_x2(struct device_node *node,
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
 
+#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
+        defined(CONFIG_SOC_DRA7XX)
 	if (hw_ops == &clkhwops_omap4_dpllmx) {
+		int ret;
+
 		/* Check if register defined, if not, drop hw-ops */
 		ret = of_property_count_elems_of_size(node, "reg", 1);
 		if (ret <= 0) {
-			hw_ops = NULL;
+			clk_hw->ops = NULL;
 		} else if (ti_clk_get_reg_addr(node, 0, &clk_hw->clksel_reg)) {
 			kfree(clk_hw);
 			return;
 		}
 	}
+#endif
 
 	/* register the clock */
 	clk = ti_clk_register(NULL, &clk_hw->hw, name);
-- 
2.9.0

