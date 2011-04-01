From: Matthias Kaehlcke <matthias.kaehlcke@tomtom.com>
Subject: [PATCH] twl4030-usb: Report correct vbus value for accessory charger
 adapters1
Date: Fri, 01 Apr 2011 23:02:07 +0200
Message-ID: <4D963D4F.2050203@tomtom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mxvs2.esa.t-systems.com ([81.7.202.143]:35440 "EHLO
	mxvs2.esa.t-systems.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753582Ab1DAVCk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 17:02:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, David Brownell <dbrownell@users.sourceforge.net>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

The twl4030-usb driver exports the status of VBUS as sysfs attribute.
In case an accessory charger adapter (ACA) is connected to the OTG
transceiver the attribute is always 'off', even when the charger
provides VBUS. Added a variable to keep track of the status of VBUS
and report it correctly

Signed-off-by: Matthias Kaehlcke <matthias.kaehlcke@tomtom.com>
---
  drivers/usb/otg/twl4030-usb.c |    9 ++++++++-
  1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
index e01b073..efeb4d1 100644
--- a/drivers/usb/otg/twl4030-usb.c
+++ b/drivers/usb/otg/twl4030-usb.c
@@ -160,6 +160,7 @@ struct twl4030_usb {

  	int			irq;
  	u8			linkstat;
+	bool			vbus_supplied;
  	u8			asleep;
  	bool			irq_enabled;
  };
@@ -250,6 +251,8 @@ static enum usb_xceiv_events 
twl4030_usb_linkstat(struct twl4030_usb *twl)
  	int	status;
  	int	linkstat = USB_EVENT_NONE;

+	twl->vbus_supplied = false;
+
  	/*
  	 * For ID/VBUS sensing, see manual section 15.4.8 ...
  	 * except when using only battery backup power, two
@@ -265,6 +268,9 @@ static enum usb_xceiv_events 
twl4030_usb_linkstat(struct twl4030_usb *twl)
  	if (status < 0)
  		dev_err(twl->dev, "USB link status err %d\n", status);
  	else if (status & (BIT(7) | BIT(2))) {
+		if (status & (BIT(7)))
+                        twl->vbus_supplied = true;
+
  		if (status & BIT(2))
  			linkstat = USB_EVENT_ID;
  		else
@@ -484,7 +490,7 @@ static ssize_t twl4030_usb_vbus_show(struct device *dev,

  	spin_lock_irqsave(&twl->lock, flags);
  	ret = sprintf(buf, "%s\n",
-			(twl->linkstat == USB_EVENT_VBUS) ? "on" : "off");
+			twl->vbus_supplied ? "on" : "off");
  	spin_unlock_irqrestore(&twl->lock, flags);

  	return ret;
@@ -608,6 +614,7 @@ static int __devinit twl4030_usb_probe(struct 
platform_device *pdev)
  	twl->otg.set_peripheral	= twl4030_set_peripheral;
  	twl->otg.set_suspend	= twl4030_set_suspend;
  	twl->usb_mode		= pdata->usb_mode;
+	twl->vbus_supplied	= false;
  	twl->asleep = 1;

  	/* init spinlock for workqueue */
-- 
1.7.1

