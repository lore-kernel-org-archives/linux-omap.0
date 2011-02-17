From: Hema HK <hemahk@ti.com>
Subject: [5/7 v4] usb: otg: TWL6030: Introduce the twl6030_phy_suspend function.
Date: Thu, 17 Feb 2011 12:06:08 +0530
Message-ID: <1297924570-3750-5-git-send-email-hemahk@ti.com>
References: <1297924570-3750-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59183 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754885Ab1BQGg0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Feb 2011 01:36:26 -0500
In-Reply-To: <1297924570-3750-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, "Kalliguddi, Hema" <hemahk@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

From: Kalliguddi, Hema <hemahk@ti.com>

Introduce the twl6030_phy_suspend function and assign to otg.set_suspend
function pointer.
This function is used by the musb-omap2430 platform driver
during suspend/resume.

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
drivers/usb/otg/twl6030-usb.c |   16 ++++++++++++++++
 drivers/usb/otg/twl6030-usb.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

Index: linux-2.6/drivers/usb/otg/twl6030-usb.c
===================================================================
--- linux-2.6.orig/drivers/usb/otg/twl6030-usb.c
+++ linux-2.6/drivers/usb/otg/twl6030-usb.c
@@ -177,6 +177,17 @@ static void twl6030_phy_shutdown(struct 
 	pdata->phy_power(twl->dev, 0, 0);
 }
 
+static int twl6030_phy_suspend(struct otg_transceiver *x, int suspend)
+{
+	struct twl6030_usb *twl = xceiv_to_twl(x);
+	struct device *dev = twl->dev;
+	struct twl4030_usb_data *pdata = dev->platform_data;
+
+	pdata->phy_suspend(dev, suspend);
+
+	return 0;
+}
+
 static int twl6030_usb_ldo_init(struct twl6030_usb *twl)
 {
 
@@ -388,6 +399,7 @@ static int __devinit twl6030_usb_probe(s
 	twl->otg.set_vbus	= twl6030_set_vbus;
 	twl->otg.init		= twl6030_phy_init;
 	twl->otg.shutdown	= twl6030_phy_shutdown;
+	twl->otg.set_suspend	= twl6030_phy_suspend;
 
 	/* init spinlock for workqueue */
 	spin_lock_init(&twl->lock);
@@ -432,6 +444,7 @@ static int __devinit twl6030_usb_probe(s
 
 	twl->asleep = 0;
 	pdata->phy_init(dev);
+	twl6030_phy_suspend(&twl->otg, 0);
 	twl6030_enable_irq(&twl->otg);
 	dev_info(&pdev->dev, "Initialized TWL6030 USB module\n");
 
