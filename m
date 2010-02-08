From: Tomi Valkeinen <tomi.valkeinen@NOKIA.COM>
Subject: [PATCH 05/17] OMAP: DSS2: move set/get_mirror()
Date: Mon,  8 Feb 2010 17:57:29 +0200
Message-ID: <1265644661-3694-6-git-send-email-tomi.valkeinen@nokia.com>
References: <1265644661-3694-1-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-2-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-3-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-4-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-5-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:26890 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409Ab0BHPzS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 10:55:18 -0500
In-Reply-To: <1265644661-3694-5-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@NOKIA.COM>

Move set/get_mirror() from omap_dss_device to omap_dss_driver.

This is part of a larger patch-set, which moves the control from omapdss
driver to the display driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 arch/arm/plat-omap/include/plat/display.h |    3 ---
 drivers/video/omap2/displays/panel-taal.c |    8 ++++++--
 drivers/video/omap2/dss/display.c         |    8 ++++----
 drivers/video/omap2/dss/dsi.c             |   25 -------------------------
 4 files changed, 10 insertions(+), 34 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index 37be8bc..4730e71 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -495,9 +495,6 @@ struct omap_dss_device {
 	u8 (*get_rotate)(struct omap_dss_device *dssdev);
 	int (*set_rotate)(struct omap_dss_device *dssdev, u8 rotate);
 
-	bool (*get_mirror)(struct omap_dss_device *dssdev);
-	int (*set_mirror)(struct omap_dss_device *dssdev, bool enable);
-
 	int (*set_wss)(struct omap_dss_device *dssdev, u32 wss);
 	u32 (*get_wss)(struct omap_dss_device *dssdev);
 
diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 5f78d38..4d64449 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -797,16 +797,20 @@ static int taal_mirror(struct omap_dss_device *dssdev, bool enable)
 
 	dev_dbg(&dssdev->dev, "mirror %d\n", enable);
 
+	dsi_bus_lock();
 	if (td->enabled) {
 		r = taal_set_addr_mode(td->rotate, enable);
-
 		if (r)
-			return r;
+			goto err;
 	}
 
 	td->mirror = enable;
 
+	dsi_bus_unlock();
 	return 0;
+err:
+	dsi_bus_unlock();
+	return r;
 }
 
 static bool taal_get_mirror(struct omap_dss_device *dssdev)
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 3b92b84..ec82f5a 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -215,9 +215,9 @@ static ssize_t display_mirror_show(struct device *dev,
 {
 	struct omap_dss_device *dssdev = to_dss_device(dev);
 	int mirror;
-	if (!dssdev->get_mirror)
+	if (!dssdev->driver->get_mirror)
 		return -ENOENT;
-	mirror = dssdev->get_mirror(dssdev);
+	mirror = dssdev->driver->get_mirror(dssdev);
 	return snprintf(buf, PAGE_SIZE, "%u\n", mirror);
 }
 
@@ -228,12 +228,12 @@ static ssize_t display_mirror_store(struct device *dev,
 	unsigned long mirror;
 	int r;
 
-	if (!dssdev->set_mirror || !dssdev->get_mirror)
+	if (!dssdev->driver->set_mirror || !dssdev->driver->get_mirror)
 		return -ENOENT;
 
 	mirror = simple_strtoul(buf, NULL, 0);
 
-	r = dssdev->set_mirror(dssdev, mirror);
+	r = dssdev->driver->set_mirror(dssdev, mirror);
 	if (r)
 		return r;
 
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index ecb15d6..8f4f28d 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -3560,28 +3560,6 @@ static u8 dsi_display_get_rotate(struct omap_dss_device *dssdev)
 	return dssdev->driver->get_rotate(dssdev);
 }
 
-static int dsi_display_set_mirror(struct omap_dss_device *dssdev, bool mirror)
-{
-	DSSDBGF("%d", mirror);
-
-	if (!dssdev->driver->set_mirror || !dssdev->driver->get_mirror)
-		return -EINVAL;
-
-	dsi_bus_lock();
-	dssdev->driver->set_mirror(dssdev, mirror);
-	dsi_bus_unlock();
-
-	return 0;
-}
-
-static bool dsi_display_get_mirror(struct omap_dss_device *dssdev)
-{
-	if (!dssdev->driver->set_mirror || !dssdev->driver->get_mirror)
-		return 0;
-
-	return dssdev->driver->get_mirror(dssdev);
-}
-
 void dsi_get_overlay_fifo_thresholds(enum omap_plane plane,
 		u32 fifo_size, enum omap_burst_size *burst_size,
 		u32 *fifo_low, u32 *fifo_high)
@@ -3613,9 +3591,6 @@ int dsi_init_display(struct omap_dss_device *dssdev)
 	dssdev->get_rotate = dsi_display_get_rotate;
 	dssdev->set_rotate = dsi_display_set_rotate;
 
-	dssdev->get_mirror = dsi_display_get_mirror;
-	dssdev->set_mirror = dsi_display_set_mirror;
-
 	/* XXX these should be figured out dynamically */
 	dssdev->caps = OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE |
 		OMAP_DSS_DISPLAY_CAP_TEAR_ELIM;
-- 
1.6.5

