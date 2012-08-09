From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 05/13] OMAPDSS: DSI: Update manager timings on a manual update
Date: Thu, 9 Aug 2012 17:19:41 +0530
Message-ID: <1344512989-4071-6-git-send-email-archit@ti.com>
References: <1343817088-29645-1-git-send-email-archit@ti.com>
 <1344512989-4071-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38265 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932087Ab2HILvj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Aug 2012 07:51:39 -0400
In-Reply-To: <1344512989-4071-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

During a command mode update using DISPC video port, we may need to swap the
connected overlay manager's width and height when 90 or 270 degree rotation is
done via the panel by changing it's address mode.

Call dss_mgr_set_timings() in update_screen_dispc() before starting the manager
update. The new manager size is updated in the 'timings' field of DSI driver's
private data via omapdss_dsi_set_size(). A panel driver is expected to call this
when performing rotation.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dsi.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index eb364d4..6e1c74b 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4180,8 +4180,7 @@ void dsi_disable_video_output(struct omap_dss_device *dssdev, int channel)
 }
 EXPORT_SYMBOL(dsi_disable_video_output);
 
-static void dsi_update_screen_dispc(struct omap_dss_device *dssdev,
-		u16 w, u16 h)
+static void dsi_update_screen_dispc(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
@@ -4195,6 +4194,8 @@ static void dsi_update_screen_dispc(struct omap_dss_device *dssdev,
 	int r;
 	const unsigned channel = dsi->update_channel;
 	const unsigned line_buf_size = dsi_get_line_buf_size(dsidev);
+	u16 w = dsi->timings.x_res;
+	u16 h = dsi->timings.y_res;
 
 	DSSDBG("dsi_update_screen_dispc(%dx%d)\n", w, h);
 
@@ -4244,6 +4245,8 @@ static void dsi_update_screen_dispc(struct omap_dss_device *dssdev,
 		msecs_to_jiffies(250));
 	BUG_ON(r == 0);
 
+	dss_mgr_set_timings(dssdev->manager, &dsi->timings);
+
 	dss_mgr_start_update(dssdev->manager);
 
 	if (dsi->te_enabled) {
@@ -4337,7 +4340,7 @@ int omap_dsi_update(struct omap_dss_device *dssdev, int channel,
 	dsi->update_bytes = dw * dh *
 		dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt) / 8;
 #endif
-	dsi_update_screen_dispc(dssdev, dw, dh);
+	dsi_update_screen_dispc(dssdev);
 
 	return 0;
 }
-- 
1.7.9.5

