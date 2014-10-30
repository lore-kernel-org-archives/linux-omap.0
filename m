From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 08/10] ARM: OMAP2+: Drop legacy code for gpmc-smc91x.c
Date: Wed, 29 Oct 2014 17:29:06 -0700
Message-ID: <1414628948-30702-9-git-send-email-tony@atomide.com>
References: <1414628948-30702-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:52298 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758056AbaJ3Aag (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2014 20:30:36 -0400
In-Reply-To: <1414628948-30702-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>

This code was only used by 2430sdp, 3430sdp, and n900 development
boards.

The 2430sdp is already device tree only, and all the users of the
3430sdp and n900 development boards are already booting in device
tree mode, so we can drop the legacy smc91x support.

Cc: Roger Quadros <rogerq@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile                 |   3 -
 arch/arm/mach-omap2/board-3430sdp.c          |  28 ----
 arch/arm/mach-omap2/board-rx51-peripherals.c |  29 -----
 arch/arm/mach-omap2/gpmc-smc91x.c            | 186 ---------------------------
 arch/arm/mach-omap2/gpmc-smc91x.h            |  42 ------
 5 files changed, 288 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/gpmc-smc91x.c
 delete mode 100644 arch/arm/mach-omap2/gpmc-smc91x.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index d9e9412..3e824f8 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -284,9 +284,6 @@ obj-y					+= $(onenand-m) $(onenand-y)
 nand-$(CONFIG_MTD_NAND_OMAP2)		:= gpmc-nand.o
 obj-y					+= $(nand-m) $(nand-y)
 
-smc91x-$(CONFIG_SMC91X)			:= gpmc-smc91x.o
-obj-y					+= $(smc91x-m) $(smc91x-y)
-
 smsc911x-$(CONFIG_SMSC911X)		:= gpmc-smsc911x.o
 obj-y					+= $(smsc911x-m) $(smsc911x-y)
 ifneq ($(CONFIG_HWSPINLOCK_OMAP),)
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index d21a304..9857882 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -38,7 +38,6 @@
 #include <video/omap-panel-data.h>
 
 #include "gpmc.h"
-#include "gpmc-smc91x.h"
 
 #include "soc.h"
 #include "board-flash.h"
@@ -407,32 +406,6 @@ static int __init omap3430_i2c_init(void)
 	return 0;
 }
 
