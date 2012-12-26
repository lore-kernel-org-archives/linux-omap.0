From: Kyungmin Park <kmpark@infradead.org>
Subject: [PATCH] arm: omap: Remove apollon board support
Date: Wed, 26 Dec 2012 14:21:06 +0900
Message-ID: <20121226052106.GA8929@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:13087 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759Ab2LZFUO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Dec 2012 00:20:14 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MFM001FIHHHIIO0@mailout3.samsung.com> for
 linux-omap@vger.kernel.org; Wed, 26 Dec 2012 14:20:12 +0900 (KST)
Received: from july ([165.213.74.254])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MFM00AEVHHMKL40@mmp1.samsung.com> for
 linux-omap@vger.kernel.org; Wed, 26 Dec 2012 14:20:11 +0900 (KST)
Content-disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com

From: Kyungmin Park <kyungmin.park@samsung.com>

As apollon board doesn't used anymore, remove it.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 41b581f..d4e4f95 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -165,12 +165,6 @@ config MACH_OMAP_H4
 	select OMAP_DEBUG_DEVICES
 	select OMAP_PACKAGE_ZAF
 
-config MACH_OMAP_APOLLON
-	bool "OMAP 2420 Apollon board"
-	depends on SOC_OMAP2420
-	default y
-	select OMAP_PACKAGE_ZAC
-
 config MACH_OMAP_2430SDP
 	bool "OMAP 2430 SDP board"
 	depends on SOC_OMAP2430
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index a8004f3..25ca2a1 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -220,7 +220,6 @@ endif
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
 obj-$(CONFIG_MACH_OMAP_H4)		+= board-h4.o
 obj-$(CONFIG_MACH_OMAP_2430SDP)		+= board-2430sdp.o
-obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o
 obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o
 obj-$(CONFIG_MACH_DEVKIT8000)     	+= board-devkit8000.o
 obj-$(CONFIG_MACH_OMAP_LDP)		+= board-ldp.o
diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 65468f6..ca7c5d4 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -783,9 +783,6 @@ static int __devinit gpmc_mem_init(void)
 	 * even if we didn't boot from ROM.
 	 */
 	boot_rom_space = BOOT_ROM_SPACE;
-	/* In apollon the CS0 is mapped as 0x0000 0000 */
-	if (machine_is_omap_apollon())
-		boot_rom_space = 0;
 	gpmc_mem_root.start = GPMC_MEM_START + boot_rom_space;
 	gpmc_mem_root.end = GPMC_MEM_END;
 
