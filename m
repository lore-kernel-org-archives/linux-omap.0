From: felipe.balbi@nokia.com
Subject: [PATCH] usb: otg: twl4030: fix wrong assumption of starting state
Date: Wed, 11 Aug 2010 13:02:32 +0300
Message-ID: <1281520952-27981-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:30208 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044Ab0HKKCj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 06:02:39 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux USB Mailing List <linux-usb@vger.kernel.org>, David Brownell <david-b@pacbell.net>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

The reset state of twl4030-usb is not sleeping, it starts
up awaken and we need to disable it if we have booted
with a disconnected cable to avoid over consumption on
the default state.

To avoid problems later, we read the current state of the
transceiver from the PHY_PWR_CTRL register. The bootloader
can, anyways, put the device to sleep before us.

Tested on a custom OMAP board.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---

Greg,

this is a bugfix but it's not a huge one, so if want
to wait until next merge window, it's fine by me.

This patch saves about 2mA for the case when we boot
with the USB cable disconnected.

 drivers/usb/otg/twl4030-usb.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
index 0e88885..05aaac1 100644
--- a/drivers/usb/otg/twl4030-usb.c
+++ b/drivers/usb/otg/twl4030-usb.c
@@ -550,6 +550,7 @@ static int __devinit twl4030_usb_probe(struct platform_device *pdev)
 	struct twl4030_usb_data *pdata = pdev->dev.platform_data;
 	struct twl4030_usb	*twl;
 	int			status, err;
+	u8			pwr;
 
 	if (!pdata) {
 		dev_dbg(&pdev->dev, "platform_data not available\n");
@@ -568,7 +569,10 @@ static int __devinit twl4030_usb_probe(struct platform_device *pdev)
 	twl->otg.set_peripheral	= twl4030_set_peripheral;
 	twl->otg.set_suspend	= twl4030_set_suspend;
 	twl->usb_mode		= pdata->usb_mode;
-	twl->asleep		= 1;
+
+	pwr = twl4030_usb_read(twl, PHY_PWR_CTRL);
+
+	twl->asleep		= (pwr & PHY_PWR_PHYPWD);
 
 	/* init spinlock for workqueue */
 	spin_lock_init(&twl->lock);
-- 
1.7.2.1.6.g61bf12

