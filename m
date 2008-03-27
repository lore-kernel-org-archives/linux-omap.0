From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 6/7] I2C: TWL4030: Reorganize code in twl4030-usb.c
Date: Thu, 27 Mar 2008 19:16:06 +0200
Message-ID: <1206638167-23951-7-git-send-email-felipe.balbi@nokia.com>
References: <1206638167-23951-1-git-send-email-felipe.balbi@nokia.com>
 <1206638167-23951-2-git-send-email-felipe.balbi@nokia.com>
 <1206638167-23951-3-git-send-email-felipe.balbi@nokia.com>
 <1206638167-23951-4-git-send-email-felipe.balbi@nokia.com>
 <1206638167-23951-5-git-send-email-felipe.balbi@nokia.com>
 <1206638167-23951-6-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:29369 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758256AbYC0RR0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Mar 2008 13:17:26 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m2RHHLxQ016544
	for <linux-omap@vger.kernel.org>; Thu, 27 Mar 2008 19:17:24 +0200
In-Reply-To: <1206638167-23951-6-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Code flow now makes sense.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/twl4030-usb.c |  131 +++++++++++++++++++--------------------
 1 files changed, 64 insertions(+), 67 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-usb.c b/drivers/i2c/chips/twl4030-usb.c
index 136e1c6..2db1c63 100644
--- a/drivers/i2c/chips/twl4030-usb.c
+++ b/drivers/i2c/chips/twl4030-usb.c
@@ -496,45 +496,6 @@ static void usb_irq_disable(void)
 	return;
 }
 
-static void twl4030_phy_suspend(int controller_off);
-static void twl4030_phy_resume(void);
-
-static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
-{
-	int ret = IRQ_NONE;
-	u8 val;
-
-	if (twl4030_i2c_read_u8(TWL4030_MODULE_INT, &val, REG_PWR_ISR1) < 0) {
-		printk(KERN_ERR "twl4030_usb: i2c read failed,"
-				" line %d\n", __LINE__);
-		goto done;
-	}
-
-	/* this interrupt line may be shared */
-	if (!(val & USB_PRES))
-		goto done;
-
-	/* clear the interrupt */
-	twl4030_i2c_write_u8(TWL4030_MODULE_INT, USB_PRES, REG_PWR_ISR1);
-
-	/* action based on cable attach or detach */
-	if (twl4030_i2c_read_u8(TWL4030_MODULE_INT, &val, REG_PWR_EDR1) < 0) {
-		printk(KERN_ERR "twl4030_usb: i2c read failed,"
-				" line %d\n", __LINE__);
-		goto done;
-	}
-
-	if (val & USB_PRES_RISING)
-		twl4030_phy_resume();
-	else
-		twl4030_phy_suspend(0);
-
-	ret = IRQ_HANDLED;
-
-done:
-	return ret;
-}
-
 static void twl4030_phy_power(struct twl4030_usb *twl, int on)
 {
 	u8 pwr;
@@ -561,34 +522,6 @@ static void twl4030_phy_power(struct twl4030_usb *twl, int on)
 	return;
 }
 
-static void twl4030_usb_ldo_init(struct twl4030_usb *twl)
-{
-	/* Enable writing to power configuration registers */
-	twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0xC0, PROTECT_KEY);
-	twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0x0C, PROTECT_KEY);
-
-	/* put VUSB3V1 LDO in active state */
-	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB_DEDICATED2);
-
-	/* input to VUSB3V1 LDO is from VBAT, not VBUS */
-	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x14, VUSB_DEDICATED1);
-
-	/* turn on 3.1V regulator */
-	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x20, VUSB3V1_DEV_GRP);
-	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB3V1_TYPE);
-
-	/* turn on 1.5V regulator */
-	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x20, VUSB1V5_DEV_GRP);
-	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB1V5_TYPE);
-
-	/* turn on 1.8V regulator */
-	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x20, VUSB1V8_DEV_GRP);
-	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB1V8_TYPE);
-
-	/* disable access to power configuration registers */
-	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, PROTECT_KEY);
-}
-
 static void twl4030_phy_suspend(int controller_off)
 {
 	struct twl4030_usb *twl = the_transceiver;
@@ -627,6 +560,70 @@ static void twl4030_phy_resume(void)
 	return;
 }
 
+static void twl4030_usb_ldo_init(struct twl4030_usb *twl)
+{
+	/* Enable writing to power configuration registers */
+	twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0xC0, PROTECT_KEY);
+	twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0x0C, PROTECT_KEY);
+
+	/* put VUSB3V1 LDO in active state */
+	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB_DEDICATED2);
+
+	/* input to VUSB3V1 LDO is from VBAT, not VBUS */
+	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x14, VUSB_DEDICATED1);
+
+	/* turn on 3.1V regulator */
+	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x20, VUSB3V1_DEV_GRP);
+	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB3V1_TYPE);
+
+	/* turn on 1.5V regulator */
+	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x20, VUSB1V5_DEV_GRP);
+	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB1V5_TYPE);
+
+	/* turn on 1.8V regulator */
+	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x20, VUSB1V8_DEV_GRP);
+	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB1V8_TYPE);
+
+	/* disable access to power configuration registers */
+	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, PROTECT_KEY);
+}
+
+static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
+{
+	int ret = IRQ_NONE;
+	u8 val;
+
+	if (twl4030_i2c_read_u8(TWL4030_MODULE_INT, &val, REG_PWR_ISR1) < 0) {
+		printk(KERN_ERR "twl4030_usb: i2c read failed,"
+				" line %d\n", __LINE__);
+		goto done;
+	}
+
+	/* this interrupt line may be shared */
+	if (!(val & USB_PRES))
+		goto done;
+
+	/* clear the interrupt */
+	twl4030_i2c_write_u8(TWL4030_MODULE_INT, USB_PRES, REG_PWR_ISR1);
+
+	/* action based on cable attach or detach */
+	if (twl4030_i2c_read_u8(TWL4030_MODULE_INT, &val, REG_PWR_EDR1) < 0) {
+		printk(KERN_ERR "twl4030_usb: i2c read failed,"
+				" line %d\n", __LINE__);
+		goto done;
+	}
+
+	if (val & USB_PRES_RISING)
+		twl4030_phy_resume();
+	else
+		twl4030_phy_suspend(0);
+
+	ret = IRQ_HANDLED;
+
+done:
+	return ret;
+}
+
 static int twl4030_set_suspend(struct otg_transceiver *x, int suspend)
 {
 	if (suspend)
-- 
1.5.5.rc1.12.g660b9

