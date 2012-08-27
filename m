From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/5] ARM: OMAP: split OMAP1, OMAP2+ RNG device registration
Date: Mon, 27 Aug 2012 17:36:11 -0600
Message-ID: <20120827233611.15045.34581.stgit@dusk.lan>
References: <20120827232922.15045.56522.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:37128 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755029Ab2H0Xit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Aug 2012 19:38:49 -0400
In-Reply-To: <20120827232922.15045.56522.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Move the OMAP1-specific RNG device creation off to mach-omap1/devices.c,
and create a omap_device-backed registration function for OMAP2+ devices
in mach-omap2/devices.c.

As a nice side-benefit, we can also get rid of
arch/arm/plat-omap/devices.c, thanks to some of the recent changes
from Tony.

One change from the previous behavior is that the RNG devices are now
registered unconditionally.  This should allow the RNG drivers to be
loaded as modules, even if the original kernel was not built that way.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap1/devices.c |   25 +++++++++++
 arch/arm/mach-omap2/devices.c |   18 ++++++++
 arch/arm/plat-omap/Makefile   |    3 -
 arch/arm/plat-omap/devices.c  |   92 -----------------------------------------
 4 files changed, 44 insertions(+), 94 deletions(-)
 delete mode 100644 arch/arm/plat-omap/devices.c

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index fa1fa4d..7f3d9d2 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -358,6 +358,30 @@ static inline void omap_init_uwire(void) {}
 #endif
 
 
+#define OMAP1_RNG_BASE		0xfffe5000
+
+static struct resource omap1_rng_resources[] = {
+	{
+		.start		= OMAP1_RNG_BASE,
+		.end		= OMAP1_RNG_BASE + 0x4f,
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device omap1_rng_device = {
+	.name		= "omap_rng",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(omap1_rng_resources),
+	.resource	= omap1_rng_resources,
+};
+
+static void omap1_init_rng(void)
+{
+	(void) platform_device_register(&omap1_rng_device);
+}
+
+/*-------------------------------------------------------------------------*/
+
 /*
  * This gets called after board-specific INIT_MACHINE, and initializes most
  * on-chip peripherals accessible on this board (except for few like USB):
@@ -396,6 +420,7 @@ static int __init omap1_init_devices(void)
 	omap_init_spi100k();
 	omap_init_sti();
 	omap_init_uwire();
+	omap1_init_rng();
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index c00c689..bc62f1e 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -464,6 +464,23 @@ static void omap_init_pmu(void)
 	platform_device_register(&omap_pmu_device);
 }
 
+/**
+ * omap_init_rng - bind the RNG hwmod to the RNG omap_device
+ *
+ * Bind the RNG hwmod to the RNG omap_device.  No return value.
+ */
+static void omap_init_rng(void)
+{
+	struct omap_hwmod *oh;
+	struct platform_device *pdev;
+
+	oh = omap_hwmod_lookup("rng");
+	if (!oh)
+		return;
+
+	pdev = omap_device_build("omap_rng", -1, oh, NULL, 0, NULL, 0, 0);
+	WARN(IS_ERR(pdev), "Can't build omap_device for omap_rng\n");
+}
 
 #if defined(CONFIG_CRYPTO_DEV_OMAP_SHAM) || defined(CONFIG_CRYPTO_DEV_OMAP_SHAM_MODULE)
 
@@ -647,6 +664,7 @@ static int __init omap2_init_devices(void)
 	}
 	omap_init_pmu();
 	omap_init_sti();
+	omap_init_rng();
 	omap_init_sham();
 	omap_init_aes();
 	omap_init_vout();
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
index 1cba927..0000000
--- a/arch/arm/plat-omap/devices.c
+++ /dev/null
@@ -1,92 +0,0 @@
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
-#include <plat/board.h>
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


