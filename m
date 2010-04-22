From: Charulatha V <charu@ti.com>
Subject: [PATCH 4/9] OMAP:GPIO: Introduce support for OMAP7xx chip specific GPIO
Date: Thu, 22 Apr 2010 21:25:15 +0530
Message-ID: <1271951720-21714-5-git-send-email-charu@ti.com>
References: <1271951720-21714-1-git-send-email-charu@ti.com>
 <1271951720-21714-2-git-send-email-charu@ti.com>
 <1271951720-21714-3-git-send-email-charu@ti.com>
 <1271951720-21714-4-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34478 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755939Ab0DVPzG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Apr 2010 11:55:06 -0400
In-Reply-To: <1271951720-21714-4-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: rnayak@ti.com, paul@pwsan.com, tony@atomide.com, khilman@deeprootsystems.com, Charulatha V <charu@ti.com>

This patch adds support for handling OMAP7xx specific gpio_init
by providing platform device data and doing device registration.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap1/gpio7xx.c |  258 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 258 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap1/gpio7xx.c

diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
new file mode 100644
index 0000000..3cf1d54
--- /dev/null
+++ b/arch/arm/mach-omap1/gpio7xx.c
@@ -0,0 +1,258 @@
+/*
+ * gpio7xx.c - OMAP7XX-specific gpio code
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
+/*
+ * OMAP7XX MPU GPIO interface data
+ */
+static struct __initdata resource omap7xx_mpu_gpio_resources[] = {
+	{
+		.start	= OMAP1_MPUIO_VBASE,
+		.end	= OMAP1_MPUIO_VBASE + SZ_2K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_7XX_MPUIO,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap7xx_mpu_gpio_config = {
+	.virtual_irq_start = IH_MPUIO_BASE,
+	.method	= METHOD_MPUIO,
+};
+
+static struct __initdata platform_device omap7xx_mpu_gpio = {
+	.name           = "omap-gpio",
+	.id             = 0,
+	.dev            = {
+		.platform_data = &omap7xx_mpu_gpio_config,
+	},
+	.num_resources = ARRAY_SIZE(omap7xx_mpu_gpio_resources),
+	.resource = omap7xx_mpu_gpio_resources,
+};
+
+/*
+ * OMAP7XX GPIO1 interface data
+ */
+static struct __initdata resource omap7xx_gpio1_resources[] = {
+	{
+		.start	= OMAP7XX_GPIO1_BASE,
+		.end	= OMAP7XX_GPIO1_BASE + SZ_2K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_7XX_GPIO_BANK1,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap7xx_gpio1_config = {
+	.virtual_irq_start = IH_GPIO_BASE,
+	.method	= METHOD_GPIO_7XX,
+};
+
+static struct __initdata platform_device omap7xx_gpio1 = {
+	.name           = "omap-gpio",
+	.id             = 1,
+	.dev            = {
+		.platform_data = &omap7xx_gpio1_config,
+	},
+	.num_resources = ARRAY_SIZE(omap7xx_gpio1_resources),
+	.resource = omap7xx_gpio1_resources,
+};
+
+/*
+ * OMAP7XX GPIO2 interface data
+ */
+static struct __initdata resource omap7xx_gpio2_resources[] = {
+	{
+		.start	= OMAP7XX_GPIO2_BASE,
+		.end	= OMAP7XX_GPIO2_BASE + SZ_2K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_7XX_GPIO_BANK2,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap7xx_gpio2_config = {
+	.virtual_irq_start = IH_GPIO_BASE + 32,
+	.method	= METHOD_GPIO_7XX,
+};
+
+static struct __initdata platform_device omap7xx_gpio2 = {
+	.name           = "omap-gpio",
+	.id             = 2,
+	.dev            = {
+		.platform_data = &omap7xx_gpio2_config,
+	},
+	.num_resources = ARRAY_SIZE(omap7xx_gpio2_resources),
+	.resource = omap7xx_gpio2_resources,
+};
+
+/*
+ * OMAP7XX GPIO3 interface data
+ */
+static struct __initdata resource omap7xx_gpio3_resources[] = {
+	{
+		.start	= OMAP7XX_GPIO3_BASE,
+		.end	= OMAP7XX_GPIO3_BASE + SZ_2K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_7XX_GPIO_BANK3,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap7xx_gpio3_config = {
+	.virtual_irq_start = IH_GPIO_BASE + 64,
+	.method	= METHOD_GPIO_7XX,
+};
+
+static struct __initdata platform_device omap7xx_gpio3 = {
+	.name           = "omap-gpio",
+	.id             = 3,
+	.dev            = {
+		.platform_data = &omap7xx_gpio3_config,
+	},
+	.num_resources = ARRAY_SIZE(omap7xx_gpio3_resources),
+	.resource = omap7xx_gpio3_resources,
+};
+
+/*
+ * OMAP7XX GPIO4 interface data
+ */
+static struct __initdata resource omap7xx_gpio4_resources[] = {
+	{
+		.start	= OMAP7XX_GPIO4_BASE,
+		.end	= OMAP7XX_GPIO4_BASE + SZ_2K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_7XX_GPIO_BANK4,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap7xx_gpio4_config = {
+	.virtual_irq_start = IH_GPIO_BASE + 96,
+	.method	= METHOD_GPIO_7XX,
+};
+
+static struct __initdata platform_device omap7xx_gpio4 = {
+	.name           = "omap-gpio",
+	.id             = 4,
+	.dev            = {
+		.platform_data = &omap7xx_gpio4_config,
+	},
+	.num_resources = ARRAY_SIZE(omap7xx_gpio4_resources),
+	.resource = omap7xx_gpio4_resources,
+};
+
+/*
+ * OMAP7XX GPIO5 interface data
+  */
+static struct __initdata resource omap7xx_gpio5_resources[] = {
+	{
+		.start	= OMAP7XX_GPIO5_BASE,
+		.end	= OMAP7XX_GPIO5_BASE + SZ_2K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_7XX_GPIO_BANK5,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap7xx_gpio5_config = {
+	.virtual_irq_start = IH_GPIO_BASE + 128,
+	.method	= METHOD_GPIO_7XX,
+};
+
+static struct __initdata platform_device omap7xx_gpio5 = {
+	.name           = "omap-gpio",
+	.id             = 5,
+	.dev            = {
+		.platform_data = &omap7xx_gpio5_config,
+	},
+	.num_resources = ARRAY_SIZE(omap7xx_gpio5_resources),
+	.resource = omap7xx_gpio5_resources,
+};
+
+/*
+ * OMAP7XX GPIO6 interface data
+  */
+static struct __initdata resource omap7xx_gpio6_resources[] = {
+	{
+		.start	= OMAP7XX_GPIO6_BASE,
+		.end	= OMAP7XX_GPIO6_BASE + SZ_2K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_7XX_GPIO_BANK6,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap7xx_gpio6_config = {
+	.virtual_irq_start = IH_GPIO_BASE + 160,
+	.method	= METHOD_GPIO_7XX,
+};
+
+static struct __initdata platform_device omap7xx_gpio6 = {
+	.name           = "omap-gpio",
+	.id             = 6,
+	.dev            = {
+		.platform_data = &omap7xx_gpio6_config,
+	},
+	.num_resources = ARRAY_SIZE(omap7xx_gpio6_resources),
+	.resource = omap7xx_gpio6_resources,
+};
+
+static struct __initdata platform_device * omap7xx_gpio_dev[] = {
+	&omap7xx_mpu_gpio,
+	&omap7xx_gpio1,
+	&omap7xx_gpio2,
+	&omap7xx_gpio3,
+	&omap7xx_gpio4,
+	&omap7xx_gpio5,
+	&omap7xx_gpio6,
+};
+
+int __init omap7xx_gpio_init(void)
+{
+	if (cpu_is_omap7xx()) {
+		early_platform_add_devices(omap7xx_gpio_dev,
+						sizeof(omap7xx_gpio_dev));
+		early_platform_driver_register_all("earlygpio");
+		early_platform_driver_probe("earlygpio",
+						sizeof(omap7xx_gpio_dev), 0);
+	}
+	return 0;
+}
+
+int __init omap7xx_gpio_dev_reg(void)
+{
+	if (cpu_is_omap7xx()) {
+		int i;
+
+		for (i = 0; i < sizeof(omap7xx_gpio_dev); i++)
+			platform_device_register(omap7xx_gpio_dev[i]);
+	}
+	return 0;
+}
+arch_initcall(omap7xx_gpio_dev_reg);
-- 
1.6.3.3

