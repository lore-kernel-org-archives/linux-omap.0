From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] Fixed processing of bootarg 'mpurate'
Date: Mon, 10 Aug 2009 15:54:53 +0530
Message-ID: <1249899893-5795-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42518 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752022AbZHJKZA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Aug 2009 06:25:00 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n7AAOtX7003264
	for <linux-omap@vger.kernel.org>; Mon, 10 Aug 2009 05:25:01 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

The argument 'mpurate' had no effect on the MPU
frequency. This patch fixes the same.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/clock34xx.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 045da92..0c62aad 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -27,6 +27,7 @@
 #include <linux/limits.h>
 #include <linux/bitops.h>
 
+#include <mach/cpu.h>
 #include <mach/clock.h>
 #include <mach/sram.h>
 #include <asm/div64.h>
@@ -948,13 +949,18 @@ static int __init omap2_clk_arch_init(void)
 	if (clk_set_rate(&virt_prcm_set, mpurate))
 		printk(KERN_ERR "Could not find matching MPU rate\n");
 #endif
+	if (clk_set_rate(&dpll1_ck, mpurate))
+		printk(KERN_ERR "*** Unable to set MPU rate\n");
+	omap3_dpll_recalc(&dpll1_ck);
 
 	recalculate_root_clocks();
 
-	printk(KERN_INFO "Switched to new clocking rate (Crystal/DPLL3/MPU): "
+	printk(KERN_INFO "Switched to new clocking rate (Crystal/Core/MPU): "
 	       "%ld.%01ld/%ld/%ld MHz\n",
-	       (osc_sys_ck.rate / 1000000), (osc_sys_ck.rate / 100000) % 10,
-	       (core_ck.rate / 1000000), (dpll1_fck.rate / 1000000)) ;
+	       (osc_sys_ck.rate / 1000000), ((osc_sys_ck.rate / 100000) % 10),
+	       (core_ck.rate / 1000000), (arm_fck.rate / 1000000)) ;
+
+	calibrate_delay();
 
 	return 0;
 }
@@ -1013,7 +1019,7 @@ int __init omap2_clk_init(void)
 
 	recalculate_root_clocks();
 
-	printk(KERN_INFO "Clocking rate (Crystal/DPLL/ARM core): "
+	printk(KERN_INFO "Clocking rate (Crystal/Core/MPU): "
 	       "%ld.%01ld/%ld/%ld MHz\n",
 	       (osc_sys_ck.rate / 1000000), (osc_sys_ck.rate / 100000) % 10,
 	       (core_ck.rate / 1000000), (arm_fck.rate / 1000000));
-- 
1.6.2.2

