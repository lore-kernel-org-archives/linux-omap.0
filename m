From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [patch-v2.6.39 07/19] usb: musb: OMAP3xxx: Fix device detection in otg & host mode
Date: Tue,  1 Mar 2011 17:15:28 +0200
Message-ID: <1298992540-5984-8-git-send-email-balbi@ti.com>
References: <1298992540-5984-1-git-send-email-balbi@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1298992540-5984-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>

In OMAP3xxx with OTG mode or host only mode, When the device
is inserted after the gadget driver loading the enumeration was not
through. This is because the mentor controller will start sensing the
ID PIN only after setting the session bit.
So after ID-GND, need to set the session bit for mentor to get it
configured as A device.

This is a fix to set the session bit again in ID_GND notification handler.
Tested with OMAP3630Zoom3 platform.

Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/omap2430.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 4726798..f5d4f36 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -246,19 +246,13 @@ static int musb_otg_notifications(struct notifier_block *nb,
 			if (musb->gadget_driver) {
 				pm_runtime_get_sync(musb->controller);
 				otg_init(musb->xceiv);
-
-				if (data->interface_type ==
-						MUSB_INTERFACE_UTMI)
-					omap2430_musb_set_vbus(musb, 1);
