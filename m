From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] usb: musb: fix build break due to partial rename
Date: Sat,  2 Oct 2010 02:04:24 +0530
Message-ID: <1285965264-17972-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, Uwe Kleine-Koenig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Michal Nazarewicz <m.nazarewicz-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Patch "usb gadget: don't save bind callback in struct usb_gadget_driver"
in Greg's USB queue missed one conversion of
usb_gadget_register_driver to usb_gadget_probe_driver,
causing a build break when MUSB is built in gadget mode.

Fix this.

Reported-by: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: Uwe Kleine-Koenig<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Michal Nazarewicz <m.nazarewicz-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
---
Greg,

Since Uwe's original patch isn't yet in mainline, maybe you could
fold this patch into the original.

 drivers/usb/musb/musb_gadget.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/usb/musb/musb_gadget.c
===================================================================
--- linux-2.6.orig/drivers/usb/musb/musb_gadget.c
+++ linux-2.6/drivers/usb/musb/musb_gadget.c
@@ -1786,7 +1786,7 @@ int usb_gadget_probe_driver(struct usb_g
 
 	return retval;
 }
-EXPORT_SYMBOL(usb_gadget_register_driver);
+EXPORT_SYMBOL(usb_gadget_probe_driver);
 
 static void stop_activity(struct musb *musb, struct usb_gadget_driver *driver)
 {
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
