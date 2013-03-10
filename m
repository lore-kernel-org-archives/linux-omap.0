From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] usb: musb: gadget: clear gadget_driver when gadget is stopped
Date: Sun, 10 Mar 2013 02:49:14 +0200
Message-ID: <1362876554-7053-1-git-send-email-notasas@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Some musb glue drivers use gadget_driver pointer to know if any gadget
drivers are loaded at some moment and base further decisions on it,
like to do runtime suspend/resume or not. Right now the pointer is
left alone on stop and OMAP musb glue later does wrong runtime_pm
decisions because of it.

Clear the gadget_driver pointer on remove, it's invalid after stop
anyway.

Signed-off-by: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/musb/musb_gadget.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 19998e9..1ddb889 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -2057,6 +2057,7 @@ static int musb_gadget_stop(struct usb_gadget *g,
 	dev_dbg(musb->controller, "unregistering driver %s\n", driver->function);
 
 	musb->is_active = 0;
+	musb->gadget_driver = NULL;
 	musb_platform_try_idle(musb, 0);
 	spin_unlock_irqrestore(&musb->lock, flags);
 
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
