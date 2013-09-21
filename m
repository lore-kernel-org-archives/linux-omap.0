From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 3/3] ARM: OMAP2: delete board-rm680
Date: Sat, 21 Sep 2013 16:45:42 +0300
Message-ID: <1379771142-29087-4-git-send-email-aaro.koskinen@iki.fi>
References: <1379771142-29087-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:46051 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929Ab3IUNtB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 21 Sep 2013 09:49:01 -0400
In-Reply-To: <1379771142-29087-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@iki.fi>, Aaro Koskinen <aaro.koskinen@iki.fi>

Delete board file for Nokia RM-680/RM-696 (N950/N9). DT-based booting
should be used for further development on this HW.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap2/Kconfig       |   7 --
 arch/arm/mach-omap2/Makefile      |   1 -
 arch/arm/mach-omap2/board-rm680.c | 167 --------------------------------------
 3 files changed, 175 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/board-rm680.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index b5fb5f7..5a8e6bf 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -314,13 +314,6 @@ config MACH_NOKIA_N8X0
 	select MACH_NOKIA_N810_WIMAX
 	select OMAP_PACKAGE_ZAC
 
-config MACH_NOKIA_RM680
-	bool "Nokia N950 (RM-680) / N9 (RM-696) phones"
-	depends on ARCH_OMAP3
-	default y
-	select MACH_NOKIA_RM696
-	select OMAP_PACKAGE_CBB
-
 config MACH_NOKIA_RX51
 	bool "Nokia N900 (RX-51) phone"
 	depends on ARCH_OMAP3
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index afb457c..8d6d156 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -246,7 +246,6 @@ obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o
 obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o
 obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o
 obj-$(CONFIG_MACH_NOKIA_N8X0)		+= board-n8x0.o
