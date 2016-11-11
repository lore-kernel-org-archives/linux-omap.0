From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 11/14] ARM: OMAP2+: Remove legacy smsc911x and smc91x GPMC
 support
Date: Fri, 11 Nov 2016 11:17:08 -0800
Message-ID: <20161111191711.5079-12-tony@atomide.com>
References: <20161111191711.5079-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161111191711.5079-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

When connecting an ethernet chip to the GPMC, such as smc91x
or smsc911x, a GPIO has to be requested to be used as an IRQ
and also the IO memory for a GPMC chip-select.

When booting with DT the chip-select allocation is handled
in a generic manner in the GPMC driver and the GPIO to IRQ
mapping is made by the DT core so this code is not needed
anymore now that mach-omap2 related boards are DT-only.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile        |   2 -
 arch/arm/mach-omap2/gpmc-smsc911x.c | 100 ------------------------------------
 arch/arm/mach-omap2/gpmc-smsc911x.h |  35 -------------
 3 files changed, 137 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/gpmc-smsc911x.c
 delete mode 100644 arch/arm/mach-omap2/gpmc-smsc911x.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -249,7 +249,5 @@ obj-y					+= $(onenand-m) $(onenand-y)
 nand-$(CONFIG_MTD_NAND_OMAP2)		:= gpmc-nand.o
 obj-y					+= $(nand-m) $(nand-y)
 
-smsc911x-$(CONFIG_SMSC911X)		:= gpmc-smsc911x.o
-obj-y					+= $(smsc911x-m) $(smsc911x-y)
 
 obj-y					+= common-board-devices.o dss-common.o
diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap2/gpmc-smsc911x.c
deleted file mode 100644
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
-#if IS_ENABLED(CONFIG_SMSC911X)
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
2.10.2
