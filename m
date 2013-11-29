From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 1/3] ARM: OMAP2+: Remove legacy smsc911x and smc91x GPMC support
Date: Fri, 29 Nov 2013 20:18:15 +0100
Message-ID: <1385752697-13700-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1385752697-13700-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:40425 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256Ab3K2TTc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Nov 2013 14:19:32 -0500
In-Reply-To: <1385752697-13700-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

When connecting an ethernet chip to the GPMC, such as smc91x
or smsc911x, a GPIO has to be requested to be used as an IRQ
and also the IO memory for a GPMC chip-select.

When booting with DT the chip-select allocation is handled
in a generic manner in the GPMC driver and the GPIO to IRQ
mapping is made by the DT core so this code is not needed
anymore now that mach-omap2 related boards are DT-only.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/mach-omap2/Makefile        |   5 -
 arch/arm/mach-omap2/gpmc-smc91x.c   | 186 ------------------------------------
 arch/arm/mach-omap2/gpmc-smc91x.h   |  42 --------
 arch/arm/mach-omap2/gpmc-smsc911x.c | 100 -------------------
 arch/arm/mach-omap2/gpmc-smsc911x.h |  35 -------
 5 files changed, 368 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/gpmc-smc91x.c
 delete mode 100644 arch/arm/mach-omap2/gpmc-smc91x.h
 delete mode 100644 arch/arm/mach-omap2/gpmc-smsc911x.c
 delete mode 100644 arch/arm/mach-omap2/gpmc-smsc911x.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 8e6b0a4..5d10feb 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -249,11 +249,6 @@ obj-y					+= $(onenand-m) $(onenand-y)
 nand-$(CONFIG_MTD_NAND_OMAP2)		:= gpmc-nand.o
 obj-y					+= $(nand-m) $(nand-y)
 
-smc91x-$(CONFIG_SMC91X)			:= gpmc-smc91x.o
-obj-y					+= $(smc91x-m) $(smc91x-y)
-
-smsc911x-$(CONFIG_SMSC911X)		:= gpmc-smsc911x.o
-obj-y					+= $(smsc911x-m) $(smsc911x-y)
 ifneq ($(CONFIG_HWSPINLOCK_OMAP),)
 obj-y					+= hwspinlock.o
 endif
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
diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap2/gpmc-smsc911x.c
deleted file mode 100644
index 2757504..0000000
--- a/arch/arm/mach-omap2/gpmc-smsc911x.c
+++ /dev/null
@@ -1,100 +0,0 @@
-/*
- * linux/arch/arm/mach-omap2/gpmc-smsc911x.c
- *
- * Copyright (C) 2009 Li-Pro.Net
- * Stephan Linz <linz@li-pro.net>
- *
- * Modified from linux/arch/arm/mach-omap2/gpmc-smc91x.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#define pr_fmt(fmt) "%s: " fmt, __func__
-
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/gpio.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
-#include <linux/smsc911x.h>
-
-#include "gpmc.h"
-#include "gpmc-smsc911x.h"
-
-static struct resource gpmc_smsc911x_resources[] = {
-	[0] = {
-		.flags		= IORESOURCE_MEM,
-	},
-	[1] = {
-		.flags		= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
-	},
-};
-
-static struct smsc911x_platform_config gpmc_smsc911x_config = {
-	.phy_interface	= PHY_INTERFACE_MODE_MII,
-	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
-	.irq_type	= SMSC911X_IRQ_TYPE_OPEN_DRAIN,
-};
-
-/*
- * Initialize smsc911x device connected to the GPMC. Note that we
- * assume that pin multiplexing is done in the board-*.c file,
- * or in the bootloader.
- */
-void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *gpmc_cfg)
-{
-	struct platform_device *pdev;
-	unsigned long cs_mem_base;
-	int ret;
-
-	if (gpmc_cs_request(gpmc_cfg->cs, SZ_16M, &cs_mem_base) < 0) {
-		pr_err("Failed to request GPMC mem region\n");
-		return;
-	}
-
-	gpmc_smsc911x_resources[0].start = cs_mem_base + 0x0;
-	gpmc_smsc911x_resources[0].end = cs_mem_base + 0xff;
-
-	if (gpio_request_one(gpmc_cfg->gpio_irq, GPIOF_IN, "smsc911x irq")) {
-		pr_err("Failed to request IRQ GPIO%d\n", gpmc_cfg->gpio_irq);
-		goto free1;
-	}
-
-	gpmc_smsc911x_resources[1].start = gpio_to_irq(gpmc_cfg->gpio_irq);
-
-	if (gpio_is_valid(gpmc_cfg->gpio_reset)) {
-		ret = gpio_request_one(gpmc_cfg->gpio_reset,
-				       GPIOF_OUT_INIT_HIGH, "smsc911x reset");
-		if (ret) {
-			pr_err("Failed to request reset GPIO%d\n",
-			       gpmc_cfg->gpio_reset);
-			goto free2;
-		}
-
-		gpio_set_value(gpmc_cfg->gpio_reset, 0);
-		msleep(100);
-		gpio_set_value(gpmc_cfg->gpio_reset, 1);
-	}
-
-	gpmc_smsc911x_config.flags = gpmc_cfg->flags ? : SMSC911X_USE_16BIT;
-
-	pdev = platform_device_register_resndata(NULL, "smsc911x", gpmc_cfg->id,
-		 gpmc_smsc911x_resources, ARRAY_SIZE(gpmc_smsc911x_resources),
-		 &gpmc_smsc911x_config, sizeof(gpmc_smsc911x_config));
-	if (IS_ERR(pdev)) {
-		pr_err("Unable to register platform device\n");
-		gpio_free(gpmc_cfg->gpio_reset);
-		goto free2;
-	}
-
-	return;
-
-free2:
-	gpio_free(gpmc_cfg->gpio_irq);
-free1:
-	gpmc_cs_free(gpmc_cfg->cs);
-
-	pr_err("Could not initialize smsc911x device\n");
-}
diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.h b/arch/arm/mach-omap2/gpmc-smsc911x.h
deleted file mode 100644
index ea6c9c8..0000000
--- a/arch/arm/mach-omap2/gpmc-smsc911x.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * arch/arm/plat-omap/include/plat/gpmc-smsc911x.h
- *
- * Copyright (C) 2009 Li-Pro.Net
- * Stephan Linz <linz@li-pro.net>
- *
- * Modified from arch/arm/plat-omap/include/plat/gpmc-smc91x.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ASM_ARCH_OMAP_GPMC_SMSC911X_H__
-
-struct omap_smsc911x_platform_data {
-	int	id;
-	int	cs;
-	int	gpio_irq;
-	int	gpio_reset;
-	u32	flags;
-};
-
-#if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
-
-extern void gpmc_smsc911x_init(struct omap_smsc911x_platform_data *d);
-
-#else
-
-static inline void gpmc_smsc911x_init(struct omap_smsc911x_platform_data *d)
-{
-}
-
-#endif
-#endif
-- 
1.8.4.2

