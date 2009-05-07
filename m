From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [RESUBMIT][PATCH 5/7] OMAP4: Update common omap machine specific sources.
Date: Thu,  7 May 2009 11:59:14 +0530
Message-ID: <1241677756-28756-5-git-send-email-santosh.shilimkar@ti.com>
References: <1241677756-28756-1-git-send-email-santosh.shilimkar@ti.com>
 <1241677756-28756-2-git-send-email-santosh.shilimkar@ti.com>
 <1241677756-28756-3-git-send-email-santosh.shilimkar@ti.com>
 <1241677756-28756-4-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54379 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752078AbZEGG3h (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 May 2009 02:29:37 -0400
In-Reply-To: <1241677756-28756-4-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch updates the common machine spcific source files for OMAP4430.
Few OMAP4 peripherals are common with OMAP3 architecture. Lot of code
gets re-used because of this.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/clockdomain.c |    2 +
 arch/arm/mach-omap2/gpmc.c        |    6 ++++
 arch/arm/mach-omap2/id.c          |    8 +++++-
 arch/arm/mach-omap2/io.c          |   51 ++++++++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/powerdomain.c |    2 +
 arch/arm/mach-omap2/sdrc.c        |    2 +
 arch/arm/mach-omap2/serial.c      |    7 +++++
 arch/arm/mach-omap2/timer-gp.c    |    9 +++++-
 8 files changed, 83 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 0e7d501..1497d18 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -177,6 +177,8 @@ void clkdm_init(struct clockdomain **clkdms,
 	struct clockdomain **c = NULL;
 	struct clkdm_pwrdm_autodep *autodep = NULL;
 
+	if (cpu_is_omap44xx())
+		return ; /* FIXME: Not yet support */
 	if (clkdms)
 		for (c = clkdms; *c; c++)
 			clkdm_register(*c);
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 2249049..f91934b 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -5,6 +5,9 @@
  *
  * Author: Juha Yrjola
  *
+ * Copyright (C) 2009 Texas Instruments
+ * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -424,6 +427,9 @@ void __init gpmc_init(void)
 	} else if (cpu_is_omap34xx()) {
 		ck = "gpmc_fck";
 		l = OMAP34XX_GPMC_BASE;
+	} else if (cpu_is_omap44xx()) {
+		ck = "gpmc_fck";
+		l = OMAP44XX_GPMC_BASE;
 	}
 
 	gpmc_l3_clk = clk_get(NULL, ck);
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 34b5914..40e0e4b 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -6,6 +6,9 @@
  * Copyright (C) 2005 Nokia Corporation
  * Written by Tony Lindgren <tony@atomide.com>
  *
+ * Copyright (C) 2009 Texas Instruments
+ * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -196,7 +199,10 @@ void __init omap2_check_revision(void)
 	 * At this point we have an idea about the processor revision set
 	 * earlier with omap2_set_globals_tap().
 	 */
-	if (cpu_is_omap24xx())
+	if (cpu_is_omap44xx()) {
+		printk(KERN_INFO "FIXME: CPU revision = OMAP4430\n");
+		return;
+	} else if (cpu_is_omap24xx())
 		omap24xx_check_revision();
 	else if (cpu_is_omap34xx())
 		omap34xx_check_revision();
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 916fcd3..6db7791 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -4,12 +4,14 @@
  * OMAP2 I/O mapping code
  *
  * Copyright (C) 2005 Nokia Corporation
- * Copyright (C) 2007 Texas Instruments
+ * Copyright (C) 2007-2009 Texas Instruments
  *
  * Author:
  *	Juha Yrjola <juha.yrjola@nokia.com>
  *	Syed Khasim <x0khasim@ti.com>
  *
+ * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -30,7 +32,9 @@
 #include <mach/sdrc.h>
 #include <mach/gpmc.h>
 
+#ifndef CONFIG_ARCH_OMAP4	/* FIXME: Remove this once clkdev is ready */
 #include "clock.h"
+#endif
 
 #include <mach/powerdomain.h>
 
@@ -166,6 +170,46 @@ static struct map_desc omap34xx_io_desc[] __initdata = {
 	},
 };
 #endif
