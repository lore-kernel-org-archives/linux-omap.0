From: Moiz Sonasath <m-sonasath@ti.com>
Subject: [PATCH] USB: OTG: Use work_queue in set_vbus for TWL6030 transciever
Date: Fri, 24 Jun 2011 10:14:03 -0500
Message-ID: <1308928443-15352-1-git-send-email-m-sonasath@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35698 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754190Ab1FXPQu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 11:16:50 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
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
 drivers/usb/otg/twl6030-usb.c |   33 +++++++++++++++++++++++++++------
 1 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/otg/twl6030-usb.c b/drivers/usb/otg/twl6030-usb.c
index cfb5aa7..857de79 100644
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
 
@@ -370,20 +374,35 @@ static int twl6030_enable_irq(struct otg_transceiver *x)
 	return 0;
 }
 
+static void otg_set_vbus_work(struct work_struct *data)
+{
+	struct twl6030_usb *twl = container_of(data, struct twl6030_usb,
+								set_vbus_work);
+
+	if (twl->vbus_enable)
+		twl6030_writeb(twl, TWL_MODULE_MAIN_CHARGE , 0x40,
+							CHARGERUSB_CTRL1);
+	else
+		twl6030_writeb(twl, TWL_MODULE_MAIN_CHARGE , 0x00,
+							CHARGERUSB_CTRL1);
+}
+
 static int twl6030_set_vbus(struct otg_transceiver *x, bool enabled)
 {
 	struct twl6030_usb *twl = xceiv_to_twl(x);
 
+	if (enabled)
+		twl->vbus_enable = 1;
+	else
+		twl->vbus_enable = 0;
+
 	/*
 	 * Start driving VBUS. Set OPA_MODE bit in CHARGERUSB_CTRL1
 	 * register. This enables boost mode.
 	 */
-	if (enabled)
-		twl6030_writeb(twl, TWL_MODULE_MAIN_CHARGE , 0x40,
-						CHARGERUSB_CTRL1);
-	 else
-		twl6030_writeb(twl, TWL_MODULE_MAIN_CHARGE , 0x00,
-						CHARGERUSB_CTRL1);
+
+	schedule_work(&twl->set_vbus_work);
+
 	return 0;
 }
 
@@ -444,6 +463,8 @@ static int __devinit twl6030_usb_probe(struct platform_device *pdev)
 
 	ATOMIC_INIT_NOTIFIER_HEAD(&twl->otg.notifier);
 
+	INIT_WORK(&twl->set_vbus_work, otg_set_vbus_work);
+
 	twl->irq_enabled = true;
 	status = request_threaded_irq(twl->irq1, NULL, twl6030_usbotg_irq,
 			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
-- 
1.6.0.4

