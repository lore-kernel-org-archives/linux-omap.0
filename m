From: Charulatha V <charu@ti.com>
Subject: [PATCH 2/9] OMAP:GPIO: Introduce support for OMAP15xx chip specific GPIO
Date: Thu, 22 Apr 2010 21:25:13 +0530
Message-ID: <1271951720-21714-3-git-send-email-charu@ti.com>
References: <1271951720-21714-1-git-send-email-charu@ti.com>
 <1271951720-21714-2-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34459 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755322Ab0DVPzD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Apr 2010 11:55:03 -0400
In-Reply-To: <1271951720-21714-2-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: rnayak@ti.com, paul@pwsan.com, tony@atomide.com, khilman@deeprootsystems.com, Charulatha V <charu@ti.com>

This patch adds support for handling OMAP15xx specific gpio_init
by providing platform device data and doing device registration.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap1/gpio15xx.c |  102 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 102 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap1/gpio15xx.c

diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
new file mode 100644
index 0000000..99c4017
--- /dev/null
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -0,0 +1,102 @@
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
+	.virtual_irq_start = IH_MPUIO_BASE,
+	.method	= METHOD_MPUIO,
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
+	.virtual_irq_start = IH_GPIO_BASE,
+	.method	= METHOD_GPIO_1510,
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
+static struct __initdata platform_device * omap15xx_gpio_dev[] = {
+	&omap15xx_mpu_gpio,
+	&omap15xx_gpio,
+};
+
+int __init omap15xx_gpio_init(void)
+{
+	if (cpu_is_omap15xx()) {
+		early_platform_add_devices(omap15xx_gpio_dev,
+						sizeof(omap15xx_gpio_dev));
+		early_platform_driver_register_all("earlygpio");
+		early_platform_driver_probe("earlygpio",
+						sizeof(omap15xx_gpio_dev), 0);
+	}
+	return 0;
+}
+
+int __init omap15xx_gpio_dev_reg(void)
+{
+	if (cpu_is_omap15xx()) {
+		platform_device_register(&omap15xx_mpu_gpio);
+		platform_device_register(&omap15xx_gpio);
+	}
+
+	return 0;
+}
+arch_initcall(omap15xx_gpio_dev_reg);
-- 
1.6.3.3