+#ifdef	CONFIG_ARCH_OMAP4
+static struct map_desc omap44xx_io_desc[] __initdata = {
+	{
+		.virtual	= L3_44XX_VIRT,
+		.pfn		= __phys_to_pfn(L3_44XX_PHYS),
+		.length		= L3_44XX_SIZE,
+		.type		= MT_DEVICE,
+	},
+	{
+		.virtual	= L4_44XX_VIRT,
+		.pfn		= __phys_to_pfn(L4_44XX_PHYS),
+		.length		= L4_44XX_SIZE,
+		.type		= MT_DEVICE,
+	},
+	{
+		.virtual	= L4_WK_44XX_VIRT,
+		.pfn		= __phys_to_pfn(L4_WK_44XX_PHYS),
+		.length		= L4_WK_44XX_SIZE,
+		.type		= MT_DEVICE,
+	},
+	{
+		.virtual	= OMAP44XX_GPMC_VIRT,
+		.pfn		= __phys_to_pfn(OMAP44XX_GPMC_PHYS),
+		.length		= OMAP44XX_GPMC_SIZE,
+		.type		= MT_DEVICE,
+	},
+	{
+		.virtual	= L4_PER_44XX_VIRT,
+		.pfn		= __phys_to_pfn(L4_PER_44XX_PHYS),
+		.length		= L4_PER_44XX_SIZE,
+		.type		= MT_DEVICE,
+	},
+	{
+		.virtual	= L4_EMU_44XX_VIRT,
+		.pfn		= __phys_to_pfn(L4_EMU_44XX_PHYS),
+		.length		= L4_EMU_44XX_SIZE,
+		.type		= MT_DEVICE,
+	},
+};
+#endif
 
 void __init omap2_map_common_io(void)
 {
@@ -183,6 +227,9 @@ void __init omap2_map_common_io(void)
 	iotable_init(omap34xx_io_desc, ARRAY_SIZE(omap34xx_io_desc));
 #endif
 
+#if defined(CONFIG_ARCH_OMAP4)
+	iotable_init(omap44xx_io_desc, ARRAY_SIZE(omap44xx_io_desc));
+#endif
 	/* Normally devicemaps_init() would flush caches and tlb after
 	 * mdesc->map_io(), but we must also do it here because of the CPU
 	 * revision check below.
@@ -200,7 +247,9 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sp)
 	omap2_mux_init();
 	pwrdm_init(powerdomains_omap);
 	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
+#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once the clkdev is ready */
 	omap2_clk_init();
+#endif
 	omap2_sdrc_init(sp);
 	gpmc_init();
 }
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 73e2971..7fc03b8 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -117,6 +117,8 @@ void pwrdm_init(struct powerdomain **pwrdm_list)
 {
 	struct powerdomain **p = NULL;
 
+	if (cpu_is_omap44xx())
+		return ; /* FIXME: Not supported yet */
 	if (pwrdm_list)
 		for (p = pwrdm_list; *p; p++)
 			pwrdm_register(*p);
diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
index 2a30060..944da57 100644
--- a/arch/arm/mach-omap2/sdrc.c
+++ b/arch/arm/mach-omap2/sdrc.c
@@ -79,6 +79,8 @@ void __init omap2_sdrc_init(struct omap_sdrc_params *sp)
 {
 	u32 l;
 
+	if (cpu_is_omap44xx())
+		return; /* SDRC not supported */
 	l = sms_read_reg(SMS_SYSCONFIG);
 	l &= ~(0x3 << 3);
 	l |= (0x2 << 3);
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 4dcf39c..5f29a42 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -8,6 +8,9 @@
  *
  * Based off of arch/arm/mach-omap/omap1/serial.c
  *
+ * Copyright (C) 2009 Texas Instruments
+ * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com
+ *
  * This file is subject to the terms and conditions of the GNU General Public
  * License. See the file "COPYING" in the main directory of this archive
  * for more details.
@@ -114,6 +117,10 @@ void __init omap_serial_init(void)
 
 	if (info == NULL)
 		return;
+	if (cpu_is_omap44xx()) {
+		for (i = 0; i < OMAP_MAX_NR_PORTS; i++)
+			serial_platform_data[i].irq += 32;
+	}
 
 	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
 		struct plat_serial8250_port *p = serial_platform_data + i;
diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 9fc13a2..080868d 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -15,9 +15,10 @@
  *
  * Some parts based off of TI's 24xx code:
  *
- *   Copyright (C) 2004 Texas Instruments, Inc.
+ * Copyright (C) 2004-2009 Texas Instruments, Inc.
  *
  * Roughly modelled after the OMAP1 MPU timer code.
+ * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License. See the file "COPYING" in the main directory of this archive
@@ -75,7 +76,8 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_PERIODIC:
 		period = clk_get_rate(omap_dm_timer_get_fclk(gptimer)) / HZ;
 		period -= 1;
-
+		if (cpu_is_omap44xx())
+			period = 0xFF;	/* FIXME: */
 		omap_dm_timer_set_load_start(gptimer, 1, 0xffffffff - period);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
@@ -108,6 +110,9 @@ static void __init omap2_gp_clockevent_init(void)
 	omap_dm_timer_set_source(gptimer, OMAP_TIMER_SRC_SYS_CLK);
 #endif
 	tick_rate = clk_get_rate(omap_dm_timer_get_fclk(gptimer));
+	if (cpu_is_omap44xx())
+		/* Assuming 32kHz clk is driving GPT1 */
+		tick_rate = 32768;	/* FIXME: */
 
 	omap2_gp_timer_irq.dev_id = (void *)gptimer;
 	setup_irq(omap_dm_timer_get_irq(gptimer), &omap2_gp_timer_irq);
-- 
1.5.4.7