-obj-$(CONFIG_MACH_NOKIA_RM680)		+= board-rm680.o sdram-nokia.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o sdram-nokia.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51-peripherals.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51-video.o
diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
deleted file mode 100644
index 345e8c4..0000000
--- a/arch/arm/mach-omap2/board-rm680.c
+++ /dev/null
@@ -1,167 +0,0 @@
-/*
- * Board support file for Nokia N950 (RM-680) / N9 (RM-696).
- *
- * Copyright (C) 2010 Nokia
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/io.h>
-#include <linux/i2c.h>
-#include <linux/gpio.h>
-#include <linux/init.h>
-#include <linux/i2c/twl.h>
-#include <linux/platform_device.h>
-#include <linux/regulator/fixed.h>
-#include <linux/regulator/machine.h>
-#include <linux/regulator/consumer.h>
-#include <linux/platform_data/mtd-onenand-omap2.h>
-#include <linux/usb/phy.h>
-
-#include <asm/mach/arch.h>
-#include <asm/mach-types.h>
-
-#include "common.h"
-#include "mux.h"
-#include "gpmc.h"
-#include "mmc.h"
-#include "hsmmc.h"
-#include "sdram-nokia.h"
-#include "common-board-devices.h"
-#include "gpmc-onenand.h"
-
-static struct regulator_consumer_supply rm680_vemmc_consumers[] = {
-	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.1"),
-};
-
-/* Fixed regulator for internal eMMC */
-static struct regulator_init_data rm680_vemmc = {
-	.constraints =	{
-		.name			= "rm680_vemmc",
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_STATUS
-					| REGULATOR_CHANGE_MODE,
-	},
-	.num_consumer_supplies		= ARRAY_SIZE(rm680_vemmc_consumers),
-	.consumer_supplies		= rm680_vemmc_consumers,
-};
-
-static struct fixed_voltage_config rm680_vemmc_config = {
-	.supply_name		= "VEMMC",
-	.microvolts		= 2900000,
-	.gpio			= 157,
-	.startup_delay		= 150,
-	.enable_high		= 1,
-	.init_data		= &rm680_vemmc,
-};
-
-static struct platform_device rm680_vemmc_device = {
-	.name			= "reg-fixed-voltage",
-	.dev			= {
-		.platform_data	= &rm680_vemmc_config,
-	},
-};
-
-static struct platform_device *rm680_peripherals_devices[] __initdata = {
-	&rm680_vemmc_device,
-};
-
-/* TWL */
-static struct twl4030_gpio_platform_data rm680_gpio_data = {
-	.pullups		= BIT(0),
-	.pulldowns		= BIT(1) | BIT(2) | BIT(8) | BIT(15),
-};
-
-static struct twl4030_platform_data rm680_twl_data = {
-	.gpio			= &rm680_gpio_data,
-	/* add rest of the children here */
-};
-
-static void __init rm680_i2c_init(void)
-{
-	omap3_pmic_get_config(&rm680_twl_data, TWL_COMMON_PDATA_USB, 0);
-	omap_pmic_init(1, 2900, "twl5031", 7 + OMAP_INTC_START, &rm680_twl_data);
-	omap_register_i2c_bus(2, 400, NULL, 0);
-	omap_register_i2c_bus(3, 400, NULL, 0);
-}
-
-#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
-	defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
-static struct omap_onenand_platform_data board_onenand_data[] = {
-	{
-		.gpio_irq	= 65,
-		.flags		= ONENAND_SYNC_READWRITE,
-	}
-};
-#endif
-
-/* eMMC */
-static struct omap2_hsmmc_info mmc[] __initdata = {
-	{
-		.name		= "internal",
-		.mmc		= 2,
-		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_MMC_HIGHSPEED,
-		.gpio_cd	= -EINVAL,
-		.gpio_wp	= -EINVAL,
-	},
-	{ /* Terminator */ }
-};
-
-static void __init rm680_peripherals_init(void)
-{
-	platform_add_devices(rm680_peripherals_devices,
-				ARRAY_SIZE(rm680_peripherals_devices));
-	rm680_i2c_init();
-	gpmc_onenand_init(board_onenand_data);
-	omap_hsmmc_init(mmc);
-}
-
-#ifdef CONFIG_OMAP_MUX
-static struct omap_board_mux board_mux[] __initdata = {
-	{ .reg_offset = OMAP_MUX_TERMINATOR },
-};
-#endif
-
-static void __init rm680_init(void)
-{
-	struct omap_sdrc_params *sdrc_params;
-
-	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
-	omap_serial_init();
-
-	sdrc_params = nokia_get_sdram_timings();
-	omap_sdrc_init(sdrc_params, sdrc_params);
-
-	usb_bind_phy("musb-hdrc.0.auto", 0, "twl4030_usb");
-	usb_musb_init(NULL);
-	rm680_peripherals_init();
-}
-
-MACHINE_START(NOKIA_RM680, "Nokia RM-680 board")
-	.atag_offset	= 0x100,
-	.reserve	= omap_reserve,
-	.map_io		= omap3_map_io,
-	.init_early	= omap3630_init_early,
-	.init_irq	= omap3_init_irq,
-	.handle_irq	= omap3_intc_handle_irq,
-	.init_machine	= rm680_init,
-	.init_late	= omap3630_init_late,
-	.init_time	= omap3_sync32k_timer_init,
-	.restart	= omap3xxx_restart,
-MACHINE_END
-
-MACHINE_START(NOKIA_RM696, "Nokia RM-696 board")
-	.atag_offset	= 0x100,
-	.reserve	= omap_reserve,
-	.map_io		= omap3_map_io,
-	.init_early	= omap3630_init_early,
-	.init_irq	= omap3_init_irq,
-	.handle_irq	= omap3_intc_handle_irq,
-	.init_machine	= rm680_init,
-	.init_late	= omap3630_init_late,
-	.init_time	= omap3_sync32k_timer_init,
-	.restart	= omap3xxx_restart,
-MACHINE_END
-- 
1.8.4.rc3

