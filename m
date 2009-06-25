From: "Premi, Sanjeev" <premi@ti.com>
Subject: bootarg mpurate is  ignored
Date: Thu, 25 Jun 2009 22:36:35 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301D831853C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51507 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751304AbZFYRGp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jun 2009 13:06:45 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5PH6fF9012959
	for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 12:06:47 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n5PH6fIR003248
	for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 22:36:41 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

I was trying to change the MPU frequency by using the bootarg mpurate.
But there was no impact of the same.

In the bootlog:
...
...
Clocking rate (Crystal/DPLL/ARM core): 26.0/332/500 MHz
...later..
Switched to new clocking rate (Crystal/Core/MPU): 26.0/332/500 MHz
...
...

>From the code, it clearly seemed to be ignored. So, I made the change below:

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 045da92..5bdd978 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -948,13 +948,20 @@ static int __init omap2_clk_arch_init(void)
        if (clk_set_rate(&virt_prcm_set, mpurate))
                printk(KERN_ERR "Could not find matching MPU rate\n");
 #endif
+       printk(KERN_ERR "Before change: %ld\n", dpll1_ck.rate);
+
+       if (clk_set_rate(&dpll1_ck, mpurate))
+               printk(KERN_ERR "*** Unable to set MPU rate\n");
+       omap3_dpll_recalc(&dpll1_ck);
+
+       printk(KERN_ERR "After change: %ld\n", dpll1_ck.rate);

        recalculate_root_clocks();

-       printk(KERN_INFO "Switched to new clocking rate (Crystal/DPLL3/MPU): "
+       printk(KERN_INFO "Switched to new clocking rate (Crystal/Core/MPU): "
               "%ld.%01ld/%ld/%ld MHz\n",
               (osc_sys_ck.rate / 1000000), (osc_sys_ck.rate / 100000) % 10,
-              (core_ck.rate / 1000000), (dpll1_fck.rate / 1000000)) ;
+              (core_ck.rate / 1000000), (dpll1_ck.rate / 1000000)) ;

        return 0;
 }

Now the bootlog seems fine:
...
...
Clocking rate (Crystal/DPLL/ARM core): 26.0/332/500 MHz
...later..
Switched to new clocking rate (Crystal/Core/MPU): 26.0/332/550 MHz
...
...
However, cat /cpu/procinfo still shows:
Processor       : ARMv7 Processor rev 3 (v7l)
BogoMIPS        : 499.92
Features        : swp half thumb fastmult vfp edsp neon vfpv3
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x1
CPU part        : 0xc08
CPU revision    : 3

Am I missing some step here?
Also, I tried changing arm_ck directly (evidently not right) as well :(
	
Best regards,
Sanjeev
