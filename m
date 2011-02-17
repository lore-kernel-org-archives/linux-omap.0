From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [patch-v2.6.39 10/12] usb: otg: TWL6030 Save the last event in otg_transceiver
Date: Thu, 17 Feb 2011 14:38:47 +0200
Message-ID: <1297946329-9353-11-git-send-email-balbi@ti.com>
References: <1297946329-9353-1-git-send-email-balbi@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297946329-9353-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>

Save the last event in the otg_transceiver so that it can used in the
musb driver and gadget driver to configure the musb and enable the
vbus for host mode and OTG mode, if the device is connected during boot.

Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/otg/twl6030-usb.c |    3 +++
 include/linux/usb/otg.h       |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/otg/twl6030-usb.c b/drivers/usb/otg/twl6030-usb.c
index b4eda02..05f17b7 100644
--- a/drivers/usb/otg/twl6030-usb.c
+++ b/drivers/usb/otg/twl6030-usb.c
@@ -262,11 +262,13 @@ static irqreturn_t twl6030_usb_irq(int irq, void *_twl)
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
@@ -299,6 +301,7 @@ static irqreturn_t twl6030_usbotg_irq(int irq, void *_twl)
 		twl->otg.default_a = true;
 		twl->otg.state = OTG_STATE_A_IDLE;
 		twl->linkstat = status;
+		twl->otg.last_event = status;
 		blocking_notifier_call_chain(&twl->otg.notifier, status,
 							twl->otg.gadget);
 	} else  {
diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
index a1a1e7a..da511ee 100644
--- a/include/linux/usb/otg.h
+++ b/include/linux/usb/otg.h
@@ -66,6 +66,7 @@ struct otg_transceiver {
 
 	u8			default_a;
 	enum usb_otg_state	state;
+	enum usb_xceiv_events	last_event;
 
 	struct usb_bus		*host;
 	struct usb_gadget	*gadget;
-- 
1.7.4.rc2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
