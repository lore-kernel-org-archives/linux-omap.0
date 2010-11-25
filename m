From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH v8 09/11] OMAP2+: GPIO: device registration
Date: Thu, 25 Nov 2010 18:18:36 +0530
Message-ID: <1290689318-10191-10-git-send-email-charu@ti.com>
References: <1290689318-10191-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49456 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753245Ab0KYMtA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Nov 2010 07:49:00 -0500
In-Reply-To: <1290689318-10191-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, p-basak2@ti.com, "Varadarajan, Charulatha" <charu@ti.com>

Use omap_device_build() API to do platform_device_register of
GPIO devices. For OMAP2+ chips, the device specific data defined
in the centralized hwmod database will be used.

gpio_init needs to be done before machine_init functions access
gpio APIs. Hence gpio_init is made as a postcore_initcall.

Signed-off-by: Charulatha V <charu@ti.com>
Acked-by: Benoit Cousson <b-cousson@ti.com>
Reviewed-by: Basak, Partha <p-basak2@ti.com>
---
 arch/arm/mach-omap2/gpio.c |  104 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 104 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/gpio.c

diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
new file mode 100644
index 0000000..413de18
--- /dev/null
+++ b/arch/arm/mach-omap2/gpio.c
@@ -0,0 +1,104 @@
+/*
+ * OMAP2+ specific gpio initialization
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
+static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
+{
+	struct omap_device *od;
+	struct omap_gpio_platform_data *pdata;
+	struct omap_gpio_dev_attr *dev_attr;
+	char *name = "omap_gpio";
+	int id;
+
+	/*
+	 * extract the device id from name field available in the
+	 * hwmod database and use the same for constructing ids for
+	 * gpio devices.
+	 * CAUTION: Make sure the name in the hwmod database does
+	 * not change. If changed, make corresponding change here
+	 * or make use of static variable mechanism to handle this.
+	 */
+	sscanf(oh->name, "gpio%d", &id);
+
+	pdata = kzalloc(sizeof(struct omap_gpio_platform_data), GFP_KERNEL);
+	if (!pdata) {
+		pr_err("gpio%d: Memory allocation failed\n", id);
+		return -ENOMEM;
+	}
+
+	dev_attr = (struct omap_gpio_dev_attr *)oh->dev_attr;
+	pdata->bank_width = dev_attr->bank_width;
+	pdata->dbck_flag = dev_attr->dbck_flag;
+	pdata->virtual_irq_start = IH_GPIO_BASE + 32 * (id - 1);
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
+		kfree(pdata);
+		return -EINVAL;
+	}
+
+	od = omap_device_build(name, id - 1, oh, pdata,
+				sizeof(*pdata),	omap_gpio_latency,
+				ARRAY_SIZE(omap_gpio_latency),
+				false);
+	kfree(pdata);
+
+	if (IS_ERR(od)) {
+		WARN(1, "Cant build omap_device for %s:%s.\n",
+					name, oh->name);
+		return PTR_ERR(od);
+	}
+
+	gpio_bank_count++;
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
+	return omap_hwmod_for_each_by_class("gpio", omap2_gpio_dev_init,
+						NULL);
+}
+postcore_initcall(omap2_gpio_init);
-- 
1.7.0.4

