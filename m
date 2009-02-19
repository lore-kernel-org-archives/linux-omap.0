From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 2/2] twl4030: move twl4030-pwrbutton to drivers/input/misc
Date: Thu, 19 Feb 2009 15:29:57 +0200
Message-ID: <1235050197-26818-3-git-send-email-me@felipebalbi.com>
References: <1235050197-26818-1-git-send-email-me@felipebalbi.com>
 <1235050197-26818-2-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:48184 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754357AbZBSNaH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Feb 2009 08:30:07 -0500
In-Reply-To: <1235050197-26818-2-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <me@felipebalbi.com>, David Brownell <dbrownell@users.sourceforge.net>, Samuel Ortiz <sameo@openedhand.com>

Take it out of drivers/i2c/chips as requested by Jean Delvare
that all drivers move out of there.

Cc: David Brownell <dbrownell@users.sourceforge.net>
Cc: Samuel Ortiz <sameo@openedhand.com>
Signed-off-by: Felipe Balbi <me@felipebalbi.com>
---
 drivers/i2c/chips/Kconfig                          |    4 ----
 drivers/i2c/chips/Makefile                         |    1 -
 drivers/input/misc/Kconfig                         |    4 ++++
 drivers/input/misc/Makefile                        |    1 +
 .../{i2c/chips => input/misc}/twl4030-pwrbutton.c  |    0
 drivers/mfd/twl4030-core.c                         |    3 ++-
 6 files changed, 7 insertions(+), 6 deletions(-)
 rename drivers/{i2c/chips => input/misc}/twl4030-pwrbutton.c (100%)

diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index e4831e1..bf7bd1b 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -98,10 +98,6 @@ config TWL4030_MADC
 	  to build it as a dinamically loadable module. The module will be
 	  called twl4030-madc.ko
 
-config TWL4030_PWRBUTTON
-	tristate "TWL4030 Power button Driver"
-	depends on TWL4030_CORE
-
 config TWL4030_POWEROFF
 	tristate "TWL4030 device poweroff"
 	depends on TWL4030_CORE
diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
index 1c94712..8da23ee 100644
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -18,7 +18,6 @@ obj-$(CONFIG_PCF8575)		+= pcf8575.o
 obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
 obj-$(CONFIG_SENSORS_TSL2550)	+= tsl2550.o
 obj-$(CONFIG_TWL4030_POWEROFF)	+= twl4030-poweroff.o
-obj-$(CONFIG_TWL4030_PWRBUTTON)	+= twl4030-pwrbutton.o
 obj-$(CONFIG_TWL4030_MADC)	+= twl4030-madc.o
 obj-$(CONFIG_RTC_X1205_I2C)	+= x1205.o
 
diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 67e5553..9667b50 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -193,6 +193,10 @@ config INPUT_CM109
 	  To compile this driver as a module, choose M here: the module will be
 	  called cm109.
 
+config INPUT_TWL4030_PWRBUTTON
+	tristate "TWL4030 Power button Driver"
+	depends on TWL4030_CORE
+
 config INPUT_UINPUT
 	tristate "User level driver support"
 	help
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index bb62e6e..2fabcdb 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_INPUT_YEALINK)		+= yealink.o
 obj-$(CONFIG_INPUT_CM109)		+= cm109.o
 obj-$(CONFIG_HP_SDC_RTC)		+= hp_sdc_rtc.o
 obj-$(CONFIG_INPUT_UINPUT)		+= uinput.o
+obj-$(CONFIG_INPUT_TWL4030_PWRBUTTON)	+= twl4030-pwrbutton.o
 obj-$(CONFIG_INPUT_APANEL)		+= apanel.o
 obj-$(CONFIG_INPUT_SGI_BTNS)		+= sgi_btns.o
 obj-$(CONFIG_INPUT_PCF50633_PMU)	+= pcf50633-input.o
diff --git a/drivers/i2c/chips/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
similarity index 100%
rename from drivers/i2c/chips/twl4030-pwrbutton.c
rename to drivers/input/misc/twl4030-pwrbutton.c
diff --git a/drivers/mfd/twl4030-core.c b/drivers/mfd/twl4030-core.c
index 1552296..bb25a4f 100644
--- a/drivers/mfd/twl4030-core.c
+++ b/drivers/mfd/twl4030-core.c
@@ -107,7 +107,8 @@
 #define twl_has_usb()	false
 #endif
 
-#if defined(CONFIG_TWL4030_PWRBUTTON) || defined(CONFIG_TWL4030_PWBUTTON_MODULE)
+#if defined(CONFIG_INPUT_TWL4030_PWRBUTTON) \
+	|| defined(CONFIG_INPUT_TWL4030_PWBUTTON_MODULE)
 #define twl_has_pwrbutton()	true
 #else
 #define twl_has_pwrbutton()	false
-- 
1.6.1.3

