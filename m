From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/4] ARM: OMAP2+ Move SoC specific headers to be local to
 mach-omap2
Date: Fri, 31 Aug 2012 17:26:27 -0700
Message-ID: <20120901002627.23715.85527.stgit@muffinssi.local>
References: <20120901002534.23715.28654.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:10306 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755304Ab2IAA0a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Aug 2012 20:26:30 -0400
In-Reply-To: <20120901002534.23715.28654.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

These can now be moved to be local headers in mach-omap2.

Note that this patch removes arch/arm/plat-omap/devices.c as it
will get removed anyways with Paul Walmsley's patch
"ARM: OMAP: split OMAP1, OMAP2+ RNG device registration".

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/am33xx.h               |    0 
 arch/arm/mach-omap2/clock33xx_data.c       |    2 -
 arch/arm/mach-omap2/control.h              |    2 -
 arch/arm/mach-omap2/hardware.h             |   12 ++--
 arch/arm/mach-omap2/omap-mpuss-lowpower.c  |    3 -
 arch/arm/mach-omap2/omap24xx.h             |    2 -
 arch/arm/mach-omap2/omap34xx.h             |    2 -
 arch/arm/mach-omap2/omap44xx.h             |    0 
 arch/arm/mach-omap2/omap54xx.h             |    0 
 arch/arm/mach-omap2/sleep24xx.S            |    3 -
 arch/arm/mach-omap2/sleep34xx.S            |    2 -
 arch/arm/mach-omap2/sleep44xx.S            |    2 -
 arch/arm/mach-omap2/ti81xx.h               |    0 
 arch/arm/plat-omap/Makefile                |    3 -
 arch/arm/plat-omap/devices.c               |   91 ----------------------------
 15 files changed, 13 insertions(+), 111 deletions(-)
 rename arch/arm/{plat-omap/include/plat/am33xx.h => mach-omap2/am33xx.h} (100%)
 rename arch/arm/{plat-omap/include/plat/omap24xx.h => mach-omap2/omap24xx.h} (98%)
 rename arch/arm/{plat-omap/include/plat/omap34xx.h => mach-omap2/omap34xx.h} (98%)
 rename arch/arm/{plat-omap/include/plat/omap44xx.h => mach-omap2/omap44xx.h} (100%)
 rename arch/arm/{plat-omap/include/plat/omap54xx.h => mach-omap2/omap54xx.h} (100%)
 rename arch/arm/{plat-omap/include/plat/ti81xx.h => mach-omap2/ti81xx.h} (100%)
 delete mode 100644 arch/arm/plat-omap/devices.c

diff --git a/arch/arm/plat-omap/include/plat/am33xx.h b/arch/arm/mach-omap2/am33xx.h
similarity index 100%
rename from arch/arm/plat-omap/include/plat/am33xx.h
rename to arch/arm/mach-omap2/am33xx.h
diff --git a/arch/arm/mach-omap2/clock33xx_data.c b/arch/arm/mach-omap2/clock33xx_data.c
index 25bbcc7..7aa5eca 100644
--- a/arch/arm/mach-omap2/clock33xx_data.c
+++ b/arch/arm/mach-omap2/clock33xx_data.c
@@ -18,8 +18,8 @@
 #include <linux/list.h>
 #include <linux/clk.h>
 #include <plat/clkdev_omap.h>
-#include <plat/am33xx.h>
 
+#include "am33xx.h"
 #include "iomap.h"
 #include "control.h"
 #include "clock.h"
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index b8cdc85..c1a5cab 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -21,7 +21,7 @@
 #include <mach/ctrl_module_pad_core_44xx.h>
 #include <mach/ctrl_module_pad_wkup_44xx.h>
 
-#include <plat/am33xx.h>
+#include "am33xx.h"
 
 #ifndef __ASSEMBLY__
 #define OMAP242X_CTRL_REGADDR(reg)					\
