From: Dima Zavin <dima-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] usb: musb: omap2430: handle charger OTG xceiver event
Date: Mon, 11 Jul 2011 15:43:17 -0700
Message-ID: <1310424197-22909-1-git-send-email-dima@android.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dima Zavin <dima-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Set a flag on OTG charger event and check it on cable
remove event (i.e. USB_EVENT_NONE). This way we will
not need to power up the PHY when an external charger
is detected by the transceiver itself.

Signed-off-by: Dima Zavin <dima-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/musb/musb_core.h |    1 +
 drivers/usb/musb/omap2430.c  |   12 ++++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 0e053b5..f65269d 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -497,6 +497,7 @@ struct musb {
 	struct usb_gadget	g;			/* the gadget */
 	struct usb_gadget_driver *gadget_driver;	/* its driver */
 #endif
+	bool			is_ac_charger:1;
 
 	/*
 	 * FIXME: Remove this flag.
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index c5d4c44..ac4cfbc 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -257,6 +257,11 @@ static int musb_otg_notifications(struct notifier_block *nb,
 		}
 		break;
 
+	case USB_EVENT_CHARGER:
+		dev_dbg(musb->controller, "Dedicated charger connect\n");
+		musb->is_ac_charger = true;
+		break;
+
 	case USB_EVENT_VBUS:
 		dev_dbg(musb->controller, "VBUS Connect\n");
 
@@ -268,6 +273,13 @@ static int musb_otg_notifications(struct notifier_block *nb,
 		break;
 
 	case USB_EVENT_NONE:
+		if (musb->is_ac_charger) {
+			dev_dbg(musb->controller,
+				"Dedicated charger disconnect\n");
+			musb->is_ac_charger = false;
+			break;
+		}
+
 		dev_dbg(musb->controller, "VBUS Disconnect\n");
 
 #ifdef CONFIG_USB_GADGET_MUSB_HDRC
-- 
1.7.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
