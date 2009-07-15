From: <gregkh-l3A5Bk7waGM@public.gmane.org>
Subject: patch usb-omap-ohci-hc_driver-s-stop-method-should-call-ohci_stop.patch added to gregkh-2.6 tree
Date: Wed, 15 Jul 2009 07:00:16 -0700
Message-ID: <12476664161827@kroah.org>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0305D662CF@dbde02.ent.ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0305D662CF-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gadiyar-l0cyMroinI0@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vikram.pandita-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    Subject: USB: OMAP: OHCI: hc_driver's stop method should call ohci_stop

to my gregkh-2.6 tree.  Its filename is

    usb-omap-ohci-hc_driver-s-stop-method-should-call-ohci_stop.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From gadiyar-l0cyMroinI0@public.gmane.org  Wed Jul 15 06:34:11 2009
From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Date: Tue, 14 Jul 2009 16:41:00 +0530
Subject: USB: OMAP: OHCI: hc_driver's stop method should call ohci_stop
To: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0305D662CF-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>


From: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>

OMAP: OHCI: hc_driver's stop method should call ohci_stop

Without this, the ohci-omap driver will not cleanup the debugfs
nodes when the driver is unloaded. So the next insmod will fail,
if CONFIG_DEBUG_FS and CONFIG_USB_DEBUG are both selected.

Reported-by: vikram pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
Signed-off-by: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>

---
 drivers/usb/host/ohci-omap.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -282,6 +282,7 @@ static int ohci_omap_init(struct usb_hcd
 static void ohci_omap_stop(struct usb_hcd *hcd)
 {
 	dev_dbg(hcd->self.controller, "stopping USB Controller\n");
+	ohci_stop(hcd);
 	omap_ohci_clock_power(0);
 }
 

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
