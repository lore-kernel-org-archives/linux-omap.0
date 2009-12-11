From: "Reddy, Teerth" <teerth@ti.com>
Subject: [PATCH] OMAP3: PM:  Dynamic calculation of SDRC clock stabilization
 delay
Date: Fri, 11 Dec 2009 16:05:05 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030ADD4AE9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59086 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757138AbZLKKfD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 05:35:03 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id nBBAZ7pr003039
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 11 Dec 2009 04:35:09 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nBBAZ64G015265
	for <linux-omap@vger.kernel.org>; Fri, 11 Dec 2009 16:05:06 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Teerth Reddy <teerth@ti.com>

This patch sets the dpll3 clock stabilization delay during
DVFS. The stabilization delay is calculated dynamically 
using the ARM performance counter.
Currently 6us of SDRC stabilization value is used to get 
the correct delay.

Signed-off-by: Romit Dasgupta <romit@ti.com>
Signed-off-by: Teerth Reddy <teerth@ti.com>
---
 arch/arm/mach-omap2/clock34xx.c        |   32 ++++++++++------------
 arch/arm/mach-omap2/sram34xx.S         |    7 ++++
 arch/arm/plat-omap/Makefile            |    1 
 arch/arm/plat-omap/include/plat/pmc.h  |    9 ++++++
 arch/arm/plat-omap/include/plat/sram.h |    6 ++++
 arch/arm/plat-omap/pmc.c               |   47 +++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/sram.c              |   23 ++++++++++++++++
 7 files changed, 108 insertions(+), 17 deletions(-)

Index: linux-omap-pm/arch/arm/plat-omap/Makefile
===================================================================
--- linux-omap-pm.orig/arch/arm/plat-omap/Makefile	2009-12-08 20:12:15.000000000 +0530
+++ linux-omap-pm/arch/arm/plat-omap/Makefile	2009-12-09 11:30:58.000000000 +0530
@@ -15,6 +15,7 @@
 # omap_device support (OMAP2+ only at the moment)
 obj-$(CONFIG_ARCH_OMAP2) += omap_device.o
 obj-$(CONFIG_ARCH_OMAP3) += omap_device.o
+obj-$(CONFIG_ARCH_OMAP3) += pmc.o
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 obj-$(CONFIG_OMAP_IOMMU) += iommu.o iovmm.o
Index: linux-omap-pm/arch/arm/plat-omap/include/plat/pmc.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap-pm/arch/arm/plat-omap/include/plat/pmc.h	2009-12-09 11:30:58.000000000 +0530
@@ -0,0 +1,9 @@
+#ifndef __PMC_H__
+#define __PMC_H__
+extern void start_perf_counter(void);
+extern void start_cycle_counter(void);
+extern void stop_cycle_counter(void);
+extern void stop_perf_counter(void);
+extern unsigned int cycle_count(void);
+extern unsigned int delay_sram;
+#endif
Index: linux-omap-pm/arch/arm/plat-omap/include/plat/sram.h
===================================================================
--- linux-omap-pm.orig/arch/arm/plat-omap/include/plat/sram.h	2009-12-08 20:12:15.000000000 +0530
+++ linux-omap-pm/arch/arm/plat-omap/include/plat/sram.h	2009-12-09 11:30:58.000000000 +0530
@@ -69,6 +69,12 @@
 			u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1);
 extern unsigned long omap3_sram_configure_core_dpll_sz;
 
+extern unsigned int measure_sram_delay(unsigned int);
+
+extern u32 __sram_wait_delay(
+		unsigned int);
+extern unsigned long __sram_wait_delay_sz;
+
 #ifdef CONFIG_PM
 extern void omap_push_sram_idle(void);
 #else
Index: linux-omap-pm/arch/arm/plat-omap/pmc.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-omap-pm/arch/arm/plat-omap/pmc.c	2009-12-09 11:30:58.000000000 +0530
@@ -0,0 +1,47 @@
+#include <linux/module.h>
+
+void start_perf_counter(void)
+{
+	unsigned int r1 = 0;
+	asm("mrc p15, 0, %0, c9, c12, 0" : "=r" (r1));
+	r1 |= 0x1; /* enable counters */
+	asm("mcr p15, 0, %0, c9, c12, 0" : : "r" (r1));
+	return;
+}
+EXPORT_SYMBOL(start_perf_counter);
+
+void start_cycle_counter(void)
+{
+	unsigned int r2 = 0;
+	r2 = 0x80000000; /* enable cycle counter only */
+	asm("mcr p15, 0, %0, c9, c12, 1" : : "r" (r2));
+	return;
+}
+EXPORT_SYMBOL(start_cycle_counter);
+
+unsigned int cycle_count(void)
+{
+	unsigned int rd = 0;
+	asm("mrc p15, 0, %0, c9, c13, 0" : "=r" (rd));
+	return rd;
+}
+EXPORT_SYMBOL(cycle_count);
+
+
+void stop_cycle_counter(void)
+{
+	unsigned int r3 = 0;
+	r3 = 0x0; /* disable cycle counter */
+	asm("mcr p15, 0, %0, c9, c12, 1" : : "r" (r3));
+	return;
+}
+EXPORT_SYMBOL(stop_cycle_counter);
+
+void stop_perf_counter(void)
+{
+	unsigned int r1 = 0;
+	r1 = 0x0; /* disable counters */
+	asm("mcr p15, 0, %0, c9, c12, 0" : : "r" (r1));
+	return;
+}
+EXPORT_SYMBOL(stop_perf_counter);
Index: linux-omap-pm/arch/arm/plat-omap/sram.c
===================================================================
--- linux-omap-pm.orig/arch/arm/plat-omap/sram.c	2009-12-08 20:12:15.000000000 +0530
+++ linux-omap-pm/arch/arm/plat-omap/sram.c	2009-12-09 14:00:56.000000000 +0530
@@ -29,6 +29,10 @@
 #include <plat/board.h>
 #include <plat/cpu.h>
 
