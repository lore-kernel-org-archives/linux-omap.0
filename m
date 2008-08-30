From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 04/33] add omap gpio expander driver
Date: Sat, 30 Aug 2008 20:16:04 +0300
Message-ID: <1220116593-862-5-git-send-email-me@felipebalbi.com>
References: <1220116593-862-1-git-send-email-me@felipebalbi.com>
 <1220116593-862-2-git-send-email-me@felipebalbi.com>
 <1220116593-862-3-git-send-email-me@felipebalbi.com>
 <1220116593-862-4-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:43810 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914AbYH3RRa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Aug 2008 13:17:30 -0400
In-Reply-To: <1220116593-862-4-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/Kconfig              |    7 +++
 drivers/i2c/chips/Makefile             |    1 +
 drivers/i2c/chips/gpio_expander_omap.c |   71 ++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+), 0 deletions(-)
 create mode 100644 drivers/i2c/chips/gpio_expander_omap.c

diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index 193c3ae..a6269c0 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -137,6 +137,13 @@ config TPS65010
 	  This driver can also be built as a module.  If so, the module
 	  will be called tps65010.
 
+config GPIOEXPANDER_OMAP
+	bool "GPIO Expander PCF8574PWR for OMAP"
+	depends on I2C && (ARCH_OMAP16XX || ARCH_OMAP24XX)
+	help
+	  If you say yes here you get support for I/O expander calls
+	  to configure IrDA, Camera and audio devices.
+
 config SENSORS_MAX6875
 	tristate "Maxim MAX6875 Power supply supervisor"
 	depends on EXPERIMENTAL
diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
index 987f600..616b3f9 100644
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_PCF8575)		+= pcf8575.o
 obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
 obj-$(CONFIG_ISP1301_OMAP)	+= isp1301_omap.o
 obj-$(CONFIG_TPS65010)		+= tps65010.o
+obj-$(CONFIG_GPIOEXPANDER_OMAP)	+= gpio_expander_omap.o
 obj-$(CONFIG_MENELAUS)		+= menelaus.o
 obj-$(CONFIG_SENSORS_TSL2550)	+= tsl2550.o
 obj-$(CONFIG_LP5521)		+= lp5521.o
diff --git a/drivers/i2c/chips/gpio_expander_omap.c b/drivers/i2c/chips/gpio_expander_omap.c
new file mode 100644
index 0000000..dfe7f04
--- /dev/null
+++ b/drivers/i2c/chips/gpio_expander_omap.c
@@ -0,0 +1,71 @@
+/*
+ * drivers/i2c/chips/gpio_expander_omap.c
+ *
+ * Copyright (C) 2004 Texas Instruments Inc
+ * Author:
+ *
+ * gpio expander is used to configure IrDA, camera and audio devices on omap 1710 processor.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/i2c.h>
+#include <linux/errno.h>
+
+int read_gpio_expa(u8 * val, int addr);
+int write_gpio_expa(u8 val, int addr);
+
+int write_gpio_expa(u8 val, int addr)
+{
+	struct i2c_adapter *adap;
+	int err;
+	struct i2c_msg msg[1];
+	unsigned char data[1];
+
+	adap = i2c_get_adapter(1);
+	if (!adap)
+		return -ENODEV;
+	msg->addr = addr;	/* I2C address of GPIO EXPA */
+	msg->flags = 0;
+	msg->len = 1;
+	msg->buf = data;
+	data[0] = val;
+	err = i2c_transfer(adap, msg, 1);
+	if (err >= 0)
+		return 0;
+	return err;
+}
+
+/* Read from I/O EXPANDER on the H3 board.
+ * The IO expanders need an independent I2C client driver.
+ */
+
+int read_gpio_expa(u8 * val, int addr)
+{
+	struct i2c_adapter *adap;
+	int err;
+	struct i2c_msg msg[1];
+	unsigned char data[1];
+
+	adap = i2c_get_adapter(1);
+	if (!adap)
+		return -ENODEV;
+	msg->addr = addr;	/* I2C address of GPIO EXPA */
+	msg->flags = I2C_M_RD;
+	msg->len = 2;
+	msg->buf = data;
+	err = i2c_transfer(adap, msg, 1);
+	*val = data[0];
+
+	if (err >= 0)
+		return 0;
+	return err;
+}
+
+EXPORT_SYMBOL(read_gpio_expa);
+EXPORT_SYMBOL(write_gpio_expa);
+
-- 
1.6.0.1.141.g445ca