-#if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91X_MODULE)
-
-static struct omap_smc91x_platform_data board_smc91x_data = {
-	.cs		= 3,
-	.flags		= GPMC_MUX_ADD_DATA | GPMC_TIMINGS_SMC91C96 |
-				IORESOURCE_IRQ_LOWLEVEL,
-};
-
-static void __init board_smc91x_init(void)
-{
-	if (omap_rev() > OMAP3430_REV_ES1_0)
-		board_smc91x_data.gpio_irq = 6;
-	else
-		board_smc91x_data.gpio_irq = 29;
-
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
 static void enable_board_wakeup_source(void)
 {
 	/* T2 interrupt line (keypad) */
@@ -609,7 +582,6 @@ static void __init omap_3430sdp_init(void)
 	omap_sdrc_init(hyb18m512160af6_sdrc_params, NULL);
 	usb_bind_phy("musb-hdrc.0.auto", 0, "twl4030_usb");
 	usb_musb_init(NULL);
-	board_smc91x_init();
 	board_flash_init(sdp_flash_partitions, chip_sel_3430, 0);
 	sdp3430_display_init();
 	enable_board_wakeup_source();
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index ddfc8df..30e7d4c 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -32,7 +32,6 @@
 
 #include "common.h"
 #include <linux/omap-dma.h>
-#include "gpmc-smc91x.h"
 
 #include "board-rx51.h"
 
@@ -1146,33 +1145,6 @@ static struct omap_onenand_platform_data board_onenand_data[] = {
 };
 #endif
 
-#if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91X_MODULE)
-
-static struct omap_smc91x_platform_data board_smc91x_data = {
-	.cs		= 1,
-	.gpio_irq	= 54,
-	.gpio_pwrdwn	= 86,
-	.gpio_reset	= 164,
-	.flags		= GPMC_TIMINGS_SMC91C96 | IORESOURCE_IRQ_HIGHLEVEL,
-};
-
-static void __init board_smc91x_init(void)
-{
-	omap_mux_init_gpio(54, OMAP_PIN_INPUT_PULLDOWN);
-	omap_mux_init_gpio(86, OMAP_PIN_OUTPUT);
-	omap_mux_init_gpio(164, OMAP_PIN_OUTPUT);
-
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
 static struct gpio rx51_wl1251_gpios[] __initdata = {
 	{ RX51_WL1251_IRQ_GPIO,	  GPIOF_IN,		"wl1251 irq"	},
 };
@@ -1303,7 +1275,6 @@ void __init rx51_peripherals_init(void)
 	rx51_i2c_init();
 	regulator_has_full_constraints();
 	gpmc_onenand_init(board_onenand_data);
-	board_smc91x_init();
 	rx51_add_gpio_keys();
 	rx51_init_wl1251();
 	rx51_init_tsc2005();
diff --git a/arch/arm/mach-omap2/gpmc-smc91x.c b/arch/arm/mach-omap2/gpmc-smc91x.c
deleted file mode 100644
index 61a0635..0000000
--- a/arch/arm/mach-omap2/gpmc-smc91x.c
+++ /dev/null
@@ -1,186 +0,0 @@
-/*
- * linux/arch/arm/mach-omap2/gpmc-smc91x.c
- *
- * Copyright (C) 2009 Nokia Corporation
- * Contact:	Tony Lindgren
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/gpio.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
-#include <linux/smc91x.h>
-
-#include "gpmc.h"
-#include "gpmc-smc91x.h"
-
-#include "soc.h"
-
-static struct omap_smc91x_platform_data *gpmc_cfg;
-
-static struct resource gpmc_smc91x_resources[] = {
-	[0] = {
-		.flags		= IORESOURCE_MEM,
-	},
-	[1] = {
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-
-static struct smc91x_platdata gpmc_smc91x_info = {
-	.flags	= SMC91X_USE_16BIT | SMC91X_NOWAIT | SMC91X_IO_SHIFT_0,
-	.leda	= RPC_LED_100_10,
-	.ledb	= RPC_LED_TX_RX,
-};
-
-static struct platform_device gpmc_smc91x_device = {
-	.name		= "smc91x",
-	.id		= -1,
-	.dev		= {
-		.platform_data = &gpmc_smc91x_info,
-	},
-	.num_resources	= ARRAY_SIZE(gpmc_smc91x_resources),
-	.resource	= gpmc_smc91x_resources,
-};
-
-static struct gpmc_settings smc91x_settings = {
-	.device_width = GPMC_DEVWIDTH_16BIT,
-};
-
-/*
- * Set the gpmc timings for smc91c96. The timings are taken
- * from the data sheet available at:
- * http://www.smsc.com/main/catalog/lan91c96.html
- * REVISIT: Level shifters can add at least to the access latency.
- */
-static int smc91c96_gpmc_retime(void)
-{
-	struct gpmc_timings t;
-	struct gpmc_device_timings dev_t;
-	const int t3 = 10;	/* Figure 12.2 read and 12.4 write */
-	const int t4_r = 20;	/* Figure 12.2 read */
-	const int t4_w = 5;	/* Figure 12.4 write */
-	const int t5 = 25;	/* Figure 12.2 read */
-	const int t6 = 15;	/* Figure 12.2 read */
-	const int t7 = 5;	/* Figure 12.4 write */
-	const int t8 = 5;	/* Figure 12.4 write */
-	const int t20 = 185;	/* Figure 12.2 read and 12.4 write */
-
-	/*
-	 * FIXME: Calculate the address and data bus muxed timings.
-	 * Note that at least adv_rd_off needs to be changed according
-	 * to omap3430 TRM Figure 11-11. Are the sdp boards using the
-	 * FPGA in between smc91x and omap as the timings are different
-	 * from above?
-	 */
-	if (gpmc_cfg->flags & GPMC_MUX_ADD_DATA)
-		return 0;
-
-	memset(&dev_t, 0, sizeof(dev_t));
-
-	dev_t.t_oeasu = t3 * 1000;
-	dev_t.t_oe = t5 * 1000;
-	dev_t.t_cez_r = t4_r * 1000;
-	dev_t.t_oez = t6 * 1000;
-	dev_t.t_rd_cycle = (t20 - t3) * 1000;
-
-	dev_t.t_weasu = t3 * 1000;
-	dev_t.t_wpl = t7 * 1000;
-	dev_t.t_wph = t8 * 1000;
-	dev_t.t_cez_w = t4_w * 1000;
-	dev_t.t_wr_cycle = (t20 - t3) * 1000;
-
-	gpmc_calc_timings(&t, &smc91x_settings, &dev_t);
-
-	return gpmc_cs_set_timings(gpmc_cfg->cs, &t);
-}
-
-/*
- * Initialize smc91x device connected to the GPMC. Note that we
- * assume that pin multiplexing is done in the board-*.c file,
- * or in the bootloader.
- */
-void __init gpmc_smc91x_init(struct omap_smc91x_platform_data *board_data)
-{
-	unsigned long cs_mem_base;
-	int ret;
-
-	gpmc_cfg = board_data;
-
-	if (gpmc_cfg->flags & GPMC_TIMINGS_SMC91C96)
-		gpmc_cfg->retime = smc91c96_gpmc_retime;
-
-	if (gpmc_cs_request(gpmc_cfg->cs, SZ_16M, &cs_mem_base) < 0) {
-		printk(KERN_ERR "Failed to request GPMC mem for smc91x\n");
-		return;
-	}
-
-	gpmc_smc91x_resources[0].start = cs_mem_base + 0x300;
-	gpmc_smc91x_resources[0].end = cs_mem_base + 0x30f;
-	gpmc_smc91x_resources[1].flags |= (gpmc_cfg->flags & IRQF_TRIGGER_MASK);
-
-	if (gpmc_cfg->flags & GPMC_MUX_ADD_DATA)
-		smc91x_settings.mux_add_data = GPMC_MUX_AD;
-	if (gpmc_cfg->flags & GPMC_READ_MON)
-		smc91x_settings.wait_on_read = true;
-	if (gpmc_cfg->flags & GPMC_WRITE_MON)
-		smc91x_settings.wait_on_write = true;
-	if (gpmc_cfg->wait_pin)
-		smc91x_settings.wait_pin = gpmc_cfg->wait_pin;
-	ret = gpmc_cs_program_settings(gpmc_cfg->cs, &smc91x_settings);
-	if (ret < 0)
-		goto free1;
-
-	if (gpmc_cfg->retime) {
-		ret = gpmc_cfg->retime();
-		if (ret != 0)
-			goto free1;
-	}
-
-	if (gpio_request_one(gpmc_cfg->gpio_irq, GPIOF_IN, "SMC91X irq") < 0)
-		goto free1;
-
-	gpmc_smc91x_resources[1].start = gpio_to_irq(gpmc_cfg->gpio_irq);
-
-	if (gpmc_cfg->gpio_pwrdwn) {
-		ret = gpio_request_one(gpmc_cfg->gpio_pwrdwn,
-				       GPIOF_OUT_INIT_LOW, "SMC91X powerdown");
-		if (ret)
-			goto free2;
-	}
-
-	if (gpmc_cfg->gpio_reset) {
-		ret = gpio_request_one(gpmc_cfg->gpio_reset,
-				       GPIOF_OUT_INIT_LOW, "SMC91X reset");
-		if (ret)
-			goto free3;
-
-		gpio_set_value(gpmc_cfg->gpio_reset, 1);
-		msleep(100);
-		gpio_set_value(gpmc_cfg->gpio_reset, 0);
-	}
-
-	if (platform_device_register(&gpmc_smc91x_device) < 0) {
-		printk(KERN_ERR "Unable to register smc91x device\n");
-		gpio_free(gpmc_cfg->gpio_reset);
-		goto free3;
-	}
-
-	return;
-
-free3:
-	if (gpmc_cfg->gpio_pwrdwn)
-		gpio_free(gpmc_cfg->gpio_pwrdwn);
-free2:
-	gpio_free(gpmc_cfg->gpio_irq);
-free1:
-	gpmc_cs_free(gpmc_cfg->cs);
-
-	printk(KERN_ERR "Could not initialize smc91x\n");
-}
diff --git a/arch/arm/mach-omap2/gpmc-smc91x.h b/arch/arm/mach-omap2/gpmc-smc91x.h
deleted file mode 100644
index b64fbee..0000000
--- a/arch/arm/mach-omap2/gpmc-smc91x.h
+++ /dev/null
@@ -1,42 +0,0 @@
-/*
- * arch/arm/plat-omap/include/mach/gpmc-smc91x.h
- *
- * Copyright (C) 2009 Nokia Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ASM_ARCH_OMAP_GPMC_SMC91X_H__
-
-#define GPMC_TIMINGS_SMC91C96	(1 << 4)
-#define GPMC_MUX_ADD_DATA	(1 << 5) /* GPMC_CONFIG1_MUXADDDATA */
-#define GPMC_READ_MON		(1 << 6) /* GPMC_CONFIG1_WAIT_READ_MON */
-#define GPMC_WRITE_MON		(1 << 7) /* GPMC_CONFIG1_WAIT_WRITE_MON */
-
-struct omap_smc91x_platform_data {
-	int	cs;
-	int	gpio_irq;
-	int	gpio_pwrdwn;
-	int	gpio_reset;
-	int	wait_pin;	/* Optional GPMC_CONFIG1_WAITPINSELECT */
-	u32	flags;
-	int	(*retime)(void);
-};
-
-#if defined(CONFIG_SMC91X) || \
-	defined(CONFIG_SMC91X_MODULE)
-
-extern void gpmc_smc91x_init(struct omap_smc91x_platform_data *d);
-
-#else
-
-#define board_smc91x_data	NULL
-
-static inline void gpmc_smc91x_init(struct omap_smc91x_platform_data *d)
-{
-}
-
-#endif
-#endif
-- 
2.1.1

