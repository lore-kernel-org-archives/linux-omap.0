From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 1/2] arm: omap: combine zoom2 and zoom3 board-files
Date: Wed, 20 Oct 2010 09:25:11 +0300
Message-ID: <1287555912-16058-2-git-send-email-balbi@ti.com>
References: <1287555912-16058-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59536 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755515Ab0JTGZf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Oct 2010 02:25:35 -0400
In-Reply-To: <1287555912-16058-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Anand Gadiyar <gadiyar@ti.com>, Felipe Balbi <balbi@ti.com>

They are extremely similar anyway, let's get rid
of one file.

While at that, also remove the empty zoom_config
variable.

Tested-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/Makefile                       |    4 +-
 .../arm/mach-omap2/{board-zoom2.c => board-zoom.c} |   52 +++++++--
 arch/arm/mach-omap2/board-zoom3.c                  |  133 --------------------
 3 files changed, 45 insertions(+), 144 deletions(-)
 rename arch/arm/mach-omap2/{board-zoom2.c => board-zoom.c} (73%)
 delete mode 100644 arch/arm/mach-omap2/board-zoom3.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 7352412..a57ae62 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -140,12 +140,12 @@ obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
 					   board-rx51-peripherals.o \
 					   board-rx51-video.o \
 					   hsmmc.o
-obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom2.o \
+obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom.o \
 					   board-zoom-peripherals.o \
 					   board-flash.o \
 					   hsmmc.o \
 					   board-zoom-debugboard.o
