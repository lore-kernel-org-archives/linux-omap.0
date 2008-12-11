From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 12/23] OMAP3 clock: initialize SDRC timings at kernel start
Date: Thu, 11 Dec 2008 17:52:31 +0200
Message-ID: <1229010762-3150-13-git-send-email-tero.kristo@nokia.com>
References: <>
 <1229010762-3150-1-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-2-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-3-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-4-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-5-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-6-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-7-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-8-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-9-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-10-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-11-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-12-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:55862 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756222AbYLKP7Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 10:59:24 -0500
In-Reply-To: <1229010762-3150-12-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

From: Paul Walmsley <paul@pwsan.com>

On the OMAP3, initialize SDRC timings when the kernel boots.  This ensures
that the kernel is running with known, optimized SDRC timings, rather than
whatever was configured by the bootloader.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock34xx.c |    3 ---
 arch/arm/mach-omap2/io.c        |   36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index adf0be3..cea3840 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -495,9 +495,6 @@ static int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 	if (clk != &dpll3_m2_ck)
 		return -EINVAL;
 
-	if (rate == clk->rate)
-		return 0;
-
 	validrate = omap2_clksel_round_rate_div(clk, rate, &new_div);
 	if (validrate != rate)
 		return -EINVAL;
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 5b529ae..6fb6c29 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/clk.h>
 
 #include <asm/tlb.h>
 
@@ -198,6 +199,38 @@ void __init omap2_map_common_io(void)
 	omapfb_reserve_sdram();
 }
 
+/*
+ * omap2_init_reprogram_sdrc - reprogram SDRC timing parameters
+ *
+ * Sets the CORE DPLL3 M2 divider to the same value that it's at
+ * currently.  This has the effect of setting the SDRC SDRAM AC timing
+ * registers to the values currently defined by the kernel.  Currently
+ * only defined for OMAP3; will return 0 if called on OMAP2.  Returns
+ * -EINVAL if the dpll3_m2_ck cannot be found, 0 if called on OMAP2,
+ * or passes along the return value of clk_set_rate().
+ */
+static int __init _omap2_init_reprogram_sdrc(void)
+{
+	struct clk *dpll3_m2_ck;
+	int v = -EINVAL;
+
+	if (!cpu_is_omap34xx())
+		return 0;
+
+	dpll3_m2_ck = clk_get(NULL, "dpll3_m2_ck");
+	if (!dpll3_m2_ck)
+		return -EINVAL;
+
+	pr_info("Reprogramming SDRC\n");
+	v = clk_set_rate(dpll3_m2_ck, clk_get_rate(dpll3_m2_ck));
+	if (v)
+		pr_err("dpll3_m2_clk rate change failed: %d\n", v);
+
+	clk_put(dpll3_m2_ck);
+
+	return v;
+}
+
 void __init omap2_init_common_hw(struct omap_sdrc_params *sp,
 				 struct omap_opp *mpu_opps,
 				 struct omap_opp *dsp_opps,
@@ -212,5 +245,8 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sp,
 	omap2_clk_init();
 	omap_pm_if_init();
 	omap2_sdrc_init(sp);
+
+	_omap2_init_reprogram_sdrc();
+
 	gpmc_init();
 }
-- 
1.5.4.3

