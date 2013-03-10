From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH 4/7] usb: otg: twl4030-usb: poll for ID disconnect
Date: Sun, 10 Mar 2013 03:07:58 +0200
Message-ID: <1362877681-8102-5-git-send-email-notasas@gmail.com>
References: <1362877681-8102-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f54.google.com ([74.125.83.54]:50962 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523Ab3CJBIT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Mar 2013 20:08:19 -0500
In-Reply-To: <1362877681-8102-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, NeilBrown <neilb@suse.de>, Grazvydas Ignotas <notasas@gmail.com>

On pandora, STS_USB interrupt doesn't arrive on USB host cable disconnect
for some reason while VBUS is driven by twl itself, but STS_HW_CONDITIONS
is updated correctly. It does work fine when PHY is powered down though.
To work around that we have to poll.

TI PSP kernels have similar workarounds, so (many?) more boards are likely
affected.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 drivers/usb/otg/twl4030-usb.c |   37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
index 90a19ff..2c1c27e 100644
--- a/drivers/usb/otg/twl4030-usb.c
+++ b/drivers/usb/otg/twl4030-usb.c
@@ -163,6 +163,8 @@ struct twl4030_usb {
 	bool			vbus_supplied;
 	u8			asleep;
 	bool			irq_enabled;
+
+	struct delayed_work	id_workaround_work;
 };
 
 /* internal define on top of container_of */
@@ -412,6 +414,16 @@ static void twl4030_phy_resume(struct twl4030_usb *twl)
 	__twl4030_phy_resume(twl);
 	twl->asleep = 0;
 	dev_dbg(twl->dev, "%s\n", __func__);
+
+	/*
+	 * XXX When VBUS gets driven after musb goes to A mode,
+	 * ID_PRES related interrupts no longer arrive, why?
+	 * Register itself is updated fine though, so we must poll.
+	 */
+	if (twl->linkstat == OMAP_MUSB_ID_GROUND) {
+		cancel_delayed_work(&twl->id_workaround_work);
+		schedule_delayed_work(&twl->id_workaround_work, HZ);
+	}
 }
 
 static int twl4030_usb_ldo_init(struct twl4030_usb *twl)
@@ -513,6 +525,28 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 	return IRQ_HANDLED;
 }
 
+static void twl4030_id_workaround_work(struct work_struct *work)
+{
+	struct twl4030_usb *twl = container_of(work, struct twl4030_usb,
+		id_workaround_work.work);
+	enum omap_musb_vbus_id_status status_prev = twl->linkstat;
+	enum omap_musb_vbus_id_status status;
+
+	status = twl4030_usb_linkstat(twl);
+	if (status != status_prev) {
+		dev_dbg(twl->dev, "handle missing status change: %d->%d\n",
+			status_prev, status);
+		twl->linkstat = status_prev;
+		twl4030_usb_irq(0, twl);
+	}
+
+	/* don't schedule during sleep - irq works right then */
+	if (status == OMAP_MUSB_ID_GROUND && !twl->asleep) {
+		cancel_delayed_work(&twl->id_workaround_work);
+		schedule_delayed_work(&twl->id_workaround_work, HZ);
+	}
+}
+
 static void twl4030_usb_phy_init(struct twl4030_usb *twl)
 {
 	enum omap_musb_vbus_id_status status;
@@ -613,6 +647,8 @@ static int twl4030_usb_probe(struct platform_device *pdev)
 	/* init spinlock for workqueue */
 	spin_lock_init(&twl->lock);
 
+	INIT_DELAYED_WORK(&twl->id_workaround_work, twl4030_id_workaround_work);
+
 	err = twl4030_usb_ldo_init(twl);
 	if (err) {
 		dev_err(&pdev->dev, "ldo init failed\n");
@@ -653,6 +689,7 @@ static int __exit twl4030_usb_remove(struct platform_device *pdev)
 	struct twl4030_usb *twl = platform_get_drvdata(pdev);
 	int val;
 
+	cancel_delayed_work(&twl->id_workaround_work);
 	free_irq(twl->irq, twl);
 	device_remove_file(twl->dev, &dev_attr_vbus);
 
-- 
1.7.9.5

