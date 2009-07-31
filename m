From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] Fixed processing of bootarg 'mpurate'
Date: Fri, 31 Jul 2009 17:13:50 +0530
Message-ID: <1249040630-2712-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54716 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752021AbZGaLn6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Jul 2009 07:43:58 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n6VBhqee006187
	for <linux-omap@vger.kernel.org>; Fri, 31 Jul 2009 06:43:58 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

The argument 'mpurate' had no effect on the MPU
frequency. This patch fixes the same.

It also ensures that DSP frequency is set according
to the OPP definitions.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/clock34xx.c |   57 +++++++++++++++++++++++++++++++++++---
 1 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index c2e5ef8..a9e7e82 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -29,6 +29,7 @@
 #include <linux/err.h>
 #include <linux/cpufreq.h>
 
+#include <mach/cpu.h>
 #include <mach/clock.h>
 #include <mach/sram.h>
 #include <mach/omap-pm.h>
@@ -42,6 +43,7 @@
 #include "prm-regbits-34xx.h"
 #include "cm.h"
 #include "cm-regbits-34xx.h"
+#include "omap3-opp.h"
 
 static const struct clkops clkops_noncore_dpll_ops;
 
@@ -1083,6 +1085,11 @@ void omap2_clk_prepare_for_reboot(void)
  */
 static int __init omap2_clk_arch_init(void)
 {
+	unsigned short opp=0;
+	unsigned short i;
+	unsigned long dsprate;
+	struct omap_opp *opp_table;
+
 	if (!mpurate)
 		return -EINVAL;
 
@@ -1092,12 +1099,49 @@ static int __init omap2_clk_arch_init(void)
 		printk(KERN_ERR "Could not find matching MPU rate\n");
 #endif
 
+	if (clk_set_rate(&dpll1_ck, mpurate))
+		printk(KERN_ERR "*** Unable to set MPU rate\n");
+	omap3_dpll_recalc(&dpll1_ck);
+
+	/* Get the OPP corresponding to the mpurate */
+	if (mpu_opps) {
+		opp_table = mpu_opps;
+
+		for (i=0;  opp_table[i].opp_id <= MAX_VDD1_OPP; i++)
+			if (opp_table[i].rate == mpurate)
+				break;
+
+		opp = opp_table[i].opp_id;
+
+		pr_debug("Switched to OPP:%d\n", opp);
+	}
+
+	/* Get dsprate corresponding to the opp */
+	if ((dsp_opps) && (opp >= VDD1_OPP1) && (opp <= VDD1_OPP5)) {
+		opp_table = dsp_opps;
+
+		for (i=0;  opp_table[i].opp_id <= MAX_VDD1_OPP; i++)
+			if (opp_table[i].opp_id == opp)
+				break;
+
+		dsprate = opp_table[i].rate;
+
+		if (clk_set_rate(&dpll2_ck, dsprate))
+			printk(KERN_ERR "*** Unable to set IVA2 rate\n");
+		omap3_dpll_recalc(&dpll2_ck);
+	}
+
 	recalculate_root_clocks();
 
-	printk(KERN_INFO "Switched to new clocking rate (Crystal/DPLL3/MPU): "
+	printk(KERN_INFO "Switched to new clocking rate (Crystal/Core/MPU): "
 	       "%ld.%01ld/%ld/%ld MHz\n",
-	       (osc_sys_ck.rate / 1000000), (osc_sys_ck.rate / 100000) % 10,
-	       (core_ck.rate / 1000000), (dpll1_fck.rate / 1000000)) ;
+	       (osc_sys_ck.rate / 1000000), ((osc_sys_ck.rate / 100000) % 10),
+	       (core_ck.rate / 1000000), (dpll1_ck.rate / 1000000)) ;
+
+	printk(KERN_INFO "IVA2 clocking rate: %ld MHz\n",
+	       (dpll2_ck.rate / 1000000)) ;
+
+	calibrate_delay();
 
 	return 0;
 }
@@ -1156,10 +1200,13 @@ int __init omap2_clk_init(void)
 
 	recalculate_root_clocks();
 
-	printk(KERN_INFO "Clocking rate (Crystal/DPLL/ARM core): "
+	printk(KERN_INFO "Clocking rate (Crystal/DPLL/MPU core): "
 	       "%ld.%01ld/%ld/%ld MHz\n",
 	       (osc_sys_ck.rate / 1000000), (osc_sys_ck.rate / 100000) % 10,
-	       (core_ck.rate / 1000000), (arm_fck.rate / 1000000));
+               (core_ck.rate / 1000000), (dpll1_ck.rate / 1000000));
+
+	printk(KERN_INFO "IVA2 clocking rate: %ld MHz\n",
+	       (dpll2_ck.rate / 1000000)) ;
 
 	/*
 	 * Only enable those clocks we will need, let the drivers
-- 
1.6.2.2

