From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 20/23] drm: omapdrm: panel-dsi-cm: add offset support
Date: Tue,  8 Mar 2016 17:39:52 +0100
Message-ID: <1457455195-1938-21-git-send-email-sre@kernel.org>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457455195-1938-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The Nokia N950 contains a panel, that is partially
covered, so that not the whole display is visible.
Thus the image must be displayed with an offset.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
index 4c1e76da68cd..c60bc3013ff4 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
@@ -45,6 +45,8 @@ struct panel_drv_data {
 	struct omap_dss_device *in;
 
 	struct omap_video_timings timings;
+	int offset_x;
+	int offset_y;
 
 	struct platform_device *pdev;
 
@@ -203,12 +205,17 @@ static int dsicm_set_update_window(struct panel_drv_data *ddata,
 {
 	struct omap_dss_device *in = ddata->in;
 	int r;
-	u16 x1 = x;
-	u16 x2 = x + w - 1;
-	u16 y1 = y;
-	u16 y2 = y + h - 1;
-
 	u8 buf[5];
+	u16 x1, x2, y1, y2;
+
+	x += ddata->offset_x;
+	y += ddata->offset_y;
+
+	x1 = x;
+	x2 = x + w - 1;
+	y1 = y;
+	y2 = y + h - 1;
+
 	buf[0] = MIPI_DCS_SET_COLUMN_ADDRESS;
 	buf[1] = (x1 >> 8) & 0xff;
 	buf[2] = (x1 >> 0) & 0xff;
@@ -1244,6 +1251,8 @@ static int dsicm_probe_of(struct platform_device *pdev)
 
 	of_property_read_u32(node, "resolution-x", (u32*) &ddata->timings.x_res);
 	of_property_read_u32(node, "resolution-y", (u32*) &ddata->timings.y_res);
+	of_property_read_u32(node, "offset-x", &ddata->offset_x);
+	of_property_read_u32(node, "offset-y", &ddata->offset_y);
 
 	ddata->timings.pixelclock = ddata->timings.x_res * ddata->timings.y_res * 60;
 
@@ -1273,6 +1282,8 @@ static int dsicm_probe(struct platform_device *pdev)
 	ddata->timings.x_res = 864;
 	ddata->timings.y_res = 480;
 	ddata->timings.pixelclock = 864 * 480 * 60;
+	ddata->offset_x = 0;
+	ddata->offset_y = 0;
 
 	if (dev_get_platdata(dev)) {
 		r = dsicm_probe_pdata(pdev);
-- 
2.7.0
