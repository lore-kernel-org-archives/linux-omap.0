From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 03/10] usb: musb: Fix PM runtime handling for connected cable
Date: Thu, 28 Apr 2016 10:33:13 -0700
Message-ID: <1461864800-29979-4-git-send-email-tony@atomide.com>
References: <1461864800-29979-1-git-send-email-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461864800-29979-1-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

We may have drivers loaded but no configured gadgets
and MUSB may be in host mode. If gadgets are configured
during host mode, PM runtime will get confused.

Disconnect PM runtime from gadget state, and do it only
based on the cable.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/musb/omap2430.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index c84e0322..9d3645f 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -259,6 +259,13 @@ static void omap_musb_set_mailbox(struct omap2430_glue *glue)
 	struct musb_hdrc_platform_data *pdata = dev_get_platdata(dev);
 	struct omap_musb_board_data *data = pdata->board_data;
 	struct usb_otg *otg = musb->xceiv->otg;
+	bool cable_connected;
+
+	cable_connected = ((glue->status & MUSB_ID_GROUND) ||
+			   (glue->status & MUSB_VBUS_VALID));
+
+	if (cable_connected)
+		pm_runtime_get_sync(dev);
 
 	switch (glue->status) {
 	case MUSB_ID_GROUND:
@@ -268,7 +275,6 @@ static void omap_musb_set_mailbox(struct omap2430_glue *glue)
 		musb->xceiv->otg->state = OTG_STATE_A_IDLE;
 		musb->xceiv->last_event = USB_EVENT_ID;
 		if (musb->gadget_driver) {
-			pm_runtime_get_sync(dev);
 			omap_control_usb_set_mode(glue->control_otghs,
 				USB_MODE_HOST);
 			omap2430_musb_set_vbus(musb, 1);
@@ -281,8 +287,6 @@ static void omap_musb_set_mailbox(struct omap2430_glue *glue)
 		otg->default_a = false;
 		musb->xceiv->otg->state = OTG_STATE_B_IDLE;
 		musb->xceiv->last_event = USB_EVENT_VBUS;
-		if (musb->gadget_driver)
-			pm_runtime_get_sync(dev);
 		omap_control_usb_set_mode(glue->control_otghs, USB_MODE_DEVICE);
 		break;
 
@@ -291,11 +295,8 @@ static void omap_musb_set_mailbox(struct omap2430_glue *glue)
 		dev_dbg(dev, "VBUS Disconnect\n");
 
 		musb->xceiv->last_event = USB_EVENT_NONE;
-		if (musb->gadget_driver) {
+		if (musb->gadget_driver)
 			omap2430_musb_set_vbus(musb, 0);
-			pm_runtime_mark_last_busy(dev);
-			pm_runtime_put_autosuspend(dev);
-		}
 
 		if (data->interface_type == MUSB_INTERFACE_UTMI)
 			otg_set_vbus(musb->xceiv->otg, 0);
@@ -307,6 +308,11 @@ static void omap_musb_set_mailbox(struct omap2430_glue *glue)
 		dev_dbg(dev, "ID float\n");
 	}
 
+	if (!cable_connected) {
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+	}
+
 	atomic_notifier_call_chain(&musb->xceiv->notifier,
 			musb->xceiv->last_event, NULL);
 }
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
