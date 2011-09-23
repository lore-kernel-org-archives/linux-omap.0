From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 07/11] OMAP2+: board-generic: Add DT support to generic board
Date: Fri, 23 Sep 2011 22:23:15 +0200
Message-ID: <1316809399-19579-8-git-send-email-b-cousson@ti.com>
References: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49181 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752262Ab1IWUYo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Sep 2011 16:24:44 -0400
In-Reply-To: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, grant.likely@secretlab.ca
Cc: paul@pwsan.com, khilman@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

Re-cycle the original board-generic file to support Device Tree
for every OMAP2+ variants.
Note: Since it is a completely new content in the existing file
I removed the original copyright.

The current approach is an intermediate step before having only
one machine descriptor that will use some generic DT aware
functions.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig         |    8 ++-
 arch/arm/mach-omap2/board-generic.c |  129 ++++++++++++++++++++++------------
 2 files changed, 89 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 7edf802..5934a27 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -106,9 +106,13 @@ comment "OMAP Board Type"
 	depends on ARCH_OMAP2PLUS
 
 config MACH_OMAP_GENERIC
-	bool "Generic OMAP board"
-	depends on ARCH_OMAP2
+	bool "Generic OMAP2+ board"
+	depends on ARCH_OMAP2PLUS
+	select USE_OF
 	default y
+	help
+	  Support for generic TI OMAP2+ boards using Flattened Device Tree.
+	  More information at Documentation/devicetree
 
 config MACH_OMAP2_TUSB6010
 	bool
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index e8d45d3..dcbd64c 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -1,76 +1,113 @@
 /*
- * linux/arch/arm/mach-omap2/board-generic.c
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
  *
- * Copyright (C) 2005 Nokia Corporation
- * Author: Paul Mundt <paul.mundt@nokia.com>
- *
- * Modified from mach-omap/omap1/board-generic.c
- *
- * Code for generic OMAP2 board. Should work on many OMAP2 systems where
- * the bootloader passes the board-specific data to the kernel.
- * Do not put any board specific code to this file; create a new machine
- * type if you need custom low-level initializations.
+ * Support for generic OMAP2+ device tree boards.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
 
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/of_platform.h>
+#include <linux/irqdomain.h>
 
 #include <mach/hardware.h>
-#include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/map.h>
 
-#include <mach/gpio.h>
-#include <plat/usb.h>
 #include <plat/board.h>
 #include <plat/common.h>
+#include <mach/omap4-common.h>
 
-static struct omap_board_config_kernel generic_config[] = {
+
+static struct of_device_id omap_dt_match_table[] __initdata = {
+	{ .compatible = "simple-bus", },
+	{ .compatible = "ti,omap-infra", },
+	{ }
 };
 
-static void __init omap_generic_init_early(void)
-{
-	omap2_init_common_infrastructure();
-}
+static struct of_device_id intc_match[] __initdata = {
+	{ .compatible = "ti,omap3-intc", },
+	{ .compatible = "arm,cortex-a9-gic", },
+	{ }
+};
 
 static void __init omap_generic_init(void)
 {
+	struct device_node *node = of_find_matching_node(NULL, intc_match);
+	if (node)
+		irq_domain_add_simple(node, 0);
+
 	omap_serial_init();
 	omap_sdrc_init(NULL, NULL);
-	omap_board_config = generic_config;
-	omap_board_config_size = ARRAY_SIZE(generic_config);
-}
 
-static void __init omap_generic_map_io(void)
-{
-	if (cpu_is_omap242x()) {
-		omap2_set_globals_242x();
-		omap242x_map_common_io();
-	} else if (cpu_is_omap243x()) {
-		omap2_set_globals_243x();
-		omap243x_map_common_io();
-	} else if (cpu_is_omap34xx()) {
-		omap2_set_globals_3xxx();
-		omap34xx_map_common_io();
-	} else if (cpu_is_omap44xx()) {
-		omap2_set_globals_443x();
-		omap44xx_map_common_io();
-	}
+	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
 }
 
-/* XXX This machine entry name should be updated */
-MACHINE_START(OMAP_GENERIC, "Generic OMAP24xx")
-	/* Maintainer: Paul Mundt <paul.mundt@nokia.com> */
-	.atag_offset	= 0x100,
+#if defined(CONFIG_SOC_OMAP2420)
+static const char *omap242x_boards_compat[] __initdata = {
+	"ti,omap2420",
+	NULL,
+};
+
+DT_MACHINE_START(OMAP242X_DT, "Generic OMAP2420 (Flattened Device Tree)")
 	.reserve	= omap_reserve,
-	.map_io		= omap_generic_map_io,
-	.init_early	= omap_generic_init_early,
+	.map_io		= omap242x_map_io,
+	.init_early	= omap2420_init_early,
 	.init_irq	= omap2_init_irq,
 	.init_machine	= omap_generic_init,
 	.timer		= &omap2_timer,
+	.dt_compat	= omap242x_boards_compat,
+MACHINE_END
+#endif
+
+#if defined(CONFIG_SOC_OMAP2430)
+static const char *omap243x_boards_compat[] __initdata = {
+	"ti,omap2430",
+	NULL,
+};
+
+DT_MACHINE_START(OMAP243X_DT, "Generic OMAP2430 (Flattened Device Tree)")
+	.reserve	= omap_reserve,
+	.map_io		= omap243x_map_io,
+	.init_early	= omap2430_init_early,
+	.init_irq	= omap2_init_irq,
+	.init_machine	= omap_generic_init,
+	.timer		= &omap2_timer,
+	.dt_compat	= omap243x_boards_compat,
+MACHINE_END
+#endif
+
+#if defined(CONFIG_ARCH_OMAP3)
+static const char *omap3_boards_compat[] __initdata = {
+	"ti,omap3",
+	NULL,
+};
+
+DT_MACHINE_START(OMAP3_DT, "Generic OMAP3 (Flattened Device Tree)")
+	.reserve	= omap_reserve,
+	.map_io		= omap3_map_io,
+	.init_early	= omap3430_init_early,
+	.init_irq	= omap3_init_irq,
+	.init_machine	= omap_generic_init,
+	.timer		= &omap3_timer,
+	.dt_compat	= omap3_boards_compat,
+MACHINE_END
+#endif
+
+#if defined(CONFIG_ARCH_OMAP4)
+static const char *omap4_boards_compat[] __initdata = {
+	"ti,omap4",
+	NULL,
+};
+
+DT_MACHINE_START(OMAP4_DT, "Generic OMAP4 (Flattened Device Tree)")
+	.reserve	= omap_reserve,
+	.map_io		= omap4_map_io,
+	.init_early	= omap4430_init_early,
+	.init_irq	= gic_init_irq,
+	.init_machine	= omap_generic_init,
+	.timer		= &omap4_timer,
+	.dt_compat	= omap4_boards_compat,
 MACHINE_END
+#endif
-- 
1.7.0.4

