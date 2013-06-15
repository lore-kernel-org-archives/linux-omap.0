From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH 7/8] ARM: OMAP1: Remove legacy irda.h and irda setup from board files
Date: Sat, 15 Jun 2013 11:31:08 +0300
Message-ID: <1371285069-6834-8-git-send-email-jarkko.nikula@bitmer.com>
References: <1371285069-6834-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:33807 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753252Ab3FOIb7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 15 Jun 2013 04:31:59 -0400
In-Reply-To: <1371285069-6834-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>

omap-ir.c driver has never been upstream and was also removed from
linux-omap.git four years ago (See linux-omap.git commit efd1e3f
("REMOVE OMAP LEGACY CODE: Reset drivers/net/irda to mainline")).

Therefore remove needless device registration from a few board files
and delete thus to be unused arch/arm/mach-omap1/include/mach/irda.h
and unused OMAP_DMA_UART3_* definitions from dma.h.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 arch/arm/mach-omap1/board-h2.c          |   36 -------------------------------
 arch/arm/mach-omap1/board-palmte.c      |   31 --------------------------
 arch/arm/mach-omap1/board-palmtt.c      |   30 --------------------------
 arch/arm/mach-omap1/board-palmz71.c     |   31 --------------------------
 arch/arm/mach-omap1/board-sx1.c         |   36 -------------------------------
 arch/arm/mach-omap1/dma.h               |    2 --
 arch/arm/mach-omap1/include/mach/irda.h |   33 ----------------------------
 7 files changed, 199 deletions(-)
 delete mode 100644 arch/arm/mach-omap1/include/mach/irda.h

diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 0dac3d2..fd90caf 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -41,7 +41,6 @@
 #include <mach/mux.h>
 #include <linux/omap-dma.h>
 #include <mach/tc.h>
-#include <mach/irda.h>
 #include <linux/platform_data/keypad-omap.h>
 #include <mach/flash.h>
 
@@ -50,7 +49,6 @@
 
 #include "common.h"
 #include "board-h2.h"
-#include "dma.h"
 
 /* At OMAP1610 Innovator the Ethernet is directly connected to CS1 */
 #define OMAP1610_ETHR_START		0x04000300
@@ -276,39 +274,6 @@ static struct platform_device h2_kp_device = {
 	.resource	= h2_kp_resources,
 };
 
