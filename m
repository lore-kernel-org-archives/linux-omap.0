From: Charulatha V <charu@ti.com>
Subject: [PATCH 02/13 v5] OMAP: GPIO: Introduce support for OMAP15xx chip GPIO init
Date: Fri,  6 Aug 2010 18:04:14 +0530
Message-ID: <1281098065-24177-3-git-send-email-charu@ti.com>
References: <1281098065-24177-1-git-send-email-charu@ti.com>
 <1281098065-24177-2-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52285 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932824Ab0HFMbo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Aug 2010 08:31:44 -0400
In-Reply-To: <1281098065-24177-2-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, rnayak@ti.com, Charulatha V <charu@ti.com>, "Basak, Partha" <p-basak2@ti.com>

This patch introduces platform_data structure for GPIO
so that GPIO module can be implemented in platform device model.

This patch also adds support for handling OMAP15xx specific gpio_init
by providing platform device data and doing device registration.

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Basak, Partha <p-basak2@ti.com>
---
 arch/arm/mach-omap1/gpio15xx.c         |  101 ++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/gpio.c              |    7 --
 arch/arm/plat-omap/include/plat/gpio.h |   20 ++++++
 3 files changed, 121 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/mach-omap1/gpio15xx.c

diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
new file mode 100644
index 0000000..b2daa66
--- /dev/null
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -0,0 +1,101 @@
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
+	.bank_width = 16,
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
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index d013b45..dfe4b9e 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -205,13 +205,6 @@ struct gpio_bank {
 	u32 dbck_enable_mask;
 };
 
-#define METHOD_MPUIO		0
-#define METHOD_GPIO_1510	1
-#define METHOD_GPIO_1610	2
-#define METHOD_GPIO_7XX		3
-#define METHOD_GPIO_24XX	5
-#define METHOD_GPIO_44XX	6
-
 #ifdef CONFIG_ARCH_OMAP16XX
 static struct gpio_bank gpio_bank_1610[5] = {
 	{ OMAP1_MPUIO_VBASE, NULL, INT_MPUIO, IH_MPUIO_BASE,
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index de1c604..67d0086 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -28,6 +28,7 @@
 
 #include <linux/io.h>
 #include <mach/irqs.h>
+#include <linux/platform_device.h>
 
 #define OMAP1_MPUIO_BASE			0xfffb5000
 
@@ -71,6 +72,25 @@
 				 IH_MPUIO_BASE + ((nr) & 0x0f) : \
 				 IH_GPIO_BASE + (nr))
 
+#define METHOD_MPUIO		0
+#define METHOD_GPIO_1510	1
+#define METHOD_GPIO_1610	2
+#define METHOD_GPIO_7XX		3
+#define METHOD_GPIO_24XX	5
+#define METHOD_GPIO_44XX	6
+
+struct omap_gpio_dev_attr {
+	int bank_width;		/* GPIO bank width */
+	bool dbck_flag;		/* dbck validity - True only for OMAP3&4 */
+	bool off_mode_support;	/* True for OMAP3&4 non-wakeup domain GPIOs */
+};
+
+struct omap_gpio_platform_data {
+	u16 virtual_irq_start;
+	int bank_type;
+	struct omap_gpio_dev_attr *gpio_attr;
+};
+
 extern int omap_gpio_init(void);	/* Call from board init only */
 extern void omap2_gpio_prepare_for_idle(int power_state);
 extern void omap2_gpio_resume_after_idle(void);
-- 
1.6.3.3

