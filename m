From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] usb: omap: fix the warning return type defaults to 'int'
Date: Tue,  5 Oct 2010 02:19:53 +0530
Message-ID: <1286225393-22472-1-git-send-email-keshava_mgowda@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gadiyar-l0cyMroinI0@public.gmane.org, nskamat-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


This patch fix the follwing warning when compiling usb code 
for OMAP defconfigs.
arch/arm/plat-omap/include/plat/usb.h:109: warning: return type defaults
to 'int'

Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
---
 arch/arm/plat-omap/include/plat/usb.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/arch/arm/plat-omap/include/plat/usb.h
===================================================================
--- linux-2.6.orig/arch/arm/plat-omap/include/plat/usb.h
+++ linux-2.6/arch/arm/plat-omap/include/plat/usb.h
@@ -105,7 +105,7 @@ static inline void omap1_usb_init(struct
 #if defined(CONFIG_ARCH_OMAP_OTG) || defined(CONFIG_ARCH_OMAP_OTG_MODULE)
 void omap2_usbfs_init(struct omap_usb_config *pdata);
 #else
-static inline omap2_usbfs_init(struct omap_usb_config *pdata)
+static inline void omap2_usbfs_init(struct omap_usb_config *pdata)
 {
 }
 #endif
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
