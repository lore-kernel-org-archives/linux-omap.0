From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv10 18/41] CLK: TI: add interface clock support for OMAP3
Date: Tue, 26 Nov 2013 10:05:59 +0200
Message-ID: <1385453182-24421-19-git-send-email-t-kristo@ti.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385453182-24421-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

OMAP3 has interface clocks in addition to functional clocks, which
require special handling for the autoidle and idle status register
offsets mainly.

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/clock/ti/interface.txt     |   54 ++++++++
 arch/arm/mach-omap2/clock.h                        |    5 -
 drivers/clk/ti/Makefile                            |    1 +
 drivers/clk/ti/interface.c                         |  130 ++++++++++++++++++++
 include/linux/clk/ti.h                             |    5 +
 5 files changed, 190 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/interface.txt
 create mode 100644 drivers/clk/ti/interface.c

diff --git a/Documentation/devicetree/bindings/clock/ti/interface.txt b/Documentation/devicetree/bindings/clock/ti/interface.txt
new file mode 100644
index 0000000..064e8ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti/interface.txt
@@ -0,0 +1,54 @@
+Binding for Texas Instruments interface clock.
+
+Binding status: Unstable - ABI compatibility may be broken in the future
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
+- compatible : shall be one of:
+  "ti,omap3-interface-clock" - basic OMAP3 interface clock
+  "ti,omap3-no-wait-interface-clock" - interface clock which has no hardware
+				       capability for waiting clock to be ready
+  "ti,omap3-hsotgusb-interface-clock" - interface clock with USB specific HW
+					handling
+  "ti,omap3-dss-interface-clock" - interface clock with DSS specific HW handling
+  "ti,omap3-ssi-interface-clock" - interface clock with SSI specific HW handling
+  "ti,am35xx-interface-clock" - interface clock with AM35xx specific HW handling
+- #clock-cells : from common clock binding; shall be set to 0
+- clocks : link to phandle of parent clock
+- reg : base address for the control register
+
+Optional properties:
+- ti,bit-shift : bit shift for the bit enabling/disabling the clock (default 0)
+
+Examples:
+	aes1_ick: aes1_ick@48004a14 {
+		#clock-cells = <0>;
+		compatible = "ti,omap3-interface-clock";
+		clocks = <&security_l4_ick2>;
+		reg = <0x48004a14 0x4>;
+		ti,bit-shift = <3>;
+	};
+
+	cam_ick: cam_ick@48004f10 {
+		#clock-cells = <0>;
+		compatible = "ti,omap3-no-wait-interface-clock";
+		clocks = <&l4_ick>;
+		reg = <0x48004f10 0x4>;
+		ti,bit-shift = <0>;
+	};
+
+	ssi_ick_3430es2: ssi_ick_3430es2@48004a10 {
+		#clock-cells = <0>;
+		compatible = "ti,omap3-ssi-interface-clock";
+		clocks = <&ssi_l4_ick>;
+		reg = <0x48004a10 0x4>;
+		ti,bit-shift = <0>;
+	};
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 1da9dc3..cbe5ff7 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -270,15 +270,10 @@ extern struct clk dummy_ck;
 
 extern const struct clk_hw_omap_ops clkhwops_iclk_wait;
 extern const struct clk_hw_omap_ops clkhwops_wait;
-extern const struct clk_hw_omap_ops clkhwops_iclk;
 extern const struct clk_hw_omap_ops clkhwops_omap3430es2_ssi_wait;
-extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_ssi_wait;
 extern const struct clk_hw_omap_ops clkhwops_omap3430es2_dss_usbhost_wait;
-extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_dss_usbhost_wait;
-extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_hsotgusb_wait;
 extern const struct clk_hw_omap_ops clkhwops_omap3430es2_hsotgusb_wait;
 extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_module_wait;
-extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_wait;
 extern const struct clk_hw_omap_ops clkhwops_apll54;
 extern const struct clk_hw_omap_ops clkhwops_apll96;
 extern const struct clk_hw_omap_ops clkhwops_omap2xxx_dpll;
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index 7eb6f2b..e42a703 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -3,6 +3,7 @@ obj-y					+= clk.o dpll.o autoidle.o divider.o \
 					   fixed-factor.o gate.o clockdomain.o \
 					   composite.o mux.o apll.o
 obj-$(CONFIG_SOC_AM33XX)		+= clk-33xx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= interface.o
 obj-$(CONFIG_ARCH_OMAP4)		+= clk-44xx.o
 obj-$(CONFIG_SOC_OMAP5)			+= clk-54xx.o
 obj-$(CONFIG_SOC_DRA7XX)		+= clk-7xx.o
