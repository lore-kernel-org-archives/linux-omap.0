From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 07/65] OMAPDSS: remove partial update from DSI
Date: Tue, 22 Nov 2011 11:21:06 +0200
Message-ID: <1321953724-6350-8-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:40181 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757164Ab1KVJWs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:22:48 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Partial update for manual update displays has never worked quite well:
* The HW has limitations on the update area, and the x and width need to
  be even.
* Showing a part of a scaled overlay causes artifacts.
* Makes the management of dispc very complex

Considering the above points and the fact that partial update is not
used anywhere, this and the following patches remove the partial update
support. This will greatly simplify the following re-write of the apply
mechanism to get proper locking and additional features like fifo-merge.

This patch removes the partial update from the dsi.c.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/panel-taal.c |   16 ++----
 drivers/video/omap2/dss/dsi.c             |   79 +++++++---------------------
 include/video/omapdss.h                   |    7 +--
 3 files changed, 25 insertions(+), 77 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 80c3f6a..0aa6c5d 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -1394,12 +1394,8 @@ static irqreturn_t taal_te_isr(int irq, void *data)
 	if (old) {
 		cancel_delayed_work(&td->te_timeout_work);
 
-		r = omap_dsi_update(dssdev, td->channel,
-				td->update_region.x,
-				td->update_region.y,
-				td->update_region.w,
-				td->update_region.h,
-				taal_framedone_cb, dssdev);
+		r = omap_dsi_update(dssdev, td->channel, taal_framedone_cb,
+				dssdev);
 		if (r)
 			goto err;
 	}
@@ -1444,10 +1440,6 @@ static int taal_update(struct omap_dss_device *dssdev,
 		goto err;
 	}
 
-	r = omap_dsi_prepare_update(dssdev, &x, &y, &w, &h, true);
-	if (r)
-		goto err;
-
 	r = taal_set_update_window(td, x, y, w, h);
 	if (r)
 		goto err;
@@ -1462,8 +1454,8 @@ static int taal_update(struct omap_dss_device *dssdev,
 				msecs_to_jiffies(250));
 		atomic_set(&td->do_update, 1);
 	} else {
-		r = omap_dsi_update(dssdev, td->channel, x, y, w, h,
-				taal_framedone_cb, dssdev);
+		r = omap_dsi_update(dssdev, td->channel, taal_framedone_cb,
+				dssdev);
 		if (r)
 			goto err;
 	}
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 787cebd..9ef04ff 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -236,11 +236,6 @@ enum dsi_lane {
 	DSI_DATA4_N	= 1 << 9,
 };
 
