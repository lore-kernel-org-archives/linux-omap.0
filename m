From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RESUBMIT][PATCH 5/7 v2] OMAP4: Update common omap machine specific sources.
Date: Tue, 19 May 2009 19:02:17 +0530
Message-ID: <1242739937-12547-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36617 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754737AbZESNcg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 May 2009 09:32:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

(patch is rebased on 2.6.30-rc6. The older version was based on 2.6.30-rc2)

This patch updates the common machine specific source files for OMAP4430.
Few OMAP4 peripherals are common with OMAP3 architecture. Lot of code
gets re-used because of this.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/gpmc.c     |    6 ++++
 arch/arm/mach-omap2/id.c       |    8 +++++-
 arch/arm/mach-omap2/io.c       |   52 ++++++++++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/serial.c   |    7 +++++
 arch/arm/mach-omap2/timer-gp.c |    9 +++++-
 5 files changed, 77 insertions(+), 5 deletions(-)

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
index 34b5914..458990e 100644
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
@@ -200,7 +203,10 @@ void __init omap2_check_revision(void)
 		omap24xx_check_revision();
 	else if (cpu_is_omap34xx())
 		omap34xx_check_revision();
-	else
+	else if (cpu_is_omap44xx()) {
+		printk(KERN_INFO "FIXME: CPU revision = OMAP4430\n");
+		return;
+	} else
 		pr_err("OMAP revision unknown, please fix!\n");
 
 	/*
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 916fcd3..32afd94 100644
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
@@ -30,6 +32,7 @@
 #include <mach/sdrc.h>
 #include <mach/gpmc.h>
 
+#ifndef CONFIG_ARCH_OMAP4	/* FIXME: Remove this once clkdev is ready */
 #include "clock.h"
 
 #include <mach/powerdomain.h>
@@ -38,7 +41,7 @@
 
 #include <mach/clockdomain.h>
 #include "clockdomains.h"
-
+#endif
 /*
  * The machine specific code may provide the extra mapping besides the
  * default mapping provided here.
@@ -166,6 +169,46 @@ static struct map_desc omap34xx_io_desc[] __initdata = {
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
@@ -183,6 +226,9 @@ void __init omap2_map_common_io(void)
 	iotable_init(omap34xx_io_desc, ARRAY_SIZE(omap34xx_io_desc));
 #endif
 
+#if defined(CONFIG_ARCH_OMAP4)
+	iotable_init(omap44xx_io_desc, ARRAY_SIZE(omap44xx_io_desc));
+#endif
 	/* Normally devicemaps_init() would flush caches and tlb after
 	 * mdesc->map_io(), but we must also do it here because of the CPU
 	 * revision check below.
@@ -198,9 +244,11 @@ void __init omap2_map_common_io(void)
 void __init omap2_init_common_hw(struct omap_sdrc_params *sp)
 {
 	omap2_mux_init();
+#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once the clkdev is ready */
 	pwrdm_init(powerdomains_omap);
 	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
 	omap2_clk_init();
 	omap2_sdrc_init(sp);
+#endif
 	gpmc_init();
 }
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
index f36aba1..6cc8fa8 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -17,9 +17,10 @@
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
@@ -82,7 +83,8 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
 	case CLOCK_EVT_MODE_PERIODIC:
 		period = clk_get_rate(omap_dm_timer_get_fclk(gptimer)) / HZ;
 		period -= 1;
-
+		if (cpu_is_omap44xx())
+			period = 0xFF;	/* FIXME: */
 		omap_dm_timer_set_load_start(gptimer, 1, 0xffffffff - period);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
@@ -145,6 +147,9 @@ static void __init omap2_gp_clockevent_init(void)
 		     "timer-gp: omap_dm_timer_set_source() failed\n");
 
 	tick_rate = clk_get_rate(omap_dm_timer_get_fclk(gptimer));
+	if (cpu_is_omap44xx())
+		/* Assuming 32kHz clk is driving GPT1 */
+		tick_rate = 32768;	/* FIXME: */
 
 	pr_info("OMAP clockevent source: GPTIMER%d at %u Hz\n",
 		gptimer_id, tick_rate);
-- 
1.5.4.7

