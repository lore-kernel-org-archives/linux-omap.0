From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/4] ARM: OMAP3: Remove legacy support for am3517crane
Date: Tue, 13 Jan 2015 09:57:43 -0800
Message-ID: <1421171865-5209-3-git-send-email-tony@atomide.com>
References: <1421171865-5209-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:51145 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751165AbbAMSBz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2015 13:01:55 -0500
In-Reply-To: <1421171865-5209-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

This board is working with device tree based booting so there should
not be any need to keep the legacy booting support around. People
using this board can boot it with appended DTB with existing bootloader.

By removing the 3517 legacy booting support we can get a bit closer to
making all of omap3 boot in device tree only mode.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig             |   5 --
 arch/arm/mach-omap2/Makefile            |   2 -
 arch/arm/mach-omap2/board-am3517crane.c | 150 --------------------------------
 3 files changed, 157 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/board-am3517crane.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index dcf126d..ba3a7a1 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -213,11 +213,6 @@ config MACH_OVERO
 	default y
 	select OMAP_PACKAGE_CBB
 
-config MACH_CRANEBOARD
-	bool "AM3517/05 CRANE board"
-	depends on ARCH_OMAP3
-	select OMAP_PACKAGE_CBB
-
 config MACH_OMAP3_PANDORA
 	bool "OMAP3 Pandora"
 	depends on ARCH_OMAP3
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index b68fb66..39b1ee1 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -253,8 +253,6 @@ obj-$(CONFIG_MACH_CM_T35)		+= board-cm-t35.o
 obj-$(CONFIG_MACH_CM_T3517)		+= board-cm-t3517.o
 obj-$(CONFIG_MACH_TOUCHBOOK)		+= board-omap3touchbook.o
 
-obj-$(CONFIG_MACH_CRANEBOARD)		+= board-am3517crane.o
-
 obj-$(CONFIG_MACH_SBC3530)		+= board-omap3stalker.o
 
 # Platform specific device init code
diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
deleted file mode 100644
index 8168dda..0000000
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ /dev/null
@@ -1,150 +0,0 @@
-/*
- * Support for AM3517/05 Craneboard
- * http://www.mistralsolutions.com/products/craneboard.php
- *
- * Copyright (C) 2010 Mistral Solutions Pvt Ltd. <www.mistralsolutions.com>
- * Author: R.Srinath <srinath@mistralsolutions.com>
- *
- * Based on mach-omap2/board-am3517evm.c
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as  published by the
- * Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any kind,
- * whether express or implied; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/gpio.h>
-#include <linux/mfd/tps65910.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
-#include <linux/mtd/partitions.h>
-#include <linux/omap-gpmc.h>
-
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-
-#include "common.h"
-#include "common-board-devices.h"
-#include "board-flash.h"
-
-#include "am35xx-emac.h"
-#include "mux.h"
-#include "control.h"
-
-#define GPIO_USB_POWER		35
-#define GPIO_USB_NRESET		38
-
-#ifdef CONFIG_OMAP_MUX
-static struct omap_board_mux board_mux[] __initdata = {
-	OMAP3_MUX(SYS_NIRQ, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
-	{ .reg_offset = OMAP_MUX_TERMINATOR },
-};
-#endif
-
-static struct usbhs_phy_data phy_data[] __initdata = {
-	{
-		.port = 1,
-		.reset_gpio = GPIO_USB_NRESET,
-		.vcc_gpio = GPIO_USB_POWER,
-		.vcc_polarity = 1,
-	},
-};
-
-static struct usbhs_omap_platform_data usbhs_bdata __initdata = {
-	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
-};
-
-static struct mtd_partition crane_nand_partitions[] = {
-	{
-		.name		= "X-Loader",
-		.offset		= 0,
-		.size		= 4 * NAND_BLOCK_SIZE,
-		.mask_flags	= MTD_WRITEABLE,
-	},
-	{
-		.name		= "U-Boot",
-		.offset		= MTDPART_OFS_APPEND,
-		.size		= 14 * NAND_BLOCK_SIZE,
-		.mask_flags	= MTD_WRITEABLE,
-	},
-	{
-		.name		= "U-Boot Env",
-		.offset		= MTDPART_OFS_APPEND,
-		.size		= 2 * NAND_BLOCK_SIZE,
-	},
-	{
-		.name		= "Kernel",
-		.offset		= MTDPART_OFS_APPEND,
-		.size		= 40 * NAND_BLOCK_SIZE,
-	},
-	{
-		.name		= "File System",
-		.offset		= MTDPART_OFS_APPEND,
-		.size		= MTDPART_SIZ_FULL,
-	},
-};
-
-static struct tps65910_board tps65910_pdata = {
-	.irq = 7 + OMAP_INTC_START,
-	.en_ck32k_xtal = true,
-};
-
-static struct i2c_board_info __initdata tps65910_board_info[] = {
-	{
-		I2C_BOARD_INFO("tps65910", 0x2d),
-		.platform_data = &tps65910_pdata,
-	},
-};
-
-static void __init am3517_crane_i2c_init(void)
-{
-	omap_register_i2c_bus(1, 2600, tps65910_board_info,
-			ARRAY_SIZE(tps65910_board_info));
-}
-
-static void __init am3517_crane_init(void)
-{
-	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
-	omap_serial_init();
-	omap_sdrc_init(NULL, NULL);
-	board_nand_init(crane_nand_partitions,
-			ARRAY_SIZE(crane_nand_partitions), 0,
-			NAND_BUSWIDTH_16, NULL);
-	am3517_crane_i2c_init();
-
-	/* Configure GPIO for EHCI port */
-	if (omap_mux_init_gpio(GPIO_USB_NRESET, OMAP_PIN_OUTPUT)) {
-		pr_err("Can not configure mux for GPIO_USB_NRESET %d\n",
-			GPIO_USB_NRESET);
-		return;
-	}
-
-	if (omap_mux_init_gpio(GPIO_USB_POWER, OMAP_PIN_OUTPUT)) {
-		pr_err("Can not configure mux for GPIO_USB_POWER %d\n",
-			GPIO_USB_POWER);
-		return;
-	}
-
-	usbhs_init_phys(phy_data, ARRAY_SIZE(phy_data));
-	usbhs_init(&usbhs_bdata);
-	am35xx_emac_init(AM35XX_DEFAULT_MDIO_FREQUENCY, 1);
-}
-
-MACHINE_START(CRANEBOARD, "AM3517/05 CRANEBOARD")
-	.atag_offset	= 0x100,
-	.reserve	= omap_reserve,
-	.map_io		= omap3_map_io,
-	.init_early	= am35xx_init_early,
-	.init_irq	= omap3_init_irq,
-	.init_machine	= am3517_crane_init,
-	.init_late	= am35xx_init_late,
-	.init_time	= omap3_sync32k_timer_init,
-	.restart	= omap3xxx_restart,
-MACHINE_END
-- 
2.1.4

