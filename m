From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] usb: omap: ohci: Missing driver unregister in module exit
Date: Tue, 14 Sep 2010 04:40:01 +0530
Message-ID: <1284419401-32101-1-git-send-email-keshava_mgowda@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gadiyar-l0cyMroinI0@public.gmane.org, nskamat-l0cyMroinI0@public.gmane.org, Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The un-registration of OHCI driver was not done in 
the ohci_hcd_mod_exit function. This was affecting rmmod command not
to work for OMAP3 platforms.
The platform driver un-registration for OMAP3 platforms is perfomed
while removing the OHCI module from kernel.

Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/host/ohci-hcd.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6/drivers/usb/host/ohci-hcd.c
===================================================================
--- linux-2.6.orig/drivers/usb/host/ohci-hcd.c
+++ linux-2.6/drivers/usb/host/ohci-hcd.c
@@ -1270,6 +1270,9 @@ static void __exit ohci_hcd_mod_exit(voi
 #ifdef PLATFORM_DRIVER
 	platform_driver_unregister(&PLATFORM_DRIVER);
 #endif
+#ifdef OMAP3_PLATFORM_DRIVER
+	platform_driver_unregister(&OMAP3_PLATFORM_DRIVER);
+#endif
 #ifdef PS3_SYSTEM_BUS_DRIVER
 	ps3_ohci_driver_unregister(&PS3_SYSTEM_BUS_DRIVER);
 #endif
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