diff --git a/arch/arm/mach-omap2/hardware.h b/arch/arm/mach-omap2/hardware.h
index 3c190f9..78f59ec 100644
--- a/arch/arm/mach-omap2/hardware.h
+++ b/arch/arm/mach-omap2/hardware.h
@@ -1,6 +1,6 @@
-#include <plat/omap24xx.h>
-#include <plat/omap34xx.h>
-#include <plat/omap44xx.h>
-#include <plat/ti81xx.h>
-#include <plat/am33xx.h>
-#include <plat/omap54xx.h>
+#include "omap24xx.h"
+#include "omap34xx.h"
+#include "omap44xx.h"
+#include "ti81xx.h"
+#include "am33xx.h"
+#include "omap54xx.h"
diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 637a1bd..ff4e6a0 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -50,9 +50,8 @@
 #include <asm/suspend.h>
 #include <asm/hardware/cache-l2x0.h>
 
-#include <plat/omap44xx.h>
-
 #include "common.h"
+#include "omap44xx.h"
 #include "omap4-sar-layout.h"
 #include "pm.h"
 #include "prcm_mpu44xx.h"
diff --git a/arch/arm/plat-omap/include/plat/omap24xx.h b/arch/arm/mach-omap2/omap24xx.h
similarity index 98%
rename from arch/arm/plat-omap/include/plat/omap24xx.h
rename to arch/arm/mach-omap2/omap24xx.h
index 92df9e2..641a2c8 100644
--- a/arch/arm/plat-omap/include/plat/omap24xx.h
+++ b/arch/arm/mach-omap2/omap24xx.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/plat-omap/include/mach/omap24xx.h
- *
  * This file contains the processor specific definitions
  * of the TI OMAP24XX.
  *
diff --git a/arch/arm/plat-omap/include/plat/omap34xx.h b/arch/arm/mach-omap2/omap34xx.h
similarity index 98%
rename from arch/arm/plat-omap/include/plat/omap34xx.h
rename to arch/arm/mach-omap2/omap34xx.h
index 0d818ac..c0d1b4b 100644
--- a/arch/arm/plat-omap/include/plat/omap34xx.h
+++ b/arch/arm/mach-omap2/omap34xx.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/plat-omap/include/mach/omap34xx.h
- *
  * This file contains the processor specific definitions of the TI OMAP34XX.
  *
  * Copyright (C) 2007 Texas Instruments.
diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h b/arch/arm/mach-omap2/omap44xx.h
similarity index 100%
rename from arch/arm/plat-omap/include/plat/omap44xx.h
rename to arch/arm/mach-omap2/omap44xx.h
diff --git a/arch/arm/plat-omap/include/plat/omap54xx.h b/arch/arm/mach-omap2/omap54xx.h
similarity index 100%
rename from arch/arm/plat-omap/include/plat/omap54xx.h
rename to arch/arm/mach-omap2/omap54xx.h
diff --git a/arch/arm/mach-omap2/sleep24xx.S b/arch/arm/mach-omap2/sleep24xx.S
index d4bf904..ce0ccd2 100644
--- a/arch/arm/mach-omap2/sleep24xx.S
+++ b/arch/arm/mach-omap2/sleep24xx.S
@@ -28,8 +28,7 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 
-#include <plat/omap24xx.h>
-
+#include "omap24xx.h"
 #include "sdrc.h"
 
 /* First address of reserved address space?  apparently valid for OMAP2 & 3 */
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 3fbe496..5069879 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -26,9 +26,9 @@
 
 #include <asm/assembler.h>
 
-#include <plat/omap34xx.h>
 #include <plat/sram.h>
 
+#include "omap34xx.h"
 #include "iomap.h"
 #include "cm2xxx_3xxx.h"
 #include "prm2xxx_3xxx.h"
