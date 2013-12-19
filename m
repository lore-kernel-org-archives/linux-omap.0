From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv11 13/49] CLK: TI: add autoidle support
Date: Thu, 19 Dec 2013 13:23:44 +0200
Message-ID: <1387452260-23276-14-git-send-email-t-kristo@ti.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38918 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612Ab3LSLZl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Dec 2013 06:25:41 -0500
In-Reply-To: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

TI clk driver now routes some of the basic clocks through own
registration routine to allow autoidle support. This routine just
checks a couple of device node properties and adds autoidle support
if required, and just passes the registration forward to basic clocks.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../devicetree/bindings/clock/ti/autoidle.txt      |   39 ++++++
 arch/arm/mach-omap2/clock.c                        |    6 +
 drivers/clk/ti/Makefile                            |    2 +-
 drivers/clk/ti/autoidle.c                          |  133 ++++++++++++++++++++
 include/linux/clk/ti.h                             |    9 ++
 5 files changed, 188 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/autoidle.txt
 create mode 100644 drivers/clk/ti/autoidle.c

diff --git a/Documentation/devicetree/bindings/clock/ti/autoidle.txt b/Documentation/devicetree/bindings/clock/ti/autoidle.txt
new file mode 100644
index 0000000..7c735dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti/autoidle.txt
@@ -0,0 +1,39 @@
+Binding for Texas Instruments autoidle clock.
+
+Binding status: Unstable - ABI compatibility may be broken in the future
+
+This binding uses the common clock binding[1]. It assumes a register mapped
+clock which can be put to idle automatically by hardware based on the usage
+and a configuration bit setting. Autoidle clock is never an individual
+clock, it is always a derivative of some basic clock like a gate, divider,
+or fixed-factor.
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- reg : offset for the register controlling the autoidle
+- ti,autoidle-shift : bit shift of the autoidle enable bit
+- ti,invert-autoidle-bit : autoidle is enabled by setting the bit to 0
+
+Examples:
+	dpll_core_m4_ck: dpll_core_m4_ck {
+		#clock-cells = <0>;
+		compatible = "ti,divider-clock";
+		clocks = <&dpll_core_x2_ck>;
+		ti,max-div = <31>;
+		ti,autoidle-shift = <8>;
+		reg = <0x2d38>;
+		ti,index-starts-at-one;
+		ti,invert-autoidle-bit;
+	};
+
+	dpll_usb_clkdcoldo_ck: dpll_usb_clkdcoldo_ck {
+		#clock-cells = <0>;
+		compatible = "ti,fixed-factor-clock";
+		clocks = <&dpll_usb_ck>;
+		ti,clock-div = <1>;
+		ti,autoidle-shift = <8>;
+		reg = <0x01b4>;
+		ti,clock-mult = <1>;
+		ti,invert-autoidle-bit;
+	};
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index c7c5d31..238be3f 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -520,6 +520,9 @@ int omap2_clk_enable_autoidle_all(void)
 	list_for_each_entry(c, &clk_hw_omap_clocks, node)
 		if (c->ops && c->ops->allow_idle)
 			c->ops->allow_idle(c);
+
+	of_ti_clk_allow_autoidle_all();
+
 	return 0;
 }
 
@@ -539,6 +542,9 @@ int omap2_clk_disable_autoidle_all(void)
 	list_for_each_entry(c, &clk_hw_omap_clocks, node)
 		if (c->ops && c->ops->deny_idle)
 			c->ops->deny_idle(c);
+
+	of_ti_clk_deny_autoidle_all();
+
 	return 0;
 }
 
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index 05af5d8..533efb4 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -1,3 +1,3 @@
 ifneq ($(CONFIG_OF),)
-obj-y					+= clk.o dpll.o
+obj-y					+= clk.o dpll.o autoidle.o
 endif
diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
new file mode 100644
index 0000000..8912ff8
--- /dev/null
+++ b/drivers/clk/ti/autoidle.c
@@ -0,0 +1,133 @@
+/*
+ * TI clock autoidle support
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
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/clk/ti.h>
+
+struct clk_ti_autoidle {
+	void __iomem		*reg;
+	u8			shift;
+	u8			flags;
+	const char		*name;
+	struct list_head	node;
+};
+
+#define AUTOIDLE_LOW		0x1
+
+static LIST_HEAD(autoidle_clks);
+
+static void ti_allow_autoidle(struct clk_ti_autoidle *clk)
+{
+	u32 val;
+
+	val = ti_clk_ll_ops->clk_readl(clk->reg);
+
+	if (clk->flags & AUTOIDLE_LOW)
+		val &= ~(1 << clk->shift);
+	else
+		val |= (1 << clk->shift);
+
+	ti_clk_ll_ops->clk_writel(val, clk->reg);
+}
+
+static void ti_deny_autoidle(struct clk_ti_autoidle *clk)
+{
+	u32 val;
+
+	val = ti_clk_ll_ops->clk_readl(clk->reg);
+
+	if (clk->flags & AUTOIDLE_LOW)
+		val |= (1 << clk->shift);
+	else
+		val &= ~(1 << clk->shift);
+
+	ti_clk_ll_ops->clk_writel(val, clk->reg);
+}
+
+/**
+ * of_ti_clk_allow_autoidle_all - enable autoidle for all clocks
+ *
+ * Enables hardware autoidle for all registered DT clocks, which have
+ * the feature.
+ */
+void of_ti_clk_allow_autoidle_all(void)
+{
+	struct clk_ti_autoidle *c;
+
+	list_for_each_entry(c, &autoidle_clks, node)
+		ti_allow_autoidle(c);
+}
+
+/**
+ * of_ti_clk_deny_autoidle_all - disable autoidle for all clocks
+ *
+ * Disables hardware autoidle for all registered DT clocks, which have
+ * the feature.
+ */
+void of_ti_clk_deny_autoidle_all(void)
+{
+	struct clk_ti_autoidle *c;
+
+	list_for_each_entry(c, &autoidle_clks, node)
+		ti_deny_autoidle(c);
+}
+
+/**
+ * of_ti_clk_autoidle_setup - sets up hardware autoidle for a clock
+ * @node: pointer to the clock device node
+ *
+ * Checks if a clock has hardware autoidle support or not (check
+ * for presence of 'ti,autoidle-shift' property in the device tree
+ * node) and sets up the hardware autoidle feature for the clock
+ * if available. If autoidle is available, the clock is also added
+ * to the autoidle list for later processing. Returns 0 on success,
+ * negative error value on failure.
+ */
+int __init of_ti_clk_autoidle_setup(struct device_node *node)
+{
+	u32 shift;
+	struct clk_ti_autoidle *clk;
+
+	/* Check if this clock has autoidle support or not */
+	if (of_property_read_u32(node, "ti,autoidle-shift", &shift))
+		return 0;
+
+	clk = kzalloc(sizeof(*clk), GFP_KERNEL);
+
+	if (!clk)
+		return -ENOMEM;
+
+	clk->shift = shift;
+	clk->name = node->name;
+	clk->reg = ti_clk_get_reg_addr(node, 0);
+
+	if (!clk->reg) {
+		kfree(clk);
+		return -EINVAL;
+	}
+
+	if (of_property_read_bool(node, "ti,invert-autoidle-bit"))
+		clk->flags |= AUTOIDLE_LOW;
+
+	list_add(&clk->node, &autoidle_clks);
+
+	return 0;
+}
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index c2ffbf6..c7e4f98 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -227,6 +227,15 @@ void ti_dt_clocks_register(struct ti_dt_clk *oclks);
 void ti_dt_clk_init_provider(struct device_node *np, int index);
 void ti_clk_retry_init(struct device_node *node, struct clk_hw *hw,
 		       ti_of_clk_init_cb_t func);
+int of_ti_clk_autoidle_setup(struct device_node *node);
+
+#ifdef CONFIG_OF
+void of_ti_clk_allow_autoidle_all(void);
+void of_ti_clk_deny_autoidle_all(void);
+#else
+static inline void of_ti_clk_allow_autoidle_all(void) { }
+static inline void of_ti_clk_deny_autoidle_all(void) { }
+#endif
 
 extern const struct clk_hw_omap_ops clkhwops_omap3_dpll;
 extern const struct clk_hw_omap_ops clkhwops_omap4_dpllmx;
-- 
1.7.9.5

