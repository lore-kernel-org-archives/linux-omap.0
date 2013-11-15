From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 09/11] ARM: OMAP2+: Remove legacy board file for 2430sdp
Date: Thu, 14 Nov 2013 16:09:56 -0800
Message-ID: <1384474198-20756-10-git-send-email-tony@atomide.com>
References: <1384474198-20756-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:42353 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754046Ab3KOAKJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Nov 2013 19:10:09 -0500
In-Reply-To: <1384474198-20756-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

We can now boot with device tree and appended DTB
with basic devices working. If people are still using
this board, patches are welcome to add more complete
support.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig         |   6 -
 arch/arm/mach-omap2/Makefile        |   1 -
 arch/arm/mach-omap2/board-2430sdp.c | 273 ------------------------------------
 3 files changed, 280 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/board-2430sdp.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index f2f71c2..4191ae0 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -192,12 +192,6 @@ config MACH_OMAP2_TUSB6010
 	depends on ARCH_OMAP2 && SOC_OMAP2420
 	default y if MACH_NOKIA_N8X0
 
-config MACH_OMAP_2430SDP
-	bool "OMAP 2430 SDP board"
-	depends on SOC_OMAP2430
-	default y
-	select OMAP_PACKAGE_ZAC
-
 config MACH_OMAP3_BEAGLE
 	bool "OMAP3 BEAGLE board"
 	depends on ARCH_OMAP3
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 8ec6c89..e0d5bcb 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -237,7 +237,6 @@ obj-$(CONFIG_SOC_OMAP2420)		+= msdi.o
 
 # Specific board support
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o pdata-quirks.o
-obj-$(CONFIG_MACH_OMAP_2430SDP)		+= board-2430sdp.o
 obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o
 obj-$(CONFIG_MACH_DEVKIT8000)     	+= board-devkit8000.o
 obj-$(CONFIG_MACH_OMAP_LDP)		+= board-ldp.o
diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
deleted file mode 100644
index c711ad6..0000000
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ /dev/null
@@ -1,273 +0,0 @@
-/*
- * linux/arch/arm/mach-omap2/board-2430sdp.c
- *
- * Copyright (C) 2006 Texas Instruments
- *
- * Modified from mach-omap2/board-generic.c
- *
- * Initial Code : Based on a patch from Komal Shah and Richard Woodruff
- * Updated the Code for 2430 SDP : Syed Mohammed Khasim
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
-#include <linux/mtd/physmap.h>
-#include <linux/mmc/host.h>
-#include <linux/delay.h>
-#include <linux/i2c/twl.h>
-#include <linux/regulator/machine.h>
-#include <linux/err.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-#include <linux/gpio.h>
-#include <linux/usb/phy.h>
-
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-
-#include "common.h"
-#include "gpmc.h"
-#include "gpmc-smc91x.h"
-
-#include <video/omapdss.h>
-#include <video/omap-panel-data.h>
-
-#include "mux.h"
-#include "hsmmc.h"
-#include "common-board-devices.h"
-
-#define SDP2430_CS0_BASE	0x04000000
-#define SECONDARY_LCD_GPIO		147
-
-static struct mtd_partition sdp2430_partitions[] = {
-	/* bootloader (U-Boot, etc) in first sector */
-	{
-		.name		= "bootloader",
-		.offset		= 0,
-		.size		= SZ_256K,
-		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
-	 },
-	/* bootloader params in the next sector */
-	{
-		.name		= "params",
-		.offset		= MTDPART_OFS_APPEND,
-		.size		= SZ_128K,
-		.mask_flags	= 0,
-	 },
-	/* kernel */
-	{
-		.name		= "kernel",
-		.offset		= MTDPART_OFS_APPEND,
-		.size		= SZ_2M,
-		.mask_flags	= 0
-	},
-	/* file system */
-	{
-		.name		= "filesystem",
-		.offset		= MTDPART_OFS_APPEND,
-		.size		= MTDPART_SIZ_FULL,
-		.mask_flags	= 0
-	}
-};
-
-static struct physmap_flash_data sdp2430_flash_data = {
-	.width		= 2,
-	.parts		= sdp2430_partitions,
-	.nr_parts	= ARRAY_SIZE(sdp2430_partitions),
-};
-
-static struct resource sdp2430_flash_resource = {
-	.start		= SDP2430_CS0_BASE,
-	.end		= SDP2430_CS0_BASE + SZ_64M - 1,
-	.flags		= IORESOURCE_MEM,
-};
-
-static struct platform_device sdp2430_flash_device = {
-	.name		= "physmap-flash",
-	.id		= 0,
-	.dev = {
-		.platform_data	= &sdp2430_flash_data,
-	},
-	.num_resources	= 1,
-	.resource	= &sdp2430_flash_resource,
-};
-
-/* LCD */
-#define SDP2430_LCD_PANEL_BACKLIGHT_GPIO	91
-#define SDP2430_LCD_PANEL_ENABLE_GPIO		154
-
-static const struct display_timing sdp2430_lcd_videomode = {
-	.pixelclock	= { 0, 5400000, 0 },
-
-	.hactive = { 0, 240, 0 },
-	.hfront_porch = { 0, 3, 0 },
-	.hback_porch = { 0, 39, 0 },
-	.hsync_len = { 0, 3, 0 },
-
-	.vactive = { 0, 320, 0 },
-	.vfront_porch = { 0, 2, 0 },
-	.vback_porch = { 0, 7, 0 },
-	.vsync_len = { 0, 1, 0 },
-
-	.flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW |
-		DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_POSEDGE,
-};
-
-static struct panel_dpi_platform_data sdp2430_lcd_pdata = {
-	.name                   = "lcd",
-	.source                 = "dpi.0",
-
-	.data_lines		= 16,
-
-	.display_timing		= &sdp2430_lcd_videomode,
-
-	.enable_gpio		= SDP2430_LCD_PANEL_ENABLE_GPIO,
-	.backlight_gpio		= SDP2430_LCD_PANEL_BACKLIGHT_GPIO,
-};
-
-static struct platform_device sdp2430_lcd_device = {
-	.name                   = "panel-dpi",
-	.id                     = 0,
-	.dev.platform_data      = &sdp2430_lcd_pdata,
-};
-
-static struct omap_dss_board_info sdp2430_dss_data = {
-	.default_display_name = "lcd",
-};
-
-static struct platform_device *sdp2430_devices[] __initdata = {
-	&sdp2430_flash_device,
-	&sdp2430_lcd_device,
-};
-
-#if IS_ENABLED(CONFIG_SMC91X)
-
-static struct omap_smc91x_platform_data board_smc91x_data = {
-	.cs		= 5,
-	.gpio_irq	= 149,
-	.flags		= GPMC_MUX_ADD_DATA | GPMC_TIMINGS_SMC91C96 |
-				IORESOURCE_IRQ_LOWLEVEL,
-
-};
-
-static void __init board_smc91x_init(void)
-{
-	omap_mux_init_gpio(149, OMAP_PIN_INPUT);
-	gpmc_smc91x_init(&board_smc91x_data);
-}
-
-#else
-
-static inline void board_smc91x_init(void)
-{
-}
-
-#endif
-
-static struct regulator_consumer_supply sdp2430_vmmc1_supplies[] = {
-	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
-};
-
-/* VMMC1 for OMAP VDD_MMC1 (i/o) and MMC1 card */
-static struct regulator_init_data sdp2430_vmmc1 = {
-	.constraints = {
-		.min_uV			= 1850000,
-		.max_uV			= 3150000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies	= ARRAY_SIZE(sdp2430_vmmc1_supplies),
-	.consumer_supplies	= &sdp2430_vmmc1_supplies[0],
-};
-
-static struct twl4030_gpio_platform_data sdp2430_gpio_data = {
-};
-
-static struct twl4030_platform_data sdp2430_twldata = {
-	/* platform_data for children goes here */
-	.gpio		= &sdp2430_gpio_data,
-	.vmmc1		= &sdp2430_vmmc1,
-};
-
-static struct i2c_board_info __initdata sdp2430_i2c1_boardinfo[] = {
-	{
-		I2C_BOARD_INFO("isp1301_omap", 0x2D),
-		.flags = I2C_CLIENT_WAKE,
-	},
-};
-
-static int __init omap2430_i2c_init(void)
-{
-	sdp2430_i2c1_boardinfo[0].irq = gpio_to_irq(78);
-	omap_register_i2c_bus(1, 100, sdp2430_i2c1_boardinfo,
-			ARRAY_SIZE(sdp2430_i2c1_boardinfo));
-	omap_pmic_init(2, 100, "twl4030", 7 + OMAP_INTC_START,
-			&sdp2430_twldata);
-	return 0;
-}
-
-static struct omap2_hsmmc_info mmc[] __initdata = {
-	{
-		.mmc		= 1,
-		.caps		= MMC_CAP_4_BIT_DATA,
-		.gpio_cd	= -EINVAL,
-		.gpio_wp	= -EINVAL,
-		.ext_clock	= 1,
-	},
-	{}	/* Terminator */
-};
-
-#ifdef CONFIG_OMAP_MUX
-static struct omap_board_mux board_mux[] __initdata = {
-	{ .reg_offset = OMAP_MUX_TERMINATOR },
-};
-#endif
-
-static void __init omap_2430sdp_init(void)
-{
-	omap2430_mux_init(board_mux, OMAP_PACKAGE_ZAC);
-
-	omap2430_i2c_init();
-
-	platform_add_devices(sdp2430_devices, ARRAY_SIZE(sdp2430_devices));
-	omap_serial_init();
-	omap_sdrc_init(NULL, NULL);
-	omap_hsmmc_init(mmc);
-
-	omap_mux_init_signal("usb0hs_stp", OMAP_PULL_ENA | OMAP_PULL_UP);
-	usb_bind_phy("musb-hdrc.0.auto", 0, "twl4030_usb");
-	usb_musb_init(NULL);
-
-	board_smc91x_init();
-
-	/* Turn off secondary LCD backlight */
-	gpio_request_one(SECONDARY_LCD_GPIO, GPIOF_OUT_INIT_LOW,
-			 "Secondary LCD backlight");
-
-	omap_display_init(&sdp2430_dss_data);
-}
-
-MACHINE_START(OMAP_2430SDP, "OMAP2430 sdp2430 board")
-	/* Maintainer: Syed Khasim - Texas Instruments Inc */
-	.atag_offset	= 0x100,
-	.reserve	= omap_reserve,
-	.map_io		= omap243x_map_io,
-	.init_early	= omap2430_init_early,
-	.init_irq	= omap2_init_irq,
-	.handle_irq	= omap2_intc_handle_irq,
-	.init_machine	= omap_2430sdp_init,
-	.init_late	= omap2430_init_late,
-	.init_time	= omap2_sync32k_timer_init,
-	.restart	= omap2xxx_restart,
-MACHINE_END
-- 
1.8.1.1

