From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH v8 02/11] OMAP15xx: GPIO: Introduce support for GPIO init
Date: Thu, 25 Nov 2010 18:18:29 +0530
Message-ID: <1290689318-10191-3-git-send-email-charu@ti.com>
References: <1290689318-10191-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36983 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752961Ab0KYMs4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Nov 2010 07:48:56 -0500
In-Reply-To: <1290689318-10191-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, p-basak2@ti.com, "Varadarajan, Charulatha" <charu@ti.com>

Add support for handling OMAP15xx specific gpio_init by
providing platform device data and doing device registration.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap1/gpio15xx.c         |   98 ++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/gpio.c              |   10 +---
 arch/arm/plat-omap/include/plat/gpio.h |   18 ++++++
 3 files changed, 118 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/mach-omap1/gpio15xx.c

diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
new file mode 100644
index 0000000..dbd8168
--- /dev/null
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -0,0 +1,98 @@
+/*
+ * OMAP15xx specific gpio init
+ *
+ * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * Author:
+ *	Charulatha V <charu@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/gpio.h>
+
+#define OMAP1_MPUIO_VBASE		OMAP1_MPUIO_BASE
+#define OMAP1510_GPIO_BASE		0xFFFCE000
+
+/* gpio1 */
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
+	.bank_width		= 16,
+};
+
+static struct __initdata platform_device omap15xx_mpu_gpio = {
+	.name           = "omap_gpio",
+	.id             = 0,
+	.dev            = {
+		.platform_data = &omap15xx_mpu_gpio_config,
+	},
+	.num_resources = ARRAY_SIZE(omap15xx_mpu_gpio_resources),
+	.resource = omap15xx_mpu_gpio_resources,
+};
+
+/* gpio2 */
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
+	.bank_width		= 16,
+};
+
+static struct __initdata platform_device omap15xx_gpio = {
+	.name           = "omap_gpio",
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
+	gpio_bank_count = 2;
+	return 0;
+}
+postcore_initcall(omap15xx_gpio_init);
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 48bccf2..610787c 100644
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
@@ -335,7 +328,8 @@ static struct gpio_bank gpio_bank_44xx[6] = {
 #endif
 
 static struct gpio_bank *gpio_bank;
-static int gpio_bank_count;
+/* TODO: Analyze removing gpio_bank_count usage from driver code */
+int gpio_bank_count;
 
 static inline struct gpio_bank *get_gpio_bank(int gpio)
 {
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index de1c604..5bef86d 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -27,6 +27,7 @@
 #define __ASM_ARCH_OMAP_GPIO_H
 
 #include <linux/io.h>
+#include <linux/platform_device.h>
 #include <mach/irqs.h>
 
 #define OMAP1_MPUIO_BASE			0xfffb5000
@@ -71,6 +72,23 @@
 				 IH_MPUIO_BASE + ((nr) & 0x0f) : \
 				 IH_GPIO_BASE + (nr))
 
+#define METHOD_MPUIO		0
+#define METHOD_GPIO_1510	1
+#define METHOD_GPIO_1610	2
+#define METHOD_GPIO_7XX		3
+#define METHOD_GPIO_24XX	5
+#define METHOD_GPIO_44XX	6
+
+struct omap_gpio_platform_data {
+	u16 virtual_irq_start;
+	int bank_type;
+	int bank_width;		/* GPIO bank width */
+	bool dbck_flag;		/* dbck required or not - True for OMAP3&4 */
+};
+
+/* TODO: Analyze removing gpio_bank_count usage from driver code */
+extern int gpio_bank_count;
+
 extern int omap_gpio_init(void);	/* Call from board init only */
 extern void omap2_gpio_prepare_for_idle(int power_state);
 extern void omap2_gpio_resume_after_idle(void);
-- 
1.7.0.4