-struct dsi_update_region {
-	u16 x, y, w, h;
-	struct omap_dss_device *device;
-};
-
 struct dsi_irq_stats {
 	unsigned long last_reset;
 	unsigned irq_count;
@@ -290,7 +285,9 @@ struct dsi_data {
 	struct dsi_isr_tables isr_tables_copy;
 
 	int update_channel;
-	struct dsi_update_region update_region;
+#ifdef DEBUG
+	unsigned update_bytes;
+#endif
 
 	bool te_enabled;
 	bool ulps_enabled;
@@ -454,7 +451,6 @@ static void dsi_perf_mark_start(struct platform_device *dsidev)
 static void dsi_perf_show(struct platform_device *dsidev, const char *name)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	struct omap_dss_device *dssdev = dsi->update_region.device;
 	ktime_t t, setup_time, trans_time;
 	u32 total_bytes;
 	u32 setup_us, trans_us, total_us;
@@ -476,9 +472,7 @@ static void dsi_perf_show(struct platform_device *dsidev, const char *name)
 
 	total_us = setup_us + trans_us;
 
-	total_bytes = dsi->update_region.w *
-		dsi->update_region.h *
-		dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt) / 8;
+	total_bytes = dsi->update_bytes;
 
 	printk(KERN_INFO "DSI(%s): %u us + %u us = %u us (%uHz), "
 			"%u bytes, %u kbytes/sec\n",
@@ -4006,7 +4000,7 @@ void dsi_video_mode_disable(struct omap_dss_device *dssdev, int channel)
 EXPORT_SYMBOL(dsi_video_mode_disable);
 
 static void dsi_update_screen_dispc(struct omap_dss_device *dssdev,
-		u16 x, u16 y, u16 w, u16 h)
+		u16 w, u16 h)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
@@ -4021,8 +4015,7 @@ static void dsi_update_screen_dispc(struct omap_dss_device *dssdev,
 	const unsigned channel = dsi->update_channel;
 	const unsigned line_buf_size = dsi_get_line_buf_size(dsidev);
 
-	DSSDBG("dsi_update_screen_dispc(%d,%d %dx%d)\n",
-			x, y, w, h);
+	DSSDBG("dsi_update_screen_dispc(%dx%d)\n", w, h);
 
 	dsi_vc_config_source(dsidev, channel, DSI_VC_SOURCE_VP);
 
@@ -4146,64 +4139,27 @@ static void dsi_framedone_irq_callback(void *data, u32 mask)
 #endif
 }
 
-int omap_dsi_prepare_update(struct omap_dss_device *dssdev,
-				    u16 *x, u16 *y, u16 *w, u16 *h,
-				    bool enlarge_update_area)
+int omap_dsi_update(struct omap_dss_device *dssdev, int channel,
+		void (*callback)(int, void *), void *data)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	u16 dw, dh;
 
-	dssdev->driver->get_resolution(dssdev, &dw, &dh);
-
-	if  (*x > dw || *y > dh)
-		return -EINVAL;
-
-	if (*x + *w > dw)
-		return -EINVAL;
-
-	if (*y + *h > dh)
-		return -EINVAL;
-
-	if (*w == 1)
-		return -EINVAL;
-
-	if (*w == 0 || *h == 0)
-		return -EINVAL;
-
 	dsi_perf_mark_setup(dsidev);
 
-	dispc_mgr_set_lcd_size(dssdev->manager->id, *w, *h);
-
-	return 0;
-}
-EXPORT_SYMBOL(omap_dsi_prepare_update);
-
-int omap_dsi_update(struct omap_dss_device *dssdev,
-		int channel,
-		u16 x, u16 y, u16 w, u16 h,
-		void (*callback)(int, void *), void *data)
-{
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
-	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-
 	dsi->update_channel = channel;
 
-	/* OMAP DSS cannot send updates of odd widths.
-	 * omap_dsi_prepare_update() makes the widths even, but add a BUG_ON
-	 * here to make sure we catch erroneous updates. Otherwise we'll only
-	 * see rather obscure HW error happening, as DSS halts. */
-	BUG_ON(x % 2 == 1);
-
 	dsi->framedone_callback = callback;
 	dsi->framedone_data = data;
 
-	dsi->update_region.x = x;
-	dsi->update_region.y = y;
-	dsi->update_region.w = w;
-	dsi->update_region.h = h;
-	dsi->update_region.device = dssdev;
+	dssdev->driver->get_resolution(dssdev, &dw, &dh);
 
-	dsi_update_screen_dispc(dssdev, x, y, w, h);
+#ifdef DEBUG
+	dsi->update_bytes = dw * dh *
+		dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt) / 8;
+#endif
+	dsi_update_screen_dispc(dssdev, dw, dh);
 
 	return 0;
 }
@@ -4216,6 +4172,7 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 	int r;
 
 	if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_CMD_MODE) {
+		u16 dw, dh;
 		u32 irq;
 		struct omap_video_timings timings = {
 			.hsw		= 1,
@@ -4226,6 +4183,10 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 			.vbp		= 0,
 		};
 
+		dssdev->driver->get_resolution(dssdev, &dw, &dh);
+		timings.x_res = dw;
+		timings.y_res = dh;
+
 		irq = dssdev->manager->id == OMAP_DSS_CHANNEL_LCD ?
 			DISPC_IRQ_FRAMEDONE : DISPC_IRQ_FRAMEDONE2;
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 378c7ed..60bf426 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -662,12 +662,7 @@ void omapdss_dsi_vc_enable_hs(struct omap_dss_device *dssdev, int channel,
 		bool enable);
 int omapdss_dsi_enable_te(struct omap_dss_device *dssdev, bool enable);
 
-int omap_dsi_prepare_update(struct omap_dss_device *dssdev,
-				    u16 *x, u16 *y, u16 *w, u16 *h,
-				    bool enlarge_update_area);
-int omap_dsi_update(struct omap_dss_device *dssdev,
-		int channel,
-		u16 x, u16 y, u16 w, u16 h,
+int omap_dsi_update(struct omap_dss_device *dssdev, int channel,
 		void (*callback)(int, void *), void *data);
 int omap_dsi_request_vc(struct omap_dss_device *dssdev, int *channel);
 int omap_dsi_set_vc_id(struct omap_dss_device *dssdev, int channel, int vc_id);
-- 
1.7.4.1

