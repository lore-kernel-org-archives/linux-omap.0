From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 5/5] clk: ti: add support for clock latching to mux clocks
Date: Thu, 15 Feb 2018 14:49:51 +0200
Message-ID: <1518698991-10099-6-git-send-email-t-kristo@ti.com>
References: <1518698991-10099-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1518698991-10099-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: sboyd@kernel.org, mturquette@baylibre.com, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Latching the clock settings is needed with certain clocks, where
the setting is "cached" in HW before doing the actual re-programming
of the clock source. This patch adds support for clock latching to
the mux clock.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clock.h |  1 +
 drivers/clk/ti/mux.c   | 13 ++++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index 62b108c..90b86aa 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -34,6 +34,7 @@ struct clk_omap_mux {
 	u32			*table;
 	u32			mask;
 	u8			shift;
+	s8			latch;
 	u8			flags;
 };
 
diff --git a/drivers/clk/ti/mux.c b/drivers/clk/ti/mux.c
index d470580..69a4308 100644
--- a/drivers/clk/ti/mux.c
+++ b/drivers/clk/ti/mux.c
@@ -86,6 +86,7 @@ static int ti_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 	}
 	val |= index << mux->shift;
 	ti_clk_ll_ops->clk_writel(val, &mux->reg);
+	ti_clk_latch(&mux->reg, mux->latch);
 
 	return 0;
 }
@@ -100,7 +101,7 @@ static struct clk *_register_mux(struct device *dev, const char *name,
 				 const char * const *parent_names,
 				 u8 num_parents, unsigned long flags,
 				 struct clk_omap_reg *reg, u8 shift, u32 mask,
-				 u8 clk_mux_flags, u32 *table)
+				 s8 latch, u8 clk_mux_flags, u32 *table)
 {
 	struct clk_omap_mux *mux;
 	struct clk *clk;
@@ -121,6 +122,7 @@ static struct clk *_register_mux(struct device *dev, const char *name,
 	memcpy(&mux->reg, reg, sizeof(*reg));
 	mux->shift = shift;
 	mux->mask = mask;
+	mux->latch = latch;
 	mux->flags = clk_mux_flags;
 	mux->table = table;
 	mux->hw.init = &init;
@@ -160,7 +162,7 @@ struct clk *ti_clk_register_mux(struct ti_clk *setup)
 		flags |= CLK_SET_RATE_PARENT;
 
 	return _register_mux(NULL, setup->name, mux->parents, mux->num_parents,
-			     flags, &reg, mux->bit_shift, mask,
+			     flags, &reg, mux->bit_shift, mask, -EINVAL,
 			     mux_flags, NULL);
 }
 
@@ -179,6 +181,7 @@ static void of_mux_clk_setup(struct device_node *node)
 	u8 clk_mux_flags = 0;
 	u32 mask = 0;
 	u32 shift = 0;
+	s32 latch = -EINVAL;
 	u32 flags = CLK_SET_RATE_NO_REPARENT;
 
 	num_parents = of_clk_get_parent_count(node);
@@ -197,6 +200,8 @@ static void of_mux_clk_setup(struct device_node *node)
 
 	of_property_read_u32(node, "ti,bit-shift", &shift);
 
+	of_property_read_u32(node, "ti,latch-bit", &latch);
+
 	if (of_property_read_bool(node, "ti,index-starts-at-one"))
 		clk_mux_flags |= CLK_MUX_INDEX_ONE;
 
@@ -211,7 +216,8 @@ static void of_mux_clk_setup(struct device_node *node)
 	mask = (1 << fls(mask)) - 1;
 
 	clk = _register_mux(NULL, node->name, parent_names, num_parents,
-			    flags, &reg, shift, mask, clk_mux_flags, NULL);
+			    flags, &reg, shift, mask, latch, clk_mux_flags,
+			    NULL);
 
 	if (!IS_ERR(clk))
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
@@ -234,6 +240,7 @@ struct clk_hw *ti_clk_build_component_mux(struct ti_clk_mux *setup)
 		return ERR_PTR(-ENOMEM);
 
 	mux->shift = setup->bit_shift;
+	mux->latch = -EINVAL;
 
 	mux->reg.index = setup->module;
 	mux->reg.offset = setup->reg;
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
