From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 03/14] CLK: TI: DPLL: simplify autoidle register detection logic
Date: Tue, 4 Mar 2014 11:18:09 +0200
Message-ID: <1393924700-6510-4-git-send-email-t-kristo@ti.com>
References: <1393924700-6510-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54301 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756688AbaCDJTX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Mar 2014 04:19:23 -0500
In-Reply-To: <1393924700-6510-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com, mturquette@linaro.org, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

AMxxxx dpll_data previously had autoidle_mask set, even if these SoC:s
don't have autoidle register. Remove the bit-field value as it is unused,
also drop the unnecessary DPLL_HAS_AUTOIDLE flag passing during init,
as we can just simply check against the contents of the autoidle_mask.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/dpll.c |   39 +++++++++++++++------------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
index 7e498a4..dda262d 100644
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -25,8 +25,6 @@
 #undef pr_fmt
 #define pr_fmt(fmt) "%s: " fmt, __func__
 
-#define DPLL_HAS_AUTOIDLE	0x1
-
 #if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
 	defined(CONFIG_SOC_DRA7XX)
 static const struct clk_ops dpll_m4xen_ck_ops = {
@@ -193,14 +191,12 @@ static void ti_clk_register_dpll_x2(struct device_node *node,
  * @node: device node containing the DPLL info
  * @ops: ops for the DPLL
  * @ddt: DPLL data template to use
- * @init_flags: flags for controlling init types
  *
  * Initializes a DPLL clock from device tree data.
  */
 static void __init of_ti_dpll_setup(struct device_node *node,
 				    const struct clk_ops *ops,
-				    const struct dpll_data *ddt,
-				    u8 init_flags)
+				    const struct dpll_data *ddt)
 {
 	struct clk_hw_omap *clk_hw = NULL;
 	struct clk_init_data *init = NULL;
@@ -247,7 +243,7 @@ static void __init of_ti_dpll_setup(struct device_node *node,
 	if (!dd->control_reg || !dd->idlest_reg || !dd->mult_div1_reg)
 		goto cleanup;
 
-	if (init_flags & DPLL_HAS_AUTOIDLE) {
+	if (dd->autoidle_mask) {
 		dd->autoidle_reg = ti_clk_get_reg_addr(node, 3);
 		if (!dd->autoidle_reg)
 			goto cleanup;
@@ -310,7 +306,7 @@ static void __init of_ti_omap3_dpll_setup(struct device_node *node)
 		.modes = (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
 	};
 
-	of_ti_dpll_setup(node, &omap3_dpll_ck_ops, &dd, DPLL_HAS_AUTOIDLE);
+	of_ti_dpll_setup(node, &omap3_dpll_ck_ops, &dd);
 }
 CLK_OF_DECLARE(ti_omap3_dpll_clock, "ti,omap3-dpll-clock",
 	       of_ti_omap3_dpll_setup);
@@ -329,7 +325,7 @@ static void __init of_ti_omap3_core_dpll_setup(struct device_node *node)
 		.freqsel_mask = 0xf0,
 	};
 
-	of_ti_dpll_setup(node, &omap3_dpll_core_ck_ops, &dd, DPLL_HAS_AUTOIDLE);
+	of_ti_dpll_setup(node, &omap3_dpll_core_ck_ops, &dd);
 }
 CLK_OF_DECLARE(ti_omap3_core_dpll_clock, "ti,omap3-dpll-core-clock",
 	       of_ti_omap3_core_dpll_setup);
@@ -349,7 +345,7 @@ static void __init of_ti_omap3_per_dpll_setup(struct device_node *node)
 		.modes = (1 << DPLL_LOW_POWER_STOP) | (1 << DPLL_LOCKED),
 	};
 
-	of_ti_dpll_setup(node, &omap3_dpll_per_ck_ops, &dd, DPLL_HAS_AUTOIDLE);
+	of_ti_dpll_setup(node, &omap3_dpll_per_ck_ops, &dd);
 }
 CLK_OF_DECLARE(ti_omap3_per_dpll_clock, "ti,omap3-dpll-per-clock",
 	       of_ti_omap3_per_dpll_setup);
