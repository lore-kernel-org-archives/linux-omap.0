From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] omap4: Fix build break by moving omap_smc1 into a separate .S
Date: Thu, 11 Mar 2010 13:03:46 +0530
Message-ID: <1268292826-1937-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36800 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106Ab0CKHdx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 02:33:53 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch moves omap_smc1 function to a seperate omap44xx-smc.S file
and sets compile flags as -Wa,-march=armv7-a.

This fix was suggested by Tony Lindgren <tony@atomide.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
The patch is generated against the latest mainline and also applies
on l-o master. Below two dependencies to test this patch on l-o
master with multi-omap build
	1. Revert Tony's commit d2fe713acc5afc9664afff440b3abe133a1c529f
	   "omap3/4: Fix compile for omap_smc1"
	2. Apply Kevin's "[PATCH 0/2] fixes for broken PM init with multi-OMAP" 	   series
   
The patch is tested with multi-omap build on OMAP3430 and OMAP4430
SDPs.
 arch/arm/mach-omap2/Makefile        |    3 +++
 arch/arm/mach-omap2/board-4430sdp.c |   26 +-------------------------
 arch/arm/mach-omap2/omap44xx-smc.S  |   34 ++++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 25 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap44xx-smc.S

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 2069fb3..4b9fc57 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -22,6 +22,9 @@ obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 # SMP support ONLY available for OMAP4
 obj-$(CONFIG_SMP)			+= omap-smp.o omap-headsmp.o
 obj-$(CONFIG_LOCAL_TIMERS)		+= timer-mpu.o
+obj-$(CONFIG_ARCH_OMAP4)		+= omap44xx-smc.o
+
+AFLAGS_omap44xx-smc.o			:=-Wa,-march=armv7-a
 
 # Functions loaded to SRAM
 obj-$(CONFIG_ARCH_OMAP2420)		+= sram242x.o
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 180ac11..b88f28c 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -50,33 +50,9 @@ static struct omap_board_config_kernel sdp4430_config[] __initdata = {
 };
 
 #ifdef CONFIG_CACHE_L2X0
-noinline void omap_smc1(u32 fn, u32 arg)
-{
-	register u32 r12 asm("r12") = fn;
-	register u32 r0 asm("r0") = arg;
-
-	/* This is common routine cache secure monitor API used to
-	 * modify the PL310 secure registers.
-	 * r0 contains the value to be modified and "r12" contains
-	 * the monitor API number. It uses few CPU registers
-	 * internally and hence they need be backed up including
-	 * link register "lr".
-	 * Explicitly save r11 and r12 the compiler generated code
-	 * won't save it.
-	 */
-	asm volatile(
-		"stmfd r13!, {r11,r12}\n"
-		"dsb\n"
-		"smc\n"
-		"ldmfd r13!, {r11,r12}\n"
-		: "+r" (r0), "+r" (r12)
-		:
-		: "r4", "r5", "r10", "lr", "cc");
-}
-EXPORT_SYMBOL(omap_smc1);
-
 static int __init omap_l2_cache_init(void)
 {
+	extern void omap_smc1(u32 fn, u32 arg);
 	void __iomem *l2cache_base;
 
 	/* To avoid code running on other OMAPs in
diff --git a/arch/arm/mach-omap2/omap44xx-smc.S b/arch/arm/mach-omap2/omap44xx-smc.S
new file mode 100644
index 0000000..3e1db6e
--- /dev/null
+++ b/arch/arm/mach-omap2/omap44xx-smc.S
@@ -0,0 +1,34 @@
+/*
+ * OMAP44xx secure APIs file.
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Written by Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ *
+ * This program is free software,you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+
+/*
+ * This is common routine to manage secure monitor API
+ * used to modify the PL310 secure registers.
+ * 'r0' contains the value to be modified and 'r12' contains
+ * the monitor API number. It uses few CPU registers
+ * internally and hence they need be backed up including
+ * link register "lr".
+ * Function signature : void omap_smc1(u32 fn, u32 arg)
+ */
+
+ENTRY(omap_smc1)
+	stmfd   sp!, {r2-r12, lr}
+	mov	r12, r0
+	mov 	r0, r1
+	dsb
+	smc
+	ldmfd   sp!, {r2-r12, pc}
+END(omap_smc1)
+
+
-- 
1.6.0.4

