From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 06/15] clk: ti: use automatic clock alias generation framework
Date: Tue, 18 Oct 2016 18:45:59 +0300
Message-ID: <1476805568-19264-7-git-send-email-t-kristo@ti.com>
References: <1476805568-19264-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1476805568-19264-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, tony@atomide.com, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Generate clock aliases automatically for all TI clock drivers.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/apll.c         |  2 +-
 drivers/clk/ti/clk-dra7-atl.c | 11 ++++++++++-
 drivers/clk/ti/clk.c          | 20 +++++++++++++++-----
 drivers/clk/ti/composite.c    | 16 +++++++++++++++-
 drivers/clk/ti/divider.c      |  2 +-
 drivers/clk/ti/dpll.c         |  6 +++---
 drivers/clk/ti/fixed-factor.c |  1 +
 drivers/clk/ti/gate.c         |  2 +-
 drivers/clk/ti/interface.c    |  2 +-
 drivers/clk/ti/mux.c          |  2 +-
 10 files changed, 49 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/ti/apll.c b/drivers/clk/ti/apll.c
index 6411e13..62b5db7 100644
--- a/drivers/clk/ti/apll.c
+++ b/drivers/clk/ti/apll.c
@@ -164,7 +164,7 @@ static void __init omap_clk_register_apll(struct clk_hw *hw,
 
 	ad->clk_bypass = __clk_get_hw(clk);
 
-	clk = clk_register(NULL, &clk_hw->hw);
+	clk = ti_clk_register(NULL, &clk_hw->hw, node->name);
 	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
 		kfree(clk_hw->hw.init->parent_names);
diff --git a/drivers/clk/ti/clk-dra7-atl.c b/drivers/clk/ti/clk-dra7-atl.c
index c773332..265b115a2 100644
--- a/drivers/clk/ti/clk-dra7-atl.c
+++ b/drivers/clk/ti/clk-dra7-atl.c
@@ -24,6 +24,9 @@
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/clk/ti.h>
+
+#include "clock.h"
 
 #define DRA7_ATL_INSTANCES	4
 
@@ -171,6 +174,7 @@ static void __init of_dra7_atl_clock_setup(struct device_node *node)
 	struct clk_init_data init = { NULL };
 	const char **parent_names = NULL;
 	struct clk *clk;
+	int ret;
 
 	clk_hw = kzalloc(sizeof(*clk_hw), GFP_KERNEL);
 	if (!clk_hw) {
@@ -200,9 +204,14 @@ static void __init of_dra7_atl_clock_setup(struct device_node *node)
 
 	init.parent_names = parent_names;
 
-	clk = clk_register(NULL, &clk_hw->hw);
+	clk = ti_clk_register(NULL, &clk_hw->hw, node->name);
 
 	if (!IS_ERR(clk)) {
+		ret = ti_clk_add_alias(NULL, clk, node->name);
+		if (ret) {
+			clk_unregister(clk);
+			goto cleanup;
+		}
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
 		kfree(parent_names);
 		return;
diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index 7fd9d8e..f526f0d 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -298,6 +298,7 @@ struct clk __init *ti_clk_register_clk(struct ti_clk *setup)
 	struct ti_clk_fixed *fixed;
 	struct ti_clk_fixed_factor *fixed_factor;
 	struct clk_hw *clk_hw;
+	int ret;
 
 	if (setup->clk)
 		return setup->clk;
@@ -308,6 +309,13 @@ struct clk __init *ti_clk_register_clk(struct ti_clk *setup)
 
 		clk = clk_register_fixed_rate(NULL, setup->name, NULL, 0,
 					      fixed->frequency);
+		if (!IS_ERR(clk)) {
+			ret = ti_clk_add_alias(NULL, clk, setup->name);
+			if (ret) {
+				clk_unregister(clk);
+				clk = ERR_PTR(ret);
+			}
+		}
 		break;
 	case TI_CLK_MUX:
 		clk = ti_clk_register_mux(setup);
@@ -325,6 +333,13 @@ struct clk __init *ti_clk_register_clk(struct ti_clk *setup)
 						fixed_factor->parent,
 						0, fixed_factor->mult,
 						fixed_factor->div);
+		if (!IS_ERR(clk)) {
+			ret = ti_clk_add_alias(NULL, clk, setup->name);
+			if (ret) {
+				clk_unregister(clk);
+				clk = ERR_PTR(ret);
+			}
+		}
 		break;
 	case TI_CLK_GATE:
 		clk = ti_clk_register_gate(setup);
@@ -387,9 +402,6 @@ int __init ti_clk_register_legacy_clks(struct ti_clk_alias *clks)
 				 */
 				goto add_aliases;
 			}
-		} else {
-			clks->lk.clk = clk;
-			clkdev_add(&clks->lk);
 		}
 		clks++;
 	}
@@ -412,8 +424,6 @@ int __init ti_clk_register_legacy_clks(struct ti_clk_alias *clks)
 				}
 			} else {
 				retry = true;
-				retry_clk->lk.clk = clk;
-				clkdev_add(&retry_clk->lk);
 				list_del(&retry_clk->link);
 			}
 		}
diff --git a/drivers/clk/ti/composite.c b/drivers/clk/ti/composite.c
index 1cf70f4..3f60f99 100644
--- a/drivers/clk/ti/composite.c
+++ b/drivers/clk/ti/composite.c
@@ -126,6 +126,7 @@ struct clk *ti_clk_register_composite(struct ti_clk *setup)
 	int num_parents = 1;
 	const char **parent_names = NULL;
 	struct clk *clk;
+	int ret;
 
 	comp = setup->data;
 
