From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] I2C: TWL4030: General cleanup in twl4030's driver
Date: Thu, 10 Apr 2008 15:40:37 +0300
Message-ID: <1207831237-24216-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:44048 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754407AbYDJMmH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Apr 2008 08:42:07 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3ACiDgZ023351
	for <linux-omap@vger.kernel.org>; Thu, 10 Apr 2008 07:44:22 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

TWL4030's Kconfig entries was a bit mixed.
Fix some missing '\n'
Add missing space in two-lined printks

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/Kconfig             |    8 ++++----
 drivers/i2c/chips/twl4030-core.c      |    2 +-
 drivers/i2c/chips/twl4030-pwrbutton.c |   10 +++++-----
 drivers/i2c/chips/twl4030-usb.c       |    2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index 4896f84..c3de735 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -132,10 +132,6 @@ config TWL4030_USB
 	bool "TWL4030 USB Transceiver Driver"
 	depends on TWL4030_CORE
 
-config TWL4030_PWRBUTTON
-        bool "TWL4030 Power button Driver"
-	depends on TWL4030_CORE
-
 choice
 	prompt "Transceiver mode"
 	depends on TWL4030_USB
@@ -143,6 +139,10 @@ choice
 	  TWL4030 USB transceiver can operate in various
 	  mutually-exclusive modes. Select one of them.
 
+config TWL4030_PWRBUTTON
+        bool "TWL4030 Power button Driver"
+	depends on TWL4030_CORE
+
 config TWL4030_USB_HS_ULPI
 	depends on TWL4030_USB
 	bool "High-speed ULPI"
diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
index 5868a81..49bd63a 100644
--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -885,7 +885,7 @@ static int __init twl4030_init(void)
 	int res;
 
 	if ((res = i2c_add_driver(&twl4030_driver))) {
-		printk(KERN_ERR "TWL4030: Driver registration failed \n");
+		printk(KERN_ERR "TWL4030: Driver registration failed\n");
 		return res;
 	}
 
diff --git a/drivers/i2c/chips/twl4030-pwrbutton.c b/drivers/i2c/chips/twl4030-pwrbutton.c
index a541ed6..cbc31aa 100644
--- a/drivers/i2c/chips/twl4030-pwrbutton.c
+++ b/drivers/i2c/chips/twl4030-pwrbutton.c
@@ -64,7 +64,7 @@ static irqreturn_t powerbutton_irq(int irq, void *dev_id)
 				 value & PWR_PWRON_IRQ);
 	} else {
 		printk(KERN_WARNING "I2C error %d while reading TWL4030"
-			"PM_MASTER STS_HW_CONDITIONS register\n", err);
+			" PM_MASTER STS_HW_CONDITIONS register\n", err);
 	}
 
 	return IRQ_HANDLED;
@@ -101,7 +101,7 @@ static int __init twl4030_pwrbutton_init(void)
 	err = twl4030_i2c_read_u8(TWL4030_MODULE_INT, &value, PWR_IMR1);
 	if (err) {
 		printk(KERN_WARNING "I2C error %d while reading TWL4030"
-					"INT PWR_IMR1 register\n", err);
+					" INT PWR_IMR1 register\n", err);
 
 		goto free_input_dev;
 	}
@@ -110,14 +110,14 @@ static int __init twl4030_pwrbutton_init(void)
 				   value & (~PWR_PWRON_IRQ), PWR_IMR1);
 	if (err) {
 		printk(KERN_WARNING "I2C error %d while writing TWL4030"
-				    "INT PWR_IMR1 register\n", err);
+				    " INT PWR_IMR1 register\n", err);
 		goto free_input_dev;
 	}
 
 	err = twl4030_i2c_read_u8(TWL4030_MODULE_INT, &value, PWR_EDR1);
 	if (err) {
 		printk(KERN_WARNING "I2C error %d while reading TWL4030"
-					"INT PWR_EDR1 register\n", err);
+					" INT PWR_EDR1 register\n", err);
 		goto free_input_dev;
 	}
 
@@ -126,7 +126,7 @@ static int __init twl4030_pwrbutton_init(void)
 
 	if (err) {
 		printk(KERN_WARNING "I2C error %d while writing TWL4030"
-					"INT PWR_EDR1 register\n", err);
+					" INT PWR_EDR1 register\n", err);
 		goto free_input_dev;
 	}
 
diff --git a/drivers/i2c/chips/twl4030-usb.c b/drivers/i2c/chips/twl4030-usb.c
index a238904..1df5427 100644
--- a/drivers/i2c/chips/twl4030-usb.c
+++ b/drivers/i2c/chips/twl4030-usb.c
@@ -726,7 +726,7 @@ static int __init twl4030_usb_init(void)
 
 	otg_set_transceiver(&twl->otg);
 
-	printk(KERN_INFO "Initialized TWL4030 USB module");
+	printk(KERN_INFO "Initialized TWL4030 USB module\n");
 
 	return 0;
 }
-- 
1.5.5.23.g2a5fe

