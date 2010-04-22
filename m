From: Charulatha V <charu@ti.com>
Subject: [PATCH 3/9] OMAP:GPIO: Introduce support for OMAP16xx chip specific GPIO
Date: Thu, 22 Apr 2010 21:25:14 +0530
Message-ID: <1271951720-21714-4-git-send-email-charu@ti.com>
References: <1271951720-21714-1-git-send-email-charu@ti.com>
 <1271951720-21714-2-git-send-email-charu@ti.com>
 <1271951720-21714-3-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34489 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755885Ab0DVPzM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Apr 2010 11:55:12 -0400
In-Reply-To: <1271951720-21714-3-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: rnayak@ti.com, paul@pwsan.com, tony@atomide.com, khilman@deeprootsystems.com, Charulatha V <charu@ti.com>

This patch adds support for handling OMAP16xx specific gpio_init
by providing platform device data and doing device registration.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap1/gpio16xx.c |  196 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 196 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap1/gpio16xx.c

diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
new file mode 100644
index 0000000..c047d1d
--- /dev/null
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -0,0 +1,196 @@
+/*
+ * gpio16xx.c - OMAP16XX-specific gpio code
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
+ * OMAP16XX MPU GPIO interface data
+ */
+static struct __initdata resource omap16xx_mpu_gpio_resources[] = {
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
+static struct __initdata omap_gpio_platform_data omap16xx_mpu_gpio_config = {
+	.virtual_irq_start = IH_MPUIO_BASE,
+	.method	= METHOD_MPUIO,
+};
+
+static struct __initdata platform_device omap16xx_mpu_gpio = {
+	.name           = "omap-gpio",
+	.id             = 0,
+	.dev            = {
+		.platform_data = &omap16xx_mpu_gpio_config,
+	},
+	.num_resources = ARRAY_SIZE(omap16xx_mpu_gpio_resources),
+	.resource = omap16xx_mpu_gpio_resources,
+};
+
+/*
+ * OMAP16XX GPIO1 interface data
+ */
+static struct __initdata resource omap16xx_gpio1_resources[] = {
+	{
+		.start	= OMAP1610_GPIO1_BASE,
+		.end	= OMAP1610_GPIO1_BASE + SZ_2K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_GPIO_BANK1,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap16xx_gpio1_config = {
+	.virtual_irq_start = IH_GPIO_BASE,
+	.method	= METHOD_GPIO_1610,
+};
+
+static struct __initdata platform_device omap16xx_gpio1 = {
+	.name           = "omap-gpio",
+	.id             = 1,
+	.dev            = {
+		.platform_data = &omap16xx_gpio1_config,
+	},
+	.num_resources = ARRAY_SIZE(omap16xx_gpio1_resources),
+	.resource = omap16xx_gpio1_resources,
+};
+
+/*
+ * OMAP16XX GPIO2 interface data
+ */
+static struct __initdata resource omap16xx_gpio2_resources[] = {
+	{
+		.start	= OMAP1610_GPIO2_BASE,
+		.end	= OMAP1610_GPIO2_BASE + SZ_2K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_1610_GPIO_BANK2,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap16xx_gpio2_config = {
+	.virtual_irq_start = IH_GPIO_BASE + 16,
+	.method	= METHOD_GPIO_1610,
+};
+
+static struct __initdata platform_device omap16xx_gpio2 = {
+	.name           = "omap-gpio",
+	.id             = 2,
+	.dev            = {
+		.platform_data = &omap16xx_gpio2_config,
+	},
+	.num_resources = ARRAY_SIZE(omap16xx_gpio2_resources),
+	.resource = omap16xx_gpio2_resources,
+};
+
+/*
+ * OMAP16XX GPIO3 interface data
+ */
+static struct __initdata resource omap16xx_gpio3_resources[] = {
+	{
+		.start	= OMAP1610_GPIO3_BASE,
+		.end	= OMAP1610_GPIO3_BASE + SZ_2K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_1610_GPIO_BANK3,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap16xx_gpio3_config = {
+	.virtual_irq_start = IH_GPIO_BASE + 32,
+	.method	= METHOD_GPIO_1610,
+};
+
+static struct __initdata platform_device omap16xx_gpio3 = {
+	.name           = "omap-gpio",
+	.id             = 3,
+	.dev            = {
+		.platform_data = &omap16xx_gpio3_config,
+	},
+	.num_resources = ARRAY_SIZE(omap16xx_gpio3_resources),
+	.resource = omap16xx_gpio3_resources,
+};
+
+/*
+ * OMAP16XX GPIO4 interface data
+  */
+static struct __initdata resource omap16xx_gpio4_resources[] = {
+	{
+		.start	= OMAP1610_GPIO4_BASE,
+		.end	= OMAP1610_GPIO4_BASE + SZ_2K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_1610_GPIO_BANK4,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap16xx_gpio4_config = {
+	.virtual_irq_start = IH_GPIO_BASE + 48,
+	.method	= METHOD_GPIO_1610,
+};
+
+static struct __initdata platform_device omap16xx_gpio4 = {
+	.name           = "omap-gpio",
+	.id             = 4,
+	.dev            = {
+		.platform_data = &omap16xx_gpio4_config,
+	},
+	.num_resources = ARRAY_SIZE(omap16xx_gpio4_resources),
+	.resource = omap16xx_gpio4_resources,
+};
+
+static struct __initdata platform_device * omap16xx_gpio_dev[] = {
+	&omap16xx_mpu_gpio,
+	&omap16xx_gpio1,
+	&omap16xx_gpio2,
+	&omap16xx_gpio3,
+	&omap16xx_gpio4,
+};
+
+int __init omap16xx_gpio_init(void)
+{
+	if (cpu_is_omap16xx()) {
+		early_platform_add_devices(omap16xx_gpio_dev,
+					sizeof(omap16xx_gpio_dev));
+		early_platform_driver_register_all("earlygpio");
+		early_platform_driver_probe("earlygpio",
+					sizeof(omap16xx_gpio_dev), 0);
+	}
+	return 0;
+}
+
+int __init omap16xx_gpio_dev_reg(void)
+{
+	if (cpu_is_omap16xx()) {
+		int i;
+
+		for (i = 0; i < sizeof(omap16xx_gpio_dev); i++)
+			platform_device_register(omap16xx_gpio_dev[i]);
+	}
+	return 0;
+}
+arch_initcall(omap16xx_gpio_dev_reg);
-- 
1.6.3.3

