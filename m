From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv9 10/43] clk: ti: add support for TI fixed factor clock
Date: Fri, 25 Oct 2013 18:57:04 +0300
Message-ID: <1382716658-6964-11-git-send-email-t-kristo@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53322 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752548Ab3JYP6x (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Oct 2013 11:58:53 -0400
In-Reply-To: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

This behaves exactly in similar manner to basic fixed-factor-clock, but
adds a few properties on top for handling clock hardware autoidling.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../bindings/clock/ti/fixed-factor-clock.txt       |   29 +++++++++
 drivers/clk/ti/Makefile                            |    2 +-
 drivers/clk/ti/fixed-factor.c                      |   65 ++++++++++++++++++++
 3 files changed, 95 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/fixed-factor-clock.txt
 create mode 100644 drivers/clk/ti/fixed-factor.c

diff --git a/Documentation/devicetree/bindings/clock/ti/fixed-factor-clock.txt b/Documentation/devicetree/bindings/clock/ti/fixed-factor-clock.txt
new file mode 100644
index 0000000..60b9e34
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti/fixed-factor-clock.txt
@@ -0,0 +1,29 @@
+Binding for TI fixed factor rate clock sources.
+
+Binding status: Unstable - ABI compatibility may be broken in the future
+
+This binding uses the common clock binding[1].
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- compatible : shall be "ti,fixed-factor-clock".
+- #clock-cells : from common clock binding; shall be set to 0.
+- ti,clock-div: fixed divider.
+- ti,clock-mult: fixed multiplier.
+- clocks: parent clock.
+
+Optional properties:
+- ti,autoidle-shift: bit shift of the autoidle enable bit for the clock
+- reg: offset for the autoidle register of this clock
+- ti,invert-autoidle-bit: autoidle is enabled by setting the bit to 0
+- ti,set-rate-parent: clk_set_rate is propagated to parent
+
+Example:
+	clock {
+		compatible = "ti,fixed-factor-clock";
+		clocks = <&parentclk>;
+		#clock-cells = <0>;
+		ti,clock-div = <2>;
+		ti,clock-mult = <1>;
+	};
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index 640ebf9..f57fc4b 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -1,4 +1,4 @@
 ifneq ($(CONFIG_OF),)
 obj-y					+= clk.o dpll.o autoidle.o divider.o \
-					   composite.o
+					   fixed-factor.o composite.o
 endif
diff --git a/drivers/clk/ti/fixed-factor.c b/drivers/clk/ti/fixed-factor.c
new file mode 100644
index 0000000..e0549c6
--- /dev/null
+++ b/drivers/clk/ti/fixed-factor.c
@@ -0,0 +1,65 @@
+/*
+ * TI Fixed Factor Clock
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
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/clk/ti.h>
+
+/**
+ * of_ti_fixed_factor_clk_setup() - Setup function for TI fixed factor clock
+ */
+static int __init of_ti_fixed_factor_clk_setup(struct device_node *node,
+					       struct regmap *regmap)
+{
+	struct clk *clk;
+	const char *clk_name = node->name;
+	const char *parent_name;
+	u32 div, mult;
+	u32 flags = 0;
+
+	if (of_property_read_u32(node, "ti,clock-div", &div)) {
+		pr_err("%s Fixed factor clock <%s> must have a clock-div property\n",
+		       __func__, node->name);
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32(node, "ti,clock-mult", &mult)) {
+		pr_err("%s Fixed factor clock <%s> must have a clokc-mult property\n",
+		       __func__, node->name);
+		return -EINVAL;
+	}
+
+	if (of_property_read_bool(node, "ti,set-rate-parent"))
+		flags |= CLK_SET_RATE_PARENT;
+
+	parent_name = of_clk_get_parent_name(node, 0);
+
+	clk = clk_register_fixed_factor(NULL, clk_name, parent_name, flags,
+					mult, div);
+
+	if (!IS_ERR(clk)) {
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+		return of_ti_autoidle_setup(node, regmap);
+	}
+
+	return PTR_ERR(clk);
+}
+CLK_OF_DECLARE(ti_fixed_factor_clk, "ti,fixed-factor-clock",
+	       of_ti_fixed_factor_clk_setup);
-- 
1.7.9.5

