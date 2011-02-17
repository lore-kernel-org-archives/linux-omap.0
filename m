From: Hema HK <hemahk@ti.com>
Subject: [2/7 v4] usb: otg: Remove one unnecessary I2C read request.
Date: Thu, 17 Feb 2011 12:06:05 +0530
Message-ID: <1297924570-3750-2-git-send-email-hemahk@ti.com>
References: <1297924570-3750-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54822 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751245Ab1BQGgW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 01:36:22 -0500
In-Reply-To: <1297924570-3750-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, "Kalliguddi, Hema" <hemahk@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

From: Kalliguddi, Hema <hemahk@ti.com>

To get the ID status there was an I2C read transfer. Removed this I2C
read transfer as this info can be used from existing variable(linkstat).

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
drivers/usb/otg/twl6030-usb.c |    7 ++-----
 drivers/usb/otg/twl6030-usb.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

Index: linux-2.6/drivers/usb/otg/twl6030-usb.c
===================================================================
--- linux-2.6.orig/drivers/usb/otg/twl6030-usb.c
+++ linux-2.6/drivers/usb/otg/twl6030-usb.c
@@ -149,7 +149,6 @@ static int twl6030_set_phy_clk(struct ot
 
 static int twl6030_phy_init(struct otg_transceiver *x)
 {
-	u8 hw_state;
 	struct twl6030_usb *twl;
 	struct device *dev;
 	struct twl4030_usb_data *pdata;
@@ -158,9 +157,7 @@ static int twl6030_phy_init(struct otg_t
 	dev  = twl->dev;
 	pdata = dev->platform_data;
 
-	hw_state = twl6030_readb(twl, TWL6030_MODULE_ID0, STS_HW_CONDITIONS);
-
-	if (hw_state & STS_USB_ID)
+	if (twl->linkstat == USB_EVENT_ID)
 		pdata->phy_power(twl->dev, 1, 1);
 	else
 		pdata->phy_power(twl->dev, 0, 1);
@@ -290,6 +287,7 @@ static irqreturn_t twl6030_usbotg_irq(in
 		status = USB_EVENT_ID;
 		twl->otg.default_a = true;
 		twl->otg.state = OTG_STATE_A_IDLE;
+		twl->linkstat = status;
 		blocking_notifier_call_chain(&twl->otg.notifier, status,
 							twl->otg.gadget);
 	} else  {
@@ -299,7 +297,6 @@ static irqreturn_t twl6030_usbotg_irq(in
 								0x1);
 	}
 	twl6030_writeb(twl, TWL_MODULE_USB, USB_ID_INT_LATCH_CLR, status);
-	twl->linkstat = status;
 
 	return IRQ_HANDLED;
 }
