From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 1/4] clk: ti: mux: add support for default-parenting
Date: Thu, 13 Feb 2014 11:00:45 +0200
Message-ID: <1392282048-6284-2-git-send-email-t-kristo@ti.com>
References: <1392282048-6284-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58380 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753423AbaBMJB3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Feb 2014 04:01:29 -0500
In-Reply-To: <1392282048-6284-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

ti,mux-clock now supports ti,default-parent property, which can be used
to configure the default parent of the clock during boot. This property
can be added to board specific files, or under the clock data itself.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 Documentation/devicetree/bindings/clock/ti/mux.txt |    7 ++++++
 drivers/clk/ti/mux.c                               |   24 ++++++++++++++++++--
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/ti/mux.txt b/Documentation/devicetree/bindings/clock/ti/mux.txt
index 2d0d170..4e291eb 100644
--- a/Documentation/devicetree/bindings/clock/ti/mux.txt
+++ b/Documentation/devicetree/bindings/clock/ti/mux.txt
@@ -48,6 +48,8 @@ Optional properties:
   zero
 - ti,set-rate-parent : clk_set_rate is propagated to parent clock,
   not supported by the composite-mux-clock subtype
+- ti,default-parent : configures mux parent during boot to be the provided
+  phandle clock
 
 Examples:
 
@@ -65,6 +67,7 @@ abe_dpll_bypass_clk_mux_ck: abe_dpll_bypass_clk_mux_ck@4a306108 {
 	clocks = <&sys_clkin_ck>, <&sys_32k_ck>;
 	ti,bit-shift = <24>;
 	reg = <0x0108>;
+	ti,default-parent = <&sys_32k_ck>;
 };
 
 mcbsp5_mux_fck: mcbsp5_mux_fck {
@@ -74,3 +77,7 @@ mcbsp5_mux_fck: mcbsp5_mux_fck {
 	ti,bit-shift = <4>;
 	reg = <0x02d8>;
 };
+
+&mcbsp5_mux_fck {
+	ti,default-parent = <&mcbsp_clks>;
+};
diff --git a/drivers/clk/ti/mux.c b/drivers/clk/ti/mux.c
index 0197a47..557a7ce 100644
--- a/drivers/clk/ti/mux.c
+++ b/drivers/clk/ti/mux.c
@@ -108,7 +108,8 @@ static struct clk *_register_mux(struct device *dev, const char *name,
 				 const char **parent_names, u8 num_parents,
 				 unsigned long flags, void __iomem *reg,
 				 u8 shift, u32 mask, u8 clk_mux_flags,
-				 u32 *table, spinlock_t *lock)
+				 u32 *table, int default_parent,
+				 spinlock_t *lock)
 {
 	struct clk_mux *mux;
 	struct clk *clk;
@@ -136,6 +137,9 @@ static struct clk *_register_mux(struct device *dev, const char *name,
 	mux->table = table;
 	mux->hw.init = &init;
 
+	if (default_parent >= 0)
+		ti_clk_mux_set_parent(&mux->hw, default_parent);
+
 	clk = clk_register(dev, &mux->hw);
 
 	if (IS_ERR(clk))
@@ -161,6 +165,8 @@ static void of_mux_clk_setup(struct device_node *node)
 	u32 mask = 0;
 	u32 shift = 0;
 	u32 flags = 0;
+	struct device_node *default_parent;
+	int default_parent_idx = -1;
 
 	num_parents = of_clk_get_parent_count(node);
 	if (num_parents < 2) {
@@ -174,6 +180,19 @@ static void of_mux_clk_setup(struct device_node *node)
 	for (i = 0; i < num_parents; i++)
 		parent_names[i] = of_clk_get_parent_name(node, i);
 
+	default_parent = of_parse_phandle(node, "ti,default-parent", 0);
+
+	if (default_parent) {
+		for (i = 0; i < num_parents; i++) {
+			struct device_node *tmp;
+			tmp = of_parse_phandle(node, "clocks", i);
+			if (tmp == default_parent) {
+				default_parent_idx = i;
+				break;
+			}
+		}
+	}
+
 	reg = ti_clk_get_reg_addr(node, 0);
 
 	if (!reg)
@@ -195,7 +214,8 @@ static void of_mux_clk_setup(struct device_node *node)
 	mask = (1 << fls(mask)) - 1;
 
 	clk = _register_mux(NULL, node->name, parent_names, num_parents, flags,
-			    reg, shift, mask, clk_mux_flags, NULL, NULL);
+			    reg, shift, mask, clk_mux_flags, NULL,
+			    default_parent_idx, NULL);
 
 	if (!IS_ERR(clk))
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
-- 
1.7.9.5

