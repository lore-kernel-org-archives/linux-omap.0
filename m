From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv7 05/36] clk: ti: add support for TI fixed factor clock
Date: Wed, 25 Sep 2013 11:48:11 +0300
Message-ID: <1380098922-30340-6-git-send-email-t-kristo@ti.com>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380098922-30340-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This behaves exactly in similar manner to basic fixed-factor-clock, but
adds a few properties on top for handling clock hardware autoidling.

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 .../bindings/clock/ti/fixed-factor-clock.txt       |   27 +++++++++
 drivers/clk/ti/Makefile                            |    3 +-
 drivers/clk/ti/fixed-factor.c                      |   62 ++++++++++++++++++++
 3 files changed, 91 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/fixed-factor-clock.txt
 create mode 100644 drivers/clk/ti/fixed-factor.c

diff --git a/Documentation/devicetree/bindings/clock/ti/fixed-factor-clock.txt b/Documentation/devicetree/bindings/clock/ti/fixed-factor-clock.txt
new file mode 100644
index 0000000..e58762b
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti/fixed-factor-clock.txt
@@ -0,0 +1,27 @@
+Binding for TI fixed factor rate clock sources.
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
