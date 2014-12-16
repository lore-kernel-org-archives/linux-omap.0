From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 02/11] clk: ti: mux: add support for legacy mux init
Date: Tue, 16 Dec 2014 18:20:47 +0200
Message-ID: <1418746856-17173-3-git-send-email-t-kristo@ti.com>
References: <1418746856-17173-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37472 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751450AbaLPQUA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Dec 2014 11:20:00 -0500
In-Reply-To: <1418746856-17173-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, mturquette@linaro.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Legacy clock data is initialized slightly differently compared to
DT clocks, thus add support for this.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clk.c   |    3 +++
 drivers/clk/ti/clock.h |    4 +++
 drivers/clk/ti/mux.c   |   70 ++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index a8958f1..215f681 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -211,6 +211,9 @@ struct clk __init *ti_clk_register_clk(struct ti_clk *setup)
 		clk = clk_register_fixed_rate(NULL, setup->name, NULL,
 					      CLK_IS_ROOT, fixed->frequency);
 		break;
+	case TI_CLK_MUX:
+		clk = ti_clk_register_mux(setup);
+		break;
 	case TI_CLK_FIXED_FACTOR:
 		fixed_factor = setup->data;
 
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index 6ee6c6e..c06bbf4 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -153,6 +153,10 @@ struct ti_clk_dpll {
 	u8 recal_st_bit;
 };
 
+struct clk *ti_clk_register_mux(struct ti_clk *setup);
+
+struct clk_hw *ti_clk_build_component_mux(struct ti_clk_mux *setup);
+
 void ti_clk_patch_legacy_clks(struct ti_clk **patch);
 struct clk *ti_clk_register_clk(struct ti_clk *setup);
 int ti_clk_register_legacy_clks(struct ti_clk_alias *clks);
diff --git a/drivers/clk/ti/mux.c b/drivers/clk/ti/mux.c
index e9d650e..728e253 100644
--- a/drivers/clk/ti/mux.c
+++ b/drivers/clk/ti/mux.c
@@ -21,6 +21,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/clk/ti.h>
+#include "clock.h"
 
 #undef pr_fmt
 #define pr_fmt(fmt) "%s: " fmt, __func__
@@ -144,6 +145,39 @@ static struct clk *_register_mux(struct device *dev, const char *name,
 	return clk;
 }
 
+struct clk *ti_clk_register_mux(struct ti_clk *setup)
+{
+	struct ti_clk_mux *mux;
+	u32 flags;
+	u8 mux_flags = 0;
+	struct clk_omap_reg *reg_setup;
+	u32 reg;
+	u32 mask;
+
+	reg_setup = (struct clk_omap_reg *)&reg;
+
+	mux = setup->data;
+	flags = CLK_SET_RATE_NO_REPARENT;
+
+	mask = mux->num_parents;
+	if (!(mux->flags & CLKF_INDEX_STARTS_AT_ONE))
+		mask--;
+
+	mask = (1 << fls(mask)) - 1;
+	reg_setup->index = mux->module;
+	reg_setup->offset = mux->reg;
+
+	if (mux->flags & CLKF_INDEX_STARTS_AT_ONE)
+		mux_flags |= CLK_MUX_INDEX_ONE;
+
+	if (mux->flags & CLKF_SET_RATE_PARENT)
+		flags |= CLK_SET_RATE_PARENT;
+
+	return _register_mux(NULL, setup->name, mux->parents, mux->num_parents,
+			     flags, (void __iomem *)reg, mux->bit_shift, mask,
+			     mux_flags, NULL, NULL);
+}
+
 /**
  * of_mux_clk_setup - Setup function for simple mux rate clock
  * @node: DT node for the clock
@@ -194,8 +228,9 @@ static void of_mux_clk_setup(struct device_node *node)
 
 	mask = (1 << fls(mask)) - 1;
 
-	clk = _register_mux(NULL, node->name, parent_names, num_parents, flags,
-			    reg, shift, mask, clk_mux_flags, NULL, NULL);
+	clk = _register_mux(NULL, node->name, parent_names, num_parents,
+			    flags, reg, shift, mask, clk_mux_flags, NULL,
+			    NULL);
 
 	if (!IS_ERR(clk))
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
@@ -205,6 +240,37 @@ cleanup:
 }
 CLK_OF_DECLARE(mux_clk, "ti,mux-clock", of_mux_clk_setup);
 
+struct clk_hw *ti_clk_build_component_mux(struct ti_clk_mux *setup)
+{
+	struct clk_mux *mux;
+	struct clk_omap_reg *reg;
+	int num_parents;
+
+	if (!setup)
+		return NULL;
+
+	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		return ERR_PTR(-ENOMEM);
+
+	reg = (struct clk_omap_reg *)&mux->reg;
+
+	mux->shift = setup->bit_shift;
+
+	reg->index = setup->module;
+	reg->offset = setup->reg;
+
+	if (setup->flags & CLKF_INDEX_STARTS_AT_ONE)
+		mux->flags |= CLK_MUX_INDEX_ONE;
+
+	num_parents = setup->num_parents;
+
+	mux->mask = num_parents - 1;
+	mux->mask = (1 << fls(mux->mask)) - 1;
+
+	return &mux->hw;
+}
+
 static void __init of_ti_composite_mux_clk_setup(struct device_node *node)
 {
 	struct clk_mux *mux;
-- 
1.7.9.5

