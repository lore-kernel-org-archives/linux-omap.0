From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 07/17] OMAP: DSS2: move wait_vsync()
Date: Mon,  8 Feb 2010 17:57:31 +0200
Message-ID: <1265644661-3694-8-git-send-email-tomi.valkeinen@nokia.com>
References: <1265644661-3694-1-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-2-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-3-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-4-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-5-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-6-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-7-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:26929 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753601Ab0BHPze (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 10:55:34 -0500
In-Reply-To: <1265644661-3694-7-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Move wait_vsync() from omap_dss_device to overlay manager.

This is part of a larger patch-set, which moves the control from omapdss
driver to the display driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 arch/arm/plat-omap/include/plat/display.h |    2 +-
 drivers/video/omap2/dss/display.c         |   14 --------------
 drivers/video/omap2/dss/manager.c         |   14 ++++++++++++++
 drivers/video/omap2/omapfb/omapfb-ioctl.c |    2 +-
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index 2fd3c10..2308912 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -370,6 +370,7 @@ struct omap_overlay_manager {
 
 	int (*apply)(struct omap_overlay_manager *mgr);
 	int (*wait_for_go)(struct omap_overlay_manager *mgr);
+	int (*wait_for_vsync)(struct omap_overlay_manager *mgr);
 };
 
 struct omap_dss_device {
@@ -482,7 +483,6 @@ struct omap_dss_device {
 	int (*update)(struct omap_dss_device *dssdev,
 			       u16 x, u16 y, u16 w, u16 h);
 	int (*sync)(struct omap_dss_device *dssdev);
-	int (*wait_vsync)(struct omap_dss_device *dssdev);
 
 	int (*set_update_mode)(struct omap_dss_device *dssdev,
 			enum omap_dss_update_mode);
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 5989afb..987a8ae 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -323,19 +323,6 @@ void default_get_overlay_fifo_thresholds(enum omap_plane plane,
 	*fifo_low = fifo_size - burst_size_bytes;
 }
 
-static int default_wait_vsync(struct omap_dss_device *dssdev)
-{
-	unsigned long timeout = msecs_to_jiffies(500);
-	u32 irq;
-
-	if (dssdev->type == OMAP_DISPLAY_TYPE_VENC)
-		irq = DISPC_IRQ_EVSYNC_ODD;
-	else
-		irq = DISPC_IRQ_VSYNC;
-
-	return omap_dispc_wait_for_irq_interruptible_timeout(irq, timeout);
-}
-
 static int default_get_recommended_bpp(struct omap_dss_device *dssdev)
 {
 	if (dssdev->panel.recommended_bpp)
@@ -427,7 +414,6 @@ void dss_init_device(struct platform_device *pdev,
 
 	dssdev->get_resolution = default_get_resolution;
 	dssdev->get_recommended_bpp = default_get_recommended_bpp;
-	dssdev->wait_vsync = default_wait_vsync;
 
 	switch (dssdev->type) {
 	case OMAP_DISPLAY_TYPE_DPI:
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 27d9c46..486cd4a 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -501,6 +501,19 @@ static int omap_dss_unset_device(struct omap_overlay_manager *mgr)
 	return 0;
 }
 
+static int dss_mgr_wait_for_vsync(struct omap_overlay_manager *mgr)
+{
+	unsigned long timeout = msecs_to_jiffies(500);
+	u32 irq;
+
+	if (mgr->device->type == OMAP_DISPLAY_TYPE_VENC)
+		irq = DISPC_IRQ_EVSYNC_ODD;
+	else
+		irq = DISPC_IRQ_VSYNC;
+
+	return omap_dispc_wait_for_irq_interruptible_timeout(irq, timeout);
+}
+
 static int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr)
 {
 	unsigned long timeout = msecs_to_jiffies(500);
@@ -1394,6 +1407,7 @@ int dss_init_overlay_managers(struct platform_device *pdev)
 		mgr->set_manager_info = &omap_dss_mgr_set_info;
 		mgr->get_manager_info = &omap_dss_mgr_get_info;
 		mgr->wait_for_go = &dss_mgr_wait_for_go;
+		mgr->wait_for_vsync = &dss_mgr_wait_for_vsync;
 
 		mgr->caps = OMAP_DSS_OVL_MGR_CAP_DISPC;
 
diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/omap2/omapfb/omapfb-ioctl.c
index f3c9c80..4e1b0cc 100644
--- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
@@ -700,7 +700,7 @@ int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd, unsigned long arg)
 			break;
 		}
 
-		r = display->wait_vsync(display);
+		r = display->manager->wait_for_vsync(display->manager);
 		break;
 
 	case OMAPFB_WAITFORGO:
-- 
1.6.5

