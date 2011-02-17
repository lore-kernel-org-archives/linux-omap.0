From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Subject: [7/7 v4] usb: musb: OMAP4430: Fix usb device detection if connected during boot
Date: Thu, 17 Feb 2011 12:06:10 +0530
Message-ID: <1297924570-3750-7-git-send-email-hemahk@ti.com>
References: <1297924570-3750-1-git-send-email-hemahk@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297924570-3750-1-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Kalliguddi, Hema <hemahk-l0cyMroinI0@public.gmane.org>

OMAP4430 is embedded with UTMI PHY. This PHY does not support the
OTG features like ID pin detection and VBUS detection. This function
is exported to an external companion chip TWL6030. Software must retrieve
the OTG HNP and SRP status from the TWL6030 and configure the bits inside
the control module that drive the related USBOTGHS UTMI interface signals.
It must also read back the UTMI signals needed to configure the TWL6030 
OTG module.

Can find more details in the TRM[1].
[1]:http://focus.ti.com/pdfs/wtbu/OMAP4430_ES2.0_Public_TRM_vJ.pdf

In OMAP4430 musb driver VBUS and ID notifications are received from the
transceiver driver. If the cable/device is connected during boot,
notifications from transceiver driver will be missed till musb driver
is loaded.
Patch to configure the transceiver in the platform_enable/disable
functions and enable the vbus in the gadget driver based on the 
last_event of the otg_transceiver.

Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
---
drivers/usb/musb/musb_gadget.c |    4 +++
 drivers/usb/musb/musb_gadget.c |    4 +++
 drivers/usb/musb/omap2430.c    |   53 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 52 insertions(+), 5 deletions(-)

Index: linux-2.6/drivers/usb/musb/musb_gadget.c
===================================================================
--- linux-2.6.orig/drivers/usb/musb/musb_gadget.c
+++ linux-2.6/drivers/usb/musb/musb_gadget.c
@@ -1855,6 +1855,10 @@ int usb_gadget_probe_driver(struct usb_g
 			} else {
 				hcd->self.uses_pio_for_control = 1;
 			}
+
+			if ((musb->xceiv->last_event == USB_EVENT_ID)
+						&& musb->xceiv->set_vbus)
+				otg_set_vbus(musb->xceiv, 1);
 		}
 	}
 
Index: linux-2.6/drivers/usb/musb/omap2430.c
===================================================================
--- linux-2.6.orig/drivers/usb/musb/omap2430.c
+++ linux-2.6/drivers/usb/musb/omap2430.c
@@ -328,16 +328,56 @@ static int omap2430_musb_init(struct mus
 	if (status)
 		DBG(1, "notification register failed\n");
 
-	/* check whether cable is already connected */
-	if (musb->xceiv->state ==OTG_STATE_B_IDLE)
-		musb_otg_notifications(&musb->nb, 1,
-					musb->xceiv->gadget);
-
 	setup_timer(&musb_idle_timer, musb_do_idle, (unsigned long) musb);
 
 	return 0;
 }
 
+static void omap2430_musb_enable(struct musb *musb)
+{
+	u8		devctl;
+	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
+	struct device *dev = musb->controller;
+	struct musb_hdrc_platform_data *pdata = dev->platform_data;
+	struct omap_musb_board_data *data = pdata->board_data;
+
+	switch (musb->xceiv->last_event) {
+
+	case USB_EVENT_ID:
+		otg_init(musb->xceiv);
+		if (data->interface_type == MUSB_INTERFACE_UTMI) {
+			devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
+			/* start the session */
+			devctl |= MUSB_DEVCTL_SESSION;
+			musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
+			while (musb_readb(musb->mregs, MUSB_DEVCTL) &
+						MUSB_DEVCTL_BDEVICE) {
+				cpu_relax();
+
+				if (time_after(jiffies, timeout)) {
+					dev_err(musb->controller,
+					"configured as A device timeout");
+					break;
+				}
+			}
+		}
+		break;
+
+	case USB_EVENT_VBUS:
+		otg_init(musb->xceiv);
+		break;
+
+	default:
+		break;
+	}
+}
+
+static void omap2430_musb_disable(struct musb *musb)
+{
+	if (musb->xceiv->last_event)
+		otg_shutdown(musb->xceiv);
+}
+
 static int omap2430_musb_exit(struct musb *musb)
 {
 
@@ -355,6 +395,9 @@ static const struct musb_platform_ops om
 	.try_idle	= omap2430_musb_try_idle,
 
 	.set_vbus	= omap2430_musb_set_vbus,
+
+	.enable		= omap2430_musb_enable,
+	.disable	= omap2430_musb_disable,
 };
 
 static u64 omap2430_dmamask = DMA_BIT_MASK(32);
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
