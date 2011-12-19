From: Felipe Contreras <felipe.contreras-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 2/4] usb: musb: trivial cleanup
Date: Mon, 19 Dec 2011 22:17:49 +0200
Message-ID: <1324325871-15137-3-git-send-email-felipe.contreras@nokia.com>
References: <1324325871-15137-1-git-send-email-felipe.contreras@nokia.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1324325871-15137-1-git-send-email-felipe.contreras-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Jiri Kosina <trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

enabled && driver || !enabled can be simplified to !enabled || driver.

Signed-off-by: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/musb/omap2430.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 1a5d45e..6f574ec 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -236,13 +236,7 @@ static int musb_otg_notifications(struct notifier_block *nb,
 	case USB_EVENT_ID:
 		dev_dbg(musb->controller, "ID GND\n");
 
-		if (is_otg_enabled(musb)) {
-			if (musb->gadget_driver) {
-				pm_runtime_get_sync(musb->controller);
-				otg_init(musb->xceiv);
-				omap2430_musb_set_vbus(musb, 1);
-			}
-		} else {
+		if (!is_otg_enabled(musb) || musb->gadget_driver) {
 			pm_runtime_get_sync(musb->controller);
 			otg_init(musb->xceiv);
 			omap2430_musb_set_vbus(musb, 1);
-- 
1.7.8

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
