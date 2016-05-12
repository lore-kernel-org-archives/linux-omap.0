From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 05/15] usb: musb: Remove conditional PM runtime calls for musb_gadget
Date: Wed, 11 May 2016 17:53:06 -0700
Message-ID: <1463014396-4095-6-git-send-email-tony@atomide.com>
References: <1463014396-4095-1-git-send-email-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463014396-4095-1-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The conditional use of PM runtime does not work properly
for musb gadget. On cable disconnect we may not get any
USB_EVENT_NONE leaving the PM runtime call unpaired.

Let's fix the issue by making sure the PM runtime calls are
paired within the functions. The glue layer will take care
of the rest.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/musb/musb_gadget.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index fff5a8a..7ecc893 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1914,8 +1914,8 @@ static int musb_gadget_start(struct usb_gadget *g,
 	if (musb->xceiv->last_event == USB_EVENT_ID)
 		musb_platform_set_vbus(musb, 1);
 
-	if (musb->xceiv->last_event == USB_EVENT_NONE)
-		pm_runtime_put(musb->controller);
+	pm_runtime_mark_last_busy(musb->controller);
+	pm_runtime_put_autosuspend(musb->controller);
 
 	return 0;
 
@@ -1934,8 +1934,7 @@ static int musb_gadget_stop(struct usb_gadget *g)
 	struct musb	*musb = gadget_to_musb(g);
 	unsigned long	flags;
 
-	if (musb->xceiv->last_event == USB_EVENT_NONE)
-		pm_runtime_get_sync(musb->controller);
+	pm_runtime_get_sync(musb->controller);
 
 	/*
 	 * REVISIT always use otg_set_peripheral() here too;
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
