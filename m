From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 18/45] CLK: DT: add support for set-rate-parent flag
Date: Thu, 29 Aug 2013 16:16:10 +0300
Message-ID: <1377782197-10611-19-git-send-email-t-kristo@ti.com>
References: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49096 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754460Ab3H2NSG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Aug 2013 09:18:06 -0400
In-Reply-To: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, rnayak@ti.com, nm@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Adding set-rate-parent to clock node now allows a node to forward
clk_set_rate request to its parent clock.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/clk-divider.c      |    6 +++++-
 drivers/clk/clk-fixed-factor.c |    6 +++++-
 drivers/clk/clk-gate.c         |    8 ++++++--
 drivers/clk/clk-mux.c          |    6 +++++-
 4 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 724f579..353fd5a 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -388,6 +388,7 @@ void of_divider_clk_setup(struct device_node *node)
 	u32 mask = 0;
 	u32 shift = 0;
 	struct clk_div_table *table;
+	u32 flags = 0;
 
 	of_property_read_string(node, "clock-output-names", &clk_name);
 
@@ -422,11 +423,14 @@ void of_divider_clk_setup(struct device_node *node)
 	if (of_property_read_bool(node, "hiword-mask"))
 		clk_divider_flags |= CLK_DIVIDER_HIWORD_MASK;
 
+	if (of_property_read_bool(node, "set-rate-parent"))
+		flags |= CLK_SET_RATE_PARENT;
+
 	table = of_clk_get_div_table(node);
 	if (IS_ERR(table))
 		return;
 
-	clk = _register_divider(NULL, clk_name, parent_name, 0, reg, shift,
+	clk = _register_divider(NULL, clk_name, parent_name, flags, reg, shift,
 			mask, clk_divider_flags, table, NULL);
 
 	if (!IS_ERR(clk))
diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index 9ff7d51..30aa121 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -107,6 +107,7 @@ void __init of_fixed_factor_clk_setup(struct device_node *node)
 	const char *clk_name = node->name;
 	const char *parent_name;
 	u32 div, mult;
+	u32 flags = 0;
 
 	if (of_property_read_u32(node, "clock-div", &div)) {
 		pr_err("%s Fixed factor clock <%s> must have a clock-div property\n",
@@ -123,7 +124,10 @@ void __init of_fixed_factor_clk_setup(struct device_node *node)
 	of_property_read_string(node, "clock-output-names", &clk_name);
 	parent_name = of_clk_get_parent_name(node, 0);
 
-	clk = clk_register_fixed_factor(NULL, clk_name, parent_name, 0,
+	if (of_property_read_bool(node, "set-rate-parent"))
+		flags |= CLK_SET_RATE_PARENT;
+
+	clk = clk_register_fixed_factor(NULL, clk_name, parent_name, flags,
 					mult, div);
 	if (!IS_ERR(clk))
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index 7ba3633..4a1360a 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -176,6 +176,7 @@ void of_gate_clk_setup(struct device_node *node)
 	const char *parent_name;
 	u8 clk_gate_flags = 0;
 	u32 bit_idx = 0;
+	u32 flags = 0;
 
 	of_property_read_string(node, "clock-output-names", &clk_name);
 
@@ -199,8 +200,11 @@ void of_gate_clk_setup(struct device_node *node)
 	if (of_property_read_bool(node, "hiword-mask"))
 		clk_gate_flags |= CLK_GATE_HIWORD_MASK;
 
-	clk = clk_register_gate(NULL, clk_name, parent_name, 0, reg, bit_idx,
-			clk_gate_flags, NULL);
+	if (of_property_read_bool(node, "set-rate-parent"))
+		flags |= CLK_SET_RATE_PARENT;
+
+	clk = clk_register_gate(NULL, clk_name, parent_name, flags, reg,
+			bit_idx, clk_gate_flags, NULL);
 
 	if (!IS_ERR(clk))
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index cb68226..87a70d4 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -184,6 +184,7 @@ void of_mux_clk_setup(struct device_node *node)
 	u8 clk_mux_flags = 0;
 	u32 mask = 0;
 	u32 shift = 0;
+	u32 flags = 0;
 
 	of_property_read_string(node, "clock-output-names", &clk_name);
 
@@ -223,8 +224,11 @@ void of_mux_clk_setup(struct device_node *node)
 	if (of_property_read_bool(node, "hiword-mask"))
 		clk_mux_flags |= CLK_MUX_HIWORD_MASK;
 
+	if (of_property_read_bool(node, "set-rate-parent"))
+		flags |= CLK_SET_RATE_PARENT;
+
 	clk = clk_register_mux_table(NULL, clk_name, parent_names, num_parents,
-			0, reg, shift, mask, clk_mux_flags, NULL, NULL);
+			flags, reg, shift, mask, clk_mux_flags, NULL, NULL);
 
 	if (!IS_ERR(clk))
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
-- 
1.7.9.5

