From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH v6 09/13] OMAP2PLUS: GPIO: use omap_device_build for device registration
Date: Sat, 18 Sep 2010 19:45:49 +0530
Message-ID: <1284819353-8512-10-git-send-email-charu@ti.com>
References: <1284819353-8512-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56366 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755461Ab0IROQR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 18 Sep 2010 10:16:17 -0400
In-Reply-To: <1284819353-8512-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, "Varadarajan, Charulatha" <charu@ti.com>

Use omap_device_build() API instead of platform_device_register for
GPIO device registration. For OMAP2PLUS chips, the device specific
data defined in centralized hwmod database will be used.

gpio_init needs to be done before machine_init functions access
gpio APIs. Hence gpio_init is made as a postcore_initcall.

Signed-off-by: Charulatha V <charu@ti.com>
Reviewed-by: Basak, Partha <p-basak2@ti.com>
---
 arch/arm/mach-omap2/gpio.c |   92 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 92 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/gpio.c

diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
new file mode 100644
index 0000000..e759311
--- /dev/null
+++ b/arch/arm/mach-omap2/gpio.c
@@ -0,0 +1,92 @@
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
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+
+#include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
+
+static struct omap_device_pm_latency omap_gpio_latency[] = {
+	[0] = {
+		.deactivate_func = omap_device_idle_hwmods,
+		.activate_func   = omap_device_enable_hwmods,
+		.flags		 = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+};
+
+static int omap2_init_gpio(struct omap_hwmod *oh, void *user)
+{
+	struct omap_device *od;
+	struct omap_gpio_platform_data *pdata;
+	char *name = "omap-gpio";
+	struct omap_gpio_dev_attr *gpio_dev_data;
+
+	if (!oh) {
+		pr_err("Could not look up omap gpio %d\n",
+				gpio_bank_count + 1);
+		return -EINVAL;
+	}
+
+	pdata = kzalloc(sizeof(struct omap_gpio_platform_data),
+					GFP_KERNEL);
+	if (!pdata) {
+		pr_err("Memory allocation failed gpio%d\n",
+				gpio_bank_count + 1);
+		return -ENOMEM;
+	}
+
+	gpio_dev_data = (struct omap_gpio_dev_attr *)oh->dev_attr;
+
+	pdata->gpio_attr = gpio_dev_data;
+	pdata->virtual_irq_start = IH_GPIO_BASE + 32 * gpio_bank_count;
+	pdata->pwrdm = omap_hwmod_get_pwrdm(oh);
+
+	switch (oh->class->rev) {
+	case 0:
+	case 1:
+		pdata->bank_type = METHOD_GPIO_24XX;
+		break;
+	case 2:
+		pdata->bank_type = METHOD_GPIO_44XX;
+		break;
+	default:
+		WARN(1, "Invalid gpio bank_type\n");
+		break;
+	}
+
+	od = omap_device_build(name, gpio_bank_count, oh, pdata,
+				sizeof(*pdata),	omap_gpio_latency,
+				ARRAY_SIZE(omap_gpio_latency),
+				false);
+	WARN(IS_ERR(od), "Cant build omap_device for %s:%s.\n",
+				name, oh->name);
+	gpio_bank_count++;
+
+	kfree(pdata);
+	return 0;
+}
+
+/*
+ * gpio_init needs to be done before
+ * machine_init functions access gpio APIs.
+ * Hence gpio_init is a postcore_initcall.
+ */
+static int __init omap2_gpio_init(void)
+{
+	return omap_hwmod_for_each_by_class("gpio", omap2_init_gpio,
+						NULL);
+}
+postcore_initcall(omap2_gpio_init);
-- 
1.7.0.4

