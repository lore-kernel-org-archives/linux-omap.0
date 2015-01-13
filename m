From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/4] ARM: OMAP3: Remove cm-t3517 legacy support
Date: Tue, 13 Jan 2015 09:57:44 -0800
Message-ID: <1421171865-5209-4-git-send-email-tony@atomide.com>
References: <1421171865-5209-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:51384 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751202AbbAMSCD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2015 13:02:03 -0500
In-Reply-To: <1421171865-5209-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Dmitry Lifshitz <lifshitz@compulab.co.il>, Igor Grinberg <grinberg@compulab.co.il>

This board is working with device tree based booting so there should
not be any need to keep the legacy booting support around. People
using this board can boot it with appended DTB with existing bootloader.

By removing the 3517 legacy booting support we can get a bit closer to
making all of omap3 boot in device tree only mode.

Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig          |   6 -
 arch/arm/mach-omap2/Makefile         |   1 -
 arch/arm/mach-omap2/board-cm-t3517.c | 335 -----------------------------------
 3 files changed, 342 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/board-cm-t3517.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index ba3a7a1..209456e 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -252,12 +252,6 @@ config MACH_CM_T35
 	select MACH_CM_T3730
 	select OMAP_PACKAGE_CUS
 
-config MACH_CM_T3517
-	bool "CompuLab CM-T3517 module"
-	depends on ARCH_OMAP3
-	default y
-	select OMAP_PACKAGE_CBB
-
 config MACH_CM_T3730
        bool
 
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 39b1ee1..29da3f4 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -250,7 +250,6 @@ obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o sdram-nokia.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51-peripherals.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51-video.o
 obj-$(CONFIG_MACH_CM_T35)		+= board-cm-t35.o
