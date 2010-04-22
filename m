From: Charulatha V <charu@ti.com>
Subject: [PATCH 5/9] OMAP:GPIO: Introduce support for OMAP2PLUS chip specific GPIO
Date: Thu, 22 Apr 2010 21:25:16 +0530
Message-ID: <1271951720-21714-6-git-send-email-charu@ti.com>
References: <1271951720-21714-1-git-send-email-charu@ti.com>
 <1271951720-21714-2-git-send-email-charu@ti.com>
 <1271951720-21714-3-git-send-email-charu@ti.com>
 <1271951720-21714-4-git-send-email-charu@ti.com>
 <1271951720-21714-5-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34486 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755885Ab0DVPzJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Apr 2010 11:55:09 -0400
In-Reply-To: <1271951720-21714-5-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: rnayak@ti.com, paul@pwsan.com, tony@atomide.com, khilman@deeprootsystems.com, Charulatha V <charu@ti.com>

This patch adds support for handling GPIO as a HWMOD adapted
platform device for OMAP2PLUS chips.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap2/gpio.c |  101 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 101 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/gpio.c

diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
new file mode 100644
index 0000000..6424050
--- /dev/null
+++ b/arch/arm/mach-omap2/gpio.c
@@ -0,0 +1,101 @@
+/*
+ * gpio.c - OMAP2PLUS-specific gpio code
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
+#include <linux/err.h>
+#include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
+
+static int gpio_bank_count;
+
+struct omap_device_pm_latency omap_gpio_latency[] = {
+	[0] = {
+		.deactivate_func = omap_device_idle_hwmods,
+		.activate_func   = omap_device_enable_hwmods,
+		.flags		 = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+};
+
+int __init gpio_init(void)
+{
+	int i = 0;
+	static int is_early_device = true;
+
+	do {
+		struct omap_device *od;
+		struct omap_hwmod *oh;
+		int hw_mod_name_len = 16;
+		int l;
+		char oh_name[hw_mod_name_len];
+		struct omap_gpio_platform_data *pdata;
+		char *name = "omap-gpio";
+
+		l = snprintf(oh_name, hw_mod_name_len, "gpio%d_hwmod", i + 1);
+		WARN(l >= hw_mod_name_len,
+			"String buffer overflow in GPIO device setup\n");
+
+		oh = omap_hwmod_lookup(oh_name);
+		if (!oh) {
+			pr_err("Could not look up %s\n", oh_name);
+			i++;
+			continue;
+		}
+
+		pdata = kzalloc(sizeof(struct omap_gpio_platform_data),
+					GFP_KERNEL);
+		if (!pdata) {
+			pr_err("Memory allocation failed gpio%d\n", i + 1);
+			return -ENOMEM;
+		}
+		pdata->base = oh->_rt_va;
+		pdata->irq = oh->mpu_irqs[0].irq;
+		if (cpu_is_omap24xx() || cpu_is_omap34xx())
+			pdata->method = METHOD_GPIO_24XX;
+		if (cpu_is_omap44xx())
+			pdata->method = METHOD_GPIO_44XX;
+		pdata->virtual_irq_start = IH_GPIO_BASE + 32 * i;
+		pdata->device_enable = omap_device_enable;
+		pdata->device_idle = omap_device_idle;
+		pdata->device_shutdown = omap_device_shutdown;
+
+		od = omap_device_build(name, i, oh, pdata,
+					sizeof(*pdata),	omap_gpio_latency,
+					ARRAY_SIZE(omap_gpio_latency),
+					is_early_device);
+		WARN(IS_ERR(od), "Cant build omap_device for %s:%s.\n",
+					name, oh->name);
+
+		i++;
+	} while (i < gpio_bank_count);
+	is_early_device = false;
+
+	return 0;
+}
+arch_initcall(gpio_init);
+
+int __init omap2_gpio_init(void)
+{
+	if (cpu_is_omap242x())
+		gpio_bank_count = 4;
+	else if (cpu_is_omap243x())
+		gpio_bank_count = 5;
+	else if (cpu_is_omap34xx() || cpu_is_omap44xx())
+		gpio_bank_count = OMAP34XX_NR_GPIOS;
+
+	if (gpio_init())
+		return -EINVAL;
+
+	early_platform_driver_register_all("earlygpio");
+	early_platform_driver_probe("earlygpio", gpio_bank_count, 0);
+	return 0;
+}
-- 
1.6.3.3