diff --git a/arch/arm/mach-omap2/sleep44xx.S b/arch/arm/mach-omap2/sleep44xx.S
index 9f6b83d..df7f840 100644
--- a/arch/arm/mach-omap2/sleep44xx.S
+++ b/arch/arm/mach-omap2/sleep44xx.S
@@ -14,10 +14,10 @@
 #include <asm/memory.h>
 #include <asm/hardware/cache-l2x0.h>
 
-#include <plat/omap44xx.h>
 #include <mach/omap-secure.h>
 
 #include "common.h"
+#include "omap44xx.h"
 #include "omap4-sar-layout.h"
 
 #if defined(CONFIG_SMP) && defined(CONFIG_PM)
diff --git a/arch/arm/plat-omap/include/plat/ti81xx.h b/arch/arm/mach-omap2/ti81xx.h
similarity index 100%
rename from arch/arm/plat-omap/include/plat/ti81xx.h
rename to arch/arm/mach-omap2/ti81xx.h
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 961bf85..a017e99 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -3,8 +3,7 @@
 #
 
 # Common support
-obj-y := common.o sram.o clock.o devices.o dma.o mux.o \
-	 fb.o counter_32k.o
+obj-y := common.o sram.o clock.o dma.o mux.o fb.o counter_32k.o
 obj-m :=
 obj-n :=
 obj-  :=
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
deleted file mode 100644
index 287ac37..0000000
--- a/arch/arm/plat-omap/devices.c
+++ /dev/null
@@ -1,91 +0,0 @@
-/*
- * linux/arch/arm/plat-omap/devices.c
- *
- * Common platform device setup/initialization for OMAP1 and OMAP2
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-#include <linux/gpio.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/io.h>
-#include <linux/slab.h>
-#include <linux/memblock.h>
-
-#include <mach/hardware.h>
-#include <asm/mach-types.h>
-#include <asm/mach/map.h>
-#include <asm/memblock.h>
-
-#include <plat/tc.h>
-#include <plat/mmc.h>
-#include <plat/menelaus.h>
-#include <plat/omap44xx.h>
-
-/*-------------------------------------------------------------------------*/
-
-#if defined(CONFIG_HW_RANDOM_OMAP) || defined(CONFIG_HW_RANDOM_OMAP_MODULE)
-
-#ifdef CONFIG_ARCH_OMAP2
-#define	OMAP_RNG_BASE		0x480A0000
-#else
-#define	OMAP_RNG_BASE		0xfffe5000
-#endif
-
-static struct resource rng_resources[] = {
-	{
-		.start		= OMAP_RNG_BASE,
-		.end		= OMAP_RNG_BASE + 0x4f,
-		.flags		= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device omap_rng_device = {
-	.name		= "omap_rng",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(rng_resources),
-	.resource	= rng_resources,
-};
-
-static void omap_init_rng(void)
-{
-	(void) platform_device_register(&omap_rng_device);
-}
-#else
-static inline void omap_init_rng(void) {}
-#endif
-
-/*
- * This gets called after board-specific INIT_MACHINE, and initializes most
- * on-chip peripherals accessible on this board (except for few like USB):
- *
- *  (a) Does any "standard config" pin muxing needed.  Board-specific
- *	code will have muxed GPIO pins and done "nonstandard" setup;
- *	that code could live in the boot loader.
- *  (b) Populating board-specific platform_data with the data drivers
- *	rely on to handle wiring variations.
- *  (c) Creating platform devices as meaningful on this board and
- *	with this kernel configuration.
- *
- * Claiming GPIOs, and setting their direction and initial values, is the
- * responsibility of the device drivers.  So is responding to probe().
- *
- * Board-specific knowledge like creating devices or pin setup is to be
- * kept out of drivers as much as possible.  In particular, pin setup
- * may be handled by the boot loader, and drivers should expect it will
- * normally have been done by the time they're probed.
- */
-static int __init omap_init_devices(void)
-{
-	/* please keep these calls, and their implementations above,
-	 * in alphabetical order so they're easier to sort through.
-	 */
-	omap_init_rng();
-	return 0;
-}
-arch_initcall(omap_init_devices);

