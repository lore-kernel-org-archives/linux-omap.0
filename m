From: Hema HK <hemahk@ti.com>
Subject: [PATCH 2/8 v2] usb: musb: Remove board_data parameter from musb_platform_init()
Date: Wed, 18 Aug 2010 19:36:09 +0530
Message-ID: <1282140369-28703-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51538 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753070Ab0HROGZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Aug 2010 10:06:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Hema HK <hemahk@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Removed the board_data parameter being passed to musb_platform_init function
as board data can be extracted from device structure which is already member of
musb structure.

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 drivers/usb/musb/blackfin.c  |    2 +-
 drivers/usb/musb/davinci.c   |    2 +-
 drivers/usb/musb/musb_core.c |    2 +-
 drivers/usb/musb/musb_core.h |    2 +-
 drivers/usb/musb/omap2430.c  |    6 ++++--
 drivers/usb/musb/tusb6010.c  |    2 +-
 6 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/musb/blackfin.c b/drivers/usb/musb/blackfin.c
index b611420..0bef011 100644
--- a/drivers/usb/musb/blackfin.c
+++ b/drivers/usb/musb/blackfin.c
@@ -323,7 +323,7 @@ int musb_platform_set_mode(struct musb *musb, u8 musb_mode)
 	return -EIO;
 }
 
-int __init musb_platform_init(struct musb *musb, void *board_data)
+int __init musb_platform_init(struct musb *musb)
 {
 
 	/*
diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
index 5762436..ce2e16f 100644
--- a/drivers/usb/musb/davinci.c
+++ b/drivers/usb/musb/davinci.c
@@ -376,7 +376,7 @@ int musb_platform_set_mode(struct musb *musb, u8 mode)
 	return -EIO;
 }
 
-int __init musb_platform_init(struct musb *musb, void *board_data)
+int __init musb_platform_init(struct musb *musb)
 {
 	void __iomem	*tibase = musb->ctrl_base;
 	u32		revision;
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 447ea9b..2a50d12 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2023,7 +2023,7 @@ bad_config:
 	 * isp1504, non-OTG, etc) mostly hooking up through ULPI.
 	 */
 	musb->isr = generic_interrupt;
-	status = musb_platform_init(musb, plat->board_data);
+	status = musb_platform_init(musb);
 	if (status < 0)
 		goto fail2;
 
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 91d6779..85a92fd 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -612,7 +612,7 @@ extern int musb_platform_get_vbus_status(struct musb *musb);
 #define musb_platform_get_vbus_status(x)	0
 #endif
 
-extern int __init musb_platform_init(struct musb *musb, void *board_data);
+extern int __init musb_platform_init(struct musb *musb);
 extern int musb_platform_exit(struct musb *musb);
 
 #endif	/* __MUSB_CORE_H__ */
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 5f04d3f..3bae428 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -189,10 +189,12 @@ int musb_platform_set_mode(struct musb *musb, u8 musb_mode)
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
 
 	/* We require some kind of external transceiver, hooked
 	 * up through ULPI.  TWL4030-family PMICs include one,
diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index 3c48e77..ab776a8 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -1091,7 +1091,7 @@ err:
 	return -ENODEV;
 }
 
-int __init musb_platform_init(struct musb *musb, void *board_data)
+int __init musb_platform_init(struct musb *musb)
 {
 	struct platform_device	*pdev;
 	struct resource		*mem;
-- 
1.7.0.4

