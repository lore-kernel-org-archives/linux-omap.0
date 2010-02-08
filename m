From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 04/17] OMAP: DSS2: move memory_read()
Date: Mon,  8 Feb 2010 17:57:28 +0200
Message-ID: <1265644661-3694-5-git-send-email-tomi.valkeinen@nokia.com>
References: <1265644661-3694-1-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-2-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-3-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-4-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:26877 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753499Ab0BHPzN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 10:55:13 -0500
In-Reply-To: <1265644661-3694-4-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Move memory_read() from omap_dss_device to omap_dss_driver.

This is part of a larger patch-set, which moves the control from omapdss
driver to the display driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 arch/arm/plat-omap/include/plat/display.h |    4 ---
 drivers/video/omap2/displays/panel-taal.c |   13 +++++++++--
 drivers/video/omap2/dss/dsi.c             |   30 -----------------------------
 drivers/video/omap2/omapfb/omapfb-ioctl.c |    4 +-
 4 files changed, 12 insertions(+), 39 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index 7c6413a..37be8bc 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -498,10 +498,6 @@ struct omap_dss_device {
 	bool (*get_mirror)(struct omap_dss_device *dssdev);
 	int (*set_mirror)(struct omap_dss_device *dssdev, bool enable);
 
-	int (*memory_read)(struct omap_dss_device *dssdev,
-			void *buf, size_t size,
-			u16 x, u16 y, u16 w, u16 h);
-
 	int (*set_wss)(struct omap_dss_device *dssdev, u32 wss);
 	u32 (*get_wss)(struct omap_dss_device *dssdev);
 
diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index e6d0954..5f78d38 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -847,6 +847,10 @@ static int taal_memory_read(struct omap_dss_device *dssdev,
 	int first = 1;
 	int plen;
 	unsigned buf_used = 0;
+	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+
+	if (!td->enabled)
+		return -ENODEV;
 
 	if (size < w * h * 3)
 		return -ENOMEM;
@@ -855,6 +859,8 @@ static int taal_memory_read(struct omap_dss_device *dssdev,
 			dssdev->panel.timings.x_res *
 			dssdev->panel.timings.y_res * 3);
 
+	dsi_bus_lock();
+
 	/* plen 1 or 2 goes into short packet. until checksum error is fixed,
 	 * use short packets. plen 32 works, but bigger packets seem to cause
 	 * an error. */
@@ -863,11 +869,11 @@ static int taal_memory_read(struct omap_dss_device *dssdev,
 	else
 		plen = 2;
 
-	taal_setup_update(dssdev, x, y, w, h);
+	taal_set_update_window(x, y, w, h);
 
 	r = dsi_vc_set_max_rx_packet_size(TCH, plen);
 	if (r)
-		return r;
+		goto err0;
 
 	while (buf_used < size) {
 		u8 dcs_cmd = first ? 0x2e : 0x3e;
@@ -900,7 +906,8 @@ static int taal_memory_read(struct omap_dss_device *dssdev,
 
 err:
 	dsi_vc_set_max_rx_packet_size(TCH, 1);
-
+err0:
+	dsi_bus_unlock();
 	return r;
 }
 
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index f7d494e..ecb15d6 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -3582,34 +3582,6 @@ static bool dsi_display_get_mirror(struct omap_dss_device *dssdev)
 	return dssdev->driver->get_mirror(dssdev);
 }
 
-static int dsi_display_memory_read(struct omap_dss_device *dssdev,
-		void *buf, size_t size,
-		u16 x, u16 y, u16 w, u16 h)
-{
-	int r;
-
-	DSSDBGF("");
-
-	if (!dssdev->driver->memory_read)
-		return -EINVAL;
-
-	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
-		return -EIO;
-
-	dsi_bus_lock();
-
-	r = dssdev->driver->memory_read(dssdev, buf, size,
-			x, y, w, h);
-
-	/* Memory read usually changes the update area. This will
-	 * force the next update to re-set the update area */
-	dsi.active_update_region.dirty = true;
-
-	dsi_bus_unlock();
-
-	return r;
-}
-
 void dsi_get_overlay_fifo_thresholds(enum omap_plane plane,
 		u32 fifo_size, enum omap_burst_size *burst_size,
 		u32 *fifo_low, u32 *fifo_high)
@@ -3644,8 +3616,6 @@ int dsi_init_display(struct omap_dss_device *dssdev)
 	dssdev->get_mirror = dsi_display_get_mirror;
 	dssdev->set_mirror = dsi_display_set_mirror;
 
-	dssdev->memory_read = dsi_display_memory_read;
-
 	/* XXX these should be figured out dynamically */
 	dssdev->caps = OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE |
 		OMAP_DSS_DISPLAY_CAP_TEAR_ELIM;
diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/omap2/omapfb/omapfb-ioctl.c
index b5657be..f3c9c80 100644
--- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
@@ -415,7 +415,7 @@ static int omapfb_memory_read(struct fb_info *fbi,
 	void *buf;
 	int r;
 
-	if (!display || !display->memory_read)
+	if (!display || !display->driver->memory_read)
 		return -ENOENT;
 
 	if (!access_ok(VERIFY_WRITE, mr->buffer, mr->buffer_size))
@@ -430,7 +430,7 @@ static int omapfb_memory_read(struct fb_info *fbi,
 		return -ENOMEM;
 	}
 
-	r = display->memory_read(display, buf, mr->buffer_size,
+	r = display->driver->memory_read(display, buf, mr->buffer_size,
 			mr->x, mr->y, mr->w, mr->h);
 
 	if (r > 0) {
-- 
1.6.5

