From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 2/4] power_supply: bq27200: separate bq27200-specific driver
Date: Sat, 18 Oct 2008 00:00:46 +0300
Message-ID: <1224277248-17021-3-git-send-email-felipe.balbi@nokia.com>
References: <1224277248-17021-1-git-send-email-felipe.balbi@nokia.com>
 <1224277248-17021-2-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:45688 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440AbYJQVBc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 17:01:32 -0400
In-Reply-To: <1224277248-17021-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Anton Vorontsov <cbou@mail.ru>, David Woodhouse <dwmw2@infradead.org>, Felipe Balbi <felipe.balbi@nokia.com>

Create a separate driver for bq27200 chip. On a later patch,
the old file and cold will be remove and Makefile/Kconfig
updated.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/power/bq27200.c |  202 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 202 insertions(+), 0 deletions(-)
 create mode 100644 drivers/power/bq27200.c

diff --git a/drivers/power/bq27200.c b/drivers/power/bq27200.c
new file mode 100644
index 0000000..ef03743
--- /dev/null
+++ b/drivers/power/bq27200.c
@@ -0,0 +1,202 @@
+/*
+ * bq27200.c - BQ27200 battery driver
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
+#include <linux/module.h>
+#include <linux/param.h>
+#include <linux/jiffies.h>
+#include <linux/workqueue.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/i2c.h>
+
+#include "bq27x00.h"
+
+static struct i2c_client *bq_client;
+
+static inline int bq27200_read(u8 reg, int *rt_value, int b_single,
+	struct bq27x00_device_info *di)
+{
+	struct i2c_client *client = bq_client;
+	struct i2c_msg msg[1];
+	unsigned char data[2];
+	int err;
+
+	if (!client->adapter)
+		return -ENODEV;
+
+	msg->addr = client->addr;
+	msg->flags = 0;
+	msg->len = 1;
+	msg->buf = data;
+
+	data[0] = reg;
+	err = i2c_transfer(client->adapter, msg, 1);
+
+	if (err >= 0) {
+		if (!b_single)
+			msg->len = 2;
+		else
+			msg->len = 1;
+
+		msg->flags = I2C_M_RD;
+		err = i2c_transfer(client->adapter, msg, 1);
+		if (err >= 0) {
+			if (!b_single)
+				*rt_value = data[1] | HIGH_BYTE(data[0]);
+			else
+				*rt_value = data[0];
+
+			return 0;
+		} else {
+			dev_dbg(di->dev, "read failed with status %d\n", err);
+			return err;
+		}
+	} else {
+		dev_dbg(di->dev, "write failed with status %d\n", err);
+		return err;
+	}
+}
+
+static void bq27200_work(struct work_struct *work)
+{
+	struct bq27x00_device_info *di = container_of(work,
+		struct bq27x00_device_info, monitor_work.work);
+
+	bq27x00_read_status(di);
+	schedule_delayed_work(&di->monitor_work, 100);
+}
+
+static int __init bq27200_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	struct bq27x00_device_info *di;
+	struct bq27x00_access_methods *bus;
+	int retval = 0;
+
+	di = kzalloc(sizeof(*di), GFP_KERNEL);
+	if (!di) {
+		dev_dbg(&client->dev, "could not allocate dev info's memory\n");
+		retval = -ENOMEM;
+		goto err_di;
+	}
+
+	bus = kzalloc(sizeof(*bus), GFP_KERNEL);
+	if (!bus) {
+		dev_dbg(&client->dev, "could not allocate bus' memory\n");
+		retval = -ENOMEM;
+		goto err_bus;
+	}
+
+	i2c_set_clientdata(client, di);
+	di->dev = &client->dev;
+	di->bat.name = "bq27200";
+	bus->read = &bq27200_read;
+	di->bus = bus;
+	bq_client = client;
+
+	bq27x00_powersupply_init(di);
+
+	retval = power_supply_register(&client->dev, &di->bat);
+	if (retval) {
+		dev_dbg(&client->dev, "could not register power_supply, %d\n",
+				retval);
+		goto err_psy;
+	}
+
+	INIT_DELAYED_WORK(&di->monitor_work, bq27200_work);
+	schedule_delayed_work(&di->monitor_work, 100);
+
+	return 0;
+
+err_psy:
+	i2c_set_clientdata(client, NULL);
+	kfree(bus);
+
+err_bus:
+	kfree(di);
+
+err_di:
+	return retval;
+}
+
+static int __exit bq27200_remove(struct i2c_client *client)
+{
+	struct bq27x00_device_info *di  = i2c_get_clientdata(client);
+
+	flush_scheduled_work();
+	power_supply_unregister(&di->bat);
+	kfree(di->bus);
+	kfree(di);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int bq27200_suspend(struct i2c_client *client, pm_message_t mesg)
+{
+	struct bq27x00_device_info *di  = i2c_get_clientdata(client);
+
+	cancel_delayed_work(&di->monitor_work);
+	return 0;
+}
+
+static int bq27200_resume(struct i2c_client *client)
+{
+	struct bq27x00_device_info *di  = i2c_get_clientdata(client);
+
+	schedule_delayed_work(&di->monitor_work, 0);
+	return 0;
+}
+#else
+#define bq27200_suspend	NULL
+#define bq27200_resume	NULL
+#endif /* CONFIG_PM */
+
+static const struct i2c_device_id bq27200_id[] = {
+	{ "bq27200", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, bq27200_id);
+
+static struct i2c_driver bq27200_driver = {
+	.driver		= {
+		.name   = "bq27200",
+	},
+	.probe		= bq27200_probe,
+	.remove		= __exit_p(bq27200_remove),
+	.suspend	= bq27200_suspend,
+	.resume		= bq27200_resume,
+	.id_table	= bq27200_id,
+};
+
+static int __init bq27200_init(void)
+{
+	return i2c_add_driver(&bq27200_driver);
+}
+module_init(bq27200_init);
+
+static void __exit bq27200_exit(void)
+{
+	i2c_del_driver(&bq27200_driver);
+}
+module_exit(bq27200_exit);
+
+MODULE_AUTHOR("Texas Instruments");
+MODULE_DESCRIPTION("BQ27200 battery moniter driver");
+MODULE_LICENSE("GPL");
+
-- 
1.6.0.2.307.gc427

