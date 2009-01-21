From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: [PATCH 1/1] TWL: USB: disable VUSB regulators when cable unplugged
Date: Wed, 21 Jan 2009 15:15:18 +0200
Message-ID: <1232543718-18199-2-git-send-email-kalle.jokiniemi@digia.com>
References: <1232543718-18199-1-git-send-email-kalle.jokiniemi@digia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from sink.edelkey.net ([213.138.147.137]:56694 "EHLO
	sink.edelkey.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756595AbZAUNPf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Jan 2009 08:15:35 -0500
In-Reply-To: <1232543718-18199-1-git-send-email-kalle.jokiniemi@digia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.balbi@nokia.com, david-b@pacbell.net, Kalle Jokiniemi <kalle.jokiniemi@digia.com>

This patch disables USB regulators VUSB1V5, VUSB1V8, and VUSB3V1
when the USB cable is unplugged to reduce power consumption.

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
---
 drivers/usb/otg/twl4030-usb.c |   30 ++++++++++++++++++++++++------
 1 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
index 416e441..105ab55 100644
--- a/drivers/usb/otg/twl4030-usb.c
+++ b/drivers/usb/otg/twl4030-usb.c
@@ -34,6 +34,7 @@
 #include <linux/delay.h>
 #include <linux/usb/otg.h>
 #include <linux/i2c/twl4030.h>
+#include <linux/regulator/consumer.h>
 
 
 /* Register defines */
@@ -246,6 +247,11 @@ struct twl4030_usb {
 	struct otg_transceiver	otg;
 	struct device		*dev;
 
+	/* TWL4030 internal USB regulator supplies */
+	struct regulator	*usb1v5;
+	struct regulator	*usb1v8;
+	struct regulator	*usb3v1;
+
 	/* for vbus reporting with irqs disabled */
 	spinlock_t		lock;
 
@@ -434,6 +440,9 @@ static void twl4030_phy_power(struct twl4030_usb *twl, int on)
 
 	pwr = twl4030_usb_read(twl, PHY_PWR_CTRL);
 	if (on) {
+		regulator_enable(twl->usb1v5);
+		regulator_enable(twl->usb1v8);
+		regulator_enable(twl->usb3v1);
 		pwr &= ~PHY_PWR_PHYPWD;
 		WARN_ON(twl4030_usb_write_verify(twl, PHY_PWR_CTRL, pwr) < 0);
 		twl4030_usb_write(twl, PHY_CLK_CTRL,
@@ -443,6 +452,9 @@ static void twl4030_phy_power(struct twl4030_usb *twl, int on)
 	} else  {
 		pwr |= PHY_PWR_PHYPWD;
 		WARN_ON(twl4030_usb_write_verify(twl, PHY_PWR_CTRL, pwr) < 0);
+		regulator_disable(twl->usb1v5);
+		regulator_disable(twl->usb1v8);
+		regulator_disable(twl->usb3v1);
 	}
 }
 
@@ -480,16 +492,19 @@ static void twl4030_usb_ldo_init(struct twl4030_usb *twl)
 	/* input to VUSB3V1 LDO is from VBAT, not VBUS */
 	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x14, VUSB_DEDICATED1);
 
-	/* turn on 3.1V regulator */
-	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x20, VUSB3V1_DEV_GRP);
+	/* Initialize 3.1V regulator */
+	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB3V1_DEV_GRP);
+	twl->usb3v1 = regulator_get(twl->dev, "usb3v1");
 	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB3V1_TYPE);
 
-	/* turn on 1.5V regulator */
-	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x20, VUSB1V5_DEV_GRP);
+	/* Initialize 1.5V regulator */
+	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB1V5_DEV_GRP);
+	twl->usb1v5 = regulator_get(twl->dev, "usb1v5");
 	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB1V5_TYPE);
 
-	/* turn on 1.8V regulator */
-	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x20, VUSB1V8_DEV_GRP);
+	/* Initialize 1.8V regulator */
+	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB1V8_DEV_GRP);
+	twl->usb1v8 = regulator_get(twl->dev, "usb1v8");
 	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0, VUSB1V8_TYPE);
 
 	/* disable access to power configuration registers */
@@ -688,6 +703,9 @@ static int __exit twl4030_usb_remove(struct platform_device *pdev)
 	twl4030_usb_clear_bits(twl, POWER_CTRL, POWER_CTRL_OTG_ENAB);
 
 	twl4030_phy_power(twl, 0);
+	regulator_put(twl->usb1v5);
+	regulator_put(twl->usb1v8);
+	regulator_put(twl->usb3v1);
 
 	kfree(twl);
 
-- 
1.5.6.5

