From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC 6/8] CLK: OMAP4: add support for the new clock init code
Date: Thu, 21 Mar 2013 19:35:45 +0200
Message-ID: <1363887347-4686-7-git-send-email-t-kristo@ti.com>
References: <1363887347-4686-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44980 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694Ab3CURhA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Mar 2013 13:37:00 -0400
In-Reply-To: <1363887347-4686-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, khilman@linaro.org, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@linaro.org>

Modifies the omap4 clock init code to support the new clock
registration method.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Mike Turquette <mturquette@linaro.org>
---
 drivers/clk/omap/cclock44xx_data.c |   52 ++++++++++++++---------------------
 1 files changed, 21 insertions(+), 31 deletions(-)

diff --git a/drivers/clk/omap/cclock44xx_data.c b/drivers/clk/omap/cclock44xx_data.c
index 25285a3..aba9bcb 100644
--- a/drivers/clk/omap/cclock44xx_data.c
+++ b/drivers/clk/omap/cclock44xx_data.c
@@ -20,20 +20,15 @@
 
 #include <linux/kernel.h>
 #include <linux/list.h>
-#include <linux/clk-private.h>
+#include <linux/clk-provider.h>
 #include <linux/clkdev.h>
 #include <linux/io.h>
 
-#include "soc.h"
-#include "iomap.h"
 #include "clock.h"
-#include "clock44xx.h"
 #include "cm1_44xx.h"
 #include "cm2_44xx.h"
 #include "cm-regbits-44xx.h"
 #include "prm44xx.h"
-#include "prm-regbits-44xx.h"
-#include "control.h"
 #include "scrm44xx.h"
 
 /* OMAP4 modulemode control */
@@ -48,6 +43,13 @@
  */
 #define OMAP4_DPLL_ABE_DEFFREQ				98304000
 
+enum {
+	OMAP4_CM1_INDEX = 1,
+	OMAP4_CM2_INDEX,
+	OMAP4_PRM_INDEX,
+	OMAP4_SCRM_INDEX
+};
+
 /* Root clocks */
 
 OMAP_CLK_FIXED_RATE(extalt_clkin_ck, CLK_IS_ROOT, 59000000, 0x0);
@@ -1925,37 +1927,24 @@ static const char *enable_init_clks[] = {
 
 int __init omap4xxx_clk_init(void)
 {
-	u32 cpu_clkflg;
-	struct omap_clk *c;
-	int rc;
-
-	if (cpu_is_omap443x()) {
-		cpu_mask = RATE_IN_4430;
-		cpu_clkflg = CK_443X;
-	} else if (cpu_is_omap446x() || cpu_is_omap447x()) {
-		cpu_mask = RATE_IN_4460 | RATE_IN_4430;
-		cpu_clkflg = CK_446X | CK_443X;
-
-		if (cpu_is_omap447x())
-			pr_warn("WARNING: OMAP4470 clock data incomplete!\n");
-	} else {
-		return 0;
-	}
-
-	for (c = omap44xx_clks; c < omap44xx_clks + ARRAY_SIZE(omap44xx_clks);
-									c++) {
-		if (c->cpu & cpu_clkflg) {
-			clkdev_add(&c->lk);
-			if (!__clk_init(NULL, c->lk.clk))
-				omap2_init_clk_hw_omap_clocks(c->lk.clk);
-		}
-	}
+	void __iomem *base[5];
+
+	base[OMAP4_CM1_INDEX] = ioremap(OMAP4430_CM1_BASE, SZ_64K);
+	base[OMAP4_CM2_INDEX] = ioremap(OMAP4430_CM2_BASE, SZ_64K);
+	base[OMAP4_PRM_INDEX] = ioremap(OMAP4430_PRM_BASE, SZ_64K);
+	base[OMAP4_SCRM_INDEX] = ioremap(OMAP4_SCRM_BASE, SZ_64K);
+
+	cpu_mask = RATE_IN_4430;
+
+	omap_clk_register_clks(omap44xx_clks, ARRAY_SIZE(omap44xx_clks),
+				CK_443X, base);
 
 	omap2_clk_disable_autoidle_all();
 
 	omap2_clk_enable_init_clocks(enable_init_clks,
 				     ARRAY_SIZE(enable_init_clks));
 
+#if 0
 	/*
 	 * On OMAP4460 the ABE DPLL fails to turn on if in idle low-power
 	 * state when turning the ABE clock domain. Workaround this by
@@ -1967,6 +1956,7 @@ int __init omap4xxx_clk_init(void)
 		rc = clk_set_rate(&dpll_abe_ck, OMAP4_DPLL_ABE_DEFFREQ);
 	if (rc)
 		pr_err("%s: failed to configure ABE DPLL!\n", __func__);
+#endif
 
 	return 0;
 }
-- 
1.7.4.1