@@ -371,7 +367,7 @@ static void __init of_ti_omap3_per_jtype_dpll_setup(struct device_node *node)
 		.modes = (1 << DPLL_LOW_POWER_STOP) | (1 << DPLL_LOCKED),
 	};
 
-	of_ti_dpll_setup(node, &omap3_dpll_per_ck_ops, &dd, DPLL_HAS_AUTOIDLE);
+	of_ti_dpll_setup(node, &omap3_dpll_per_ck_ops, &dd);
 }
 CLK_OF_DECLARE(ti_omap3_per_jtype_dpll_clock, "ti,omap3-dpll-per-j-type-clock",
 	       of_ti_omap3_per_jtype_dpll_setup);
@@ -391,7 +387,7 @@ static void __init of_ti_omap4_dpll_setup(struct device_node *node)
 		.modes = (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
 	};
 
-	of_ti_dpll_setup(node, &dpll_ck_ops, &dd, DPLL_HAS_AUTOIDLE);
+	of_ti_dpll_setup(node, &dpll_ck_ops, &dd);
 }
 CLK_OF_DECLARE(ti_omap4_dpll_clock, "ti,omap4-dpll-clock",
 	       of_ti_omap4_dpll_setup);
@@ -410,7 +406,7 @@ static void __init of_ti_omap4_core_dpll_setup(struct device_node *node)
 		.modes = (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
 	};
 
-	of_ti_dpll_setup(node, &dpll_core_ck_ops, &dd, DPLL_HAS_AUTOIDLE);
+	of_ti_dpll_setup(node, &dpll_core_ck_ops, &dd);
 }
 CLK_OF_DECLARE(ti_omap4_core_dpll_clock, "ti,omap4-dpll-core-clock",
 	       of_ti_omap4_core_dpll_setup);
@@ -433,7 +429,7 @@ static void __init of_ti_omap4_m4xen_dpll_setup(struct device_node *node)
 		.modes = (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
 	};
 
-	of_ti_dpll_setup(node, &dpll_m4xen_ck_ops, &dd, DPLL_HAS_AUTOIDLE);
+	of_ti_dpll_setup(node, &dpll_m4xen_ck_ops, &dd);
 }
 CLK_OF_DECLARE(ti_omap4_m4xen_dpll_clock, "ti,omap4-dpll-m4xen-clock",
 	       of_ti_omap4_m4xen_dpll_setup);
@@ -454,7 +450,7 @@ static void __init of_ti_omap4_jtype_dpll_setup(struct device_node *node)
 		.modes = (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
 	};
 
-	of_ti_dpll_setup(node, &dpll_m4xen_ck_ops, &dd, DPLL_HAS_AUTOIDLE);
+	of_ti_dpll_setup(node, &dpll_m4xen_ck_ops, &dd);
 }
 CLK_OF_DECLARE(ti_omap4_jtype_dpll_clock, "ti,omap4-dpll-j-type-clock",
 	       of_ti_omap4_jtype_dpll_setup);
@@ -465,7 +461,6 @@ static void __init of_ti_am3_no_gate_dpll_setup(struct device_node *node)
 	const struct dpll_data dd = {
 		.idlest_mask = 0x1,
 		.enable_mask = 0x7,
-		.autoidle_mask = 0x7,
 		.mult_mask = 0x7ff << 8,
 		.div1_mask = 0x7f,
 		.max_multiplier = 2047,
@@ -474,7 +469,7 @@ static void __init of_ti_am3_no_gate_dpll_setup(struct device_node *node)
 		.modes = (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
 	};
 
-	of_ti_dpll_setup(node, &dpll_no_gate_ck_ops, &dd, 0);
+	of_ti_dpll_setup(node, &dpll_no_gate_ck_ops, &dd);
 }
 CLK_OF_DECLARE(ti_am3_no_gate_dpll_clock, "ti,am3-dpll-no-gate-clock",
 	       of_ti_am3_no_gate_dpll_setup);
