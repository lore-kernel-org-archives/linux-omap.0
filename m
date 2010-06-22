From: Charulatha V <charu@ti.com>
Subject: [PATCH:v4 04/13] OMAP: GPIO: Introduce support for OMAP15xx chip GPIO init
Date: Tue, 22 Jun 2010 20:31:47 +0530
Message-ID: <1277218916-15213-5-git-send-email-charu@ti.com>
References: <1277218916-15213-1-git-send-email-charu@ti.com>
 <1277218916-15213-2-git-send-email-charu@ti.com>
 <1277218916-15213-3-git-send-email-charu@ti.com>
 <1277218916-15213-4-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33361 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758421Ab0FVPB3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Jun 2010 11:01:29 -0400
In-Reply-To: <1277218916-15213-4-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, tony@atomide.com, rnayak@ti.com, p-basak2@ti.com, b-cousson@ti.com, Charulatha V <charu@ti.com>

This patch adds support for handling OMAP15xx specific gpio_init
by providing platform device data and doing device registration.

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Basak, Partha <p-basak2@ti.com>
---
 arch/arm/mach-omap1/gpio15xx.c |  105 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 105 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap1/gpio15xx.c

diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
new file mode 100644
index 0000000..f3d2bd4
--- /dev/null
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -0,0 +1,102 @@
+/*
+ * OMAP15XX-specific gpio code
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
+#define OMAP1_MPUIO_VBASE		OMAP1_MPUIO_BASE
+#define OMAP1510_GPIO_BASE		0xfffce000
+
+static struct omap_gpio_dev_attr omap15xx_gpio_attr = {
+		.gpio_bank_width = 16,
+		.omap1_ick_flag	= true,
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
+	.bank_type		= METHOD_MPUIO,
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
+	.bank_type		= METHOD_GPIO_1510,
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
+	gpio_bank_count = 2,
+	return 0;
+}
+postcore_initcall(omap15xx_gpio_init);
-- 
1.6.3.3

