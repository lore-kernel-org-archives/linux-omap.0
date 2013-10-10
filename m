From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 8/8] ARM: OMAP2+: Remove legacy support for zoom platforms
Date: Thu, 10 Oct 2013 15:21:00 -0700
Message-ID: <20131010222100.9063.53820.stgit@localhost>
References: <20131010221833.9063.49904.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:48469 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755844Ab3JJWVC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Oct 2013 18:21:02 -0400
In-Reply-To: <20131010221833.9063.49904.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org

We now have pretty decent device tree based support for
zoom platforms. It's not complete, but basics work for
me so adding more features should be quite trivial.

Looks like also 3630 sdp is zoom based, and looking
at it's board file should also be trivial to support
with the device tree based booting.

Patches are welcome if people are still using these.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig                  |   20 -
 arch/arm/mach-omap2/Makefile                 |    9 -
 arch/arm/mach-omap2/board-3630sdp.c          |  225 ----------------
 arch/arm/mach-omap2/board-ldp.c              |    3 
 arch/arm/mach-omap2/board-zoom-debugboard.c  |  139 ----------
 arch/arm/mach-omap2/board-zoom-display.c     |   71 -----
 arch/arm/mach-omap2/board-zoom-peripherals.c |  360 --------------------------
 arch/arm/mach-omap2/board-zoom.c             |  159 -----------
 arch/arm/mach-omap2/board-zoom.h             |   10 -
 9 files changed, 1 insertion(+), 995 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/board-3630sdp.c
 delete mode 100644 arch/arm/mach-omap2/board-zoom-debugboard.c
 delete mode 100644 arch/arm/mach-omap2/board-zoom-display.c
 delete mode 100644 arch/arm/mach-omap2/board-zoom-peripherals.c
 delete mode 100644 arch/arm/mach-omap2/board-zoom.c
 delete mode 100644 arch/arm/mach-omap2/board-zoom.h

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 91a65b3..216154d 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -317,20 +317,6 @@ config MACH_NOKIA_RX51
 	default y
 	select OMAP_PACKAGE_CBB
 
-config MACH_OMAP_ZOOM2
-	bool "OMAP3 Zoom2 board"
-	depends on ARCH_OMAP3
-	default y
-	select OMAP_PACKAGE_CBB
-	select REGULATOR_FIXED_VOLTAGE if REGULATOR
-
-config MACH_OMAP_ZOOM3
-	bool "OMAP3630 Zoom3 board"
-	depends on ARCH_OMAP3
-	default y
-	select OMAP_PACKAGE_CBP
-	select REGULATOR_FIXED_VOLTAGE if REGULATOR
-
 config MACH_CM_T35
 	bool "CompuLab CM-T35/CM-T3730 modules"
 	depends on ARCH_OMAP3
@@ -366,12 +352,6 @@ config MACH_SBC3530
 	default y
 	select OMAP_PACKAGE_CUS
 
