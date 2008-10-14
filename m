From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 7/7] leds: lp5521: move to drivers/leds
Date: Wed, 15 Oct 2008 00:39:57 +0300
Message-ID: <1224020397-2842-8-git-send-email-me@felipebalbi.com>
References: <1224020397-2842-1-git-send-email-me@felipebalbi.com>
 <1224020397-2842-2-git-send-email-me@felipebalbi.com>
 <1224020397-2842-3-git-send-email-me@felipebalbi.com>
 <1224020397-2842-4-git-send-email-me@felipebalbi.com>
 <1224020397-2842-5-git-send-email-me@felipebalbi.com>
 <1224020397-2842-6-git-send-email-me@felipebalbi.com>
 <1224020397-2842-7-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:48074 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbYJNVlG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 17:41:06 -0400
In-Reply-To: <1224020397-2842-7-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>, Richard Purdie <rpurdie@rpsys.net>

From: Felipe Balbi <felipe.balbi@nokia.com>

This driver should be sitting together with the other
led drivers.

Cc: Richard Purdie <rpurdie@rpsys.net>
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
index d803c41..0aed293 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -219,13 +219,6 @@ config SENSORS_TSL2563
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
index ba41a57..5e17df3 100644
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -30,7 +30,6 @@ obj-$(CONFIG_TWL4030_POWEROFF)	+= twl4030-poweroff.o
 obj-$(CONFIG_TWL4030_PWRBUTTON)	+= twl4030-pwrbutton.o
 obj-$(CONFIG_TWL4030_MADC)	+= twl4030-madc.o
 obj-$(CONFIG_RTC_X1205_I2C)	+= x1205.o
-obj-$(CONFIG_LP5521)		+= lp5521.o
 
 ifeq ($(CONFIG_I2C_DEBUG_CHIP),y)
 EXTRA_CFLAGS += -DDEBUG
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 6a2f441..943e3d9 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -146,6 +146,16 @@ config LEDS_CM_X270
 	help
 	  This option enables support for the CM-X270 LEDs.
 
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
index fd6316e..ce5c8cd 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_LEDS_COBALT_RAQ)		+= leds-cobalt-raq.o
 obj-$(CONFIG_LEDS_PCA9532)		+= leds-pca9532.o
 obj-$(CONFIG_LEDS_GPIO)			+= leds-gpio.o
 obj-$(CONFIG_LEDS_CM_X270)              += leds-cm-x270.o
+obj-$(CONFIG_LEDS_LP5521)		+= leds-lp5521.o
 obj-$(CONFIG_LEDS_CLEVO_MAIL)		+= leds-clevo-mail.o
 obj-$(CONFIG_LEDS_HP6XX)		+= leds-hp6xx.o
 obj-$(CONFIG_LEDS_FSG)			+= leds-fsg.o
diff --git a/drivers/i2c/chips/lp5521.c b/drivers/leds/leds-lp5521.c
similarity index 100%
rename from drivers/i2c/chips/lp5521.c
rename to drivers/leds/leds-lp5521.c
-- 
1.6.0.2.307.gc427

