From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv9 12/43] CLK: TI: add support for clockdomain binding
Date: Fri, 25 Oct 2013 18:57:06 +0300
Message-ID: <1382716658-6964-13-git-send-email-t-kristo@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37577 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754338Ab3JYP7E (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Oct 2013 11:59:04 -0400
In-Reply-To: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Some OMAP clocks require knowledge about their parent clockdomain for
book keeping purposes. This patch creates a new DT binding for TI
clockdomains, which act as a collection of device clocks.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../devicetree/bindings/clock/ti/clockdomain.txt   |   21 +++++++
 arch/arm/mach-omap2/clock.h                        |    1 -
 drivers/clk/ti/Makefile                            |    3 +-
 drivers/clk/ti/clockdomain.c                       |   58 ++++++++++++++++++++
 include/linux/clk/ti.h                             |    3 +
 5 files changed, 84 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/clockdomain.txt
 create mode 100644 drivers/clk/ti/clockdomain.c

diff --git a/Documentation/devicetree/bindings/clock/ti/clockdomain.txt b/Documentation/devicetree/bindings/clock/ti/clockdomain.txt
new file mode 100644
index 0000000..45e6f7c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti/clockdomain.txt
@@ -0,0 +1,21 @@
+Binding for Texas Instruments clockdomain.
+
+Binding status: Unstable - ABI compatibility may be broken in the future
+
+This binding uses the common clock binding[1]. Every clock on
+TI SoC belongs to one clockdomain, but software only needs this
+information for specific clocks which require their parent
+clockdomain to be controlled when the clock is enabled/disabled.
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- compatible : shall be "ti,clockdomain"
+- #clock-cells : from common clock binding; shall be set to 0.
+- clocks : link phandles of clocks within this domain
+
+Examples:
+	dss_clkdm: dss_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&dss1_alwon_fck_3430es2>, <&dss_ick_3430es2>;
+	};
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 08b3360..8be0279 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -38,7 +38,6 @@ struct omap_clk {
 	}
 
 struct clockdomain;
-#define to_clk_hw_omap(_hw) container_of(_hw, struct clk_hw_omap, hw)
 
 #define DEFINE_STRUCT_CLK(_name, _parent_array_name, _clkops_name)	\
 	static struct clk _name = {				\
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index 7cba389..67056fb 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -1,4 +1,5 @@
 ifneq ($(CONFIG_OF),)
 obj-y					+= clk.o dpll.o autoidle.o divider.o \
-					   fixed-factor.o gate.o composite.o
+					   fixed-factor.o gate.o clockdomain.o \
+					   composite.o
 endif
diff --git a/drivers/clk/ti/clockdomain.c b/drivers/clk/ti/clockdomain.c
new file mode 100644
index 0000000..1b3099e
--- /dev/null
+++ b/drivers/clk/ti/clockdomain.c
@@ -0,0 +1,58 @@
+/*
+ * OMAP clockdomain support
+ *
+ * Copyright (C) 2013 Texas Instruments, Inc.
+ *
+ * Tero Kristo <t-kristo@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/clk/ti.h>
+
+static void __init of_ti_clockdomain_setup(struct device_node *node)
+{
+	struct clk *clk;
+	struct clk_hw *clk_hw;
+	const char *clkdm_name = node->name;
+	int i;
+	int num_clks;
+
+	num_clks = of_count_phandle_with_args(node, "clocks", "#clock-cells");
+
+	for (i = 0; i < num_clks; i++) {
+		clk = of_clk_get(node, i);
+		if (__clk_get_flags(clk) & CLK_IS_BASIC) {
+			pr_warn("%s: can't setup clkdm for basic clk %s\n",
+				__func__, __clk_get_name(clk));
+			continue;
+		}
+		clk_hw = __clk_get_hw(clk);
+		to_clk_hw_omap(clk_hw)->clkdm_name = clkdm_name;
+		omap2_init_clk_clkdm(clk_hw);
+	}
+}
+
+static struct of_device_id ti_clkdm_match_table[] __initdata = {
+	{ .compatible = "ti,clockdomain" },
+	{ }
+};
+
+void __init ti_dt_clockdomains_setup(void)
+{
+	struct device_node *np;
+	for_each_matching_node(np, ti_clkdm_match_table) {
+		of_ti_clockdomain_setup(np);
+	}
+}
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 29baca8..70446fb 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -190,6 +190,8 @@ struct ti_dt_clk {
 		.node_name = name,	\
 	}
 
+#define to_clk_hw_omap(_hw) container_of(_hw, struct clk_hw_omap, hw)
+
 void omap2_init_clk_hw_omap_clocks(struct clk *clk);
 int omap3_noncore_dpll_enable(struct clk_hw *hw);
 void omap3_noncore_dpll_disable(struct clk_hw *hw);
@@ -217,6 +219,7 @@ int omap2_dflt_clk_is_enabled(struct clk_hw *hw);
 
 void ti_dt_clocks_register(struct ti_dt_clk *oclks);
 void ti_dt_clk_init_provider(struct device_node *np, struct regmap *regmap);
+void ti_dt_clockdomains_setup(void);
 int of_ti_autoidle_setup(struct device_node *node, struct regmap *regmap);
 int ti_clk_add_component(struct device_node *node, struct clk_hw *hw, int type);
 
-- 
1.7.9.5