-config MACH_OMAP_3630SDP
-	bool "OMAP3630 SDP board"
-	depends on ARCH_OMAP3
-	default y
-	select OMAP_PACKAGE_CBP
-
 config MACH_TI8168EVM
 	bool "TI8168 Evaluation Module"
 	depends on SOC_TI81XX
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 7be6e3a..9d78b49 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -249,15 +249,6 @@ obj-$(CONFIG_MACH_NOKIA_RM680)		+= board-rm680.o sdram-nokia.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o sdram-nokia.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51-peripherals.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51-video.o
-obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom.o board-zoom-peripherals.o
-obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom-display.o
-obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom-debugboard.o
-obj-$(CONFIG_MACH_OMAP_ZOOM3)		+= board-zoom.o board-zoom-peripherals.o
-obj-$(CONFIG_MACH_OMAP_ZOOM3)		+= board-zoom-display.o
-obj-$(CONFIG_MACH_OMAP_ZOOM3)		+= board-zoom-debugboard.o
-obj-$(CONFIG_MACH_OMAP_3630SDP)		+= board-3630sdp.o
-obj-$(CONFIG_MACH_OMAP_3630SDP)		+= board-zoom-peripherals.o
-obj-$(CONFIG_MACH_OMAP_3630SDP)		+= board-zoom-display.o
 obj-$(CONFIG_MACH_CM_T35)		+= board-cm-t35.o
 obj-$(CONFIG_MACH_CM_T3517)		+= board-cm-t3517.o
 obj-$(CONFIG_MACH_IGEP0020)		+= board-igep0020.o
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
deleted file mode 100644
index 20d6d81..0000000
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ /dev/null
@@ -1,225 +0,0 @@
-/*
- * Copyright (C) 2009 Texas Instruments Inc.
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
-#include <linux/mtd/nand.h>
-
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-
-#include "common.h"
-#include "gpmc-smc91x.h"
-
-#include "board-zoom.h"
-
-#include "board-flash.h"
-#include "mux.h"
-#include "sdram-hynix-h8mbx00u0mer-0em.h"
-
-#if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91X_MODULE)
-
-static struct omap_smc91x_platform_data board_smc91x_data = {
-	.cs             = 3,
-	.flags          = GPMC_MUX_ADD_DATA | IORESOURCE_IRQ_LOWLEVEL,
-};
-
-static void __init board_smc91x_init(void)
-{
-	board_smc91x_data.gpio_irq = 158;
-	gpmc_smc91x_init(&board_smc91x_data);
-}
-
-#else
-
-static inline void board_smc91x_init(void)
-{
-}
-
-#endif /* defined(CONFIG_SMC91X) || defined(CONFIG_SMC91X_MODULE) */
-
-static void enable_board_wakeup_source(void)
-{
-	/* T2 interrupt line (keypad) */
-	omap_mux_init_signal("sys_nirq",
-		OMAP_WAKEUP_EN | OMAP_PIN_INPUT_PULLUP);
-}
-
-static struct usbhs_phy_data phy_data[] __initdata = {
-	{
-		.port = 1,
-		.reset_gpio = 126,
-		.vcc_gpio = -EINVAL,
-	},
-	{
-		.port = 2,
-		.reset_gpio = 61,
-		.vcc_gpio = -EINVAL,
-	},
-};
-
-static struct usbhs_omap_platform_data usbhs_bdata __initdata = {
-
-	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
-	.port_mode[1] = OMAP_EHCI_PORT_MODE_PHY,
-};
-
-#ifdef CONFIG_OMAP_MUX
-static struct omap_board_mux board_mux[] __initdata = {
-	{ .reg_offset = OMAP_MUX_TERMINATOR },
-};
-#endif
-
-/*
- * SDP3630 CS organization
- * See also the Switch S8 settings in the comments.
- */
-static char chip_sel_sdp[][GPMC_CS_NUM] = {
-	{PDC_NOR, PDC_NAND, PDC_ONENAND, DBG_MPDB, 0, 0, 0, 0}, /* S8:1111 */
-	{PDC_ONENAND, PDC_NAND, PDC_NOR, DBG_MPDB, 0, 0, 0, 0}, /* S8:1110 */
-	{PDC_NAND, PDC_ONENAND, PDC_NOR, DBG_MPDB, 0, 0, 0, 0}, /* S8:1101 */
-};
-
-static struct mtd_partition sdp_nor_partitions[] = {
-	/* bootloader (U-Boot, etc) in first sector */
-	{
-		.name		= "Bootloader-NOR",
-		.offset		= 0,
-		.size		= SZ_256K,
-		.mask_flags	= MTD_WRITEABLE, /* force read-only */
-	},
-	/* bootloader params in the next sector */
-	{
-		.name		= "Params-NOR",
-		.offset		= MTDPART_OFS_APPEND,
-		.size		= SZ_256K,
-		.mask_flags	= 0,
-	},
-	/* kernel */
-	{
-		.name		= "Kernel-NOR",
-		.offset		= MTDPART_OFS_APPEND,
-		.size		= SZ_2M,
-		.mask_flags	= 0
-	},
-	/* file system */
-	{
-		.name		= "Filesystem-NOR",
-		.offset		= MTDPART_OFS_APPEND,
-		.size		= MTDPART_SIZ_FULL,
-		.mask_flags	= 0
-	}
-};
-
-static struct mtd_partition sdp_onenand_partitions[] = {
-	{
-		.name		= "X-Loader-OneNAND",
-		.offset		= 0,
-		.size		= 4 * (64 * 2048),
-		.mask_flags	= MTD_WRITEABLE  /* force read-only */
-	},
-	{
-		.name		= "U-Boot-OneNAND",
-		.offset		= MTDPART_OFS_APPEND,
-		.size		= 2 * (64 * 2048),
-		.mask_flags	= MTD_WRITEABLE  /* force read-only */
-	},
-	{
-		.name		= "U-Boot Environment-OneNAND",
-		.offset		= MTDPART_OFS_APPEND,
-		.size		= 1 * (64 * 2048),
-	},
-	{
-		.name		= "Kernel-OneNAND",
-		.offset		= MTDPART_OFS_APPEND,
-		.size		= 16 * (64 * 2048),
-	},
-	{
-		.name		= "File System-OneNAND",
-		.offset		= MTDPART_OFS_APPEND,
-		.size		= MTDPART_SIZ_FULL,
-	},
-};
-
-static struct mtd_partition sdp_nand_partitions[] = {
-	/* All the partition sizes are listed in terms of NAND block size */
-	{
-		.name		= "X-Loader-NAND",
-		.offset		= 0,
-		.size		= 4 * (64 * 2048),
-		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
-	},
-	{
-		.name		= "U-Boot-NAND",
-		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x80000 */
-		.size		= 10 * (64 * 2048),
-		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
-	},
-	{
-		.name		= "Boot Env-NAND",
-
-		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x1c0000 */
-		.size		= 6 * (64 * 2048),
-	},
-	{
-		.name		= "Kernel-NAND",
-		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x280000 */
-		.size		= 40 * (64 * 2048),
-	},
-	{
-		.name		= "File System - NAND",
-		.size		= MTDPART_SIZ_FULL,
-		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x780000 */
-	},
-};
-
-static struct flash_partitions sdp_flash_partitions[] = {
-	{
-		.parts = sdp_nor_partitions,
-		.nr_parts = ARRAY_SIZE(sdp_nor_partitions),
-	},
-	{
-		.parts = sdp_onenand_partitions,
-		.nr_parts = ARRAY_SIZE(sdp_onenand_partitions),
-	},
-	{
-		.parts = sdp_nand_partitions,
-		.nr_parts = ARRAY_SIZE(sdp_nand_partitions),
-	},
-};
-
-static void __init omap_sdp_init(void)
-{
-	omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
-	zoom_peripherals_init();
-	omap_sdrc_init(h8mbx00u0mer0em_sdrc_params,
-				  h8mbx00u0mer0em_sdrc_params);
-	zoom_display_init();
-	board_smc91x_init();
-	board_flash_init(sdp_flash_partitions, chip_sel_sdp, NAND_BUSWIDTH_16);
-	enable_board_wakeup_source();
-
-	usbhs_init_phys(phy_data, ARRAY_SIZE(phy_data));
-	usbhs_init(&usbhs_bdata);
-}
-
-MACHINE_START(OMAP_3630SDP, "OMAP 3630SDP board")
-	.atag_offset	= 0x100,
-	.reserve	= omap_reserve,
-	.map_io		= omap3_map_io,
-	.init_early	= omap3630_init_early,
-	.init_irq	= omap3_init_irq,
-	.handle_irq	= omap3_intc_handle_irq,
-	.init_machine	= omap_sdp_init,
-	.init_late	= omap3630_init_late,
-	.init_time	= omap3_sync32k_timer_init,
-	.restart	= omap3xxx_restart,
-MACHINE_END
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index dd8da2c..4ec8d82 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -36,7 +36,6 @@
 #include <asm/mach/map.h>
 
 #include "common.h"
