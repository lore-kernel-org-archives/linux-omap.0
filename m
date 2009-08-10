From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] OMAP3: PM : Set DSP frequency corresponding to mpurate
Date: Mon, 10 Aug 2009 15:55:09 +0530
Message-ID: <1249899909-5848-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35886 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752484AbZHJKZQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Aug 2009 06:25:16 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n7AAPADX010267
	for <linux-omap@vger.kernel.org>; Mon, 10 Aug 2009 05:25:16 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

Argument 'mpurate' is used to change the MPU frequency
at boot time. This patch changes the DSP frequency as
per the OPP definition corresponding to the mpurate

It also verifies if the specified mpurate is valid in
the OPP table.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/clock34xx.c |   45 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index c956fdc..b22d1f7 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -43,6 +43,7 @@
 #include "prm-regbits-34xx.h"
 #include "cm.h"
 #include "cm-regbits-34xx.h"
+#include "omap3-opp.h"
 
 static const struct clkops clkops_noncore_dpll_ops;
 
@@ -1103,6 +1104,11 @@ void omap2_clk_prepare_for_reboot(void)
  */
 static int __init omap2_clk_arch_init(void)
 {
+	short opp=0, valid=0;
+	short i;
+	unsigned long dsprate;
+	struct omap_opp *opp_table;
+
 	if (!mpurate)
 		return -EINVAL;
 
@@ -1111,16 +1117,53 @@ static int __init omap2_clk_arch_init(void)
 	if (clk_set_rate(&virt_prcm_set, mpurate))
 		printk(KERN_ERR "Could not find matching MPU rate\n");
 #endif
+	/* Check if mpurate is valid */
+	if (mpu_opps) {
+		opp_table = mpu_opps;
+
+		for (i = 1; opp_table[i].opp_id <= MAX_VDD1_OPP; i++) {
+			if (opp_table[i].rate == mpurate) {
+				valid = 1;
+				break;
+			}
+		}
+
+		if (valid) {
+			opp = opp_table[i].opp_id;
+			pr_debug("Switching to OPP:%d\n", opp);
+		} else {
+			printk(KERN_ERR "*** Invalid MPU rate specified\n");
+			return 1;
+		}
+	}
+
 	if (clk_set_rate(&dpll1_ck, mpurate))
 		printk(KERN_ERR "*** Unable to set MPU rate\n");
 	omap3_dpll_recalc(&dpll1_ck);
 
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
 
 	printk(KERN_INFO "Switched to new clocking rate (Crystal/Core/MPU): "
 	       "%ld.%01ld/%ld/%ld MHz\n",
 	       (osc_sys_ck.rate / 1000000), ((osc_sys_ck.rate / 100000) % 10),
 	       (core_ck.rate / 1000000), (arm_fck.rate / 1000000)) ;
+	printk(KERN_INFO "IVA2 clocking rate: %ld MHz\n",
+	       (iva2_ck.rate / 1000000)) ;
 
 	calibrate_delay();
 
@@ -1185,6 +1228,8 @@ int __init omap2_clk_init(void)
 	       "%ld.%01ld/%ld/%ld MHz\n",
 	       (osc_sys_ck.rate / 1000000), (osc_sys_ck.rate / 100000) % 10,
 	       (core_ck.rate / 1000000), (arm_fck.rate / 1000000));
+	printk(KERN_INFO "IVA2 clocking rate: %ld MHz\n",
+	       (iva2_ck.rate / 1000000)) ;
 
 	/*
 	 * Only enable those clocks we will need, let the drivers
-- 
1.6.2.2

