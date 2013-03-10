From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 7/7] usb: musb: gadget: use platform callback to enable vbus
Date: Sun, 10 Mar 2013 03:08:01 +0200
Message-ID: <1362877681-8102-8-git-send-email-notasas@gmail.com>
References: <1362877681-8102-1-git-send-email-notasas@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1362877681-8102-1-git-send-email-notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>, Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On some platform configurations (like OMAP3+twl4030) it's the platform
code that enables VBUS, not OTG transceiver, so call vbus platform
callback instead, it will then call the transceiver if needed.

This fixes a use case where USB cable is plugged first and gadget
driver is loaded later after that.

Signed-off-by: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/musb/musb_gadget.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index be18537..19998e9 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1972,9 +1972,8 @@ static int musb_gadget_start(struct usb_gadget *g,
 		goto err;
 	}
 
-	if ((musb->xceiv->last_event == USB_EVENT_ID)
-				&& otg->set_vbus)
-		otg_set_vbus(otg, 1);
+	if (musb->xceiv->last_event == USB_EVENT_ID)
+		musb_platform_set_vbus(musb, 1);
 
 	hcd->self.uses_pio_for_control = 1;
 
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