diff --git a/drivers/clk/ti/interface.c b/drivers/clk/ti/interface.c
new file mode 100644
index 0000000..9180423
--- /dev/null
+++ b/drivers/clk/ti/interface.c
@@ -0,0 +1,130 @@
+/*
+ * OMAP interface clock support
+ *
+ * Copyright (C) 2013 Texas Instruments, Inc.
+ *
+ * Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
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
+#undef pr_fmt
+#define pr_fmt(fmt) "%s: " fmt, __func__
+
+static const struct clk_ops ti_interface_clk_ops = {
+	.init		= &omap2_init_clk_clkdm,
+	.enable		= &omap2_dflt_clk_enable,
+	.disable	= &omap2_dflt_clk_disable,
+	.is_enabled	= &omap2_dflt_clk_is_enabled,
+};
+
+static int __init _of_ti_interface_clk_setup(struct device_node *node,
+					     const struct clk_hw_omap_ops *ops)
+{
+	struct clk *clk;
+	struct clk_init_data init = { NULL };
+	struct clk_hw_omap *clk_hw;
+	const char *parent_name;
+	u32 val;
+	int ret = 0;
+
+	clk_hw = kzalloc(sizeof(*clk_hw), GFP_KERNEL);
+	if (!clk_hw)
+		return -ENOMEM;
+
+	clk_hw->hw.init = &init;
+	clk_hw->ops = ops;
+	clk_hw->flags = REGMAP_ADDRESSING;
+
+	clk_hw->enable_reg = ti_clk_get_reg_addr(node, 0);
+	if (!clk_hw->enable_reg) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (!of_property_read_u32(node, "ti,bit-shift", &val))
+		clk_hw->enable_bit = val;
+
+	init.name = node->name;
+	init.ops = &ti_interface_clk_ops;
+	init.flags = 0;
+
+	parent_name = of_clk_get_parent_name(node, 0);
+	if (!parent_name) {
+		pr_err("%s must have a parent\n", node->name);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	init.num_parents = 1;
+	init.parent_names = &parent_name;
+
+	clk = clk_register(NULL, &clk_hw->hw);
+
+	if (!IS_ERR(clk)) {
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+		omap2_init_clk_hw_omap_clocks(clk);
+		return 0;
+	}
+	ret = PTR_ERR(clk);
+
+cleanup:
+	kfree(clk_hw);
+	return ret;
+}
+
+static int __init of_ti_interface_clk_setup(struct device_node *node)
+{
+	return _of_ti_interface_clk_setup(node, &clkhwops_iclk_wait);
+}
+CLK_OF_DECLARE(ti_interface_clk, "ti,omap3-interface-clock",
+	       of_ti_interface_clk_setup);
+
+static int __init of_ti_no_wait_interface_clk_setup(struct device_node *node)
+{
+	return _of_ti_interface_clk_setup(node, &clkhwops_iclk);
+}
+CLK_OF_DECLARE(ti_no_wait_interface_clk, "ti,omap3-no-wait-interface-clock",
+	       of_ti_no_wait_interface_clk_setup);
+
+static int __init of_ti_hsotgusb_interface_clk_setup(struct device_node *node)
+{
+	return _of_ti_interface_clk_setup(node, &clkhwops_omap3430es2_iclk_hsotgusb_wait);
+}
+CLK_OF_DECLARE(ti_hsotgusb_interface_clk, "ti,omap3-hsotgusb-interface-clock",
+	       of_ti_hsotgusb_interface_clk_setup);
+
+static int __init of_ti_dss_interface_clk_setup(struct device_node *node)
+{
+	return _of_ti_interface_clk_setup(node, &clkhwops_omap3430es2_iclk_dss_usbhost_wait);
+}
+CLK_OF_DECLARE(ti_dss_interface_clk, "ti,omap3-dss-interface-clock",
+	       of_ti_dss_interface_clk_setup);
+
+static int __init of_ti_ssi_interface_clk_setup(struct device_node *node)
+{
+	return _of_ti_interface_clk_setup(node,
+					  &clkhwops_omap3430es2_iclk_ssi_wait);
+}
+CLK_OF_DECLARE(ti_ssi_interface_clk, "ti,omap3-ssi-interface-clock",
+	       of_ti_ssi_interface_clk_setup);
+
+static int __init of_ti_am35xx_interface_clk_setup(struct device_node *node)
+{
+	return _of_ti_interface_clk_setup(node, &clkhwops_am35xx_ipss_wait);
+}
+CLK_OF_DECLARE(ti_am35xx_interface_clk, "ti,am35xx-interface-clock",
+	       of_ti_am35xx_interface_clk_setup);
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index f7287ef..45d9d52 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -258,6 +258,11 @@ extern const struct clk_hw_omap_ops clkhwops_omap4_dpllmx;
 extern const struct clk_hw_omap_ops clkhwops_wait;
 extern const struct clk_hw_omap_ops clkhwops_omap3430es2_dss_usbhost_wait;
 extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_module_wait;
+extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_wait;
+extern const struct clk_hw_omap_ops clkhwops_iclk;
 extern const struct clk_hw_omap_ops clkhwops_iclk_wait;
+extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_ssi_wait;
+extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_dss_usbhost_wait;
+extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_hsotgusb_wait;
 
 #endif
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