+#ifdef CONFIG_ARCH_OMAP3
+#include <plat/pmc.h>
+#endif
+
 #include <plat/control.h>
 
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
@@ -423,6 +427,25 @@
 }
 #endif
 
+
+#ifdef CONFIG_ARCH_OMAP3
+unsigned int measure_sram_delay(unsigned int loop)
+{
+	unsigned int start = 0, end = 0;
+	void (*_omap3_sram_delay)(unsigned long);
+	_omap3_sram_delay = omap_sram_push(__sram_wait_delay,
+						__sram_wait_delay_sz);
+	start_perf_counter();
+	start_cycle_counter();
+	start = cycle_count();
+	_omap3_sram_delay(loop);
+	end = cycle_count();
+	stop_cycle_counter();
+	stop_perf_counter();
+	return end - start;
+}
+#endif
+
 int __init omap_sram_init(void)
 {
 	omap_detect_sram();
Index: linux-omap-pm/arch/arm/mach-omap2/clock34xx.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/clock34xx.c	2009-12-08 20:12:15.000000000 +0530
+++ linux-omap-pm/arch/arm/mach-omap2/clock34xx.c	2009-12-11 14:38:38.000000000 +0530
@@ -37,6 +37,8 @@
 #include <asm/div64.h>
 #include <asm/clkdev.h>
 
+#include <plat/pmc.h>
+
 #include <plat/sdrc.h>
 #include "clock.h"
 #include "prm.h"
@@ -46,6 +48,8 @@
 
 static const struct clkops clkops_noncore_dpll_ops;
 
+unsigned int delay_sram;
+
 static void omap3430es2_clk_ssi_find_idlest(struct clk *clk,
 					    void __iomem **idlest_reg,
 					    u8 *idlest_bit);
@@ -333,14 +337,9 @@
 /* Scale factor for fixed-point arith in omap3_core_dpll_m2_set_rate() */
 #define SDRC_MPURATE_SCALE		8
 
-/* 2^SDRC_MPURATE_BASE_SHIFT: MPU MHz that SDRC_MPURATE_LOOPS is defined for */
-#define SDRC_MPURATE_BASE_SHIFT		9
-
-/*
- * SDRC_MPURATE_LOOPS: Number of MPU loops to execute at
- * 2^MPURATE_BASE_SHIFT MHz for SDRC to stabilize
- */
-#define SDRC_MPURATE_LOOPS		96
+/* SDRC_TIME_STABILIZE: Time for SDRC to stabilize in us */
+/* hardcode currently */
+#define	SDRC_TIME_STABILIZE		6
 
 /*
  * DPLL5_FREQ_FOR_USBHOST: USBHOST and USBTLL are the only clocks
@@ -870,16 +869,10 @@
 		unlock_dll = 1;
 	}
 
-	/*
-	 * XXX This only needs to be done when the CPU frequency changes
-	 */
+	/* Calculate the number of MPU cycles to wait for SDRC to stabilize */
+
 	mpurate = arm_fck.rate / CYCLES_PER_MHZ;
-	c = (mpurate << SDRC_MPURATE_SCALE) >> SDRC_MPURATE_BASE_SHIFT;
-	c += 1;  /* for safety */
-	c *= SDRC_MPURATE_LOOPS;
-	c >>= SDRC_MPURATE_SCALE;
-	if (c == 0)
-		c = 1;
+	c = ((SDRC_TIME_STABILIZE * mpurate) / (delay_sram * 2));
 
 	pr_debug("clock: changing CORE DPLL rate from %lu to %lu\n", clk->rate,
 		 validrate);
@@ -1228,6 +1221,11 @@
 	vclk = clk_get(NULL, "virt_prcm_set");
 	sclk = clk_get(NULL, "sys_ck");
 #endif
+
+	/* Measure sram delay */
+	delay_sram = measure_sram_delay(10000)/(10000*2);
+	pr_debug("SRAM delay: %d\n", delay_sram);
+
 	return 0;
 }
 
Index: linux-omap-pm/arch/arm/mach-omap2/sram34xx.S
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/sram34xx.S	2009-12-08 20:12:15.000000000 +0530
+++ linux-omap-pm/arch/arm/mach-omap2/sram34xx.S	2009-12-09 11:30:58.000000000 +0530
@@ -298,3 +298,10 @@
 ENTRY(omap3_sram_configure_core_dpll_sz)
 	.word	. - omap3_sram_configure_core_dpll
 
+ENTRY(__sram_wait_delay)
+	subs 	r0, r0, #1
+	bne	__sram_wait_delay
+	bx	lr
+
+ENTRY(__sram_wait_delay_sz)
+	.word	. - __sram_wait_delay
