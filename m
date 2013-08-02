From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 22/31] CLK: TI: add interface clock support for OMAP3
Date: Fri, 2 Aug 2013 19:25:41 +0300
Message-ID: <1375460751-23676-23-git-send-email-t-kristo@ti.com>
References: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50397 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754639Ab3HBQ1j (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Aug 2013 12:27:39 -0400
In-Reply-To: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

OMAP3 has interface clocks in addition to functional clocks, which
require special handling for the autoidle and idle status register
offsets mainly.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../devicetree/bindings/clock/ti/interface.txt     |   45 +++++++++
 arch/arm/mach-omap2/clock.h                        |    6 --
 drivers/clk/ti/Makefile                            |    2 +-
 drivers/clk/ti/interface.c                         |  105 ++++++++++++++++++++
 include/linux/clk/ti.h                             |    7 ++
 5 files changed, 158 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/interface.txt
 create mode 100644 drivers/clk/ti/interface.c

diff --git a/Documentation/devicetree/bindings/clock/ti/interface.txt b/Documentation/devicetree/bindings/clock/ti/interface.txt
new file mode 100644
index 0000000..8b09ae7
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti/interface.txt
@@ -0,0 +1,45 @@
+Binding for Texas Instruments interface clock.
+
+This binding uses the common clock binding[1]. This clock is
+quite much similar to the basic gate-clock [2], however,
+it supports a number of additional features, including
+companion clock finding (match corresponding functional gate
+clock) and hardware autoidle enable / disable.
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+[2] Documentation/devicetree/bindings/clock/gate-clock.txt
+
+Required properties:
+- compatible : shall be "ti,interface-clock"
+- #clock-cells : from common clock binding; shall be set to 0
+- clocks : link to phandle of parent clock
+- reg : base address for the control register
+
+Optional properties:
+- ti,enable-bit : bit shift for the bit enabling/disabling the clock
+		  (default 0)
+- ti,iclk-no-wait : flag for selecting non-waiting hw-ops
+- ti,iclk-hsotgusb : flag for selecting hsotgusb hw-ops
+- ti,iclk-dss : flag for selecting DSS interface clock hw-ops
+- ti,iclk-ssi : flag for selecting SSI interface clock hw-ops
+- ti,am35xx-clk : flag for selecting AM35xx interface clock hw-ops
+- ti,clkdm-name : parent clockdomain name
+
+Examples:
+	aes1_ick: aes1_ick@48004a14 {
+		#clock-cells = <0>;
+		compatible = "ti,interface-clock";
+		clocks = <&security_l4_ick2>;
+		reg = <0x48004a14 0x4>;
+		ti,enable-bit = <3>;
+	};
+
+	cam_ick: cam_ick@48004f10 {
+		#clock-cells = <0>;
+		compatible = "ti,interface-clock";
+		clocks = <&l4_ick>;
+		reg = <0x48004f10 0x4>;
+		ti,clkdm-name = "cam_clkdm";
+		ti,enable-bit = <0>;
+		ti,iclk-no-wait;
+	};
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 08c9aa6..685da9a 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -285,14 +285,8 @@ extern const struct clksel_rate gfx_l3_rates[];
 extern const struct clksel_rate dsp_ick_rates[];
 extern struct clk dummy_ck;
 
-extern const struct clk_hw_omap_ops clkhwops_iclk_wait;
-extern const struct clk_hw_omap_ops clkhwops_iclk;
 extern const struct clk_hw_omap_ops clkhwops_omap3430es2_ssi_wait;
-extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_ssi_wait;
-extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_dss_usbhost_wait;
-extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_hsotgusb_wait;
 extern const struct clk_hw_omap_ops clkhwops_omap3430es2_hsotgusb_wait;
-extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_wait;
 extern const struct clk_hw_omap_ops clkhwops_apll54;
 extern const struct clk_hw_omap_ops clkhwops_apll96;
 extern const struct clk_hw_omap_ops clkhwops_omap2xxx_dpll;
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index bcc0717..01925fd 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -1,5 +1,5 @@
 ifneq ($(CONFIG_OF),)
 obj-y					+= clk.o dpll.o autoidle.o gate.o \
 					   apll.o clk-44xx.o clk-54xx.o \
-					   clk-7xx.o clk-33xx.o
+					   clk-7xx.o clk-33xx.o interface.o
 endif
diff --git a/drivers/clk/ti/interface.c b/drivers/clk/ti/interface.c
new file mode 100644
index 0000000..a2e37da
--- /dev/null
+++ b/drivers/clk/ti/interface.c
@@ -0,0 +1,105 @@
+/*
+ * OMAP interface clock support
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
+static const struct clk_ops omap_interface_clk_ops = {
+	.init		= &omap2_init_clk_clkdm,
+	.enable		= &omap2_dflt_clk_enable,
+	.disable	= &omap2_dflt_clk_disable,
+	.is_enabled	= &omap2_dflt_clk_is_enabled,
+};
+
+void __init of_omap_interface_clk_setup(struct device_node *node)
+{
+	struct clk *clk;
+	struct clk_init_data init = { 0 };
+	struct clk_hw_omap *clk_hw;
+	const char *clk_name = node->name;
+	int num_parents;
+	const char **parent_names = NULL;
+	int i;
+	u32 val;
+
+	clk_hw = kzalloc(sizeof(*clk_hw), GFP_KERNEL);
+	if (!clk_hw) {
+		pr_err("%s: could not allocate clk_hw_omap\n", __func__);
+		return;
+	}
+
+	clk_hw->hw.init = &init;
+	clk_hw->ops = &clkhwops_iclk_wait;
+	clk_hw->enable_reg = of_iomap(node, 0);
+
+	if (!of_property_read_u32(node, "ti,enable-bit", &val))
+		clk_hw->enable_bit = val;
+
+	if (of_property_read_bool(node, "ti,iclk-no-wait"))
+		clk_hw->ops = &clkhwops_iclk;
+
+	if (of_property_read_bool(node, "ti,iclk-hsotgusb"))
+		clk_hw->ops = &clkhwops_omap3430es2_iclk_hsotgusb_wait;
+
+	if (of_property_read_bool(node, "ti,iclk-dss"))
+		clk_hw->ops = &clkhwops_omap3430es2_iclk_dss_usbhost_wait;
+
+	if (of_property_read_bool(node, "ti,iclk-ssi"))
+		clk_hw->ops = &clkhwops_omap3430es2_iclk_ssi_wait;
+
+	if (of_property_read_bool(node, "ti,am35xx-clk"))
+		clk_hw->ops = &clkhwops_am35xx_ipss_wait;
+
+	of_property_read_string(node, "clock-output-names", &clk_name);
+	of_property_read_string(node, "ti,clkdm-name", &clk_hw->clkdm_name);
+
+	init.name = clk_name;
+	init.ops = &omap_interface_clk_ops;
+	init.flags = 0;
+
+	num_parents = of_clk_get_parent_count(node);
+	if (num_parents < 1) {
+		pr_err("%s: omap interface_clk %s must have parent(s)\n",
+		       __func__, node->name);
+		goto cleanup;
+	}
+
+	parent_names = kzalloc(sizeof(char *) * num_parents, GFP_KERNEL);
+
+	for (i = 0; i < num_parents; i++)
+		parent_names[i] = of_clk_get_parent_name(node, i);
+
+	init.num_parents = num_parents;
+	init.parent_names = parent_names;
+
+	clk = clk_register(NULL, &clk_hw->hw);
+
+	if (!IS_ERR(clk)) {
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+		omap2_init_clk_hw_omap_clocks(clk);
+		return;
+	}
+
+cleanup:
+	kfree(parent_names);
+	kfree(clk_hw);
+}
+CLK_OF_DECLARE(omap_interface_clk, "ti,interface-clock",
+	       of_omap_interface_clk_setup);
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 8ff2c29..8076394 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -204,5 +204,12 @@ extern const struct clk_hw_omap_ops clkhwops_omap4_dpllmx;
 extern const struct clk_hw_omap_ops clkhwops_wait;
 extern const struct clk_hw_omap_ops clkhwops_omap3430es2_dss_usbhost_wait;
 extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_module_wait;
+extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_wait;
+
+extern const struct clk_hw_omap_ops clkhwops_iclk_wait;
+extern const struct clk_hw_omap_ops clkhwops_iclk;
+extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_ssi_wait;
+extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_dss_usbhost_wait;
+extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_hsotgusb_wait;
 
 #endif
-- 
1.7.9.5

