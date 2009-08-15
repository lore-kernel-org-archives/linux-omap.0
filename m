From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 03/13] [PATCH] OMAP3 clock: Fixed processing of bootarg
	'mpurate'
Date: Sat, 15 Aug 2009 14:19:44 +0300
Message-ID: <20090815111938.7384.72648.stgit@localhost.localdomain>
References: <20090815111704.7384.31564.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:32955 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283AbZHOL0N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Aug 2009 07:26:13 -0400
In-Reply-To: <20090815111704.7384.31564.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-arm@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

From: Sanjeev Premi <premi@ti.com>

The argument 'mpurate' had no effect on the MPU
frequency. This patch fixes the same.

Signed-off-by: Sanjeev Premi <premi@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock34xx.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index cd7819c..fafcd32 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -27,6 +27,7 @@
 #include <linux/limits.h>
 #include <linux/bitops.h>
 
+#include <mach/cpu.h>
 #include <mach/clock.h>
 #include <mach/sram.h>
 #include <asm/div64.h>
@@ -1067,17 +1068,17 @@ static int __init omap2_clk_arch_init(void)
 		return -EINVAL;
 
 	/* REVISIT: not yet ready for 343x */
-#if 0
-	if (clk_set_rate(&virt_prcm_set, mpurate))
-		printk(KERN_ERR "Could not find matching MPU rate\n");
-#endif
+	if (clk_set_rate(&dpll1_ck, mpurate))
+		printk(KERN_ERR "*** Unable to set MPU rate\n");
 
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
@@ -1136,7 +1137,7 @@ int __init omap2_clk_init(void)
 
 	recalculate_root_clocks();
 
-	printk(KERN_INFO "Clocking rate (Crystal/DPLL/ARM core): "
+	printk(KERN_INFO "Clocking rate (Crystal/Core/MPU): "
 	       "%ld.%01ld/%ld/%ld MHz\n",
 	       (osc_sys_ck.rate / 1000000), (osc_sys_ck.rate / 100000) % 10,
 	       (core_ck.rate / 1000000), (arm_fck.rate / 1000000));


