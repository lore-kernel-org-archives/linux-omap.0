From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 07/11] clk: ti: composite: add support for legacy composite clock init
Date: Tue, 16 Dec 2014 18:20:52 +0200
Message-ID: <1418746856-17173-8-git-send-email-t-kristo@ti.com>
References: <1418746856-17173-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37485 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750976AbaLPQUK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Dec 2014 11:20:10 -0500
In-Reply-To: <1418746856-17173-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, mturquette@linaro.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Legacy clock data is initialized slightly differently compared to
DT clocks, thus add support for this.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clk.c       |    3 +++
 drivers/clk/ti/clock.h     |    1 +
 drivers/clk/ti/composite.c |   46 ++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index f41a757..546dae4 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -217,6 +217,9 @@ struct clk __init *ti_clk_register_clk(struct ti_clk *setup)
 	case TI_CLK_DIVIDER:
 		clk = ti_clk_register_divider(setup);
 		break;
+	case TI_CLK_COMPOSITE:
+		clk = ti_clk_register_composite(setup);
+		break;
 	case TI_CLK_FIXED_FACTOR:
 		fixed_factor = setup->data;
 
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index f4e8eb2..8d9c603 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -157,6 +157,7 @@ struct clk *ti_clk_register_gate(struct ti_clk *setup);
 struct clk *ti_clk_register_interface(struct ti_clk *setup);
 struct clk *ti_clk_register_mux(struct ti_clk *setup);
 struct clk *ti_clk_register_divider(struct ti_clk *setup);
+struct clk *ti_clk_register_composite(struct ti_clk *setup);
 struct clk *ti_clk_register_dpll(struct ti_clk *setup);
 
 struct clk_hw *ti_clk_build_component_div(struct ti_clk_divider *setup);
diff --git a/drivers/clk/ti/composite.c b/drivers/clk/ti/composite.c
index 19d8980..3a9665f 100644
--- a/drivers/clk/ti/composite.c
+++ b/drivers/clk/ti/composite.c
@@ -23,6 +23,8 @@
 #include <linux/clk/ti.h>
 #include <linux/list.h>
 
+#include "clock.h"
+
 #undef pr_fmt
 #define pr_fmt(fmt) "%s: " fmt, __func__
 
@@ -116,8 +118,44 @@ static inline struct clk_hw *_get_hw(struct clk_hw_omap_comp *clk, int idx)
 
 #define to_clk_hw_comp(_hw) container_of(_hw, struct clk_hw_omap_comp, hw)
 
-static void __init ti_clk_register_composite(struct clk_hw *hw,
-					     struct device_node *node)
+struct clk *ti_clk_register_composite(struct ti_clk *setup)
+{
+	struct ti_clk_composite *comp;
+	struct clk_hw *gate;
+	struct clk_hw *mux;
+	struct clk_hw *div;
+	int num_parents = 1;
+	const char **parent_names = NULL;
+	struct clk *clk;
+
+	comp = setup->data;
+
+	div = ti_clk_build_component_div(comp->divider);
+	gate = ti_clk_build_component_gate(comp->gate);
+	mux = ti_clk_build_component_mux(comp->mux);
+
+	if (div)
+		parent_names = &comp->divider->parent;
+
+	if (gate)
+		parent_names = &comp->gate->parent;
+
+	if (mux) {
+		num_parents = comp->mux->num_parents;
+		parent_names = comp->mux->parents;
+	}
+
+	clk = clk_register_composite(NULL, setup->name,
+				     parent_names, num_parents, mux,
+				     &ti_clk_mux_ops, div,
+				     &ti_composite_divider_ops, gate,
+				     &ti_composite_gate_ops, 0);
+
+	return clk;
+}
+
+static void __init _register_composite(struct clk_hw *hw,
+				       struct device_node *node)
 {
 	struct clk *clk;
 	struct clk_hw_omap_comp *cclk = to_clk_hw_comp(hw);
@@ -136,7 +174,7 @@ static void __init ti_clk_register_composite(struct clk_hw *hw,
 			pr_debug("component %s not ready for %s, retry\n",
 				 cclk->comp_nodes[i]->name, node->name);
 			if (!ti_clk_retry_init(node, hw,
-					       ti_clk_register_composite))
+					       _register_composite))
 				return;
 
 			goto cleanup;
@@ -216,7 +254,7 @@ static void __init of_ti_composite_clk_setup(struct device_node *node)
 	for (i = 0; i < num_clks; i++)
 		cclk->comp_nodes[i] = _get_component_node(node, i);
 
-	ti_clk_register_composite(&cclk->hw, node);
+	_register_composite(&cclk->hw, node);
 }
 CLK_OF_DECLARE(ti_composite_clock, "ti,composite-clock",
 	       of_ti_composite_clk_setup);
-- 
1.7.9.5