@@ -150,6 +151,12 @@ struct clk *ti_clk_register_composite(struct ti_clk *setup)
 				     &ti_composite_divider_ops, gate,
 				     &ti_composite_gate_ops, 0);
 
+	ret = ti_clk_add_alias(NULL, clk, setup->name);
+	if (ret) {
+		clk_unregister(clk);
+		return ERR_PTR(ret);
+	}
+
 	return clk;
 }
 #endif
@@ -163,6 +170,7 @@ static void __init _register_composite(struct clk_hw *hw,
 	int num_parents = 0;
 	const char **parent_names = NULL;
 	int i;
+	int ret;
 
 	/* Check for presence of each component clock */
 	for (i = 0; i < CLK_COMPONENT_TYPE_MAX; i++) {
@@ -217,8 +225,14 @@ static void __init _register_composite(struct clk_hw *hw,
 				     _get_hw(cclk, CLK_COMPONENT_TYPE_GATE),
 				     &ti_composite_gate_ops, 0);
 
-	if (!IS_ERR(clk))
+	if (!IS_ERR(clk)) {
+		ret = ti_clk_add_alias(NULL, clk, node->name);
+		if (ret) {
+			clk_unregister(clk);
+			goto cleanup;
+		}
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	}
 
 cleanup:
 	/* Free component clock list entries */
diff --git a/drivers/clk/ti/divider.c b/drivers/clk/ti/divider.c
index b4e5de1..a6750f8 100644
--- a/drivers/clk/ti/divider.c
+++ b/drivers/clk/ti/divider.c
@@ -282,7 +282,7 @@ static struct clk *_register_divider(struct device *dev, const char *name,
 	div->table = table;
 
 	/* register the clock */
-	clk = clk_register(dev, &div->hw);
+	clk = ti_clk_register(dev, &div->hw, name);
 
 	if (IS_ERR(clk))
 		kfree(div);
diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
index 9fc8754..2c3c83e 100644
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -173,7 +173,7 @@ static void __init _register_dpll(struct clk_hw *hw,
 	dd->clk_bypass = __clk_get_hw(clk);
 
 	/* register the clock */
-	clk = clk_register(NULL, &clk_hw->hw);
+	clk = ti_clk_register(NULL, &clk_hw->hw, node->name);
 
 	if (!IS_ERR(clk)) {
 		omap2_init_clk_hw_omap_clocks(&clk_hw->hw);
@@ -276,7 +276,7 @@ struct clk *ti_clk_register_dpll(struct ti_clk *setup)
 	if (dpll->flags & CLKF_J_TYPE)
 		dd->flags |= DPLL_J_TYPE;
 
-	clk = clk_register(NULL, &clk_hw->hw);
+	clk = ti_clk_register(NULL, &clk_hw->hw, setup->name);
 
 	if (!IS_ERR(clk))
 		return clk;
@@ -328,7 +328,7 @@ static void _register_dpll_x2(struct device_node *node,
 	init.num_parents = 1;
 
 	/* register the clock */
-	clk = clk_register(NULL, &clk_hw->hw);
+	clk = ti_clk_register(NULL, &clk_hw->hw, name);
 
 	if (IS_ERR(clk)) {
 		kfree(clk_hw);
diff --git a/drivers/clk/ti/fixed-factor.c b/drivers/clk/ti/fixed-factor.c
index 3cd4067..0174a51 100644
--- a/drivers/clk/ti/fixed-factor.c
+++ b/drivers/clk/ti/fixed-factor.c
@@ -62,6 +62,7 @@ static void __init of_ti_fixed_factor_clk_setup(struct device_node *node)
 	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
 		of_ti_clk_autoidle_setup(node);
+		ti_clk_add_alias(NULL, clk, clk_name);
 	}
 }
 CLK_OF_DECLARE(ti_fixed_factor_clk, "ti,fixed-factor-clock",
diff --git a/drivers/clk/ti/gate.c b/drivers/clk/ti/gate.c
index bc05f27..b3291db 100644
--- a/drivers/clk/ti/gate.c
+++ b/drivers/clk/ti/gate.c
@@ -120,7 +120,7 @@ static struct clk *_register_gate(struct device *dev, const char *name,
 
 	init.flags = flags;
 
-	clk = clk_register(NULL, &clk_hw->hw);
+	clk = ti_clk_register(NULL, &clk_hw->hw, name);
 
 	if (IS_ERR(clk))
 		kfree(clk_hw);
diff --git a/drivers/clk/ti/interface.c b/drivers/clk/ti/interface.c
index e505e6f..7927e1a 100644
--- a/drivers/clk/ti/interface.c
+++ b/drivers/clk/ti/interface.c
@@ -58,7 +58,7 @@ static struct clk *_register_interface(struct device *dev, const char *name,
 	init.num_parents = 1;
 	init.parent_names = &parent_name;
 
-	clk = clk_register(NULL, &clk_hw->hw);
+	clk = ti_clk_register(NULL, &clk_hw->hw, name);
 
 	if (IS_ERR(clk))
 		kfree(clk_hw);
diff --git a/drivers/clk/ti/mux.c b/drivers/clk/ti/mux.c
index 57ff471..774098e 100644
--- a/drivers/clk/ti/mux.c
+++ b/drivers/clk/ti/mux.c
@@ -127,7 +127,7 @@ static struct clk *_register_mux(struct device *dev, const char *name,
 	mux->table = table;
 	mux->hw.init = &init;
 
-	clk = clk_register(dev, &mux->hw);
+	clk = ti_clk_register(dev, &mux->hw, name);
 
 	if (IS_ERR(clk))
 		kfree(mux);
-- 
1.9.1

