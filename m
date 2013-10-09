From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv8 07/36] CLK: TI: add support for clockdomain binding
Date: Wed, 9 Oct 2013 18:30:38 +0300
Message-ID: <1381332668-962-8-git-send-email-t-kristo@ti.com>
References: <1381332668-962-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39987 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074Ab3JIPc4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Oct 2013 11:32:56 -0400
In-Reply-To: <1381332668-962-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Some OMAP clocks require knowledge about their parent clockdomain for
book keeping purposes. This patch creates a new DT binding for TI
clockdomains, which act as a collection of device clocks.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 .../devicetree/bindings/clock/ti/clockdomain.txt   |   21 +++++++++
 arch/arm/mach-omap2/clock.h                        |    1 -
 drivers/clk/ti/Makefile                            |    2 +-
 drivers/clk/ti/clockdomain.c                       |   46 ++++++++++++++++++++
 include/linux/clk/ti.h                             |    2 +
 5 files changed, 70 insertions(+), 2 deletions(-)
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
index f0b7218..56d4664 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -38,7 +38,6 @@ struct omap_clk {
 	}
 
 struct clockdomain;
-#define to_clk_hw_omap(_hw) container_of(_hw, struct clk_hw_omap, hw)
 
 #define DEFINE_STRUCT_CLK(_name, _parent_array_name, _clkops_name)	\
 	static struct clk _name = {				\
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index 63b1c45..ce8bd06 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -1,4 +1,4 @@
 ifneq ($(CONFIG_OF),)
 obj-y					+= clk.o dpll.o autoidle.o divider.o \
-					   fixed-factor.o gate.o
+					   fixed-factor.o gate.o clockdomain.o
 endif
diff --git a/drivers/clk/ti/clockdomain.c b/drivers/clk/ti/clockdomain.c
new file mode 100644
index 0000000..3573bc9
--- /dev/null
+++ b/drivers/clk/ti/clockdomain.c
@@ -0,0 +1,46 @@
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
+CLK_OF_DECLARE(ti_clockdomain, "ti,clockdomain", of_ti_clockdomain_setup);
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index e0a2d32..e70a2eb 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -186,6 +186,8 @@ struct ti_dt_clk {
 		.node_name = name,	\
 	}
 
+#define to_clk_hw_omap(_hw) container_of(_hw, struct clk_hw_omap, hw)
+
 void omap2_init_clk_hw_omap_clocks(struct clk *clk);
 int omap3_noncore_dpll_enable(struct clk_hw *hw);
 void omap3_noncore_dpll_disable(struct clk_hw *hw);
-- 
1.7.9.5

