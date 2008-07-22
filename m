From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: [Resending - PATCH 3/3] Triton BCI driver for OMAP3430 - USB
     changes
Date: Tue, 22 Jul 2008 17:27:04 +0530 (IST)
Message-ID: <39616.192.168.10.89.1216727824.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:47974 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751212AbYGVL5O (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Jul 2008 07:57:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Mikko.K.Ylinen@nokia.com

From: Madhusudhan Chikkature<madhu.cr@ti.com>

This patch calls the functionality supported by the TWL4030 battery charger
interface driver
to enable/disable battery charging upon cable attach/detach.

Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>
---
 drivers/i2c/chips/twl4030-usb.c |    7 +++++--
 include/linux/i2c/twl4030.h     |    7 +++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

Index: linux-omap-2.6/drivers/i2c/chips/twl4030-usb.c
===================================================================
--- linux-omap-2.6.orig/drivers/i2c/chips/twl4030-usb.c	2008-07-03
16:09:05.000000000 +0530
+++ linux-omap-2.6/drivers/i2c/chips/twl4030-usb.c	2008-07-03
17:03:30.000000000 +0530
@@ -601,10 +601,13 @@ static irqreturn_t twl4030_usb_irq(int i
 		goto done;
 	}

-	if (val & USB_PRES_RISING)
+	if (val & USB_PRES_RISING) {
 		twl4030_phy_resume();
-	else
+		twl4030charger_usb_en(1);
+	} else {
+		twl4030charger_usb_en(0);
 		twl4030_phy_suspend(0);
+	}

 	ret = IRQ_HANDLED;

Index: linux-omap-2.6/include/linux/i2c/twl4030.h
===================================================================
--- linux-omap-2.6.orig/include/linux/i2c/twl4030.h	2008-07-03
16:09:05.000000000 +0530
+++ linux-omap-2.6/include/linux/i2c/twl4030.h	2008-07-03 17:03:30.000000000 +0530
@@ -127,4 +127,11 @@ int twl4030_set_gpio_edge_ctrl(int gpio,
 int twl4030_set_gpio_debounce(int gpio, int enable);
 int twl4030_free_gpio(int gpio);

+#if defined(CONFIG_TWL4030_BCI_BATTERY) || \
+	defined(CONFIG_TWL4030_BCI_BATTERY_MODULE)
+	extern int twl4030charger_usb_en(int enable);
+#else
+	static inline int twl4030charger_usb_en(int enable) { return 0; }
+#endif
+
 #endif /* End of __TWL4030_H */


