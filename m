From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 5/8] leds: lp5521: move to drivers/leds
Date: Tue, 10 Feb 2009 14:16:02 +0200
Message-ID: <1234268165-23573-6-git-send-email-felipe.balbi@nokia.com>
References: <1234268165-23573-1-git-send-email-felipe.balbi@nokia.com>
 <1234268165-23573-2-git-send-email-felipe.balbi@nokia.com>
 <1234268165-23573-3-git-send-email-felipe.balbi@nokia.com>
 <1234268165-23573-4-git-send-email-felipe.balbi@nokia.com>
 <1234268165-23573-5-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:62466 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753508AbZBJMa1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Feb 2009 07:30:27 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n1ACU28l003644
	for <linux-omap@vger.kernel.org>; Tue, 10 Feb 2009 14:30:24 +0200
In-Reply-To: <1234268165-23573-5-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

This driver should be sitting together with the other
led drivers.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/Kconfig                          |    7 -------
 drivers/i2c/chips/Makefile                         |    1 -
 drivers/leds/Kconfig                               |   10 ++++++++++
 drivers/leds/Makefile                              |    1 +
 drivers/{i2c/chips/lp5521.c => leds/leds-lp5521.c} |    0
 5 files changed, 11 insertions(+), 8 deletions(-)
 rename drivers/{i2c/chips/lp5521.c => leds/leds-lp5521.c} (100%)

diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index bb95b3e..e4831e1 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -141,13 +141,6 @@ config SENSORS_TSL2563
          This driver can also be built as a module.  If so, the module
          will be called tsl2563.
 
-config LP5521
-	tristate "LP5521 LED driver chip"
-	depends on I2C
-	help
-	  If you say yes here you get support for the National Semiconductor
-	  LP5521 LED driver.
-
 config MENELAUS
 	bool "TWL92330/Menelaus PM chip"
 	depends on I2C=y && ARCH_OMAP24XX
diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
index 32a395f..1c94712 100644
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -21,7 +21,6 @@ obj-$(CONFIG_TWL4030_POWEROFF)	+= twl4030-poweroff.o
 obj-$(CONFIG_TWL4030_PWRBUTTON)	+= twl4030-pwrbutton.o
 obj-$(CONFIG_TWL4030_MADC)	+= twl4030-madc.o
 obj-$(CONFIG_RTC_X1205_I2C)	+= x1205.o
-obj-$(CONFIG_LP5521)		+= lp5521.o
 
 ifeq ($(CONFIG_I2C_DEBUG_CHIP),y)
 EXTRA_CFLAGS += -DDEBUG
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 4d4ff64..8d0f37e 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -134,6 +134,16 @@ config LEDS_GPIO
 	  outputs. To be useful the particular board must have LEDs
 	  and they must be connected to the GPIO lines.
 
+config LEDS_LP5521
+	tristate "LED Support for the LP5521 LEDs"
+	depends on LEDS_CLASS && I2C
+	help
+	  If you say 'Y' here you get support for the National Semiconductor
+	  LP5521 LED driver used in n8x0 boards.
+
+	  This driver can be built as a module by choosing 'M'. The module
+	  will be called leds-lp5521.
+
 config LEDS_CLEVO_MAIL
 	tristate "Mail LED on Clevo notebook (EXPERIMENTAL)"
 	depends on LEDS_CLASS && X86 && SERIO_I8042 && DMI && EXPERIMENTAL
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 7ac6ad3..4ab09e8 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_LEDS_COBALT_RAQ)		+= leds-cobalt-raq.o
 obj-$(CONFIG_LEDS_SUNFIRE)		+= leds-sunfire.o
 obj-$(CONFIG_LEDS_PCA9532)		+= leds-pca9532.o
 obj-$(CONFIG_LEDS_GPIO)			+= leds-gpio.o
+obj-$(CONFIG_LEDS_LP5521)		+= leds-lp5521.o
 obj-$(CONFIG_LEDS_CLEVO_MAIL)		+= leds-clevo-mail.o
 obj-$(CONFIG_LEDS_HP6XX)		+= leds-hp6xx.o
 obj-$(CONFIG_LEDS_FSG)			+= leds-fsg.o
diff --git a/drivers/i2c/chips/lp5521.c b/drivers/leds/leds-lp5521.c
similarity index 100%
rename from drivers/i2c/chips/lp5521.c
rename to drivers/leds/leds-lp5521.c
-- 
1.6.1.265.g9a013

