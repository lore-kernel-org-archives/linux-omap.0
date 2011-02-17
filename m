From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Subject: [6/7 v4] usb: otg: TWL6030 Save the last event in otg_transceiver
Date: Thu, 17 Feb 2011 12:06:09 +0530
Message-ID: <1297924570-3750-6-git-send-email-hemahk@ti.com>
References: <1297924570-3750-1-git-send-email-hemahk@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297924570-3750-1-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Kalliguddi, Hema <hemahk-l0cyMroinI0@public.gmane.org>

Save the last event in the otg_transceiver so that it can used in the
musb driver and gadget driver to configure the musb and enable the 
vbus for host mode and OTG mode, if the device is connected during boot.

Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
---
[Reusing some part of the patch[1] posted by Arnaud Mandy]
[1] http://permalink.gmane.org/gmane.linux.usb.general/37123
---
 drivers/usb/otg/twl6030-usb.c |    3 +++
 include/linux/usb/otg.h       |    1 +
 2 files changed, 4 insertions(+)

Index: linux-2.6/drivers/usb/otg/twl6030-usb.c
===================================================================
--- linux-2.6.orig/drivers/usb/otg/twl6030-usb.c
+++ linux-2.6/drivers/usb/otg/twl6030-usb.c
@@ -262,11 +262,13 @@ static irqreturn_t twl6030_usb_irq(int i
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
@@ -299,6 +301,7 @@ static irqreturn_t twl6030_usbotg_irq(in
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
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
