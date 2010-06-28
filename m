From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/4] usb: musb: Remove board_data parameter from musb_platform_init()
Date: Mon, 28 Jun 2010 17:45:17 +0530
Message-ID: <1277727317-5879-1-git-send-email-hemahk@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Hema HK  <hemahk-l0cyMroinI0@public.gmane.org>

Removed the board_data parameter being passed to musb_platform_init function 
as board data can be extracted from device structure which is already member of 
musb structure.

Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>,tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
---
Based off  pm-wip/hwmods-omap4.

 drivers/usb/musb/blackfin.c  |    2 +-
 drivers/usb/musb/davinci.c   |    2 +-
 drivers/usb/musb/musb_core.c |    2 +-
 drivers/usb/musb/musb_core.h |    2 +-
 drivers/usb/musb/omap2430.c  |    6 ++++--
 drivers/usb/musb/tusb6010.c  |    2 +-
 6 files changed, 9 insertions(+), 7 deletions(-)

Index: linux-omap-pm/drivers/usb/musb/blackfin.c
===================================================================
--- linux-omap-pm.orig/drivers/usb/musb/blackfin.c
+++ linux-omap-pm/drivers/usb/musb/blackfin.c
@@ -323,7 +323,7 @@ int musb_platform_set_mode(struct musb *
 	return -EIO;
 }
 
-int __init musb_platform_init(struct musb *musb, void *board_data)
+int __init musb_platform_init(struct musb *musb)
 {
 
 	/*
Index: linux-omap-pm/drivers/usb/musb/davinci.c
===================================================================
--- linux-omap-pm.orig/drivers/usb/musb/davinci.c
+++ linux-omap-pm/drivers/usb/musb/davinci.c
@@ -376,7 +376,7 @@ int musb_platform_set_mode(struct musb *
 	return -EIO;
 }
 
-int __init musb_platform_init(struct musb *musb, void *board_data)
+int __init musb_platform_init(struct musb *musb)
 {
 	void __iomem	*tibase = musb->ctrl_base;
 	u32		revision;
Index: linux-omap-pm/drivers/usb/musb/musb_core.c
===================================================================
--- linux-omap-pm.orig/drivers/usb/musb/musb_core.c
+++ linux-omap-pm/drivers/usb/musb/musb_core.c
@@ -2026,7 +2026,7 @@ bad_config:
 	 * isp1504, non-OTG, etc) mostly hooking up through ULPI.
 	 */
 	musb->isr = generic_interrupt;
-	status = musb_platform_init(musb, plat->board_data);
+	status = musb_platform_init(musb);
 	if (status < 0)
 		goto fail2;
 
Index: linux-omap-pm/drivers/usb/musb/musb_core.h
===================================================================
--- linux-omap-pm.orig/drivers/usb/musb/musb_core.h
+++ linux-omap-pm/drivers/usb/musb/musb_core.h
@@ -610,7 +610,7 @@ extern int musb_platform_get_vbus_status
 #define musb_platform_get_vbus_status(x)	0
 #endif
 
-extern int __init musb_platform_init(struct musb *musb, void *board_data);
+extern int __init musb_platform_init(struct musb *musb);
 extern int musb_platform_exit(struct musb *musb);
 
 #endif	/* __MUSB_CORE_H__ */
Index: linux-omap-pm/drivers/usb/musb/omap2430.c
===================================================================
--- linux-omap-pm.orig/drivers/usb/musb/omap2430.c
+++ linux-omap-pm/drivers/usb/musb/omap2430.c
@@ -189,10 +189,12 @@ int musb_platform_set_mode(struct musb *
 	return 0;
 }
 
-int __init musb_platform_init(struct musb *musb, void *board_data)
+int __init musb_platform_init(struct musb *musb)
 {
 	u32 l;
-	struct omap_musb_board_data *data = board_data;
+	struct device *dev = musb->controller;
+	struct musb_hdrc_platform_data *plat = dev->platform_data;
+	struct omap_musb_board_data *data = plat->board_data;
 
 #if defined(CONFIG_ARCH_OMAP2430)
 	omap_cfg_reg(AE5_2430_USB0HS_STP);
Index: linux-omap-pm/drivers/usb/musb/tusb6010.c
===================================================================
--- linux-omap-pm.orig/drivers/usb/musb/tusb6010.c
+++ linux-omap-pm/drivers/usb/musb/tusb6010.c
@@ -1104,7 +1104,7 @@ err:
 	return -ENODEV;
 }
 
-int __init musb_platform_init(struct musb *musb, void *board_data)
+int __init musb_platform_init(struct musb *musb)
 {
 	struct platform_device	*pdev;
 	struct resource		*mem;
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
