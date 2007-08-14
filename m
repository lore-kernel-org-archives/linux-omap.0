From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.23-rc2-omap1] menelaus minor cleanups
Date: Mon, 13 Aug 2007 22:51:05 -0700
Message-ID: <200708132251.05709.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Remove duplicate Menelaus Kconfig entry (omap tree only).

Fix Menelaus build error, and remove needless "#define DEBUG" (goes upstream).

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/i2c/chips/Kconfig    |   10 ----------
 drivers/i2c/chips/menelaus.c |    3 +--
 2 files changed, 1 insertion(+), 12 deletions(-)

--- h4.orig/drivers/i2c/chips/Kconfig	2007-08-10 11:26:41.000000000 -0700
+++ h4/drivers/i2c/chips/Kconfig	2007-08-13 15:33:51.000000000 -0700
@@ -130,16 +130,6 @@ config GPIOEXPANDER_OMAP
 	  If you say yes here you get support for I/O expander calls
 	  to configure IrDA, Camera and audio devices.
 
-config MENELAUS
-	bool "TWL92330/Menelaus PM chip"
-	depends on I2C=y && ARCH_OMAP24XX
-	help
-	  If you say yes here you get support for the Texas Instruments
-	  TWL92330/Menelaus Power Management chip. This include voltage
-	  regulators, Dual slot memory card tranceivers, real-time clock
-	  and other features that are often used in portable devices like
-	  cell phones and PDAs.
-
 config TWL4030_CORE
 	bool "TI's TWL4030 companion chip Core Driver Support"
 	depends on I2C=y && ARCH_OMAP24XX
--- h4.orig/drivers/i2c/chips/menelaus.c	2007-08-10 11:26:41.000000000 -0700
+++ h4/drivers/i2c/chips/menelaus.c	2007-08-13 15:37:15.000000000 -0700
@@ -1,4 +1,3 @@
-#define DEBUG
 /*
  * Copyright (C) 2004 Texas Instruments, Inc.
  *
@@ -933,7 +932,7 @@ static int menelaus_set_time(struct devi
 		return status;
 	status = menelaus_write_reg(MENELAUS_RTC_WKDAY, BIN2BCD(t->tm_wday));
 	if (status < 0) {
-		dev_err(&the_menelaus->client->dev, "rtc write reg %02x",
+		dev_err(&the_menelaus->client->dev, "rtc write reg %02x"
 				"err %d\n", MENELAUS_RTC_WKDAY, status);
 		return status;
 	}
