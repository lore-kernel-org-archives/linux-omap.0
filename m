From: x0070977@dbdmail.itg.ti.com
Subject: [RFC/PATCH 2/2] Triton Battery charger interface driver for
     OMAP3430
Date: Fri, 20 Jun 2008 17:36:00 +0530 (IST)
Message-ID: <62852.192.168.10.89.1213963560.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:32848 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752506AbYFTMGG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jun 2008 08:06:06 -0400
Received: from dlep32.itg.ti.com ([157.170.170.70])
	by calf.ext.ti.com (8.13.7/8.13.7) with ESMTP id m5KC60QT027633
	for <linux-omap@vger.kernel.org>; Fri, 20 Jun 2008 07:06:05 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep32.itg.ti.com (8.13.7/8.13.7) with ESMTP id m5KC5wiv010346
	for <linux-omap@vger.kernel.org>; Fri, 20 Jun 2008 07:05:59 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Madhusudhan Chikkature <madhu.cr@ti.com>

This patch updates the twl4030 usb driver to call the functionality supported
by the TWL4030 battery charger interface driver to enable/disable battery
charging upon cable attach/detach.

Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
---
 drivers/i2c/chips/twl4030-usb.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

Index: linux-omap-2.6/drivers/i2c/chips/twl4030-usb.c
===================================================================
--- linux-omap-2.6.orig/drivers/i2c/chips/twl4030-usb.c	2008-06-20
15:42:26.000000000 +0530
+++ linux-omap-2.6/drivers/i2c/chips/twl4030-usb.c	2008-06-20
15:47:40.000000000 +0530
@@ -589,6 +589,12 @@
 	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, PROTECT_KEY);
 }

+#ifdef CONFIG_TWL4030_BCI_BATTERY
+extern int twl4030charger_usb_en(int enable);
+#else
+static inline int twl4030charger_usb_en(int enable) { return 0; }
+#endif
+
 static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 {
 	int ret = IRQ_NONE;
@@ -601,10 +607,13 @@
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



