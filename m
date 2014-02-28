From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 05/12] CLK: TI: APLL: add support for omap2 aplls
Date: Fri, 28 Feb 2014 11:22:57 +0200
Message-ID: <1393579384-23440-6-git-send-email-t-kristo@ti.com>
References: <1393579384-23440-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1393579384-23440-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This patch adds support for omap2 type aplls, which have gating and
autoidle functionality.

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/clock/ti/apll.txt          |   21 ++-
 arch/arm/mach-omap2/clock.h                        |   11 --
 drivers/clk/ti/apll.c                              |  180 ++++++++++++++++++++
 include/linux/clk/ti.h                             |   21 ++-
 4 files changed, 216 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/ti/apll.txt b/Documentation/devicetree/bindings/clock/ti/apll.txt
index 7faf5a6..61ecd30 100644
--- a/Documentation/devicetree/bindings/clock/ti/apll.txt
+++ b/Documentation/devicetree/bindings/clock/ti/apll.txt
@@ -14,18 +14,29 @@ a subtype of a DPLL [2], although a simplified one at that.
 [2] Documentation/devicetree/bindings/clock/ti/dpll.txt
 
 Required properties:
-- compatible : shall be "ti,dra7-apll-clock"
+- compatible : shall be "ti,dra7-apll-clock" or "ti,omap2-apll-clock"
 - #clock-cells : from common clock binding; shall be set to 0.
 - clocks : link phandles of parent clocks (clk-ref and clk-bypass)
 - reg : address and length of the register set for controlling the APLL.
   It contains the information of registers in the following order:
-	"control" - contains the control register base address
-	"idlest" - contains the idlest register base address
+	"control" - contains the control register offset
+	"idlest" - contains the idlest register offset
+	"autoidle" - contains the autoidle register offset (OMAP2 only)
 
 Examples:
-	apll_pcie_ck: apll_pcie_ck@4a008200 {
+	apll_pcie_ck: apll_pcie_ck {
 		#clock-cells = <0>;
 		clocks = <&apll_pcie_in_clk_mux>, <&dpll_pcie_ref_ck>;
-		reg = <0x4a00821c 0x4>, <0x4a008220 0x4>;
+		reg = <0x021c>, <0x0220>;
 		compatible = "ti,dra7-apll-clock";
 	};
+
+	apll96_ck: apll96_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap2-apll-clock";
+		clocks = <&sys_ck>;
+		ti,bit-shift = <2>;
+		ti,idlest-shift = <8>;
+		ti,clock-frequency = <96000000>;
+		reg = <0x0500>, <0x0530>, <0x0520>;
+	};
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 7057f37..7b7a03c 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -178,17 +178,6 @@ struct clksel {
 	const struct clksel_rate *rates;
 };
 
-struct clk_hw_omap_ops {
-	void			(*find_idlest)(struct clk_hw_omap *oclk,
-					void __iomem **idlest_reg,
-					u8 *idlest_bit, u8 *idlest_val);
-	void			(*find_companion)(struct clk_hw_omap *oclk,
-					void __iomem **other_reg,
-					u8 *other_bit);
-	void			(*allow_idle)(struct clk_hw_omap *oclk);
-	void			(*deny_idle)(struct clk_hw_omap *oclk);
-};
-
 /* CM_CLKSEL2_PLL.CORE_CLK_SRC bits (2XXX) */
 #define CORE_CLK_SRC_32K		0x0
 #define CORE_CLK_SRC_DPLL		0x1
diff --git a/drivers/clk/ti/apll.c b/drivers/clk/ti/apll.c
index b986f61..60b2427 100644
--- a/drivers/clk/ti/apll.c
+++ b/drivers/clk/ti/apll.c
@@ -221,3 +221,183 @@ cleanup:
 	kfree(init);
 }
 CLK_OF_DECLARE(dra7_apll_clock, "ti,dra7-apll-clock", of_dra7_apll_setup);
