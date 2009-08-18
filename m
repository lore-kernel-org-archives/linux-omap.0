From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 03/11] OMAP3 clock: Fixed processing of bootarg 'mpurate'
Date: Tue, 18 Aug 2009 14:56:24 +0300
Message-ID: <20090818115623.14171.6386.stgit@localhost.localdomain>
References: <20090818115147.14171.55785.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090818115147.14171.55785.stgit-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, linux-arm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sanjeev Premi <premi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Sanjeev Premi <premi-l0cyMroinI0@public.gmane.org>

The argument 'mpurate' had no effect on the MPU
frequency. This patch fixes the same.

Signed-off-by: Sanjeev Premi <premi-l0cyMroinI0@public.gmane.org>
Signed-off-by: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
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


--
To unsubscribe from this list: send the line "unsubscribe linux-arm" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
