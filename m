From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 2/2] ARM: OMAP: Remove debug-devices.c
Date: Tue, 13 Nov 2012 16:02:20 -0600
Message-ID: <1352844140-11103-3-git-send-email-jon-hunter@ti.com>
References: <1352844140-11103-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38562 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753630Ab2KMWC2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Nov 2012 17:02:28 -0500
In-Reply-To: <1352844140-11103-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

The OMAP2420 H4 board was the only board using the
plat-omap/debug-devices.c code for configuring ethernet support. Now
that OMAP2420 H4 has been migrated to use the generic gpmc code for
configuring ethernet support, the debug-devices.c file is no longer
used and so remove it and its header file.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/debug-devices.h |    9 ----
 arch/arm/plat-omap/Makefile         |    1 -
 arch/arm/plat-omap/debug-devices.c  |   93 -----------------------------------
 3 files changed, 103 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/debug-devices.h
 delete mode 100644 arch/arm/plat-omap/debug-devices.c

diff --git a/arch/arm/mach-omap2/debug-devices.h b/arch/arm/mach-omap2/debug-devices.h
deleted file mode 100644
index a4edbd2..0000000
--- a/arch/arm/mach-omap2/debug-devices.h
+++ /dev/null
@@ -1,9 +0,0 @@
-#ifndef _OMAP_DEBUG_DEVICES_H
-#define _OMAP_DEBUG_DEVICES_H
-
-#include <linux/types.h>
-
-/* for TI reference platforms sharing the same debug card */
-extern int debug_card_init(u32 addr, unsigned gpio);
-
-#endif
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index dacaee0..1eca088 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -12,7 +12,6 @@ obj-  :=
 obj-$(CONFIG_ARCH_OMAP2PLUS) += omap_device.o
 
 obj-$(CONFIG_OMAP_DM_TIMER) += dmtimer.o
-obj-$(CONFIG_OMAP_DEBUG_DEVICES) += debug-devices.o
 obj-$(CONFIG_OMAP_DEBUG_LEDS) += debug-leds.o
 i2c-omap-$(CONFIG_I2C_OMAP) := i2c.o
 obj-y += $(i2c-omap-m) $(i2c-omap-y)
diff --git a/arch/arm/plat-omap/debug-devices.c b/arch/arm/plat-omap/debug-devices.c
deleted file mode 100644
index 5a4678e..0000000
--- a/arch/arm/plat-omap/debug-devices.c
+++ /dev/null
@@ -1,93 +0,0 @@
-/*
- * linux/arch/arm/plat-omap/debug-devices.c
- *
- * Copyright (C) 2005 Nokia Corporation
- * Modified from mach-omap2/board-h4.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/gpio.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/io.h>
-#include <linux/smc91x.h>
-
-#include <mach/hardware.h>
-#include "../mach-omap2/debug-devices.h"
-
-/* Many OMAP development platforms reuse the same "debug board"; these
- * platforms include H2, H3, H4, and Perseus2.
- */
-
-static struct smc91x_platdata smc91x_info = {
-	.flags	= SMC91X_USE_16BIT | SMC91X_NOWAIT,
-	.leda	= RPC_LED_100_10,
-	.ledb	= RPC_LED_TX_RX,
-};
-
-static struct resource smc91x_resources[] = {
-	[0] = {
-		.flags  = IORESOURCE_MEM,
-	},
-	[1] = {
-		.flags  = IORESOURCE_IRQ | IORESOURCE_IRQ_LOWEDGE,
-	},
-};
-
-static struct platform_device smc91x_device = {
-	.name		= "smc91x",
-	.id		= -1,
-	.dev		= {
-		.platform_data = &smc91x_info,
-	},
-	.num_resources	= ARRAY_SIZE(smc91x_resources),
-	.resource	= smc91x_resources,
-};
-
-static struct resource led_resources[] = {
-	[0] = {
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device led_device = {
-	.name		= "omap_dbg_led",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(led_resources),
-	.resource	= led_resources,
-};
-
-static struct platform_device *debug_devices[] __initdata = {
-	&smc91x_device,
-	&led_device,
-	/* ps2 kbd + mouse ports */
-	/* 4 extra uarts */
-	/* 6 input dip switches */
-	/* 8 output pins */
-};
-
-int __init debug_card_init(u32 addr, unsigned gpio)
-{
-	int	status;
-
-	smc91x_resources[0].start = addr + 0x300;
-	smc91x_resources[0].end   = addr + 0x30f;
-
-	smc91x_resources[1].start = gpio_to_irq(gpio);
-	smc91x_resources[1].end   = gpio_to_irq(gpio);
-
-	status = gpio_request(gpio, "SMC91x irq");
-	if (status < 0) {
-		printk(KERN_ERR "GPIO%d unavailable for smc91x IRQ\n", gpio);
-		return status;
-	}
-	gpio_direction_input(gpio);
-
-	led_resources[0].start = addr;
-	led_resources[0].end   = addr + SZ_4K - 1;
-
-	return platform_add_devices(debug_devices, ARRAY_SIZE(debug_devices));
-}
-- 
1.7.9.5

