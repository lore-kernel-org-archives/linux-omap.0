From: Hema HK <hemahk@ti.com>
Subject: [6/7 v2] usb: otg: TWL6030 Save the last event in otg_transceiver
Date: Tue, 15 Feb 2011 15:12:37 +0530
Message-ID: <1297762958-26199-6-git-send-email-hemahk@ti.com>
References: <1297762958-26199-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58652 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754624Ab1BOJnY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 04:43:24 -0500
In-Reply-To: <1297762958-26199-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, "Kalliguddi, Hema" <hemahk@ti.com>, Felipe Balbi <balbi@ti.com>

From: Kalliguddi, Hema <hemahk@ti.com>

Save the last event in the otg_transceiver so that it can used in the
musb driver and gadget driver to configure the musb and enable the 
vbus for host mode and OTG mode, if the device is connected during boot.

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <balbi@ti.com>

---
[Reusing some part of the patch[1] posted by Arnaud Mandy]
[1] http://permalink.gmane.org/gmane.linux.usb.general/37123
---
 drivers/usb/otg/twl6030-usb.c |    3 +++
 include/linux/usb/otg.h       |    1 +
 2 files changed, 4 insertions(+)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

Index: linux-2.6/drivers/usb/otg/twl6030-usb.c
===================================================================
--- linux-2.6.orig/drivers/usb/otg/twl6030-usb.c
+++ linux-2.6/drivers/usb/otg/twl6030-usb.c
@@ -265,11 +265,13 @@ static irqreturn_t twl6030_usb_irq(int i
 			twl->otg.default_a = false;
 			twl->otg.state = OTG_STATE_B_IDLE;
 			twl->linkstat = status;
+			twl->otg.last_event = status;
 			blocking_notifier_call_chain(&twl->otg.notifier,
 						status, twl->otg.gadget);
 		} else {
 			status = USB_EVENT_NONE;
 			twl->linkstat = status;
+			twl->otg.last_event = status;
 			blocking_notifier_call_chain(&twl->otg.notifier,
 						status, twl->otg.gadget);
 			if (twl->asleep) {
@@ -302,6 +304,7 @@ static irqreturn_t twl6030_usbotg_irq(in
 		twl->otg.default_a = true;
 		twl->otg.state = OTG_STATE_A_IDLE;
 		twl->linkstat = status;
+		twl->otg.last_event = status;
 		blocking_notifier_call_chain(&twl->otg.notifier, status,
 							twl->otg.gadget);
 	} else  {
Index: linux-2.6/include/linux/usb/otg.h
===================================================================
--- linux-2.6.orig/include/linux/usb/otg.h
+++ linux-2.6/include/linux/usb/otg.h
@@ -66,6 +66,7 @@ struct otg_transceiver {
 
 	u8			default_a;
 	enum usb_otg_state	state;
+	enum usb_xceiv_events	last_event;
 
 	struct usb_bus		*host;
 	struct usb_gadget	*gadget;
