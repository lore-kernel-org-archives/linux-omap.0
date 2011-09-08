From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv7 1/9] power: add omap prm driver skeleton
Date: Thu, 8 Sep 2011 18:22:16 +0300
Message-ID: <1315495344-23133-2-git-send-email-t-kristo@ti.com>
References: <1315495344-23133-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47217 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753457Ab1IHPWf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Sep 2011 11:22:35 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <1315495344-23133-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, paul@pwsan.com, govindraj.raja@ti.com

This driver will eventually support OMAP soc PRM module features, e.g. PRCM
chain interrupts.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/power/Kconfig    |    7 ++++
 drivers/power/Makefile   |    1 +
 drivers/power/omap_prm.c |   83 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+), 0 deletions(-)
 create mode 100644 drivers/power/omap_prm.c

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 57de051..e735a95 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -249,4 +249,11 @@ config CHARGER_MAX8998
 	  Say Y to enable support for the battery charger control sysfs and
 	  platform data of MAX8998/LP3974 PMICs.
 
+config OMAP_PRM
+	bool "OMAP Power and Reset Management driver"
+	depends on (ARCH_OMAP) && PM
+	help
+	  Say Y to enable support for the OMAP Power and Reset Management
+	  driver.
+
 endif # POWER_SUPPLY
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index b4af13d..8df93c2 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_WM831X_BACKUP)	+= wm831x_backup.o
 obj-$(CONFIG_WM831X_POWER)	+= wm831x_power.o
 obj-$(CONFIG_WM8350_POWER)	+= wm8350_power.o
 obj-$(CONFIG_TEST_POWER)	+= test_power.o
+obj-$(CONFIG_OMAP_PRM)		+= omap_prm.o
 
 obj-$(CONFIG_BATTERY_DS2760)	+= ds2760_battery.o
 obj-$(CONFIG_BATTERY_DS2780)	+= ds2780_battery.o
diff --git a/drivers/power/omap_prm.c b/drivers/power/omap_prm.c
new file mode 100644
index 0000000..dfc0920
--- /dev/null
+++ b/drivers/power/omap_prm.c
@@ -0,0 +1,83 @@
+/*
+ * OMAP Power and Reset Management (PRM) driver
+ *
+ * Copyright (C) 2011 Texas Instruments, Inc.
+ *
+ * Author: Tero Kristo <t-kristo@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/ctype.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+
+#define DRIVER_NAME "omap-prm"
+
+struct omap_prm_device {
+	struct platform_device		pdev;
+};
+
+static struct omap_prm_device prm_dev = {
+	.pdev		= {
+		.name	= DRIVER_NAME,
+		.id	= -1,
+	},
+};
+
+static int __init omap_prm_probe(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int __devexit omap_prm_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver prm_driver = {
+	.remove		= __exit_p(omap_prm_remove),
+	.driver		= {
+		.name	= DRIVER_NAME,
+	},
+};
+
+static int __init omap_prm_init(void)
+{
+	int ret;
+
+	ret = platform_device_register(&prm_dev.pdev);
+
+	if (ret) {
+		printk(KERN_ERR "Unable to register PRM device: %d\n", ret);
+		return ret;
+	}
+
+	ret = platform_driver_probe(&prm_driver, omap_prm_probe);
+
+	if (ret)
+		printk(KERN_ERR "PRM driver probe failed: %d\n", ret);
+
+	return ret;
+}
+subsys_initcall(omap_prm_init);
+
+static void __exit omap_prm_exit(void)
+{
+	platform_device_unregister(&prm_dev.pdev);
+	platform_driver_unregister(&prm_driver);
+}
+module_exit(omap_prm_exit);
+
+MODULE_ALIAS("platform:"DRIVER_NAME);
+MODULE_AUTHOR("Tero Kristo <t-kristo@ti.com>");
+MODULE_DESCRIPTION("OMAP PRM driver");
+MODULE_LICENSE("GPL");
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

