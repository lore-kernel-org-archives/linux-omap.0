From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 26/33] CLK: omap: gate: add support for OMAP36xx dpllx_mx_ck:s
Date: Tue, 23 Jul 2013 10:20:21 +0300
Message-ID: <1374564028-11352-27-git-send-email-t-kristo@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58551 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754571Ab3GWHXI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Jul 2013 03:23:08 -0400
In-Reply-To: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, nm@ti.com, rnayak@ti.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

OMAP3630 dpll3_m3_ck, dpll4_m2_ck, dpll4_m3_ck, dpll4_m4_ck,
dpll4_m5_ck & dpll4_m6_ck dividers gets loaded with reset
value after their respective PWRDN bits are set.  Any dummy write
(Any other value different from the Read value) to the
corresponding CM_CLKSEL register will refresh the dividers.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/omap/gate.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/omap/gate.c b/drivers/clk/omap/gate.c
index b560ff4..50c7f2e 100644
--- a/drivers/clk/omap/gate.c
+++ b/drivers/clk/omap/gate.c
@@ -28,6 +28,10 @@
 
 #ifdef CONFIG_OF
 
+#define to_clk_divider(_hw) container_of(_hw, struct clk_divider, hw)
+
+static int omap36xx_gate_clk_enable_with_hsdiv_restore(struct clk_hw *clk);
+
 static const struct clk_ops omap_gate_clkdm_clk_ops = {
 	.init		= &omap2_init_clk_clkdm,
 	.enable		= &omap2_clkops_enable_clkdm,
@@ -41,6 +45,54 @@ static const struct clk_ops omap_gate_clk_ops = {
 	.is_enabled	= &omap2_dflt_clk_is_enabled,
 };
 
+static const struct clk_ops omap_gate_clk_hsdiv_restore_ops = {
+	.init		= &omap2_init_clk_clkdm,
+	.enable		= &omap36xx_gate_clk_enable_with_hsdiv_restore,
+	.disable	= &omap2_dflt_clk_disable,
+	.is_enabled	= &omap2_dflt_clk_is_enabled,
+};
+
+/**
+ * omap36xx_gate_clk_enable_with_hsdiv_restore - enable clocks suffering
+ *         from HSDivider PWRDN problem Implements Errata ID: i556.
+ * @clk: DPLL output struct clk
+ *
+ * 3630 only: dpll3_m3_ck, dpll4_m2_ck, dpll4_m3_ck, dpll4_m4_ck,
+ * dpll4_m5_ck & dpll4_m6_ck dividers gets loaded with reset
+ * valueafter their respective PWRDN bits are set.  Any dummy write
+ * (Any other value different from the Read value) to the
+ * corresponding CM_CLKSEL register will refresh the dividers.
+ */
+static int omap36xx_gate_clk_enable_with_hsdiv_restore(struct clk_hw *clk)
+{
+	struct clk_divider *parent;
+	struct clk_hw *parent_hw;
+	u32 dummy_v, orig_v;
+	int ret;
+
+	/* Clear PWRDN bit of HSDIVIDER */
+	ret = omap2_dflt_clk_enable(clk);
+
+	/* Parent is the x2 node, get parent of parent for the m2 div */
+	parent_hw = __clk_get_hw(__clk_get_parent(__clk_get_parent(clk->clk)));
+	parent = to_clk_divider(parent_hw);
+
+	/* Restore the dividers */
+	if (!ret) {
+		orig_v = __raw_readl(parent->reg);
+		dummy_v = orig_v;
+
+		/* Write any other value different from the Read value */
+		dummy_v ^= (1 << parent->shift);
+		__raw_writel(dummy_v, parent->reg);
+
+		/* Write the original divider */
+		__raw_writel(orig_v, parent->reg);
+	}
+
+	return ret;
+}
+
 void __init of_omap_gate_clk_setup(struct device_node *node)
 {
 	struct clk *clk;
@@ -70,7 +122,10 @@ void __init of_omap_gate_clk_setup(struct device_node *node)
 		/* No register, clkdm control only */
 		init.ops = &omap_gate_clkdm_clk_ops;
 	} else {
-		init.ops = &omap_gate_clk_ops;
+		if (of_property_read_bool(node, "ti,hsdiv-restore"))
+			init.ops = &omap_gate_clk_hsdiv_restore_ops;
+		else
+			init.ops = &omap_gate_clk_ops;
 		clk_hw->enable_reg = of_iomap(node, 0);
 		of_property_read_u32(node, "ti,enable-bit", &val);
 		clk_hw->enable_bit = val;
-- 
1.7.9.5