diff --git a/arch/arm/mach-omap2/include/mach/uncompress.h b/arch/arm/mach-omap2/include/mach/uncompress.h
index 8e3546d..e278451 100644
--- a/arch/arm/mach-omap2/include/mach/uncompress.h
+++ b/arch/arm/mach-omap2/include/mach/uncompress.h
@@ -115,7 +115,6 @@ static inline void arch_decomp_setup(void)
 	do {
 		/* omap2 based boards using UART1 */
 		DEBUG_LL_OMAP2(1, omap_2430sdp);
-		DEBUG_LL_OMAP2(1, omap_apollon);
 		DEBUG_LL_OMAP2(1, omap_h4);
 
 		/* omap2 based boards using UART3 */
diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index 54ca8ae..c904f42 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -291,30 +291,6 @@ static struct panel_config generic_dpi_panels[] = {
 		.name			= "h4",
 	},
 
-	/* Unknown panel used in Samsung OMAP2 Apollon */
-	{
-		{
-			.x_res		= 480,
-			.y_res		= 272,
-
-			.pixel_clock	= 6250,
-
-			.hsw		= 41,
-			.hfp		= 2,
-			.hbp		= 2,
-
-			.vsw		= 10,
-			.vfp		= 2,
-			.vbp		= 2,
-
-			.vsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
-			.hsync_level	= OMAPDSS_SIG_ACTIVE_LOW,
-			.data_pclk_edge	= OMAPDSS_DRIVE_SIG_RISING_EDGE,
-			.de_level	= OMAPDSS_SIG_ACTIVE_HIGH,
-			.sync_pclk_edge	= OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES,
-		},
-		.name			= "apollon",
-	},
 	/* FocalTech ETM070003DH6 */
 	{
 		{
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
deleted file mode 100644
index 5d0a61f..0000000
--- a/arch/arm/mach-omap2/board-apollon.c
+++ /dev/null
@@ -1,342 +0,0 @@
-/*
- * linux/arch/arm/mach-omap2/board-apollon.c
- *
- * Copyright (C) 2005,2006 Samsung Electronics
- * Author: Kyungmin Park <kyungmin.park@samsung.com>
- *
- * Modified from mach-omap/omap2/board-h4.c
- *
- * Code for apollon OMAP2 board. Should work on many OMAP2 systems where
- * the bootloader passes the board-specific data to the kernel.
- * Do not put any board specific code to this file; create a new machine
- * type if you need custom low-level initializations.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/partitions.h>
-#include <linux/mtd/onenand.h>
-#include <linux/delay.h>
-#include <linux/leds.h>
-#include <linux/err.h>
-#include <linux/clk.h>
-#include <linux/smc91x.h>
-#include <linux/gpio.h>
-#include <linux/platform_data/leds-omap.h>
-
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/flash.h>
-
-#include "common.h"
-#include "gpmc.h"
-
-#include <video/omapdss.h>
-#include <video/omap-panel-generic-dpi.h>
-
-#include "mux.h"
-#include "control.h"
-
-/* LED & Switch macros */
-#define LED0_GPIO13		13
-#define LED1_GPIO14		14
-#define LED2_GPIO15		15
-#define SW_ENTER_GPIO16		16
-#define SW_UP_GPIO17		17
-#define SW_DOWN_GPIO58		58
-
-#define APOLLON_FLASH_CS	0
-#define APOLLON_ETH_CS		1
-#define APOLLON_ETHR_GPIO_IRQ	74
-
-static struct mtd_partition apollon_partitions[] = {
-	{
-		.name		= "X-Loader + U-Boot",
-		.offset		= 0,
-		.size		= SZ_128K,
-		.mask_flags	= MTD_WRITEABLE,
-	},
-	{
-		.name		= "params",
-		.offset		= MTDPART_OFS_APPEND,
-		.size		= SZ_128K,
-	},
-	{
-		.name		= "kernel",
-		.offset		= MTDPART_OFS_APPEND,
-		.size		= SZ_2M,
-	},
-	{
-		.name		= "rootfs",
-		.offset		= MTDPART_OFS_APPEND,
-		.size		= SZ_16M,
-	},
-	{
-		.name		= "filesystem00",
-		.offset		= MTDPART_OFS_APPEND,
-		.size		= SZ_32M,
-	},
-	{
-		.name		= "filesystem01",
-		.offset		= MTDPART_OFS_APPEND,
-		.size		= MTDPART_SIZ_FULL,
-	},
-};
-
-static struct onenand_platform_data apollon_flash_data = {
-	.parts		= apollon_partitions,
-	.nr_parts	= ARRAY_SIZE(apollon_partitions),
-};
-
-static struct resource apollon_flash_resource[] = {
-	[0] = {
-		.flags		= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device apollon_onenand_device = {
-	.name		= "onenand-flash",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &apollon_flash_data,
-	},
-	.num_resources	= ARRAY_SIZE(apollon_flash_resource),
-	.resource	= apollon_flash_resource,
-};
-
-static void __init apollon_flash_init(void)
-{
-	unsigned long base;
-
-	if (gpmc_cs_request(APOLLON_FLASH_CS, SZ_128K, &base) < 0) {
-		printk(KERN_ERR "Cannot request OneNAND GPMC CS\n");
-		return;
-	}
-	apollon_flash_resource[0].start = base;
-	apollon_flash_resource[0].end   = base + SZ_128K - 1;
-}
-
-static struct smc91x_platdata appolon_smc91x_info = {
-	.flags	= SMC91X_USE_16BIT | SMC91X_NOWAIT,
-	.leda	= RPC_LED_100_10,
-	.ledb	= RPC_LED_TX_RX,
-};
-
-static struct resource apollon_smc91x_resources[] = {
-	[0] = {
-		.flags  = IORESOURCE_MEM,
-	},
-	[1] = {
-		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
-	},
-};
-
-static struct platform_device apollon_smc91x_device = {
-	.name		= "smc91x",
-	.id		= -1,
-	.dev	= {
-		.platform_data	= &appolon_smc91x_info,
-	},
-	.num_resources	= ARRAY_SIZE(apollon_smc91x_resources),
-	.resource	= apollon_smc91x_resources,
-};
-
-static struct omap_led_config apollon_led_config[] = {
-	{
-		.cdev	= {
-			.name	= "apollon:led0",
-		},
-		.gpio	= LED0_GPIO13,
-	},
-	{
-		.cdev	= {
-			.name	= "apollon:led1",
-		},
-		.gpio	= LED1_GPIO14,
-	},
-	{
-		.cdev	= {
-			.name	= "apollon:led2",
-		},
-		.gpio	= LED2_GPIO15,
-	},
-};
-
-static struct omap_led_platform_data apollon_led_data = {
-	.nr_leds	= ARRAY_SIZE(apollon_led_config),
-	.leds		= apollon_led_config,
-};
-
-static struct platform_device apollon_led_device = {
-	.name		= "omap-led",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &apollon_led_data,
-	},
-};
-
-static struct platform_device *apollon_devices[] __initdata = {
-	&apollon_onenand_device,
-	&apollon_smc91x_device,
-	&apollon_led_device,
-};
-
-static inline void __init apollon_init_smc91x(void)
-{
-	unsigned long base;
-
-	unsigned int rate;
-	struct clk *gpmc_fck;
-	int eth_cs;
-	int err;
-
-	gpmc_fck = clk_get(NULL, "gpmc_fck");	/* Always on ENABLE_ON_INIT */
-	if (IS_ERR(gpmc_fck)) {
-		WARN_ON(1);
-		return;
-	}
-
-	clk_prepare_enable(gpmc_fck);
-	rate = clk_get_rate(gpmc_fck);
-
-	eth_cs = APOLLON_ETH_CS;
-
-	/* Make sure CS1 timings are correct */
-	gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG1, 0x00011200);
-
-	if (rate >= 160000000) {
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG2, 0x001f1f01);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG3, 0x00080803);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG4, 0x1c0b1c0a);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG5, 0x041f1F1F);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG6, 0x000004C4);
-	} else if (rate >= 130000000) {
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG2, 0x001f1f00);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG3, 0x00080802);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG4, 0x1C091C09);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG5, 0x041f1F1F);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG6, 0x000004C4);
-	} else {/* rate = 100000000 */
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG2, 0x001f1f00);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG3, 0x00080802);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG4, 0x1C091C09);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG5, 0x031A1F1F);
-		gpmc_cs_write_reg(eth_cs, GPMC_CS_CONFIG6, 0x000003C2);
-	}
-
-	if (gpmc_cs_request(APOLLON_ETH_CS, SZ_16M, &base) < 0) {
-		printk(KERN_ERR "Failed to request GPMC CS for smc91x\n");
-		goto out;
-	}
-	apollon_smc91x_resources[0].start = base + 0x300;
-	apollon_smc91x_resources[0].end   = base + 0x30f;
-	udelay(100);
-
-	omap_mux_init_gpio(APOLLON_ETHR_GPIO_IRQ, 0);
-	err = gpio_request_one(APOLLON_ETHR_GPIO_IRQ, GPIOF_IN, "SMC91x irq");
-	if (err) {
-		printk(KERN_ERR "Failed to request GPIO%d for smc91x IRQ\n",
-			APOLLON_ETHR_GPIO_IRQ);
-		gpmc_cs_free(APOLLON_ETH_CS);
-	}
-out:
-	clk_disable_unprepare(gpmc_fck);
-	clk_put(gpmc_fck);
-}
-
-static struct panel_generic_dpi_data apollon_panel_data = {
-	.name			= "apollon",
-};
-
-static struct omap_dss_device apollon_lcd_device = {
-	.name			= "lcd",
-	.driver_name		= "generic_dpi_panel",
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.phy.dpi.data_lines	= 18,
-	.data			= &apollon_panel_data,
-};
-
-static struct omap_dss_device *apollon_dss_devices[] = {
-	&apollon_lcd_device,
-};
-
-static struct omap_dss_board_info apollon_dss_data = {
-	.num_devices	= ARRAY_SIZE(apollon_dss_devices),
-	.devices	= apollon_dss_devices,
-	.default_device	= &apollon_lcd_device,
-};
-
-static struct gpio apollon_gpio_leds[] __initdata = {
-	{ LED0_GPIO13, GPIOF_OUT_INIT_LOW, "LED0" }, /* LED0 - AA10 */
-	{ LED1_GPIO14, GPIOF_OUT_INIT_LOW, "LED1" }, /* LED1 - AA6  */
-	{ LED2_GPIO15, GPIOF_OUT_INIT_LOW, "LED2" }, /* LED2 - AA4  */
-};
-
-static void __init apollon_led_init(void)
-{
-	omap_mux_init_signal("vlynq_clk.gpio_13", 0);
-	omap_mux_init_signal("vlynq_rx1.gpio_14", 0);
-	omap_mux_init_signal("vlynq_rx0.gpio_15", 0);
-
-	gpio_request_array(apollon_gpio_leds, ARRAY_SIZE(apollon_gpio_leds));
-}
-
-#ifdef CONFIG_OMAP_MUX
-static struct omap_board_mux board_mux[] __initdata = {
-	{ .reg_offset = OMAP_MUX_TERMINATOR },
-};
-#endif
-
-static void __init omap_apollon_init(void)
-{
-	u32 v;
-
-	omap2420_mux_init(board_mux, OMAP_PACKAGE_ZAC);
-
-	apollon_init_smc91x();
-	apollon_led_init();
-	apollon_flash_init();
-
-	/* REVISIT: where's the correct place */
-	omap_mux_init_signal("sys_nirq", OMAP_PULL_ENA | OMAP_PULL_UP);
-
-	/* LCD PWR_EN */
-	omap_mux_init_signal("mcbsp2_dr.gpio_11", OMAP_PULL_ENA | OMAP_PULL_UP);
-
-	/* Use Internal loop-back in MMC/SDIO Module Input Clock selection */
-	v = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
-	v |= (1 << 24);
-	omap_ctrl_writel(v, OMAP2_CONTROL_DEVCONF0);
-
-	/*
- 	 * Make sure the serial ports are muxed on at this point.
-	 * You have to mux them off in device drivers later on
-	 * if not needed.
-	 */
-	apollon_smc91x_resources[1].start = gpio_to_irq(APOLLON_ETHR_GPIO_IRQ);
-	apollon_smc91x_resources[1].end = gpio_to_irq(APOLLON_ETHR_GPIO_IRQ);
-	platform_add_devices(apollon_devices, ARRAY_SIZE(apollon_devices));
-	omap_serial_init();
-	omap_sdrc_init(NULL, NULL);
-	omap_display_init(&apollon_dss_data);
-}
-
-MACHINE_START(OMAP_APOLLON, "OMAP24xx Apollon")
-	/* Maintainer: Kyungmin Park <kyungmin.park@samsung.com> */
-	.atag_offset	= 0x100,
-	.reserve	= omap_reserve,
-	.map_io		= omap242x_map_io,
-	.init_early	= omap2420_init_early,
-	.init_irq	= omap2_init_irq,
-	.handle_irq	= omap2_intc_handle_irq,
-	.init_machine	= omap_apollon_init,
-	.init_late	= omap2420_init_late,
-	.timer		= &omap2_timer,
-	.restart	= omap2xxx_restart,
-MACHINE_END
