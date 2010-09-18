From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH v6 02/13] OMAP: GPIO: Introduce support for OMAP15xx chip GPIO init
Date: Sat, 18 Sep 2010 19:45:42 +0530
Message-ID: <1284819353-8512-3-git-send-email-charu@ti.com>
References: <1284819353-8512-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48459 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755290Ab0IROQQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 Sep 2010 10:16:16 -0400
In-Reply-To: <1284819353-8512-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, "Varadarajan, Charulatha" <charu@ti.com>

This patch introduces platform_data structure for
GPIO so that GPIO module can be implemented in
platform device model.

This patch also adds support for handling OMAP15xx
specific gpio_init by providing platform device data
and doing device registration.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap1/gpio15xx.c         |  101 ++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/gpio.c              |    7 --
 arch/arm/plat-omap/include/plat/gpio.h |   22 +++++++
 3 files changed, 123 insertions(+), 7 deletions(-)
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
index dc8c0dc..e34bc60 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -210,13 +210,6 @@ struct gpio_bank {
 static void omap3_gpio_restore_context(void);
 static void omap3_gpio_save_context(void);
 
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
index c81ef94..c8a70d7 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -28,6 +28,9 @@
 
 #include <linux/io.h>
 #include <mach/irqs.h>
+#include <linux/platform_device.h>
+
+#include <plat/powerdomain.h>
 
 #define OMAP1_MPUIO_BASE			0xfffb5000
 
@@ -71,6 +74,25 @@
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
+	bool dbck_flag;		/* dbck required or not - True for OMAP3&4 */
+};
+
+struct omap_gpio_platform_data {
+	u16 virtual_irq_start;
+	int bank_type;
+	struct omap_gpio_dev_attr *gpio_attr;
+	struct powerdomain *pwrdm;
+};
+
 extern int omap_gpio_init(void);	/* Call from board init only */
 extern void omap2_gpio_prepare_for_idle(void);
 extern void omap2_gpio_resume_after_idle(void);
-- 
1.7.0.4