-obj-$(CONFIG_MACH_OMAP_ZOOM3)		+= board-zoom3.o \
+obj-$(CONFIG_MACH_OMAP_ZOOM3)		+= board-zoom.o \
 					   board-zoom-peripherals.o \
 					   board-flash.o \
 					   hsmmc.o \
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom.c
similarity index 73%
rename from arch/arm/mach-omap2/board-zoom2.c
rename to arch/arm/mach-omap2/board-zoom.c
index 694c926..4215abc 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom.c
@@ -1,6 +1,7 @@
 /*
- * Copyright (C) 2009 Texas Instruments Inc.
+ * Copyright (C) 2009-2010 Texas Instruments Inc.
  * Mikkel Christensen <mlc@ti.com>
+ * Felipe Balbi <balbi@ti.com>
  *
  * Modified from mach-omap2/board-ldp.c
  *
@@ -20,17 +21,24 @@
 
 #include <plat/common.h>
 #include <plat/board.h>
+#include <plat/usb.h>
 
 #include <mach/board-zoom.h>
 
 #include "board-flash.h"
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
+#include "sdram-hynix-h8mbx00u0mer-0em.h"
 
-static void __init omap_zoom2_init_irq(void)
+static void __init omap_zoom_init_irq(void)
 {
-	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
-				 mt46h32m32lf6_sdrc_params);
+	if (machine_is_omap_zoom2())
+		omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
+				mt46h32m32lf6_sdrc_params);
+	else if (machine_is_omap_zoom3())
+		omap2_init_common_hw(h8mbx00u0mer0em_sdrc_params,
+				h8mbx00u0mer0em_sdrc_params);
+
 	omap_init_irq();
 	omap_gpio_init();
 }
@@ -132,20 +140,46 @@ static struct mtd_partition zoom_nand_partitions[] = {
 	},
 };
 
-static void __init omap_zoom2_init(void)
+static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+	.port_mode[0]		= EHCI_HCD_OMAP_MODE_UNKNOWN,
+	.port_mode[1]		= EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[2]		= EHCI_HCD_OMAP_MODE_UNKNOWN,
+	.phy_reset		= true,
+	.reset_gpio_port[0]	= -EINVAL,
+	.reset_gpio_port[1]	= 64,
+	.reset_gpio_port[2]	= -EINVAL,
+};
+
+static void __init omap_zoom_init(void)
 {
-	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
-	zoom_peripherals_init();
+	if (machine_is_omap_zoom2()) {
+		omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
+	} else if (machine_is_omap_zoom3()) {
+		omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
+		omap_mux_init_gpio(64, OMAP_PIN_OUTPUT);
+		usb_ehci_init(&ehci_pdata);
+	}
+
 	board_nand_init(zoom_nand_partitions,
 			ARRAY_SIZE(zoom_nand_partitions), ZOOM_NAND_CS);
 	zoom_debugboard_init();
+	zoom_peripherals_init();
 }
 
 MACHINE_START(OMAP_ZOOM2, "OMAP Zoom2 board")
 	.boot_params	= 0x80000100,
 	.map_io		= omap3_map_io,
 	.reserve	= omap_reserve,
-	.init_irq	= omap_zoom2_init_irq,
-	.init_machine	= omap_zoom2_init,
+	.init_irq	= omap_zoom_init_irq,
+	.init_machine	= omap_zoom_init,
+	.timer		= &omap_timer,
+MACHINE_END
+
+MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board")
+	.boot_params	= 0x80000100,
+	.map_io		= omap3_map_io,
+	.reserve	= omap_reserve,
+	.init_irq	= omap_zoom_init_irq,
+	.init_machine	= omap_zoom_init,
 	.timer		= &omap_timer,
 MACHINE_END
diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
deleted file mode 100644
index 5adde12..0000000
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ /dev/null
@@ -1,133 +0,0 @@
-/*
- * Copyright (C) 2009 Texas Instruments Inc.
- *
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/input.h>
-#include <linux/gpio.h>
-
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-
-#include <mach/board-zoom.h>
-
-#include <plat/common.h>
-#include <plat/board.h>
-#include <plat/usb.h>
-
-#include "board-flash.h"
-#include "mux.h"
-#include "sdram-hynix-h8mbx00u0mer-0em.h"
-
-static struct omap_board_config_kernel zoom_config[] __initdata = {
-};
-
-static struct mtd_partition zoom_nand_partitions[] = {
-	/* All the partition sizes are listed in terms of NAND block size */
-	{
-		.name		= "X-Loader-NAND",
-		.offset		= 0,
-		.size		= 4 * (64 * 2048),	/* 512KB, 0x80000 */
-		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
-	},
-	{
-		.name		= "U-Boot-NAND",
-		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x80000 */
-		.size		= 10 * (64 * 2048),	/* 1.25MB, 0x140000 */
-		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
-	},
-	{
-		.name		= "Boot Env-NAND",
-		.offset		= MTDPART_OFS_APPEND,   /* Offset = 0x1c0000 */
-		.size		= 2 * (64 * 2048),	/* 256KB, 0x40000 */
-	},
-	{
-		.name		= "Kernel-NAND",
-		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x0200000*/
-		.size		= 240 * (64 * 2048),	/* 30M, 0x1E00000 */
-	},
-	{
-		.name		= "system",
-		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x2000000 */
-		.size		= 3328 * (64 * 2048),	/* 416M, 0x1A000000 */
-	},
-	{
-		.name		= "userdata",
-		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x1C000000*/
-		.size		= 256 * (64 * 2048),	/* 32M, 0x2000000 */
-	},
-	{
-		.name		= "cache",
-		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x1E000000*/
-		.size		= 256 * (64 * 2048),	/* 32M, 0x2000000 */
-	},
-};
-
-static void __init omap_zoom_init_irq(void)
-{
-	omap_board_config = zoom_config;
-	omap_board_config_size = ARRAY_SIZE(zoom_config);
-	omap2_init_common_hw(h8mbx00u0mer0em_sdrc_params,
-			h8mbx00u0mer0em_sdrc_params);
-	omap_init_irq();
-	omap_gpio_init();
-}
-
-#ifdef CONFIG_OMAP_MUX
-static struct omap_board_mux board_mux[] __initdata = {
-	/* WLAN IRQ - GPIO 162 */
-	OMAP3_MUX(MCBSP1_CLKX, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP),
-	/* WLAN POWER ENABLE - GPIO 101 */
-	OMAP3_MUX(CAM_D2, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
-	/* WLAN SDIO: MMC3 CMD */
-	OMAP3_MUX(MCSPI1_CS1, OMAP_MUX_MODE3 | OMAP_PIN_INPUT_PULLUP),
-	/* WLAN SDIO: MMC3 CLK */
-	OMAP3_MUX(ETK_CLK, OMAP_MUX_MODE2 | OMAP_PIN_INPUT_PULLUP),
-	/* WLAN SDIO: MMC3 DAT[0-3] */
-	OMAP3_MUX(ETK_D3, OMAP_MUX_MODE2 | OMAP_PIN_INPUT_PULLUP),
-	OMAP3_MUX(ETK_D4, OMAP_MUX_MODE2 | OMAP_PIN_INPUT_PULLUP),
-	OMAP3_MUX(ETK_D5, OMAP_MUX_MODE2 | OMAP_PIN_INPUT_PULLUP),
-	OMAP3_MUX(ETK_D6, OMAP_MUX_MODE2 | OMAP_PIN_INPUT_PULLUP),
-	{ .reg_offset = OMAP_MUX_TERMINATOR },
-};
-#else
-#define board_mux	NULL
-#endif
-
-static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
-	.port_mode[0]		= EHCI_HCD_OMAP_MODE_UNKNOWN,
-	.port_mode[1]		= EHCI_HCD_OMAP_MODE_PHY,
-	.port_mode[2]		= EHCI_HCD_OMAP_MODE_UNKNOWN,
-	.phy_reset		= true,
-	.reset_gpio_port[0]	= -EINVAL,
-	.reset_gpio_port[1]	= 64,
-	.reset_gpio_port[2]	= -EINVAL,
-};
-
-static void __init omap_zoom_init(void)
-{
-	omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
-	zoom_peripherals_init();
-	board_nand_init(zoom_nand_partitions,
-			 ARRAY_SIZE(zoom_nand_partitions), ZOOM_NAND_CS);
-	zoom_debugboard_init();
-
-	omap_mux_init_gpio(64, OMAP_PIN_OUTPUT);
-	usb_ehci_init(&ehci_pdata);
-}
-
-MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board")
-	.boot_params	= 0x80000100,
-	.map_io		= omap3_map_io,
-	.reserve	= omap_reserve,
-	.init_irq	= omap_zoom_init_irq,
-	.init_machine	= omap_zoom_init,
-	.timer		= &omap_timer,
-MACHINE_END
-- 
1.7.3.1.120.g38a18

