From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 6/8] tsl2563: move tsl2563 to drivers/hwmon
Date: Tue, 14 Oct 2008 16:01:38 +0300
Message-ID: <1223989300-27294-7-git-send-email-felipe.balbi@nokia.com>
References: <1223989300-27294-1-git-send-email-felipe.balbi@nokia.com>
 <1223989300-27294-2-git-send-email-felipe.balbi@nokia.com>
 <1223989300-27294-3-git-send-email-felipe.balbi@nokia.com>
 <1223989300-27294-4-git-send-email-felipe.balbi@nokia.com>
 <1223989300-27294-5-git-send-email-felipe.balbi@nokia.com>
 <1223989300-27294-6-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:48409 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755513AbYJNNCa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 09:02:30 -0400
In-Reply-To: <1223989300-27294-6-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>, Jean Delvare <khali@linux-fr.org>

Moving the driver to where it should sit. No functional
changes.

Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/hwmon/Kconfig                  |   10 ++++++++++
 drivers/hwmon/Makefile                 |    1 +
 drivers/{i2c/chips => hwmon}/tsl2563.c |    2 +-
 drivers/i2c/chips/Kconfig              |   10 ----------
 drivers/i2c/chips/Makefile             |    1 -
 5 files changed, 12 insertions(+), 12 deletions(-)
 rename drivers/{i2c/chips => hwmon}/tsl2563.c (99%)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 390c6fa..dabc148 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -670,6 +670,16 @@ config SENSORS_THMC50
 	  This driver can also be built as a module.  If so, the module
 	  will be called thmc50.
 
+config SENSORS_TSL2563
+       tristate "Taos TSL2563 ambient light sensor"
+       depends on I2C && HWMON
+       help
+         If you say yes here you get support for the Taos TSL2563
+         ambient light sensor.
+
+         This driver can also be built as a module.  If so, the module
+         will be called tsl2563.
+
 config SENSORS_VIA686A
 	tristate "VIA686A"
 	depends on PCI
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 2580d5d..28990a5 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_SENSORS_SMSC47B397)+= smsc47b397.o
 obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
 obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
 obj-$(CONFIG_SENSORS_THMC50)	+= thmc50.o
+obj-$(CONFIG_SENSORS_TSL2563)	+= tsl2563.o
 obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
 obj-$(CONFIG_SENSORS_VT1211)	+= vt1211.o
 obj-$(CONFIG_SENSORS_VT8231)	+= vt8231.o
diff --git a/drivers/i2c/chips/tsl2563.c b/drivers/hwmon/tsl2563.c
similarity index 99%
rename from drivers/i2c/chips/tsl2563.c
rename to drivers/hwmon/tsl2563.c
index e05b880..afc3265 100644
--- a/drivers/i2c/chips/tsl2563.c
+++ b/drivers/hwmon/tsl2563.c
@@ -1,5 +1,5 @@
 /*
- * drivers/i2c/chips/tsl2563.c
+ * tsl2563.c - TSL2563 Ambient Light Sensor
  *
  * Copyright (C) 2008 Nokia Corporation
  *
diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index 0aed293..d1ad80b 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -209,16 +209,6 @@ config SENSORS_TSL2550
 	  This driver can also be built as a module.  If so, the module
 	  will be called tsl2550.
 
-config SENSORS_TSL2563
-       tristate "Taos TSL2563 ambient light sensor"
-       depends on I2C && HWMON
-       help
-         If you say yes here you get support for the Taos TSL2563
-         ambient light sensor.
-
-         This driver can also be built as a module.  If so, the module
-         will be called tsl2563.
-
 config MENELAUS
 	bool "TWL92330/Menelaus PM chip"
 	depends on I2C=y && ARCH_OMAP24XX
diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
index 5e17df3..919013c 100644
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -23,7 +23,6 @@ obj-$(CONFIG_SENSORS_TLV320AIC23) += tlv320aic23.o
 obj-$(CONFIG_GPIOEXPANDER_OMAP)	+= gpio_expander_omap.o
 obj-$(CONFIG_MENELAUS)		+= menelaus.o
 obj-$(CONFIG_SENSORS_TSL2550)	+= tsl2550.o
-obj-$(CONFIG_SENSORS_TSL2563)	+= tsl2563.o
 obj-$(CONFIG_TWL4030_CORE)	+= twl4030-pwrirq.o twl4030-power.o
 obj-$(CONFIG_TWL4030_USB)	+= twl4030-usb.o
 obj-$(CONFIG_TWL4030_POWEROFF)	+= twl4030-poweroff.o
-- 
1.6.0.2.307.gc427

