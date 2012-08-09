From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 04/13] OMAPDSS: DSI: Add function to set panel size for command mode panels
Date: Thu, 9 Aug 2012 17:19:40 +0530
Message-ID: <1344512989-4071-5-git-send-email-archit@ti.com>
References: <1343817088-29645-1-git-send-email-archit@ti.com>
 <1344512989-4071-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59760 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417Ab2HILve (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Aug 2012 07:51:34 -0400
In-Reply-To: <1344512989-4071-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

DSI command mode panels don't need to configure a full set of timings to
configure DSI, they only require the width and the height of the panel in
pixels.

Use omapdss_dsi_set_size for command mode panels, omapdss_dsi_set_timings is
meant for video mode panels. When performing rotation via chaning the address
mode of the panel, we would need to swap width and height when doing 90 or 270
rotation. Make sure that omapdss_dsi_set_size() makes the new width and height
visible to DSI.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-taal.c |   14 ++++++++++++++
 drivers/video/omap2/dss/dsi.c             |   23 ++++++++++++++++-------
 include/video/omapdss.h                   |    1 +
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 3f5acc7..c3bca2f 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -1060,6 +1060,9 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 		goto err0;
 	};
 
+	omapdss_dsi_set_size(dssdev, dssdev->panel.timings.x_res,
+		dssdev->panel.timings.y_res);
+
 	r = omapdss_dsi_display_enable(dssdev);
 	if (r) {
 		dev_err(&dssdev->dev, "failed to enable DSI\n");
@@ -1487,6 +1490,7 @@ static int taal_get_te(struct omap_dss_device *dssdev)
 static int taal_rotate(struct omap_dss_device *dssdev, u8 rotate)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	u16 dw, dh;
 	int r;
 
 	dev_dbg(&dssdev->dev, "rotate %d\n", rotate);
@@ -1508,6 +1512,16 @@ static int taal_rotate(struct omap_dss_device *dssdev, u8 rotate)
 			goto err;
 	}
 
+	if (rotate == 0 || rotate == 2) {
+		dw = dssdev->panel.timings.x_res;
+		dh = dssdev->panel.timings.y_res;
+	} else {
+		dw = dssdev->panel.timings.y_res;
+		dh = dssdev->panel.timings.x_res;
+	}
+
+	omapdss_dsi_set_size(dssdev, dw, dh);
+
 	td->rotate = rotate;
 
 	dsi_bus_unlock(dssdev);
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 815b606..eb364d4 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4330,7 +4330,8 @@ int omap_dsi_update(struct omap_dss_device *dssdev, int channel,
 	dsi->framedone_callback = callback;
 	dsi->framedone_data = data;
 
-	dssdev->driver->get_resolution(dssdev, &dw, &dh);
+	dw = dsi->timings.x_res;
+	dh = dsi->timings.y_res;
 
 #ifdef DEBUG
 	dsi->update_bytes = dw * dh *
@@ -4378,12 +4379,6 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 	u32 irq = 0;
 
 	if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_CMD_MODE) {
-		u16 dw, dh;
-
-		dssdev->driver->get_resolution(dssdev, &dw, &dh);
-
-		dsi->timings.x_res = dw;
-		dsi->timings.y_res = dh;
 		dsi->timings.hsw = 1;
 		dsi->timings.hfp = 1;
 		dsi->timings.hbp = 1;
@@ -4702,6 +4697,20 @@ void omapdss_dsi_set_timings(struct omap_dss_device *dssdev,
 }
 EXPORT_SYMBOL(omapdss_dsi_set_timings);
 
+void omapdss_dsi_set_size(struct omap_dss_device *dssdev, u16 w, u16 h)
+{
+	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
+	mutex_lock(&dsi->lock);
+
+	dsi->timings.x_res = w;
+	dsi->timings.y_res = h;
+
+	mutex_unlock(&dsi->lock);
+}
+EXPORT_SYMBOL(omapdss_dsi_set_size);
+
 static int __init dsi_init_display(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index a2cd133..a85b3fb 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -738,6 +738,7 @@ void omapdss_dsi_vc_enable_hs(struct omap_dss_device *dssdev, int channel,
 int omapdss_dsi_enable_te(struct omap_dss_device *dssdev, bool enable);
 void omapdss_dsi_set_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings);
+void omapdss_dsi_set_size(struct omap_dss_device *dssdev, u16 w, u16 h);
 
 int omap_dsi_update(struct omap_dss_device *dssdev, int channel,
 		void (*callback)(int, void *), void *data);
-- 
1.7.9.5

