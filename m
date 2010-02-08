From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 06/17] OMAP: DSS2: move get/set_rotate()
Date: Mon,  8 Feb 2010 17:57:30 +0200
Message-ID: <1265644661-3694-7-git-send-email-tomi.valkeinen@nokia.com>
References: <1265644661-3694-1-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-2-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-3-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-4-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-5-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-6-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:45832 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409Ab0BHPzO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 10:55:14 -0500
In-Reply-To: <1265644661-3694-6-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Move get/set_rotate() from omap_dss_device to omap_dss_driver.

This is part of a larger patch-set, which moves the control from omapdss
driver to the display driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 arch/arm/plat-omap/include/plat/display.h |    3 --
 drivers/video/omap2/displays/panel-taal.c |    9 ++++++-
 drivers/video/omap2/dss/display.c         |    8 +++---
 drivers/video/omap2/dss/dsi.c             |   33 -----------------------------
 4 files changed, 11 insertions(+), 42 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index 4730e71..2fd3c10 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -492,9 +492,6 @@ struct omap_dss_device {
 	int (*enable_te)(struct omap_dss_device *dssdev, bool enable);
 	int (*get_te)(struct omap_dss_device *dssdev);
 
-	u8 (*get_rotate)(struct omap_dss_device *dssdev);
-	int (*set_rotate)(struct omap_dss_device *dssdev, u8 rotate);
-
 	int (*set_wss)(struct omap_dss_device *dssdev, u32 wss);
 	u32 (*get_wss)(struct omap_dss_device *dssdev);
 
diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 4d64449..8f90de0 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -772,16 +772,21 @@ static int taal_rotate(struct omap_dss_device *dssdev, u8 rotate)
 
 	dev_dbg(&dssdev->dev, "rotate %d\n", rotate);
 
+	dsi_bus_lock();
+
 	if (td->enabled) {
 		r = taal_set_addr_mode(rotate, td->mirror);
-
 		if (r)
-			return r;
+			goto err;
 	}
 
 	td->rotate = rotate;
 
+	dsi_bus_unlock();
 	return 0;
+err:
+	dsi_bus_unlock();
+	return r;
 }
 
 static u8 taal_get_rotate(struct omap_dss_device *dssdev)
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index ec82f5a..5989afb 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -185,9 +185,9 @@ static ssize_t display_rotate_show(struct device *dev,
 {
 	struct omap_dss_device *dssdev = to_dss_device(dev);
 	int rotate;
-	if (!dssdev->get_rotate)
+	if (!dssdev->driver->get_rotate)
 		return -ENOENT;
-	rotate = dssdev->get_rotate(dssdev);
+	rotate = dssdev->driver->get_rotate(dssdev);
 	return snprintf(buf, PAGE_SIZE, "%u\n", rotate);
 }
 
@@ -198,12 +198,12 @@ static ssize_t display_rotate_store(struct device *dev,
 	unsigned long rot;
 	int r;
 
-	if (!dssdev->set_rotate || !dssdev->get_rotate)
+	if (!dssdev->driver->set_rotate || !dssdev->driver->get_rotate)
 		return -ENOENT;
 
 	rot = simple_strtoul(buf, NULL, 0);
 
-	r = dssdev->set_rotate(dssdev, rot);
+	r = dssdev->driver->set_rotate(dssdev, rot);
 	if (r)
 		return r;
 
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 8f4f28d..8d6a436 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -3530,36 +3530,6 @@ static int dsi_display_get_te(struct omap_dss_device *dssdev)
 	return dsi.te_enabled;
 }
 
-static int dsi_display_set_rotate(struct omap_dss_device *dssdev, u8 rotate)
-{
-
-	DSSDBGF("%d", rotate);
-
-	if (!dssdev->driver->set_rotate || !dssdev->driver->get_rotate)
-		return -EINVAL;
-
-	dsi_bus_lock();
-	dssdev->driver->set_rotate(dssdev, rotate);
-	if (dsi.update_mode == OMAP_DSS_UPDATE_AUTO) {
-		u16 w, h;
-		/* the display dimensions may have changed, so set a new
-		 * update region */
-		dssdev->get_resolution(dssdev, &w, &h);
-		dsi_set_update_region(dssdev, 0, 0, w, h);
-	}
-	dsi_bus_unlock();
-
-	return 0;
-}
-
-static u8 dsi_display_get_rotate(struct omap_dss_device *dssdev)
-{
-	if (!dssdev->driver->set_rotate || !dssdev->driver->get_rotate)
-		return 0;
-
-	return dssdev->driver->get_rotate(dssdev);
-}
-
 void dsi_get_overlay_fifo_thresholds(enum omap_plane plane,
 		u32 fifo_size, enum omap_burst_size *burst_size,
 		u32 *fifo_low, u32 *fifo_high)
@@ -3588,9 +3558,6 @@ int dsi_init_display(struct omap_dss_device *dssdev)
 	dssdev->enable_te = dsi_display_enable_te;
 	dssdev->get_te = dsi_display_get_te;
 
-	dssdev->get_rotate = dsi_display_get_rotate;
-	dssdev->set_rotate = dsi_display_set_rotate;
-
 	/* XXX these should be figured out dynamically */
 	dssdev->caps = OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE |
 		OMAP_DSS_DISPLAY_CAP_TEAR_ELIM;
-- 
1.6.5

