From: Charulatha V <charu@ti.com>
Subject: [PATCH 03/11] OMAP: GPIO: Introduce support for OMAP15xx chip GPIO init
Date: Tue, 18 May 2010 20:20:52 +0530
Message-ID: <1274194260-16401-4-git-send-email-charu@ti.com>
References: <1274194260-16401-1-git-send-email-charu@ti.com>
 <1274194260-16401-2-git-send-email-charu@ti.com>
 <1274194260-16401-3-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35804 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757887Ab0EROtz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 May 2010 10:49:55 -0400
In-Reply-To: <1274194260-16401-3-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: rnayak@ti.com, paul@pwsan.com, tony@atomide.com, khilman@deeprootsystems.com, Charulatha V <charu@ti.com>

This patch adds support for handling OMAP15xx specific gpio_init
by providing platform device data and doing device registration.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap1/gpio15xx.c |  99 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 104 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap1/gpio15xx.c

diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
new file mode 100644
index 0000000..c9082bd
--- /dev/null
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -0,0 +1,99 @@
+/*
+ * gpio15xx.c - OMAP15XX-specific gpio code
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ *
+ * Author:
+ *	Charulatha V <charu@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/gpio.h>
+
+static struct omap_gpio_dev_attr omap15xx_gpio_attr = {
+		.gpio_bank_count	= 2,
+		.gpio_bank_bits		= 16,
+		.arm_gpio_ck_flag	= true,
+};
+
+/*
+ * OMAP15XX GPIO1 interface data
+ */
+static struct __initdata resource omap15xx_mpu_gpio_resources[] = {
+	{
+		.start	= OMAP1_MPUIO_VBASE,
+		.end	= OMAP1_MPUIO_VBASE + SZ_2K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_MPUIO,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap15xx_mpu_gpio_config = {
+	.virtual_irq_start	= IH_MPUIO_BASE,
+	.method			= METHOD_MPUIO,
+	.gpio_attr		= &omap15xx_gpio_attr,
+};
+
+static struct __initdata platform_device omap15xx_mpu_gpio = {
+	.name           = "omap-gpio",
+	.id             = 0,
+	.dev            = {
+		.platform_data = &omap15xx_mpu_gpio_config,
+	},
+	.num_resources = ARRAY_SIZE(omap15xx_mpu_gpio_resources),
+	.resource = omap15xx_mpu_gpio_resources,
+};
+
+/*
+ * OMAP15XX GPIO2 interface data
+ */
+static struct __initdata resource omap15xx_gpio_resources[] = {
+	{
+		.start	= OMAP1510_GPIO_BASE,
+		.end	= OMAP1510_GPIO_BASE + SZ_2K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_GPIO_BANK1,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap15xx_gpio_config = {
+	.virtual_irq_start	= IH_GPIO_BASE,
+	.method			= METHOD_GPIO_1510,
+	.gpio_attr		= &omap15xx_gpio_attr,
+};
+
+static struct __initdata platform_device omap15xx_gpio = {
+	.name           = "omap-gpio",
+	.id             = 1,
+	.dev            = {
+		.platform_data = &omap15xx_gpio_config,
+	},
+	.num_resources = ARRAY_SIZE(omap15xx_gpio_resources),
+	.resource = omap15xx_gpio_resources,
+};
+
+/*
+ * omap15xx_gpio_init needs to be done before
+ * machine_init functions access gpio APIs.
+ * Hence omap15xx_gpio_init is a postcore_initcall.
+ */
+static int __init omap15xx_gpio_init(void)
+{
+	if (!cpu_is_omap15xx())
+		return -EINVAL;
+
+	platform_device_register(&omap15xx_mpu_gpio);
+	platform_device_register(&omap15xx_gpio);
+
+	return 0;
+}
+postcore_initcall(omap15xx_gpio_init);
-- 
1.6.3.3

