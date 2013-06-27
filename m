From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 2/4] ARM: OMAP5: clockdomain data: add init file for omap54xx
Date: Thu, 27 Jun 2013 11:38:17 +0300
Message-ID: <1372322299-25046-3-git-send-email-t-kristo@ti.com>
References: <1372322299-25046-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1372322299-25046-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, mturquette@linaro.org, nm@ti.com, rnayak@ti.com
Cc: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

cclock54xx_data.c now contains only init function and the clkdev mapping
that is still needed by some drivers. Eventually most of this file can
be removed, once a common location for the clk init can be found, and
the clkdev mapping is no longer needed.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cclock54xx_data.c |   80 +++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 arch/arm/mach-omap2/cclock54xx_data.c

diff --git a/arch/arm/mach-omap2/cclock54xx_data.c b/arch/arm/mach-omap2/cclock54xx_data.c
new file mode 100644
index 0000000..f23f44e
--- /dev/null
+++ b/arch/arm/mach-omap2/cclock54xx_data.c
@@ -0,0 +1,74 @@
+/*
+ * OMAP54xx Clock data
+ *
+ * Copyright (C) 2013 Texas Instruments, Inc.
+ *
+ * Paul Walmsley (paul@pwsan.com)
+ * Rajendra Nayak (rnayak@ti.com)
+ * Benoit Cousson (b-cousson@ti.com)
+ * Mike Turquette (mturquette@linaro.org)
+ * Tero Kristo (t-kristo@ti.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/clkdev.h>
+#include <linux/io.h>
+#include <linux/clk-provider.h>
+#include <linux/clk/omap.h>
+
+#include "soc.h"
+#include "clock.h"
+
+#define OMAP5_DPLL_ABE_DEFFREQ				98304000
+
+/*
+ * clkdev
+ */
+static struct omap_dt_clk omap54xx_clks[] = {
+	DT_CLK(NULL,	"timer_32k_ck",	"sys_32k_ck"),
+	DT_CLK("omap_timer.1",	"sys_ck",		"sys_clkin"),
+	DT_CLK("omap_timer.2",	"sys_ck",		"sys_clkin"),
+	DT_CLK("omap_timer.3",	"sys_ck",		"sys_clkin"),
+	DT_CLK("omap_timer.4",	"sys_ck",		"sys_clkin"),
+	DT_CLK("omap_timer.9",	"sys_ck",		"sys_clkin"),
+	DT_CLK("omap_timer.10",	"sys_ck",		"sys_clkin"),
+	DT_CLK("omap_timer.11",	"sys_ck",		"sys_clkin"),
+	DT_CLK("omap_timer.5",	"sys_ck",		"dss_syc_gfclk_div"),
+	DT_CLK("omap_timer.6",	"sys_ck",		"dss_syc_gfclk_div"),
+	DT_CLK("omap_timer.7",	"sys_ck",		"dss_syc_gfclk_div"),
+	DT_CLK("omap_timer.8",	"sys_ck",		"dss_syc_gfclk_div"),
+};
+
+int __init omap5xxx_clk_init(void)
+{
+	struct clk *abe_dpll_ref, *sys_32k_ck, *abe_dpll;
+	int rc;
+
+	/*
+	 * Must stay commented until all OMAP SoC drivers are
+	 * converted to runtime PM, or drivers may start crashing
+	 *
+	 * omap2_clk_disable_clkdm_control();
+	 */
+	dt_omap_clk_init();
+
+	omap_dt_clocks_register(omap54xx_clks, ARRAY_SIZE(omap54xx_clks));
+
+	omap2_clk_disable_autoidle_all();
+
+	abe_dpll_ref = clk_get_sys(NULL, "abe_dpll_clk_mux");
+	sys_32k_ck = clk_get_sys(NULL, "sys_32k_ck");
+	rc = clk_set_parent(abe_dpll_ref, sys_32k_ck);
+	abe_dpll = clk_get_sys(NULL, "dpll_abe_ck");
+	if (!rc)
+		rc = clk_set_rate(abe_dpll, OMAP5_DPLL_ABE_DEFFREQ);
+	if (rc)
+		pr_err("%s: failed to configure ABE DPLL!\n", __func__);
+
+	return 0;
+}
-- 
1.7.9.5
