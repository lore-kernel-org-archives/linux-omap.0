From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 4/4] ARM: DRA7: clockdomain data: add init file for dra7
Date: Thu, 27 Jun 2013 11:38:19 +0300
Message-ID: <1372322299-25046-5-git-send-email-t-kristo@ti.com>
References: <1372322299-25046-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53597 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752426Ab3F0IjT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Jun 2013 04:39:19 -0400
In-Reply-To: <1372322299-25046-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, mturquette@linaro.org, nm@ti.com, rnayak@ti.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

cclock7xx_data.c now contains only init function and the clkdev mapping
that is still needed by some drivers. Eventually most of this file can
be removed, once a common location for the clk init can be found, and
the clkdev mapping is no longer needed.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cclock7xx_data.c |   93 ++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 arch/arm/mach-omap2/cclock7xx_data.c

diff --git a/arch/arm/mach-omap2/cclock7xx_data.c b/arch/arm/mach-omap2/cclock7xx_data.c
new file mode 100644
index 0000000..dba528a
--- /dev/null
+++ b/arch/arm/mach-omap2/cclock7xx_data.c
@@ -0,0 +1,83 @@
+/*
+ * DRA7xx Clock data
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
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/io.h>
+#include <linux/clk/omap.h>
+
+#include "soc.h"
+#include "clock.h"
+
+#define DRA7_DPLL_ABE_DEFFREQ			361267200
+#define DRA7_DPLL_GMAC_DEFFREQ			1000000000
+
+/*
+ * clkdev
+ */
+
+static struct omap_dt_clk dra7xx_clks[] = {
+	DT_CLK(NULL,	"timer_32k_ck",		"sys_32k_ck"),
+	DT_CLK("4ae18000.timer",	"timer_sys_ck",		"sys_clkin2"),
+	DT_CLK("48032000.timer",	"timer_sys_ck",		"sys_clkin2"),
+	DT_CLK("48034000.timer",	"timer_sys_ck",		"sys_clkin2"),
+	DT_CLK("48036000.timer",	"timer_sys_ck",		"sys_clkin2"),
+	DT_CLK("4803e000.timer",	"timer_sys_ck",		"sys_clkin2"),
+	DT_CLK("48086000.timer",	"timer_sys_ck",		"sys_clkin2"),
+	DT_CLK("48088000.timer",	"timer_sys_ck",		"sys_clkin2"),
+	DT_CLK("48820000.timer",	"timer_sys_ck",		"timer_sys_clk_div"),
+	DT_CLK("48822000.timer",	"timer_sys_ck",		"timer_sys_clk_div"),
+	DT_CLK("48824000.timer",	"timer_sys_ck",		"timer_sys_clk_div"),
+	DT_CLK("48826000.timer",	"timer_sys_ck",		"timer_sys_clk_div"),
+	DT_CLK(NULL,       "sys_clkin",                    "sys_clkin1"),
+};
+
+int __init dra7xx_clk_init(void)
+{
+	struct clk *abe_dpll_mux, *sys_clkin2, *dpll_ck;
+	int rc;
+	/*
+	 * Must stay commented until all OMAP SoC drivers are
+	 * converted to runtime PM, or drivers may start crashing
+	 *
+	 * omap2_clk_disable_clkdm_control();
+	 */
+
+	dt_omap_clk_init();
+
+	omap_dt_clocks_register(dra7xx_clks, ARRAY_SIZE(dra7xx_clks));
+
+	omap2_clk_disable_autoidle_all();
+
+	abe_dpll_mux = clk_get_sys(NULL, "abe_dpll_sys_clk_mux");
+	sys_clkin2 = clk_get_sys(NULL, "sys_clkin2");
+	dpll_ck = clk_get_sys(NULL, "dpll_abe_ck");
+
+	rc = clk_set_parent(abe_dpll_mux, sys_clkin2);
+	if (!rc)
+		rc = clk_set_rate(dpll_ck, DRA7_DPLL_ABE_DEFFREQ);
+	if (rc)
+		pr_err("%s: failed to configure ABE DPLL!\n", __func__);
+
+	dpll_ck = clk_get_sys(NULL, "dpll_gmac_ck");
+	rc = clk_set_rate(dpll_ck, DRA7_DPLL_GMAC_DEFFREQ);
+	if (rc)
+		pr_err("%s: failed to configure GMAC DPLL!\n", __func__);
+
+	return 0;
+}
-- 
1.7.9.5