-#define H2_IRDA_FIRSEL_GPIO_PIN	17
-
-static struct omap_irda_config h2_irda_data = {
-	.transceiver_cap	= IR_SIRMODE | IR_MIRMODE | IR_FIRMODE,
-	.rx_channel		= OMAP_DMA_UART3_RX,
-	.tx_channel		= OMAP_DMA_UART3_TX,
-	.dest_start		= UART3_THR,
-	.src_start		= UART3_RHR,
-	.tx_trigger		= 0,
-	.rx_trigger		= 0,
-};
-
-static struct resource h2_irda_resources[] = {
-	[0] = {
-		.start	= INT_UART3,
-		.end	= INT_UART3,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static u64 irda_dmamask = 0xffffffff;
-
-static struct platform_device h2_irda_device = {
-	.name		= "omapirda",
-	.id		= 0,
-	.dev		= {
-		.platform_data	= &h2_irda_data,
-		.dma_mask	= &irda_dmamask,
-	},
-	.num_resources	= ARRAY_SIZE(h2_irda_resources),
-	.resource	= h2_irda_resources,
-};
-
 static struct gpio_led h2_gpio_led_pins[] = {
 	{
 		.name		= "h2:red",
@@ -339,7 +304,6 @@ static struct platform_device *h2_devices[] __initdata = {
 	&h2_nor_device,
 	&h2_nand_device,
 	&h2_smc91x_device,
-	&h2_irda_device,
 	&h2_kp_device,
 	&h2_gpio_leds,
 };
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 845a1a7..3b8e98f 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -38,14 +38,12 @@
 #include <mach/mux.h>
 #include <mach/tc.h>
 #include <linux/omap-dma.h>
-#include <mach/irda.h>
 #include <linux/platform_data/keypad-omap.h>
 
 #include <mach/hardware.h>
 #include <mach/usb.h>
 
 #include "common.h"
-#include "dma.h"
 
 #define PALMTE_USBDETECT_GPIO	0
 #define PALMTE_USB_OR_DC_GPIO	1
@@ -167,40 +165,11 @@ static struct platform_device palmte_backlight_device = {
 	},
 };
 
-static struct omap_irda_config palmte_irda_config = {
-	.transceiver_cap	= IR_SIRMODE,
-	.rx_channel		= OMAP_DMA_UART3_RX,
-	.tx_channel		= OMAP_DMA_UART3_TX,
-	.dest_start		= UART3_THR,
-	.src_start		= UART3_RHR,
-	.tx_trigger		= 0,
-	.rx_trigger		= 0,
-};
-
-static struct resource palmte_irda_resources[] = {
-	[0]	= {
-		.start	= INT_UART3,
-		.end	= INT_UART3,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device palmte_irda_device = {
-	.name		= "omapirda",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &palmte_irda_config,
-	},
-	.num_resources	= ARRAY_SIZE(palmte_irda_resources),
-	.resource	= palmte_irda_resources,
-};
-
 static struct platform_device *palmte_devices[] __initdata = {
 	&palmte_rom_device,
 	&palmte_kp_device,
 	&palmte_lcd_device,
 	&palmte_backlight_device,
-	&palmte_irda_device,
 };
 
 static struct omap_usb_config palmte_usb_config __initdata = {
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index 65a4a3e..ca50120 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -38,14 +38,12 @@
 #include <mach/mux.h>
 #include <linux/omap-dma.h>
 #include <mach/tc.h>
-#include <mach/irda.h>
 #include <linux/platform_data/keypad-omap.h>
 
 #include <mach/hardware.h>
 #include <mach/usb.h>
 
 #include "common.h"
-#include "dma.h"
 
 #define PALMTT_USBDETECT_GPIO	0
 #define PALMTT_CABLE_GPIO	1
@@ -163,33 +161,6 @@ static struct platform_device palmtt_lcd_device = {
 	.name		= "lcd_palmtt",
 	.id		= -1,
 };
-static struct omap_irda_config palmtt_irda_config = {
-	.transceiver_cap	= IR_SIRMODE,
-	.rx_channel		= OMAP_DMA_UART3_RX,
-	.tx_channel		= OMAP_DMA_UART3_TX,
-	.dest_start		= UART3_THR,
-	.src_start		= UART3_RHR,
-	.tx_trigger		= 0,
-	.rx_trigger		= 0,
-};
-
-static struct resource palmtt_irda_resources[] = {
-	[0]	= {
-		.start	= INT_UART3,
-		.end	= INT_UART3,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device palmtt_irda_device = {
-	.name		= "omapirda",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &palmtt_irda_config,
-	},
-	.num_resources	= ARRAY_SIZE(palmtt_irda_resources),
-	.resource	= palmtt_irda_resources,
-};
 
 static struct platform_device palmtt_spi_device = {
 	.name		= "spi_palmtt",
@@ -234,7 +205,6 @@ static struct platform_device *palmtt_devices[] __initdata = {
 	&palmtt_flash_device,
 	&palmtt_kp_device,
 	&palmtt_lcd_device,
-	&palmtt_irda_device,
 	&palmtt_spi_device,
 	&palmtt_backlight_device,
 	&palmtt_led_device,
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index 01c9700..470e12d 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -40,14 +40,12 @@
 #include <mach/mux.h>
 #include <linux/omap-dma.h>
 #include <mach/tc.h>
-#include <mach/irda.h>
 #include <linux/platform_data/keypad-omap.h>
 
 #include <mach/hardware.h>
 #include <mach/usb.h>
 
 #include "common.h"
-#include "dma.h"
 
 #define PALMZ71_USBDETECT_GPIO	0
 #define PALMZ71_PENIRQ_GPIO	6
@@ -153,34 +151,6 @@ static struct platform_device palmz71_lcd_device = {
 	.id	= -1,
 };
 
-static struct omap_irda_config palmz71_irda_config = {
-	.transceiver_cap	= IR_SIRMODE,
-	.rx_channel		= OMAP_DMA_UART3_RX,
-	.tx_channel		= OMAP_DMA_UART3_TX,
-	.dest_start		= UART3_THR,
-	.src_start		= UART3_RHR,
-	.tx_trigger		= 0,
-	.rx_trigger		= 0,
-};
-
-static struct resource palmz71_irda_resources[] = {
-	[0] = {
-		.start	= INT_UART3,
-		.end	= INT_UART3,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device palmz71_irda_device = {
-	.name	= "omapirda",
-	.id	= -1,
-	.dev = {
-		.platform_data = &palmz71_irda_config,
-	},
-	.num_resources	= ARRAY_SIZE(palmz71_irda_resources),
-	.resource	= palmz71_irda_resources,
-};
-
 static struct platform_device palmz71_spi_device = {
 	.name	= "spi_palmz71",
 	.id	= -1,
@@ -202,7 +172,6 @@ static struct platform_device *devices[] __initdata = {
 	&palmz71_rom_device,
 	&palmz71_kp_device,
 	&palmz71_lcd_device,
-	&palmz71_irda_device,
 	&palmz71_spi_device,
 	&palmz71_backlight_device,
 };
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 9732a98..0a8d334 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -37,7 +37,6 @@
 #include <mach/flash.h>
 #include <mach/mux.h>
 #include <linux/omap-dma.h>
-#include <mach/irda.h>
 #include <mach/tc.h>
 #include <mach/board-sx1.h>
 
@@ -45,7 +44,6 @@
 #include <mach/usb.h>
 
 #include "common.h"
-#include "dma.h"
 
 /* Write to I2C device */
 int sx1_i2c_write_byte(u8 devaddr, u8 regoffset, u8 value)
@@ -228,39 +226,6 @@ static struct platform_device sx1_kp_device = {
 	.resource	= sx1_kp_resources,
 };
 
-/*----------- IRDA -------------------------*/
-
-static struct omap_irda_config sx1_irda_data = {
-	.transceiver_cap	= IR_SIRMODE,
-	.rx_channel		= OMAP_DMA_UART3_RX,
-	.tx_channel		= OMAP_DMA_UART3_TX,
-	.dest_start		= UART3_THR,
-	.src_start		= UART3_RHR,
-	.tx_trigger		= 0,
-	.rx_trigger		= 0,
-};
-
-static struct resource sx1_irda_resources[] = {
-	[0] = {
-		.start	= INT_UART3,
-		.end	= INT_UART3,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static u64 irda_dmamask = 0xffffffff;
-
-static struct platform_device sx1_irda_device = {
-	.name		= "omapirda",
-	.id		= 0,
-	.dev		= {
-		.platform_data	= &sx1_irda_data,
-		.dma_mask	= &irda_dmamask,
-	},
-	.num_resources	= ARRAY_SIZE(sx1_irda_resources),
-	.resource	= sx1_irda_resources,
-};
-
 /*----------- MTD -------------------------*/
 
 static struct mtd_partition sx1_partitions[] = {
@@ -366,7 +331,6 @@ static struct omap_lcd_config sx1_lcd_config __initdata = {
 static struct platform_device *sx1_devices[] __initdata = {
 	&sx1_flash_device,
 	&sx1_kp_device,
-	&sx1_irda_device,
 };
 
 /*-----------------------------------------*/
diff --git a/arch/arm/mach-omap1/dma.h b/arch/arm/mach-omap1/dma.h
index dc33cd9..6c751e8 100644
--- a/arch/arm/mach-omap1/dma.h
+++ b/arch/arm/mach-omap1/dma.h
@@ -20,8 +20,6 @@
 #define __OMAP1_DMA_CHANNEL_H
 
 /* DMA channels for omap1 */
-#define OMAP_DMA_UART3_TX		18
-#define OMAP_DMA_UART3_RX		19
 
 /* These are only for 1610 */
 
diff --git a/arch/arm/mach-omap1/include/mach/irda.h b/arch/arm/mach-omap1/include/mach/irda.h
deleted file mode 100644
index 40f6033..0000000
--- a/arch/arm/mach-omap1/include/mach/irda.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- *  arch/arm/plat-omap/include/mach/irda.h
- *
- *  Copyright (C) 2005-2006 Komal Shah <komal_shah802003@yahoo.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#ifndef ASMARM_ARCH_IRDA_H
-#define ASMARM_ARCH_IRDA_H
-
-/* board specific transceiver capabilities */
-
-#define IR_SEL		1	/* Selects IrDA */
-#define IR_SIRMODE	2
-#define IR_FIRMODE	4
-#define IR_MIRMODE	8
-
-struct omap_irda_config {
-	int transceiver_cap;
-	int (*transceiver_mode)(struct device *dev, int mode);
-	int (*select_irda)(struct device *dev, int state);
-	int rx_channel;
-	int tx_channel;
-	unsigned long dest_start;
-	unsigned long src_start;
-	int tx_trigger;
-	int rx_trigger;
-	int mode;
-};
-
-#endif
-- 
1.7.10.4

