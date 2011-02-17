From: Felipe Balbi <balbi@ti.com>
Subject: [patch-v2.6.39 06/12] usb: otg: Remove one unnecessary I2C read request.
Date: Thu, 17 Feb 2011 14:38:43 +0200
Message-ID: <1297946329-9353-7-git-send-email-balbi@ti.com>
References: <1297946329-9353-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:50122 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756190Ab1BQMjO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 07:39:14 -0500
In-Reply-To: <1297946329-9353-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Hema HK <hemahk@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>

From: Hema HK <hemahk@ti.com>

To get the ID status there was an I2C read transfer. Removed this I2C
read transfer as this info can be used from existing variable(linkstat).

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/otg/twl6030-usb.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/otg/twl6030-usb.c b/drivers/usb/otg/twl6030-usb.c
index eca4591..88989e6 100644
--- a/drivers/usb/otg/twl6030-usb.c
+++ b/drivers/usb/otg/twl6030-usb.c
@@ -149,7 +149,6 @@ static int twl6030_set_phy_clk(struct otg_transceiver *x, int on)
 
 static int twl6030_phy_init(struct otg_transceiver *x)
 {
-	u8 hw_state;
 	struct twl6030_usb *twl;
 	struct device *dev;
 	struct twl4030_usb_data *pdata;
@@ -158,9 +157,7 @@ static int twl6030_phy_init(struct otg_transceiver *x)
 	dev  = twl->dev;
 	pdata = dev->platform_data;
 
-	hw_state = twl6030_readb(twl, TWL6030_MODULE_ID0, STS_HW_CONDITIONS);
-
-	if (hw_state & STS_USB_ID)
+	if (twl->linkstat == USB_EVENT_ID)
 		pdata->phy_power(twl->dev, 1, 1);
 	else
 		pdata->phy_power(twl->dev, 0, 1);
@@ -290,6 +287,7 @@ static irqreturn_t twl6030_usbotg_irq(int irq, void *_twl)
 		status = USB_EVENT_ID;
 		twl->otg.default_a = true;
 		twl->otg.state = OTG_STATE_A_IDLE;
+		twl->linkstat = status;
 		blocking_notifier_call_chain(&twl->otg.notifier, status,
 							twl->otg.gadget);
 	} else  {
@@ -299,7 +297,6 @@ static irqreturn_t twl6030_usbotg_irq(int irq, void *_twl)
 								0x1);
 	}
 	twl6030_writeb(twl, TWL_MODULE_USB, USB_ID_INT_LATCH_CLR, status);
-	twl->linkstat = status;
 
 	return IRQ_HANDLED;
 }
-- 
1.7.4.rc2

