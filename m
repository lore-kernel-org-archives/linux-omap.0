From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 3/4] power_supply: bq27200: separate bq27000-specific driver
Date: Sat, 18 Oct 2008 00:00:47 +0300
Message-ID: <1224277248-17021-4-git-send-email-felipe.balbi@nokia.com>
References: <1224277248-17021-1-git-send-email-felipe.balbi@nokia.com>
 <1224277248-17021-2-git-send-email-felipe.balbi@nokia.com>
 <1224277248-17021-3-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:45693 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753520AbYJQVBe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 17:01:34 -0400
In-Reply-To: <1224277248-17021-3-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Anton Vorontsov <cbou@mail.ru>, David Woodhouse <dwmw2@infradead.org>, Felipe Balbi <felipe.balbi@nokia.com>

Create a separate driver for bq27000 chip. On a later patch,
the old file and cold will be remove and Makefile/Kconfig
updated

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/power/bq27000.c |  173 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 173 insertions(+), 0 deletions(-)
 create mode 100644 drivers/power/bq27000.c

diff --git a/drivers/power/bq27000.c b/drivers/power/bq27000.c
new file mode 100644
index 0000000..35a6b67
--- /dev/null
+++ b/drivers/power/bq27000.c
@@ -0,0 +1,173 @@
+/*
+ * bq27000.c - BQ27000 battery driver
+ *
+ * Copyright (C) 2008 Texas Instruments, Inc.
+ * Copyright (C) 2008 Nokia Corporation
+ *
+ * Author: Texas Instruments
+ *
+ * This package is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/param.h>
+#include <linux/jiffies.h>
+#include <linux/workqueue.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+
+#include "../w1/w1.h"
+#include "bq27x00.h"
+
+static struct device *w1_dev;
+
+extern int w1_bq27000_read(struct device *dev, u8 reg);
+
+static inline int bq27000_read(u8 reg, int *rt_value, int b_single,
+	struct bq27x00_device_info *di)
+{
+	u8 val;
+
+	val = w1_bq27000_read(w1_dev, reg);
+	*rt_value = val;
+
+	if (!b_single) {
+		val = 0;
+		val = w1_bq27000_read(w1_dev, reg + 1);
+		*rt_value +=  HIGH_BYTE((int) val);
+	}
+
+	return 0;
+}
+
+static void bq27000_work(struct work_struct *work)
+{
+	struct bq27x00_device_info *di = container_of(work,
+		struct bq27x00_device_info, monitor_work.work);
+
+	bq27x00_read_status(di);
+	schedule_delayed_work(&di->monitor_work, 100);
+}
+
+static int __init bq27000_probe(struct  platform_device *pdev)
+{
+	struct bq27x00_device_info *di;
+	struct bq27x00_access_methods *bus;
+	int retval = 0;
+
+	di = kzalloc(sizeof(*di), GFP_KERNEL);
+	if (!di) {
+		dev_dbg(&pdev->dev, "could not allocate dev info's memory\n");
+		retval = -ENOMEM;
+		goto err_di;
+	}
+
+	bus = kzalloc(sizeof(*bus), GFP_KERNEL);
+	if (!bus) {
+		dev_dbg(&pdev->dev, "could not allocate bus' memory\n");
+		retval = -ENOMEM;
+		goto err_bus;
+	}
+
+	platform_set_drvdata(pdev, di);
+
+	w1_dev = pdev->dev.parent;
+	di->dev = &pdev->dev;
+	di->bat.name = "bq27000";
+	bus->read = &bq27000_read;
+	di->bus = bus;
+
+	bq27x00_powersupply_init(di);
+
+	retval = power_supply_register(&pdev->dev, &di->bat);
+	if (retval) {
+		dev_dbg(&pdev->dev, "could not register power_supply, %d\n",
+				retval);
+		goto err_psy;
+	}
+
+	INIT_DELAYED_WORK(&di->monitor_work, bq27000_work);
+	schedule_delayed_work(&di->monitor_work, 50);
+
+	return 0;
+
+err_psy:
+	platform_set_drvdata(pdev, NULL);
+	kfree(bus);
+
+err_bus:
+	kfree(di);
+
+err_di:
+	return retval;
+}
+
+static int __exit bq27000_remove(struct  platform_device *pdev)
+{
+	struct bq27x00_device_info *di = platform_get_drvdata(pdev);
+
+	flush_scheduled_work();
+	power_supply_unregister(&di->bat);
+	platform_set_drvdata(pdev, NULL);
+	kfree(di->bus);
+	kfree(di);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int bq27000_suspend(struct platform_device *pdev,
+	pm_message_t state)
+{
+	struct bq27x00_device_info *di = platform_get_drvdata(pdev);
+
+	cancel_delayed_work(&di->monitor_work);
+	return 0;
+}
+
+static int bq27000_resume(struct platform_device *pdev)
+{
+	struct bq27x00_device_info *di = platform_get_drvdata(pdev);
+
+	schedule_delayed_work(&di->monitor_work, 0);
+	return 0;
+}
+#else
+#define bq27000_suspend	NULL
+#define bq27000_resume	NULL
+#endif /* CONFIG_PM */
+
+static struct platform_driver bq27000_driver = {
+	.driver		= {
+		.name	= "bq27000",
+	},
+	.probe		= bq27000_probe,
+	.remove		= __exit_p(bq27000_remove),
+	.suspend	= bq27000_suspend,
+	.resume		= bq27000_resume,
+};
+
+static int __init bq27x00_init(void)
+{
+	return platform_driver_register(&bq27000_driver);
+}
+module_init(bq27x00_init);
+
+static void __exit bq27x00_exit(void)
+{
+	platform_driver_unregister(&bq27000_driver);
+}
+module_exit(bq27x00_exit);
+
+MODULE_AUTHOR("Texas Instruments");
+MODULE_DESCRIPTION("BQ27000 battery moniter driver");
+MODULE_LICENSE("GPL");
+
-- 
1.6.0.2.307.gc427

