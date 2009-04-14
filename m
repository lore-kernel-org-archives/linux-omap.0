From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/11] ARM: OMAP: Remove old dead gpio expander code
Date: Tue, 14 Apr 2009 14:50:28 -0700
Message-ID: <20090414215028.9878.37223.stgit@localhost>
References: <20090414214638.9878.17987.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57061 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801AbZDNVua (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Apr 2009 17:50:30 -0400
In-Reply-To: <20090414214638.9878.17987.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

This should be done with GPIO calls. Patches against the
mainline tree welcome to add the necessary working functionality
back.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-h3.c                 |  101 ------------------------
 arch/arm/mach-omap2/board-h4.c                 |   95 -----------------------
 arch/arm/plat-omap/include/mach/gpioexpander.h |   35 --------
 arch/arm/plat-omap/include/mach/irda.h         |    4 -
 4 files changed, 0 insertions(+), 235 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/mach/gpioexpander.h

diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index 4695965..f597968 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -39,12 +39,10 @@
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
 
-#include <mach/gpioexpander.h>
 #include <mach/irqs.h>
 #include <mach/mux.h>
 #include <mach/tc.h>
 #include <mach/nand.h>
-#include <mach/irda.h>
 #include <mach/usb.h>
 #include <mach/keypad.h>
 #include <mach/dma.h>
@@ -276,104 +274,6 @@ static struct platform_device h3_kp_device = {
 	.resource	= h3_kp_resources,
 };
 
-
-/* Select between the IrDA and aGPS module
- */
-static int h3_select_irda(struct device *dev, int state)
-{
-	unsigned char expa;
-	int err = 0;
-
-	if ((err = read_gpio_expa(&expa, 0x26))) {
-		printk(KERN_ERR "Error reading from I/O EXPANDER \n");
-		return err;
-	}
-
-	/* 'P6' enable/disable IRDA_TX and IRDA_RX */
-	if (state & IR_SEL) { /* IrDA */
-		if ((err = write_gpio_expa(expa | 0x40, 0x26))) {
-			printk(KERN_ERR "Error writing to I/O EXPANDER \n");
-			return err;
-		}
-	} else {
-		if ((err = write_gpio_expa(expa & ~0x40, 0x26))) {
-			printk(KERN_ERR "Error writing to I/O EXPANDER \n");
-			return err;
-		}
-	}
-	return err;
-}
-
-static void set_trans_mode(struct work_struct *work)
-{
-	struct omap_irda_config *irda_config =
-		container_of(work, struct omap_irda_config, gpio_expa.work);
-	int mode = irda_config->mode;
-	unsigned char expa;
-	int err = 0;
-
-	if ((err = read_gpio_expa(&expa, 0x27)) != 0) {
-		printk(KERN_ERR "Error reading from I/O expander\n");
-	}
-
-	expa &= ~0x03;
-
-	if (mode & IR_SIRMODE) {
-		expa |= 0x01;
-	} else { /* MIR/FIR */
-		expa |= 0x03;
-	}
-
-	if ((err = write_gpio_expa(expa, 0x27)) != 0) {
-		printk(KERN_ERR "Error writing to I/O expander\n");
-	}
-}
-
-static int h3_transceiver_mode(struct device *dev, int mode)
-{
-	struct omap_irda_config *irda_config = dev->platform_data;
-
-	irda_config->mode = mode;
-	cancel_delayed_work(&irda_config->gpio_expa);
-	PREPARE_DELAYED_WORK(&irda_config->gpio_expa, set_trans_mode);
-	schedule_delayed_work(&irda_config->gpio_expa, 0);
-
-	return 0;
-}
-
-static struct omap_irda_config h3_irda_data = {
-	.transceiver_cap	= IR_SIRMODE | IR_MIRMODE | IR_FIRMODE,
-	.transceiver_mode	= h3_transceiver_mode,
-	.select_irda	 	= h3_select_irda,
-	.rx_channel		= OMAP_DMA_UART3_RX,
-	.tx_channel		= OMAP_DMA_UART3_TX,
-	.dest_start		= UART3_THR,
-	.src_start		= UART3_RHR,
-	.tx_trigger		= 0,
-	.rx_trigger		= 0,
-};
-
-static struct resource h3_irda_resources[] = {
-	[0] = {
-		.start	= INT_UART3,
-		.end	= INT_UART3,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static u64 irda_dmamask = 0xffffffff;
-
-static struct platform_device h3_irda_device = {
-	.name		= "omapirda",
-	.id		= 0,
-	.dev		= {
-		.platform_data	= &h3_irda_data,
-		.dma_mask	= &irda_dmamask,
-	},
-	.num_resources	= ARRAY_SIZE(h3_irda_resources),
-	.resource	= h3_irda_resources,
-};
-
 static struct platform_device h3_lcd_device = {
 	.name		= "lcd_h3",
 	.id		= -1,
@@ -395,7 +295,6 @@ static struct platform_device *devices[] __initdata = {
 	&nand_device,
         &smc91x_device,
 	&intlat_device,
-	&h3_irda_device,
 	&h3_kp_device,
 	&h3_lcd_device,
 };
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index a0267a9..e7d017c 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -33,10 +33,8 @@
 
 #include <mach/control.h>
 #include <mach/gpio.h>
-#include <mach/gpioexpander.h>
 #include <mach/mux.h>
 #include <mach/usb.h>
-#include <mach/irda.h>
 #include <mach/board.h>
 #include <mach/common.h>
 #include <mach/keypad.h>
@@ -138,98 +136,6 @@ static struct platform_device h4_flash_device = {
 	.resource	= &h4_flash_resource,
 };
 
-/* Select between the IrDA and aGPS module
- */
-static int h4_select_irda(struct device *dev, int state)
-{
-	unsigned char expa;
-	int err = 0;
-
-	if ((err = read_gpio_expa(&expa, 0x21))) {
-		printk(KERN_ERR "Error reading from I/O expander\n");
-		return err;
-	}
-
-	/* 'P6' enable/disable IRDA_TX and IRDA_RX */
-	if (state & IR_SEL) {	/* IrDa */
-		if ((err = write_gpio_expa(expa | 0x01, 0x21))) {
-			printk(KERN_ERR "Error writing to I/O expander\n");
-			return err;
-		}
-	} else {
-		if ((err = write_gpio_expa(expa & ~0x01, 0x21))) {
-			printk(KERN_ERR "Error writing to I/O expander\n");
-			return err;
-		}
-	}
-	return err;
-}
-
-static void set_trans_mode(struct work_struct *work)
-{
-	struct omap_irda_config *irda_config =
-		container_of(work, struct omap_irda_config, gpio_expa.work);
-	int mode = irda_config->mode;
-	unsigned char expa;
-	int err = 0;
-
-	if ((err = read_gpio_expa(&expa, 0x20)) != 0) {
-		printk(KERN_ERR "Error reading from I/O expander\n");
-	}
-
-	expa &= ~0x01;
-
-	if (!(mode & IR_SIRMODE)) { /* MIR/FIR */
-		expa |= 0x01;
-	}
-
-	if ((err = write_gpio_expa(expa, 0x20)) != 0) {
-		printk(KERN_ERR "Error writing to I/O expander\n");
-	}
-}
-
-static int h4_transceiver_mode(struct device *dev, int mode)
-{
-	struct omap_irda_config *irda_config = dev->platform_data;
-
-	irda_config->mode = mode;
-	cancel_delayed_work(&irda_config->gpio_expa);
-	PREPARE_DELAYED_WORK(&irda_config->gpio_expa, set_trans_mode);
-	schedule_delayed_work(&irda_config->gpio_expa, 0);
-
-	return 0;
-}
-
-static struct omap_irda_config h4_irda_data = {
-	.transceiver_cap	= IR_SIRMODE | IR_MIRMODE | IR_FIRMODE,
-	.transceiver_mode	= h4_transceiver_mode,
-	.select_irda	 	= h4_select_irda,
-	.rx_channel		= OMAP24XX_DMA_UART3_RX,
-	.tx_channel		= OMAP24XX_DMA_UART3_TX,
-	.dest_start		= OMAP_UART3_BASE,
-	.src_start		= OMAP_UART3_BASE,
-	.tx_trigger		= OMAP24XX_DMA_UART3_TX,
-	.rx_trigger		= OMAP24XX_DMA_UART3_RX,
-};
-
-static struct resource h4_irda_resources[] = {
-	[0] = {
-		.start	= INT_24XX_UART3_IRQ,
-		.end	= INT_24XX_UART3_IRQ,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device h4_irda_device = {
-	.name		= "omapirda",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &h4_irda_data,
-	},
-	.num_resources	= 1,
-	.resource	= h4_irda_resources,
-};
-
 static struct omap_kp_platform_data h4_kp_data = {
 	.rows		= 6,
 	.cols		= 7,
@@ -255,7 +161,6 @@ static struct platform_device h4_lcd_device = {
 
 static struct platform_device *h4_devices[] __initdata = {
 	&h4_flash_device,
-	&h4_irda_device,
 	&h4_kp_device,
 	&h4_lcd_device,
 };
diff --git a/arch/arm/plat-omap/include/mach/gpioexpander.h b/arch/arm/plat-omap/include/mach/gpioexpander.h
deleted file mode 100644
index 90444a0..0000000
--- a/arch/arm/plat-omap/include/mach/gpioexpander.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * arch/arm/plat-omap/include/mach/gpioexpander.h
- *
- *
- * Copyright (C) 2004 Texas Instruments, Inc.
- *
- * This package is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
- * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
- * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
- */
-
-#ifndef __ASM_ARCH_OMAP_GPIOEXPANDER_H
-#define __ASM_ARCH_OMAP_GPIOEXPANDER_H
-
-/* Function Prototypes for GPIO Expander functions */
-
-#ifdef CONFIG_GPIOEXPANDER_OMAP
-int read_gpio_expa(u8 *, int);
-int write_gpio_expa(u8 , int);
-#else
-static inline int read_gpio_expa(u8 *val, int addr)
-{
-	return 0;
-}
-static inline int write_gpio_expa(u8 val, int addr)
-{
-	return 0;
-}
-#endif
-
-#endif /* __ASM_ARCH_OMAP_GPIOEXPANDER_H */
diff --git a/arch/arm/plat-omap/include/mach/irda.h b/arch/arm/plat-omap/include/mach/irda.h
index 8372a00..40f6033 100644
--- a/arch/arm/plat-omap/include/mach/irda.h
+++ b/arch/arm/plat-omap/include/mach/irda.h
@@ -21,10 +21,6 @@ struct omap_irda_config {
 	int transceiver_cap;
 	int (*transceiver_mode)(struct device *dev, int mode);
 	int (*select_irda)(struct device *dev, int state);
-	/* Very specific to the needs of some platforms (h3,h4)
-	 * having calls which can sleep in irda_set_speed.
-	 */
-	struct delayed_work gpio_expa;
 	int rx_channel;
 	int tx_channel;
 	unsigned long dest_start;