@@ -484,7 +479,6 @@ static void __init of_ti_am3_jtype_dpll_setup(struct device_node *node)
 	const struct dpll_data dd = {
 		.idlest_mask = 0x1,
 		.enable_mask = 0x7,
-		.autoidle_mask = 0x7,
 		.mult_mask = 0x7ff << 8,
 		.div1_mask = 0x7f,
 		.max_multiplier = 4095,
@@ -494,7 +488,7 @@ static void __init of_ti_am3_jtype_dpll_setup(struct device_node *node)
 		.modes = (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
 	};
 
-	of_ti_dpll_setup(node, &dpll_ck_ops, &dd, 0);
+	of_ti_dpll_setup(node, &dpll_ck_ops, &dd);
 }
 CLK_OF_DECLARE(ti_am3_jtype_dpll_clock, "ti,am3-dpll-j-type-clock",
 	       of_ti_am3_jtype_dpll_setup);
@@ -504,7 +498,6 @@ static void __init of_ti_am3_no_gate_jtype_dpll_setup(struct device_node *node)
 	const struct dpll_data dd = {
 		.idlest_mask = 0x1,
 		.enable_mask = 0x7,
-		.autoidle_mask = 0x7,
 		.mult_mask = 0x7ff << 8,
 		.div1_mask = 0x7f,
 		.max_multiplier = 2047,
@@ -514,7 +507,7 @@ static void __init of_ti_am3_no_gate_jtype_dpll_setup(struct device_node *node)
 		.modes = (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
 	};
 
-	of_ti_dpll_setup(node, &dpll_no_gate_ck_ops, &dd, 0);
+	of_ti_dpll_setup(node, &dpll_no_gate_ck_ops, &dd);
 }
 CLK_OF_DECLARE(ti_am3_no_gate_jtype_dpll_clock,
 	       "ti,am3-dpll-no-gate-j-type-clock",
@@ -525,7 +518,6 @@ static void __init of_ti_am3_dpll_setup(struct device_node *node)
 	const struct dpll_data dd = {
 		.idlest_mask = 0x1,
 		.enable_mask = 0x7,
-		.autoidle_mask = 0x7,
 		.mult_mask = 0x7ff << 8,
 		.div1_mask = 0x7f,
 		.max_multiplier = 2047,
@@ -534,7 +526,7 @@ static void __init of_ti_am3_dpll_setup(struct device_node *node)
 		.modes = (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
 	};
 
-	of_ti_dpll_setup(node, &dpll_ck_ops, &dd, 0);
+	of_ti_dpll_setup(node, &dpll_ck_ops, &dd);
 }
 CLK_OF_DECLARE(ti_am3_dpll_clock, "ti,am3-dpll-clock", of_ti_am3_dpll_setup);
 
@@ -543,7 +535,6 @@ static void __init of_ti_am3_core_dpll_setup(struct device_node *node)
 	const struct dpll_data dd = {
 		.idlest_mask = 0x1,
 		.enable_mask = 0x7,
-		.autoidle_mask = 0x7,
 		.mult_mask = 0x7ff << 8,
 		.div1_mask = 0x7f,
 		.max_multiplier = 2047,
@@ -552,7 +543,7 @@ static void __init of_ti_am3_core_dpll_setup(struct device_node *node)
 		.modes = (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
 	};
 
-	of_ti_dpll_setup(node, &dpll_core_ck_ops, &dd, 0);
+	of_ti_dpll_setup(node, &dpll_core_ck_ops, &dd);
 }
 CLK_OF_DECLARE(ti_am3_core_dpll_clock, "ti,am3-dpll-core-clock",
 	       of_ti_am3_core_dpll_setup);
-- 
1.7.9.5

