From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH v6 04/13] OMAP: GPIO: Introduce support for OMAP7xx chip GPIO init
Date: Sat, 18 Sep 2010 19:45:44 +0530
Message-ID: <1284819353-8512-5-git-send-email-charu@ti.com>
References: <1284819353-8512-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48463 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755445Ab0IROQQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 Sep 2010 10:16:16 -0400
In-Reply-To: <1284819353-8512-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, "Varadarajan, Charulatha" <charu@ti.com>

This patch adds support for handling OMAP7xx specific gpio_init
by providing platform device data and doing device registration.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap1/gpio7xx.c |  274 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 274 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap1/gpio7xx.c

diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
new file mode 100644
index 0000000..48c7f13
--- /dev/null
+++ b/arch/arm/mach-omap1/gpio7xx.c
@@ -0,0 +1,274 @@
+/*
+ * OMAP7XX-specific gpio code
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
+#define OMAP7XX_GPIO1_BASE		0xfffbc000
+#define OMAP7XX_GPIO2_BASE		0xfffbc800
+#define OMAP7XX_GPIO3_BASE		0xfffbd000
+#define OMAP7XX_GPIO4_BASE		0xfffbd800
+#define OMAP7XX_GPIO5_BASE		0xfffbe000
+#define OMAP7XX_GPIO6_BASE		0xfffbe800
+#define OMAP1_MPUIO_VBASE		OMAP1_MPUIO_BASE
+
+static struct omap_gpio_dev_attr omap7xx_gpio_attr = {
+	.bank_width = 32,
+};
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
+	.virtual_irq_start	= IH_MPUIO_BASE,
+	.bank_type		= METHOD_MPUIO,
+	.gpio_attr		= &omap7xx_gpio_attr,
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
+	.virtual_irq_start	= IH_GPIO_BASE,
+	.bank_type		= METHOD_GPIO_7XX,
+	.gpio_attr		= &omap7xx_gpio_attr,
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
+	.virtual_irq_start	= IH_GPIO_BASE + 32,
+	.bank_type		= METHOD_GPIO_7XX,
+	.gpio_attr		= &omap7xx_gpio_attr,
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
+	.virtual_irq_start	= IH_GPIO_BASE + 64,
+	.bank_type		= METHOD_GPIO_7XX,
+	.gpio_attr		= &omap7xx_gpio_attr,
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
+	.virtual_irq_start	= IH_GPIO_BASE + 96,
+	.bank_type		= METHOD_GPIO_7XX,
+	.gpio_attr		= &omap7xx_gpio_attr,
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
+	.virtual_irq_start	= IH_GPIO_BASE + 128,
+	.bank_type		= METHOD_GPIO_7XX,
+	.gpio_attr		= &omap7xx_gpio_attr,
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
+	.virtual_irq_start	= IH_GPIO_BASE + 160,
+	.bank_type		= METHOD_GPIO_7XX,
+	.gpio_attr		= &omap7xx_gpio_attr,
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
+/*
+ * omap7xx_gpio_init needs to be done before
+ * machine_init functions access gpio APIs.
+ * Hence omap7xx_gpio_init is a postcore_initcall.
+ */
+static int __init omap7xx_gpio_init(void)
+{
+	int i;
+
+	if (!cpu_is_omap7xx())
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(omap7xx_gpio_dev); i++)
+		platform_device_register(omap7xx_gpio_dev[i]);
+
+	gpio_bank_count = ARRAY_SIZE(omap7xx_gpio_dev);
+
+	return 0;
+}
+postcore_initcall(omap7xx_gpio_init);
-- 
1.7.0.4

