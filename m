From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv8 05/36] clk: ti: add support for TI fixed factor clock
Date: Wed, 9 Oct 2013 18:30:36 +0300
Message-ID: <1381332668-962-6-git-send-email-t-kristo@ti.com>
References: <1381332668-962-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39977 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074Ab3JIPcs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Oct 2013 11:32:48 -0400
In-Reply-To: <1381332668-962-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

This behaves exactly in similar manner to basic fixed-factor-clock, but
adds a few properties on top for handling clock hardware autoidling.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 .../bindings/clock/ti/fixed-factor-clock.txt       |   29 +++++++++
 drivers/clk/ti/Makefile                            |    3 +-
 drivers/clk/ti/fixed-factor.c                      |   62 ++++++++++++++++++++
 3 files changed, 93 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/fixed-factor-clock.txt
 create mode 100644 drivers/clk/ti/fixed-factor.c

diff --git a/Documentation/devicetree/bindings/clock/ti/fixed-factor-clock.txt b/Documentation/devicetree/bindings/clock/ti/fixed-factor-clock.txt
new file mode 100644
index 0000000..beb77d1
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
+- reg: base address for the autoidle register of this clock
+- ti,autoidle-low: autoidle is enabled by setting the bit to 0
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
index 72a410b..a9b986a 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -1,3 +1,4 @@
 ifneq ($(CONFIG_OF),)
-obj-y					+= clk.o dpll.o autoidle.o divider.o
+obj-y					+= clk.o dpll.o autoidle.o divider.o \
+					   fixed-factor.o
 endif
diff --git a/drivers/clk/ti/fixed-factor.c b/drivers/clk/ti/fixed-factor.c
new file mode 100644
index 0000000..c3814ae
--- /dev/null
+++ b/drivers/clk/ti/fixed-factor.c
@@ -0,0 +1,62 @@
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
+static void __init of_ti_fixed_factor_clk_setup(struct device_node *node)
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
+		return;
+	}
+
+	if (of_property_read_u32(node, "ti,clock-mult", &mult)) {
+		pr_err("%s Fixed factor clock <%s> must have a clokc-mult property\n",
+		       __func__, node->name);
+		return;
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
+		of_ti_autoidle_setup(node);
+	}
+}
+CLK_OF_DECLARE(ti_fixed_factor_clk, "ti,fixed-factor-clock",
+	       of_ti_fixed_factor_clk_setup);
-- 
1.7.9.5

