From: Moiz Sonasath <m-sonasath@ti.com>
Subject: [PATCHv2] USB: OTG: Use work_queue in set_vbus for TWL6030 transciever
Date: Mon, 27 Jun 2011 10:01:01 -0500
Message-ID: <1309186861-4463-1-git-send-email-m-sonasath@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34496 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750718Ab1F0PEG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Jun 2011 11:04:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, toddpoynor@google.com
Cc: linux-omap@vger.kernel.org, balbi@ti.com, gregkh@suse.de, Moiz Sonasath <m-sonasath@ti.com>

From: Moiz Sonasath <m-sonasath@ti.com>

With this commit: cccad6d4b103e53fb3d1fc1467f654ecb572d047
usb: otg: notifier: switch to atomic notifier

Following dumps are observed on attach/detach for MUSB HOST
mode and on a detach for MUSB Device mode.

BUG: sleeping function called from invalid context at kernel/mutex.c:85
where, the source is:
twl6030_usb_irq
->atomic_notifier_call_chain
 ->musb_otg_notifications
  ->twl6030_set_vbus
   ->twl_i2c_write_u8
    ->mutex_lock

This patch moves the i2c writes in set_vbus function to a
work-queue thereby avoiding I2C writes in atomic context.

Tested HOST and Device mode functionality on OMAP4460

Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
---
 drivers/usb/otg/twl6030-usb.c |   30 ++++++++++++++++++++++++------
 1 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/otg/twl6030-usb.c b/drivers/usb/otg/twl6030-usb.c
index cfb5aa7..b4d2c09 100644
--- a/drivers/usb/otg/twl6030-usb.c
+++ b/drivers/usb/otg/twl6030-usb.c
@@ -95,11 +95,15 @@ struct twl6030_usb {
 
 	struct regulator		*usb3v3;
 
+	/* used to set vbus, in atomic path */
+	struct work_struct	set_vbus_work;
+
 	int			irq1;
 	int			irq2;
 	u8			linkstat;
 	u8			asleep;
 	bool			irq_enabled;
+	bool			vbus_enable;
 	unsigned long		features;
 };
 
@@ -370,20 +374,31 @@ static int twl6030_enable_irq(struct otg_transceiver *x)
 	return 0;
 }
 
-static int twl6030_set_vbus(struct otg_transceiver *x, bool enabled)
+static void otg_set_vbus_work(struct work_struct *data)
 {
-	struct twl6030_usb *twl = xceiv_to_twl(x);
+	struct twl6030_usb *twl = container_of(data, struct twl6030_usb,
+								set_vbus_work);
 
 	/*
 	 * Start driving VBUS. Set OPA_MODE bit in CHARGERUSB_CTRL1
 	 * register. This enables boost mode.
 	 */
-	if (enabled)
+
+	if (twl->vbus_enable)
 		twl6030_writeb(twl, TWL_MODULE_MAIN_CHARGE , 0x40,
-						CHARGERUSB_CTRL1);
-	 else
+							CHARGERUSB_CTRL1);
+	else
 		twl6030_writeb(twl, TWL_MODULE_MAIN_CHARGE , 0x00,
-						CHARGERUSB_CTRL1);
+							CHARGERUSB_CTRL1);
+}
+
+static int twl6030_set_vbus(struct otg_transceiver *x, bool enabled)
+{
+	struct twl6030_usb *twl = xceiv_to_twl(x);
+
+	twl->vbus_enable = enabled;
+	schedule_work(&twl->set_vbus_work);
+
 	return 0;
 }
 
@@ -444,6 +459,8 @@ static int __devinit twl6030_usb_probe(struct platform_device *pdev)
 
 	ATOMIC_INIT_NOTIFIER_HEAD(&twl->otg.notifier);
 
+	INIT_WORK(&twl->set_vbus_work, otg_set_vbus_work);
+
 	twl->irq_enabled = true;
 	status = request_threaded_irq(twl->irq1, NULL, twl6030_usbotg_irq,
 			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
@@ -494,6 +511,7 @@ static int __exit twl6030_usb_remove(struct platform_device *pdev)
 	regulator_put(twl->usb3v3);
 	pdata->phy_exit(twl->dev);
 	device_remove_file(twl->dev, &dev_attr_vbus);
+	cancel_work_sync(&twl->set_vbus_work);
 	kfree(twl);
 
 	return 0;
-- 
1.6.0.4