-#include "board-zoom.h"
 #include "gpmc.h"
 #include "gpmc-smsc911x.h"
 
@@ -406,7 +405,7 @@ static void __init omap_ldp_init(void)
 	usb_bind_phy("musb-hdrc.0.auto", 0, "twl4030_usb");
 	usb_musb_init(NULL);
 	board_nand_init(ldp_nand_partitions, ARRAY_SIZE(ldp_nand_partitions),
-			ZOOM_NAND_CS, 0, nand_default_timings);
+			0, 0, nand_default_timings);
 
 	omap_hsmmc_init(mmc);
 	ldp_display_init();
diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
deleted file mode 100644
index 42e5f23..0000000
--- a/arch/arm/mach-omap2/board-zoom-debugboard.c
+++ /dev/null
@@ -1,139 +0,0 @@
-/*
- * Copyright (C) 2009 Texas Instruments Inc.
- * Mikkel Christensen <mlc@ti.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/gpio.h>
-#include <linux/serial_8250.h>
-#include <linux/smsc911x.h>
-#include <linux/interrupt.h>
-
-#include <linux/regulator/fixed.h>
-#include <linux/regulator/machine.h>
-
-#include "gpmc.h"
-#include "gpmc-smsc911x.h"
-
-#include "board-zoom.h"
-
-#include "soc.h"
-#include "common.h"
-
-#define ZOOM_SMSC911X_CS	7
-#define ZOOM_SMSC911X_GPIO	158
-#define ZOOM_QUADUART_CS	3
-#define ZOOM_QUADUART_GPIO	102
-#define ZOOM_QUADUART_RST_GPIO	152
-#define QUART_CLK		1843200
-#define DEBUG_BASE		0x08000000
-#define ZOOM_ETHR_START	DEBUG_BASE
-
-static struct omap_smsc911x_platform_data zoom_smsc911x_cfg = {
-	.cs             = ZOOM_SMSC911X_CS,
-	.gpio_irq       = ZOOM_SMSC911X_GPIO,
-	.gpio_reset     = -EINVAL,
-	.flags		= SMSC911X_USE_32BIT,
-};
-
-static inline void __init zoom_init_smsc911x(void)
-{
-	gpmc_smsc911x_init(&zoom_smsc911x_cfg);
-}
-
-static struct plat_serial8250_port serial_platform_data[] = {
-	{
-		.mapbase	= ZOOM_UART_BASE,
-		.flags		= UPF_BOOT_AUTOCONF|UPF_IOREMAP|UPF_SHARE_IRQ,
-		.irqflags	= IRQF_SHARED | IRQF_TRIGGER_RISING,
-		.iotype		= UPIO_MEM,
-		.regshift	= 1,
-		.uartclk	= QUART_CLK,
-	}, {
-		.flags		= 0
-	}
-};
-
-static struct platform_device zoom_debugboard_serial_device = {
-	.name			= "serial8250",
-	.id			= PLAT8250_DEV_PLATFORM,
-	.dev			= {
-		.platform_data	= serial_platform_data,
-	},
-};
-
-static inline void __init zoom_init_quaduart(void)
-{
-	int quart_cs;
-	unsigned long cs_mem_base;
-	int quart_gpio = 0;
-
-	if (gpio_request_one(ZOOM_QUADUART_RST_GPIO,
-				GPIOF_OUT_INIT_LOW,
-				"TL16CP754C GPIO") < 0) {
-		pr_err("Failed to request GPIO%d for TL16CP754C\n",
-			ZOOM_QUADUART_RST_GPIO);
-		return;
-	}
-
-	quart_cs = ZOOM_QUADUART_CS;
-
-	if (gpmc_cs_request(quart_cs, SZ_1M, &cs_mem_base) < 0) {
-		pr_err("Failed to request GPMC mem for Quad UART(TL16CP754C)\n");
-		return;
-	}
-
-	quart_gpio = ZOOM_QUADUART_GPIO;
-
-	if (gpio_request_one(quart_gpio, GPIOF_IN, "TL16CP754C GPIO") < 0)
-		printk(KERN_ERR "Failed to request GPIO%d for TL16CP754C\n",
-								quart_gpio);
-
-	serial_platform_data[0].irq = gpio_to_irq(102);
-}
-
-static inline int omap_zoom_debugboard_detect(void)
-{
-	int debug_board_detect = 0;
-	int ret = 1;
-
-	debug_board_detect = ZOOM_SMSC911X_GPIO;
-
-	if (gpio_request_one(debug_board_detect, GPIOF_IN,
-			     "Zoom debug board detect") < 0) {
-		pr_err("Failed to request GPIO%d for Zoom debug board detect\n",
-		       debug_board_detect);
-		return 0;
-	}
-
-	if (!gpio_get_value(debug_board_detect)) {
-		ret = 0;
-	}
-	gpio_free(debug_board_detect);
-	return ret;
-}
-
-static struct platform_device *zoom_devices[] __initdata = {
-	&zoom_debugboard_serial_device,
-};
-
-static struct regulator_consumer_supply dummy_supplies[] = {
-	REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
-	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
-};
-
-int __init zoom_debugboard_init(void)
-{
-	if (!omap_zoom_debugboard_detect())
-		return 0;
-
-	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
-	zoom_init_smsc911x();
-	zoom_init_quaduart();
-	return platform_add_devices(zoom_devices, ARRAY_SIZE(zoom_devices));
-}
diff --git a/arch/arm/mach-omap2/board-zoom-display.c b/arch/arm/mach-omap2/board-zoom-display.c
deleted file mode 100644
index 3d8ecc1..0000000
--- a/arch/arm/mach-omap2/board-zoom-display.c
+++ /dev/null
@@ -1,71 +0,0 @@
-/*
- * Copyright (C) 2010 Texas Instruments Inc.
- *
- * Modified from mach-omap2/board-zoom-peripherals.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/gpio.h>
-#include <linux/spi/spi.h>
-#include <linux/platform_data/spi-omap2-mcspi.h>
-#include <video/omapdss.h>
-#include <video/omap-panel-data.h>
-
-#include "board-zoom.h"
-#include "soc.h"
-#include "common.h"
-
-#define LCD_PANEL_RESET_GPIO_PROD	96
-#define LCD_PANEL_RESET_GPIO_PILOT	55
-#define LCD_PANEL_QVGA_GPIO		56
-
-static struct panel_nec_nl8048hl11_platform_data zoom_lcd_pdata = {
-	.name                   = "lcd",
-	.source                 = "dpi.0",
-
-	.data_lines		= 24,
-
-	.res_gpio		= -1,	/* filled in code */
-	.qvga_gpio		= LCD_PANEL_QVGA_GPIO,
-};
-
-static struct omap_dss_board_info zoom_dss_data = {
-	.default_display_name = "lcd",
-};
-
-static void __init zoom_lcd_panel_init(void)
-{
-	zoom_lcd_pdata.res_gpio = (omap_rev() > OMAP3430_REV_ES3_0) ?
-			LCD_PANEL_RESET_GPIO_PROD :
-			LCD_PANEL_RESET_GPIO_PILOT;
-}
-
-static struct omap2_mcspi_device_config dss_lcd_mcspi_config = {
-	.turbo_mode		= 1,
-};
-
-static struct spi_board_info nec_8048_spi_board_info[] __initdata = {
-	[0] = {
-		.modalias		= "panel-nec-nl8048hl11",
-		.bus_num		= 1,
-		.chip_select		= 2,
-		.max_speed_hz		= 375000,
-		.controller_data	= &dss_lcd_mcspi_config,
-		.platform_data		= &zoom_lcd_pdata,
-	},
-};
-
-void __init zoom_display_init(void)
-{
-	omap_display_init(&zoom_dss_data);
-	zoom_lcd_panel_init();
-	spi_register_board_info(nec_8048_spi_board_info,
-				ARRAY_SIZE(nec_8048_spi_board_info));
-}
-
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
deleted file mode 100644
index a90375d..0000000
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ /dev/null
@@ -1,360 +0,0 @@
-/*
- * Copyright (C) 2009 Texas Instruments Inc.
- *
- * Modified from mach-omap2/board-zoom2.c
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
-#include <linux/input/matrix_keypad.h>
-#include <linux/gpio.h>
-#include <linux/i2c/twl.h>
-#include <linux/regulator/machine.h>
-#include <linux/regulator/fixed.h>
-#include <linux/wl12xx.h>
-#include <linux/mmc/host.h>
-#include <linux/platform_data/gpio-omap.h>
-#include <linux/platform_data/omap-twl4030.h>
-#include <linux/usb/phy.h>
-#include <linux/pwm.h>
-#include <linux/leds_pwm.h>
-#include <linux/pwm_backlight.h>
-
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-
-#include "common.h"
-
-#include "board-zoom.h"
-
-#include "mux.h"
-#include "hsmmc.h"
-#include "common-board-devices.h"
-
-#define OMAP_ZOOM_WLAN_PMENA_GPIO	(101)
-#define OMAP_ZOOM_TSC2004_IRQ_GPIO	(153)
-#define OMAP_ZOOM_WLAN_IRQ_GPIO		(162)
-
-/* Zoom2 has Qwerty keyboard*/
-static uint32_t board_keymap[] = {
-	KEY(0, 0, KEY_E),
-	KEY(0, 1, KEY_R),
-	KEY(0, 2, KEY_T),
-	KEY(0, 3, KEY_HOME),
-	KEY(0, 6, KEY_I),
-	KEY(0, 7, KEY_LEFTSHIFT),
-	KEY(1, 0, KEY_D),
-	KEY(1, 1, KEY_F),
-	KEY(1, 2, KEY_G),
-	KEY(1, 3, KEY_SEND),
-	KEY(1, 6, KEY_K),
-	KEY(1, 7, KEY_ENTER),
-	KEY(2, 0, KEY_X),
-	KEY(2, 1, KEY_C),
-	KEY(2, 2, KEY_V),
-	KEY(2, 3, KEY_END),
-	KEY(2, 6, KEY_DOT),
-	KEY(2, 7, KEY_CAPSLOCK),
-	KEY(3, 0, KEY_Z),
-	KEY(3, 1, KEY_KPPLUS),
-	KEY(3, 2, KEY_B),
-	KEY(3, 3, KEY_F1),
-	KEY(3, 6, KEY_O),
-	KEY(3, 7, KEY_SPACE),
-	KEY(4, 0, KEY_W),
-	KEY(4, 1, KEY_Y),
-	KEY(4, 2, KEY_U),
-	KEY(4, 3, KEY_F2),
-	KEY(4, 4, KEY_VOLUMEUP),
-	KEY(4, 6, KEY_L),
-	KEY(4, 7, KEY_LEFT),
-	KEY(5, 0, KEY_S),
-	KEY(5, 1, KEY_H),
-	KEY(5, 2, KEY_J),
-	KEY(5, 3, KEY_F3),
-	KEY(5, 4, KEY_UNKNOWN),
-	KEY(5, 5, KEY_VOLUMEDOWN),
-	KEY(5, 6, KEY_M),
-	KEY(5, 7, KEY_RIGHT),
-	KEY(6, 0, KEY_Q),
-	KEY(6, 1, KEY_A),
-	KEY(6, 2, KEY_N),
-	KEY(6, 3, KEY_BACKSPACE),
-	KEY(6, 6, KEY_P),
-	KEY(6, 7, KEY_UP),
-	KEY(7, 0, KEY_PROG1),	/*MACRO 1 <User defined> */
-	KEY(7, 1, KEY_PROG2),	/*MACRO 2 <User defined> */
-	KEY(7, 2, KEY_PROG3),	/*MACRO 3 <User defined> */
-	KEY(7, 3, KEY_PROG4),	/*MACRO 4 <User defined> */
-	KEY(7, 6, KEY_SELECT),
-	KEY(7, 7, KEY_DOWN)
-};
-
-static struct matrix_keymap_data board_map_data = {
-	.keymap			= board_keymap,
-	.keymap_size		= ARRAY_SIZE(board_keymap),
-};
-
-static struct twl4030_keypad_data zoom_kp_twl4030_data = {
-	.keymap_data	= &board_map_data,
-	.rows		= 8,
-	.cols		= 8,
-	.rep		= 1,
-};
-
-static struct regulator_consumer_supply zoom_vmmc1_supply[] = {
-	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
-};
-
-static struct regulator_consumer_supply zoom_vsim_supply[] = {
-	REGULATOR_SUPPLY("vmmc_aux", "omap_hsmmc.0"),
-};
-
-static struct regulator_consumer_supply zoom_vmmc2_supply[] = {
-	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.1"),
-};
-
-static struct regulator_consumer_supply zoom_vmmc3_supply[] = {
-	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.2"),
-};
-
-/* VMMC1 for OMAP VDD_MMC1 (i/o) and MMC1 card */
-static struct regulator_init_data zoom_vmmc1 = {
-	.constraints = {
-		.min_uV			= 1850000,
-		.max_uV			= 3150000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies  = ARRAY_SIZE(zoom_vmmc1_supply),
-	.consumer_supplies      = zoom_vmmc1_supply,
-};
-
-/* VMMC2 for MMC2 card */
-static struct regulator_init_data zoom_vmmc2 = {
-	.constraints = {
-		.min_uV			= 1850000,
-		.max_uV			= 1850000,
-		.apply_uV		= true,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies  = ARRAY_SIZE(zoom_vmmc2_supply),
-	.consumer_supplies      = zoom_vmmc2_supply,
-};
-
-/* VSIM for OMAP VDD_MMC1A (i/o for DAT4..DAT7) */
-static struct regulator_init_data zoom_vsim = {
-	.constraints = {
-		.min_uV			= 1800000,
-		.max_uV			= 3000000,
-		.valid_modes_mask	= REGULATOR_MODE_NORMAL
-					| REGULATOR_MODE_STANDBY,
-		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
-					| REGULATOR_CHANGE_MODE
-					| REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies  = ARRAY_SIZE(zoom_vsim_supply),
-	.consumer_supplies      = zoom_vsim_supply,
-};
-
-static struct regulator_init_data zoom_vmmc3 = {
-	.constraints = {
-		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
-	},
-	.num_consumer_supplies	= ARRAY_SIZE(zoom_vmmc3_supply),
-	.consumer_supplies	= zoom_vmmc3_supply,
-};
-
-static struct fixed_voltage_config zoom_vwlan = {
-	.supply_name		= "vwl1271",
-	.microvolts		= 1800000, /* 1.8V */
-	.gpio			= OMAP_ZOOM_WLAN_PMENA_GPIO,
-	.startup_delay		= 70000, /* 70msec */
-	.enable_high		= 1,
-	.enabled_at_boot	= 0,
-	.init_data		= &zoom_vmmc3,
-};
-
-static struct platform_device omap_vwlan_device = {
-	.name		= "reg-fixed-voltage",
-	.id		= 1,
-	.dev = {
-		.platform_data	= &zoom_vwlan,
-	},
-};
-
-static struct pwm_lookup zoom_pwm_lookup[] = {
-	PWM_LOOKUP("twl-pwm", 0, "leds_pwm", "zoom::keypad"),
-	PWM_LOOKUP("twl-pwm", 1, "pwm-backlight", "backlight"),
-};
-
-static struct led_pwm zoom_pwm_leds[] = {
-	{
-		.name		= "zoom::keypad",
-		.max_brightness	= 127,
-		.pwm_period_ns	= 7812500,
-	},
-};
-
-static struct led_pwm_platform_data zoom_pwm_data = {
-	.num_leds	= ARRAY_SIZE(zoom_pwm_leds),
-	.leds		= zoom_pwm_leds,
-};
-
-static struct platform_device zoom_leds_pwm = {
-	.name	= "leds_pwm",
-	.id	= -1,
-	.dev	= {
-		.platform_data = &zoom_pwm_data,
-	},
-};
-
-static struct platform_pwm_backlight_data zoom_backlight_data = {
-	.pwm_id = 1,
-	.max_brightness = 127,
-	.dft_brightness = 127,
-	.pwm_period_ns = 7812500,
-};
-
-static struct platform_device zoom_backlight_pwm = {
-	.name   = "pwm-backlight",
-	.id     = -1,
-	.dev    = {
-		.platform_data = &zoom_backlight_data,
-	},
-};
-
-static struct platform_device *zoom_devices[] __initdata = {
-	&omap_vwlan_device,
-	&zoom_leds_pwm,
-	&zoom_backlight_pwm,
-};
-
-static struct wl12xx_platform_data omap_zoom_wlan_data __initdata = {
-	.board_ref_clock = WL12XX_REFCLOCK_26, /* 26 MHz */
-};
-
-static struct omap2_hsmmc_info mmc[] = {
-	{
-		.name		= "external",
-		.mmc		= 1,
-		.caps		= MMC_CAP_4_BIT_DATA,
-		.gpio_wp	= -EINVAL,
-		.power_saving	= true,
-		.deferred	= true,
-	},
-	{
-		.name		= "internal",
-		.mmc		= 2,
-		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
-		.gpio_cd	= -EINVAL,
-		.gpio_wp	= -EINVAL,
-		.nonremovable	= true,
-		.power_saving	= true,
-	},
-	{
-		.name		= "wl1271",
-		.mmc		= 3,
-		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_POWER_OFF_CARD,
-		.gpio_wp	= -EINVAL,
-		.gpio_cd	= -EINVAL,
-		.nonremovable	= true,
-	},
-	{}      /* Terminator */
-};
-
-static struct omap_tw4030_pdata omap_twl4030_audio_data = {
-	.voice_connected = true,
-	.custom_routing	= true,
-
-	.has_hs		= OMAP_TWL4030_LEFT | OMAP_TWL4030_RIGHT,
-	.has_hf		= OMAP_TWL4030_LEFT | OMAP_TWL4030_RIGHT,
-
-	.has_mainmic	= true,
-	.has_submic	= true,
-	.has_hsmic	= true,
-	.has_linein	= OMAP_TWL4030_LEFT | OMAP_TWL4030_RIGHT,
-};
-
-static int zoom_twl_gpio_setup(struct device *dev,
-		unsigned gpio, unsigned ngpio)
-{
-	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
-	mmc[0].gpio_cd = gpio + 0;
-	omap_hsmmc_late_init(mmc);
-
-	/* Audio setup */
-	omap_twl4030_audio_data.jack_detect = gpio + 2;
-	omap_twl4030_audio_init("Zoom2", &omap_twl4030_audio_data);
-
-	return 0;
-}
-
-static struct twl4030_gpio_platform_data zoom_gpio_data = {
-	.setup		= zoom_twl_gpio_setup,
-};
-
-static struct twl4030_platform_data zoom_twldata = {
-	/* platform_data for children goes here */
-	.gpio		= &zoom_gpio_data,
-	.keypad		= &zoom_kp_twl4030_data,
-	.vmmc1          = &zoom_vmmc1,
-	.vmmc2          = &zoom_vmmc2,
-	.vsim           = &zoom_vsim,
-};
-
-static int __init omap_i2c_init(void)
-{
-	omap3_pmic_get_config(&zoom_twldata,
-			TWL_COMMON_PDATA_USB | TWL_COMMON_PDATA_BCI |
-			TWL_COMMON_PDATA_MADC | TWL_COMMON_PDATA_AUDIO,
-			TWL_COMMON_REGULATOR_VDAC | TWL_COMMON_REGULATOR_VPLL2);
-
-	if (machine_is_omap_zoom2())
-		zoom_twldata.audio->codec->ramp_delay_value = 3; /* 161 ms */
-
-	omap_pmic_init(1, 2400, "twl5030", 7 + OMAP_INTC_START, &zoom_twldata);
-	omap_register_i2c_bus(2, 400, NULL, 0);
-	omap_register_i2c_bus(3, 400, NULL, 0);
-	return 0;
-}
-
-static void enable_board_wakeup_source(void)
-{
-	/* T2 interrupt line (keypad) */
-	omap_mux_init_signal("sys_nirq",
-		OMAP_WAKEUP_EN | OMAP_PIN_INPUT_PULLUP);
-}
-
-void __init zoom_peripherals_init(void)
-{
-	int ret;
-
-	omap_zoom_wlan_data.irq = gpio_to_irq(OMAP_ZOOM_WLAN_IRQ_GPIO);
-	ret = wl12xx_set_platform_data(&omap_zoom_wlan_data);
-
-	if (ret)
-		pr_err("error setting wl12xx data: %d\n", ret);
-
-	omap_hsmmc_init(mmc);
-	omap_i2c_init();
-	pwm_add_table(zoom_pwm_lookup, ARRAY_SIZE(zoom_pwm_lookup));
-	platform_add_devices(zoom_devices, ARRAY_SIZE(zoom_devices));
-	usb_bind_phy("musb-hdrc.0.auto", 0, "twl4030_usb");
-	usb_musb_init(NULL);
-	enable_board_wakeup_source();
-	omap_serial_init();
-}
diff --git a/arch/arm/mach-omap2/board-zoom.c b/arch/arm/mach-omap2/board-zoom.c
deleted file mode 100644
index 1a3dd86..0000000
--- a/arch/arm/mach-omap2/board-zoom.c
+++ /dev/null
@@ -1,159 +0,0 @@
-/*
- * Copyright (C) 2009-2010 Texas Instruments Inc.
- * Mikkel Christensen <mlc@ti.com>
- * Felipe Balbi <balbi@ti.com>
- *
- * Modified from mach-omap2/board-ldp.c
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
-#include <linux/i2c/twl.h>
-#include <linux/mtd/nand.h>
-
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-
-#include "common.h"
-
-#include "board-zoom.h"
-
-#include "board-flash.h"
-#include "mux.h"
-#include "sdram-micron-mt46h32m32lf-6.h"
-#include "sdram-hynix-h8mbx00u0mer-0em.h"
-
-#define ZOOM3_EHCI_RESET_GPIO		64
-
-#ifdef CONFIG_OMAP_MUX
-static struct omap_board_mux board_mux[] __initdata = {
-	/* WLAN IRQ - GPIO 162 */
-	OMAP3_MUX(MCBSP1_CLKX, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
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
-#endif
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
-static struct usbhs_phy_data phy_data[] __initdata = {
-	{
-		.port = 2,
-		.reset_gpio = ZOOM3_EHCI_RESET_GPIO,
-		.vcc_gpio = -EINVAL,
-	},
-};
-
-static struct usbhs_omap_platform_data usbhs_bdata __initdata = {
-	.port_mode[1]		= OMAP_EHCI_PORT_MODE_PHY,
-};
-
-static void __init omap_zoom_init(void)
-{
-	if (machine_is_omap_zoom2()) {
-		omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
-	} else if (machine_is_omap_zoom3()) {
-		omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
-		omap_mux_init_gpio(ZOOM3_EHCI_RESET_GPIO, OMAP_PIN_OUTPUT);
-
-		usbhs_init_phys(phy_data, ARRAY_SIZE(phy_data));
-		usbhs_init(&usbhs_bdata);
-	}
-
-	board_nand_init(zoom_nand_partitions,
-			ARRAY_SIZE(zoom_nand_partitions), ZOOM_NAND_CS,
-			NAND_BUSWIDTH_16, nand_default_timings);
-	zoom_debugboard_init();
-	zoom_peripherals_init();
-
-	if (machine_is_omap_zoom2())
-		omap_sdrc_init(mt46h32m32lf6_sdrc_params,
-					  mt46h32m32lf6_sdrc_params);
-	else if (machine_is_omap_zoom3())
-		omap_sdrc_init(h8mbx00u0mer0em_sdrc_params,
-					  h8mbx00u0mer0em_sdrc_params);
-
-	zoom_display_init();
-}
-
-MACHINE_START(OMAP_ZOOM2, "OMAP Zoom2 board")
-	.atag_offset	= 0x100,
-	.reserve	= omap_reserve,
-	.map_io		= omap3_map_io,
-	.init_early	= omap3430_init_early,
-	.init_irq	= omap3_init_irq,
-	.handle_irq	= omap3_intc_handle_irq,
-	.init_machine	= omap_zoom_init,
-	.init_late	= omap3430_init_late,
-	.init_time	= omap3_sync32k_timer_init,
-	.restart	= omap3xxx_restart,
-MACHINE_END
-
-MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board")
-	.atag_offset	= 0x100,
-	.reserve	= omap_reserve,
-	.map_io		= omap3_map_io,
-	.init_early	= omap3630_init_early,
-	.init_irq	= omap3_init_irq,
-	.handle_irq	= omap3_intc_handle_irq,
-	.init_machine	= omap_zoom_init,
-	.init_late	= omap3630_init_late,
-	.init_time	= omap3_sync32k_timer_init,
-	.restart	= omap3xxx_restart,
-MACHINE_END
diff --git a/arch/arm/mach-omap2/board-zoom.h b/arch/arm/mach-omap2/board-zoom.h
deleted file mode 100644
index 2e94869..0000000
--- a/arch/arm/mach-omap2/board-zoom.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/*
- * Defines for zoom boards
- */
-#include <video/omapdss.h>
-
-#define ZOOM_NAND_CS    0
-
-extern int __init zoom_debugboard_init(void);
-extern void __init zoom_peripherals_init(void);
-extern void __init zoom_display_init(void);

