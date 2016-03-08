From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 23/23] drm: omapdrm: panel-dsi-cm: provide timings methods for omapdrm
Date: Tue,  8 Mar 2016 17:39:55 +0100
Message-ID: <1457455195-1938-24-git-send-email-sre@kernel.org>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457455195-1938-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Provide omapdrm with methods to acquire timings
and check them later, so that it can properly
initialize the display.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c | 38 +++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
index 196fe8d18ff4..edd1298b3a71 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
@@ -1163,6 +1163,41 @@ static void dsicm_ulps_work(struct work_struct *work)
 	mutex_unlock(&ddata->lock);
 }
 
+static void dsicm_get_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+
+	*timings = ddata->timings;
+}
+
+static int dsicm_check_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+	int ret = 0;
+
+	if (timings->x_res != ddata->timings.x_res)
+		ret = -EINVAL;
+	else if (timings->y_res != ddata->timings.y_res)
+		ret = -EINVAL;
+
+	/* pixelclock is modified by dsi, so not easily checkable */
+
+	/* vfp, vbp, hfp, hbp are (re-)configured automatically by dsi */
+
+	if (ret) {
+		dev_warn(dssdev->dev, "wrong resolution: %d x %d",
+			timings->x_res, timings->y_res);
+		dev_warn(dssdev->dev, "panel resolution: %d x %d",
+			ddata->timings.x_res, ddata->timings.y_res);
+	} else {
+		dev_dbg(dssdev->dev, "mode check: ok");
+	}
+
+	return ret;
+}
+
 static struct omap_dss_driver dsicm_ops = {
 	.connect	= dsicm_connect,
 	.disconnect	= dsicm_disconnect,
@@ -1180,6 +1215,9 @@ static struct omap_dss_driver dsicm_ops = {
 	.get_te		= dsicm_get_te,
 
 	.memory_read	= dsicm_memory_read,
+
+	.get_timings	= dsicm_get_timings,
+	.check_timings	= dsicm_check_timings,
 };
 
 static int dsicm_probe_pdata(struct platform_device *pdev)
-- 
2.7.0
