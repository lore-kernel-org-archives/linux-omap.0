From: Charulatha V <charu@ti.com>
Subject: [PATCH 09/11] OMAP: GPIO: Introduce support for OMAP2PLUS chip GPIO init
Date: Tue, 18 May 2010 20:20:58 +0530
Message-ID: <1274194260-16401-10-git-send-email-charu@ti.com>
References: <1274194260-16401-1-git-send-email-charu@ti.com>
 <1274194260-16401-2-git-send-email-charu@ti.com>
 <1274194260-16401-3-git-send-email-charu@ti.com>
 <1274194260-16401-4-git-send-email-charu@ti.com>
 <1274194260-16401-5-git-send-email-charu@ti.com>
 <1274194260-16401-6-git-send-email-charu@ti.com>
 <1274194260-16401-7-git-send-email-charu@ti.com>
 <1274194260-16401-8-git-send-email-charu@ti.com>
 <1274194260-16401-9-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52280 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757243Ab0EROtx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 10:49:53 -0400
In-Reply-To: <1274194260-16401-9-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: rnayak@ti.com, paul@pwsan.com, tony@atomide.com, khilman@deeprootsystems.com, Charulatha V <charu@ti.com>

This patch adds support for handling GPIO as a HWMOD FW adapted
platform device for OMAP2PLUS chips.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap2/gpio.c |  113 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 113 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/gpio.c

diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
new file mode 100644
index 0000000..bc339ef
--- /dev/null
+++ b/arch/arm/mach-omap2/gpio.c
@@ -0,0 +1,113 @@
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
+	static int id;
+	struct omap_gpio_dev_attr *gpio_dev_data;
+
+	if (!oh)
+		pr_err("Could not look up omap gpio %d\n", id + 1);
+
+	pdata = kzalloc(sizeof(struct omap_gpio_platform_data),
+					GFP_KERNEL);
+	if (!pdata) {
+		pr_err("Memory allocation failed gpio%d\n", id + 1);
+		return -ENOMEM;
+	}
+
+	gpio_dev_data = (struct omap_gpio_dev_attr *)oh->dev_attr;
+	pdata->gpio_attr = gpio_dev_data;
+	pdata->method = (int)user;
+	pdata->virtual_irq_start = IH_GPIO_BASE + 32 * id;
+
+	od = omap_device_build(name, id, oh, pdata,
+				sizeof(*pdata),	omap_gpio_latency,
+				ARRAY_SIZE(omap_gpio_latency),
+				false);
+	WARN(IS_ERR(od), "Cant build omap_device for %s:%s.\n",
+				name, oh->name);
+
+	id++;
+	return 0;
+}
+
+static int __init gpio_init(int method)
+{
+	return omap_hwmod_for_each_by_class("gpio", omap2_init_gpio,
+						(void *)method);
+}
+
+/*
+ * gpio_init needs to be done before
+ * machine_init functions access gpio APIs.
+ * Hence gpio_init is a postcore_initcall.
+ */
+#ifdef CONFIG_ARCH_OMAP2
+static int __init omap242x_gpio_init(void)
+{	if (!cpu_is_omap2420())
+		return -EINVAL;
+
+	return gpio_init(METHOD_GPIO_24XX);
+}
+postcore_initcall(omap242x_gpio_init);
+
+static int __init omap243x_gpio_init(void)
+{
+	if (!cpu_is_omap2430())
+		return -EINVAL;
+
+	return gpio_init(METHOD_GPIO_24XX);
+}
+postcore_initcall(omap243x_gpio_init);
+#endif
+
+#ifdef CONFIG_ARCH_OMAP3
+static int __init omap3xxx_gpio_init(void)
+{
+	if (!cpu_is_omap34xx())
+		return -EINVAL;
+
+	return gpio_init(METHOD_GPIO_24XX);
+}
+postcore_initcall(omap3xxx_gpio_init);
+#endif
+
+#ifdef CONFIG_ARCH_OMAP4
+static int __init omap44xx_gpio_init(void)
+{
+	if (!cpu_is_omap44xx())
+		return -EINVAL;
+
+	return gpio_init(METHOD_GPIO_44XX);
+}
+postcore_initcall(omap44xx_gpio_init);
+#endif
-- 
1.6.3.3