-obj-$(CONFIG_MACH_CM_T3517)		+= board-cm-t3517.o
 obj-$(CONFIG_MACH_TOUCHBOOK)		+= board-omap3touchbook.o
 
 obj-$(CONFIG_MACH_SBC3530)		+= board-omap3stalker.o
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
deleted file mode 100644
index 794756d..0000000
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ /dev/null
@@ -1,335 +0,0 @@
-/*
- * linux/arch/arm/mach-omap2/board-cm-t3517.c
- *
- * Support for the CompuLab CM-T3517 modules
- *
- * Copyright (C) 2010 CompuLab, Ltd.
- * Author: Igor Grinberg <grinberg@compulab.co.il>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/delay.h>
-#include <linux/gpio.h>
-#include <linux/leds.h>
-#include <linux/omap-gpmc.h>
-#include <linux/rtc-v3020.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
-#include <linux/mtd/partitions.h>
-#include <linux/mmc/host.h>
-#include <linux/can/platform/ti_hecc.h>
-
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-
-#include "common.h"
-#include <linux/platform_data/mtd-nand-omap2.h>
-
-#include "am35xx.h"
-
-#include "mux.h"
-#include "control.h"
-#include "hsmmc.h"
-#include "common-board-devices.h"
-#include "am35xx-emac.h"
-
-#if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
-static struct gpio_led cm_t3517_leds[] = {
-	[0] = {
-		.gpio			= 186,
-		.name			= "cm-t3517:green",
-		.default_trigger	= "heartbeat",
-		.active_low		= 0,
-	},
-};
-
-static struct gpio_led_platform_data cm_t3517_led_pdata = {
-	.num_leds	= ARRAY_SIZE(cm_t3517_leds),
-	.leds		= cm_t3517_leds,
-};
-
-static struct platform_device cm_t3517_led_device = {
-	.name		= "leds-gpio",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &cm_t3517_led_pdata,
-	},
-};
-
-static void __init cm_t3517_init_leds(void)
-{
-	platform_device_register(&cm_t3517_led_device);
-}
-#else
-static inline void cm_t3517_init_leds(void) {}
-#endif
-
-#if defined(CONFIG_CAN_TI_HECC) || defined(CONFIG_CAN_TI_HECC_MODULE)
-static struct resource cm_t3517_hecc_resources[] = {
-	{
-		.start	= AM35XX_IPSS_HECC_BASE,
-		.end	= AM35XX_IPSS_HECC_BASE + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= 24 + OMAP_INTC_START,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct ti_hecc_platform_data cm_t3517_hecc_pdata = {
-	.scc_hecc_offset	= AM35XX_HECC_SCC_HECC_OFFSET,
-	.scc_ram_offset		= AM35XX_HECC_SCC_RAM_OFFSET,
-	.hecc_ram_offset	= AM35XX_HECC_RAM_OFFSET,
-	.mbx_offset		= AM35XX_HECC_MBOX_OFFSET,
-	.int_line		= AM35XX_HECC_INT_LINE,
-	.version		= AM35XX_HECC_VERSION,
-};
-
-static struct platform_device cm_t3517_hecc_device = {
-	.name		= "ti_hecc",
-	.id		= 1,
-	.num_resources	= ARRAY_SIZE(cm_t3517_hecc_resources),
-	.resource	= cm_t3517_hecc_resources,
-	.dev		= {
-		.platform_data	= &cm_t3517_hecc_pdata,
-	},
-};
-
-static void cm_t3517_init_hecc(void)
-{
-	platform_device_register(&cm_t3517_hecc_device);
-}
-#else
-static inline void cm_t3517_init_hecc(void) {}
-#endif
-
-#if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
-static struct omap2_hsmmc_info cm_t3517_mmc[] = {
-	{
-		.mmc		= 1,
-		.caps		= MMC_CAP_4_BIT_DATA,
-		.gpio_cd	= 144,
-		.gpio_wp	= 59,
-	},
-	{
-		.mmc		= 2,
-		.caps		= MMC_CAP_4_BIT_DATA,
-		.gpio_cd	= -EINVAL,
-		.gpio_wp	= -EINVAL,
-	},
-	{}	/* Terminator */
-};
-#else
-#define cm_t3517_mmc NULL
-#endif
-
-#if defined(CONFIG_RTC_DRV_V3020) || defined(CONFIG_RTC_DRV_V3020_MODULE)
-#define RTC_IO_GPIO		(153)
-#define RTC_WR_GPIO		(154)
-#define RTC_RD_GPIO		(53)
-#define RTC_CS_GPIO		(163)
-#define RTC_CS_EN_GPIO		(160)
-
-struct v3020_platform_data cm_t3517_v3020_pdata = {
-	.use_gpio	= 1,
-	.gpio_cs	= RTC_CS_GPIO,
-	.gpio_wr	= RTC_WR_GPIO,
-	.gpio_rd	= RTC_RD_GPIO,
-	.gpio_io	= RTC_IO_GPIO,
-};
-
-static struct platform_device cm_t3517_rtc_device = {
-	.name		= "v3020",
-	.id		= -1,
-	.dev		= {
-		.platform_data = &cm_t3517_v3020_pdata,
-	}
-};
-
-static void __init cm_t3517_init_rtc(void)
-{
-	int err;
-
-	err = gpio_request_one(RTC_CS_EN_GPIO, GPIOF_OUT_INIT_HIGH,
-			       "rtc cs en");
-	if (err) {
-		pr_err("CM-T3517: rtc cs en gpio request failed: %d\n", err);
-		return;
-	}
-
-	platform_device_register(&cm_t3517_rtc_device);
-}
-#else
-static inline void cm_t3517_init_rtc(void) {}
-#endif
-
-#if defined(CONFIG_USB_EHCI_HCD) || defined(CONFIG_USB_EHCI_HCD_MODULE)
-#define HSUSB1_RESET_GPIO	(146)
-#define HSUSB2_RESET_GPIO	(147)
-#define USB_HUB_RESET_GPIO	(152)
-
-static struct usbhs_phy_data phy_data[] __initdata = {
-	{
-		.port = 1,
-		.reset_gpio = HSUSB1_RESET_GPIO,
-		.vcc_gpio = -EINVAL,
-	},
-	{
-		.port = 2,
-		.reset_gpio = HSUSB2_RESET_GPIO,
-		.vcc_gpio = -EINVAL,
-	},
-};
-
-static struct usbhs_omap_platform_data cm_t3517_ehci_pdata __initdata = {
-	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
-	.port_mode[1] = OMAP_EHCI_PORT_MODE_PHY,
-};
-
-static int __init cm_t3517_init_usbh(void)
-{
-	int err;
-
-	err = gpio_request_one(USB_HUB_RESET_GPIO, GPIOF_OUT_INIT_LOW,
-			       "usb hub rst");
-	if (err) {
-		pr_err("CM-T3517: usb hub rst gpio request failed: %d\n", err);
-	} else {
-		udelay(10);
-		gpio_set_value(USB_HUB_RESET_GPIO, 1);
-		msleep(1);
-	}
-
-	usbhs_init_phys(phy_data, ARRAY_SIZE(phy_data));
-	usbhs_init(&cm_t3517_ehci_pdata);
-
-	return 0;
-}
-#else
-static inline int cm_t3517_init_usbh(void)
-{
-	return 0;
-}
-#endif
-
-#if defined(CONFIG_MTD_NAND_OMAP2) || defined(CONFIG_MTD_NAND_OMAP2_MODULE)
-static struct mtd_partition cm_t3517_nand_partitions[] = {
-	{
-		.name           = "xloader",
-		.offset         = 0,			/* Offset = 0x00000 */
-		.size           = 4 * NAND_BLOCK_SIZE,
-		.mask_flags     = MTD_WRITEABLE
-	},
-	{
-		.name           = "uboot",
-		.offset         = MTDPART_OFS_APPEND,	/* Offset = 0x80000 */
-		.size           = 15 * NAND_BLOCK_SIZE,
-	},
-	{
-		.name           = "uboot environment",
-		.offset         = MTDPART_OFS_APPEND,	/* Offset = 0x260000 */
-		.size           = 2 * NAND_BLOCK_SIZE,
-	},
-	{
-		.name           = "linux",
-		.offset         = MTDPART_OFS_APPEND,	/* Offset = 0x2A0000 */
-		.size           = 32 * NAND_BLOCK_SIZE,
-	},
-	{
-		.name           = "rootfs",
-		.offset         = MTDPART_OFS_APPEND,	/* Offset = 0x6A0000 */
-		.size           = MTDPART_SIZ_FULL,
-	},
-};
-
-static struct omap_nand_platform_data cm_t3517_nand_data = {
-	.parts			= cm_t3517_nand_partitions,
-	.nr_parts		= ARRAY_SIZE(cm_t3517_nand_partitions),
-	.cs			= 0,
-};
-
-static void __init cm_t3517_init_nand(void)
-{
-	if (gpmc_nand_init(&cm_t3517_nand_data, NULL) < 0)
-		pr_err("CM-T3517: NAND initialization failed\n");
-}
-#else
-static inline void cm_t3517_init_nand(void) {}
-#endif
-
-#ifdef CONFIG_OMAP_MUX
-static struct omap_board_mux board_mux[] __initdata = {
-	/* GPIO186 - Green LED */
-	OMAP3_MUX(SYS_CLKOUT2, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
-
-	/* RTC GPIOs: */
-	/* IO - GPIO153 */
-	OMAP3_MUX(MCBSP4_DR, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
-	/* WR# - GPIO154 */
-	OMAP3_MUX(MCBSP4_DX, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
-	/* RD# - GPIO53 */
-	OMAP3_MUX(GPMC_NCS2, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
-	/* CS# - GPIO163 */
-	OMAP3_MUX(UART3_CTS_RCTX, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
-	/* CS EN - GPIO160 */
-	OMAP3_MUX(MCBSP_CLKS, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
-
-	/* HSUSB1 RESET */
-	OMAP3_MUX(UART2_TX, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
-	/* HSUSB2 RESET */
-	OMAP3_MUX(UART2_RX, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
-	/* CM-T3517 USB HUB nRESET */
-	OMAP3_MUX(MCBSP4_CLKX, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
-
-	/* CD - GPIO144 and WP - GPIO59 for MMC1 - SB-T35 */
-	OMAP3_MUX(UART2_CTS, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP),
-	OMAP3_MUX(GPMC_CLK, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP),
-
-	{ .reg_offset = OMAP_MUX_TERMINATOR },
-};
-#endif
-
-static void __init cm_t3517_init(void)
-{
-	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
-	omap_serial_init();
-	omap_sdrc_init(NULL, NULL);
-	cm_t3517_init_leds();
-	cm_t3517_init_nand();
-	cm_t3517_init_rtc();
-	cm_t3517_init_usbh();
-	cm_t3517_init_hecc();
-	am35xx_emac_init(AM35XX_DEFAULT_MDIO_FREQUENCY, 1);
-	omap_hsmmc_init(cm_t3517_mmc);
-}
-
-MACHINE_START(CM_T3517, "Compulab CM-T3517")
-	.atag_offset	= 0x100,
-	.reserve        = omap_reserve,
-	.map_io		= omap3_map_io,
-	.init_early	= am35xx_init_early,
-	.init_irq	= omap3_init_irq,
-	.init_machine	= cm_t3517_init,
-	.init_late	= am35xx_init_late,
-	.init_time	= omap3_gptimer_timer_init,
-	.restart	= omap3xxx_restart,
-MACHINE_END
-- 
2.1.4