+
+#define OMAP2_EN_APLL_LOCKED	0x3
+#define OMAP2_EN_APLL_STOPPED	0x0
+
+static int omap2_apll_is_enabled(struct clk_hw *hw)
+{
+	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
+	struct dpll_data *ad = clk->dpll_data;
+	u32 v;
+
+	v = ti_clk_ll_ops->clk_readl(ad->control_reg);
+	v &= ad->enable_mask;
+
+	v >>= __ffs(ad->enable_mask);
+
+	return v == OMAP2_EN_APLL_LOCKED ? 1 : 0;
+}
+
+static unsigned long omap2_apll_recalc(struct clk_hw *hw,
+				       unsigned long parent_rate)
+{
+	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
+
+	if (omap2_apll_is_enabled(hw))
+		return clk->fixed_rate;
+
+	return 0;
+}
+
+static int omap2_apll_enable(struct clk_hw *hw)
+{
+	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
+	struct dpll_data *ad = clk->dpll_data;
+	u32 v;
+	int i = 0;
+
+	v = ti_clk_ll_ops->clk_readl(ad->control_reg);
+	v &= ~ad->enable_mask;
+	v |= OMAP2_EN_APLL_LOCKED << __ffs(ad->enable_mask);
+	ti_clk_ll_ops->clk_writel(v, ad->control_reg);
+
+	while (1) {
+		v = ti_clk_ll_ops->clk_readl(ad->idlest_reg);
+		if (v & ad->idlest_mask)
+			break;
+		if (i > MAX_APLL_WAIT_TRIES)
+			break;
+		i++;
+		udelay(1);
+	}
+
+	if (i == MAX_APLL_WAIT_TRIES) {
+		pr_warn("%s failed to transition to locked\n",
+			__clk_get_name(clk->hw.clk));
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static void omap2_apll_disable(struct clk_hw *hw)
+{
+	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
+	struct dpll_data *ad = clk->dpll_data;
+	u32 v;
+
+	v = ti_clk_ll_ops->clk_readl(ad->control_reg);
+	v &= ~ad->enable_mask;
+	v |= OMAP2_EN_APLL_STOPPED << __ffs(ad->enable_mask);
+	ti_clk_ll_ops->clk_writel(v, ad->control_reg);
+}
+
+static struct clk_ops omap2_apll_ops = {
+	.enable		= &omap2_apll_enable,
+	.disable	= &omap2_apll_disable,
+	.is_enabled	= &omap2_apll_is_enabled,
+	.recalc_rate	= &omap2_apll_recalc,
+};
+
+static void omap2_apll_set_autoidle(struct clk_hw_omap *clk, u32 val)
+{
+	struct dpll_data *ad = clk->dpll_data;
+	u32 v;
+
+	v = ti_clk_ll_ops->clk_readl(ad->autoidle_reg);
+	v &= ~ad->autoidle_mask;
+	v |= val << __ffs(ad->autoidle_mask);
+	ti_clk_ll_ops->clk_writel(v, ad->control_reg);
+}
+
+#define OMAP2_APLL_AUTOIDLE_LOW_POWER_STOP	0x3
+#define OMAP2_APLL_AUTOIDLE_DISABLE		0x0
+
+static void omap2_apll_allow_idle(struct clk_hw_omap *clk)
+{
+	omap2_apll_set_autoidle(clk, OMAP2_APLL_AUTOIDLE_LOW_POWER_STOP);
+}
+
+static void omap2_apll_deny_idle(struct clk_hw_omap *clk)
+{
+	omap2_apll_set_autoidle(clk, OMAP2_APLL_AUTOIDLE_DISABLE);
+}
+
+static struct clk_hw_omap_ops omap2_apll_hwops = {
+	.allow_idle	= &omap2_apll_allow_idle,
+	.deny_idle	= &omap2_apll_deny_idle,
+};
+
+static void __init of_omap2_apll_setup(struct device_node *node)
+{
+	struct dpll_data *ad = NULL;
+	struct clk_hw_omap *clk_hw = NULL;
+	struct clk_init_data *init = NULL;
+	struct clk *clk;
+	const char *parent_name;
+	u32 val;
+
+	ad = kzalloc(sizeof(*clk_hw), GFP_KERNEL);
+	clk_hw = kzalloc(sizeof(*clk_hw), GFP_KERNEL);
+	init = kzalloc(sizeof(*init), GFP_KERNEL);
+
+	if (!ad || !clk_hw || !init)
+		goto cleanup;
+
+	clk_hw->dpll_data = ad;
+	clk_hw->hw.init = init;
+	init->ops = &omap2_apll_ops;
+	init->name = node->name;
+	clk_hw->ops = &omap2_apll_hwops;
+
+	init->num_parents = of_clk_get_parent_count(node);
+	if (init->num_parents != 1) {
+		pr_err("%s must have one parent\n", node->name);
+		goto cleanup;
+	}
+
+	parent_name = of_clk_get_parent_name(node, 0);
+	init->parent_names = &parent_name;
+
+	if (of_property_read_u32(node, "ti,clock-frequency", &val)) {
+		pr_err("%s missing clock-frequency\n", node->name);
+		goto cleanup;
+	}
+	clk_hw->fixed_rate = val;
+
+	if (of_property_read_u32(node, "ti,bit-shift", &val)) {
+		pr_err("%s missing bit-shift\n", node->name);
+		goto cleanup;
+	}
+
+	clk_hw->enable_bit = val;
+	ad->enable_mask = 0x3 << val;
+	ad->autoidle_mask = 0x3 << val;
+
+	if (of_property_read_u32(node, "ti,idlest-shift", &val)) {
+		pr_err("%s missing idlest-shift\n", node->name);
+		goto cleanup;
+	}
+
+	ad->idlest_mask = 1 << val;
+
+	ad->control_reg = ti_clk_get_reg_addr(node, 0);
+	ad->autoidle_reg = ti_clk_get_reg_addr(node, 1);
+	ad->idlest_reg = ti_clk_get_reg_addr(node, 2);
+
+	if (!ad->control_reg || !ad->autoidle_reg || !ad->idlest_reg)
+		goto cleanup;
+
+	clk = clk_register(NULL, &clk_hw->hw);
+	if (!IS_ERR(clk)) {
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+		kfree(init);
+		return;
+	}
+cleanup:
+	kfree(clk_hw);
+	kfree(init);
+}
+CLK_OF_DECLARE(omap2_apll_clock, "ti,omap2-apll-clock",
+	       of_omap2_apll_setup);
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 2310adc..ddac0d0 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -94,7 +94,26 @@ struct dpll_data {
 	u8			flags;
 };
 
-struct clk_hw_omap_ops;
+struct clk_hw_omap;
+
+/**
+ * struct clk_hw_omap_ops - OMAP clk ops
+ * @find_idlest: find idlest register information for a clock
+ * @find_companion: find companion clock register information for a clock,
+ *		    basically converts CM_ICLKEN* <-> CM_FCLKEN*
+ * @allow_idle: enables autoidle hardware functionality for a clock
+ * @deny_idle: prevent autoidle hardware functionality for a clock
+ */
+struct clk_hw_omap_ops {
+	void	(*find_idlest)(struct clk_hw_omap *oclk,
+			void __iomem **idlest_reg,
+			u8 *idlest_bit, u8 *idlest_val);
+	void	(*find_companion)(struct clk_hw_omap *oclk,
+			void __iomem **other_reg,
+			u8 *other_bit);
+	void	(*allow_idle)(struct clk_hw_omap *oclk);
+	void	(*deny_idle)(struct clk_hw_omap *oclk);
+};
 
 /**
  * struct clk_hw_omap - OMAP struct clk
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
