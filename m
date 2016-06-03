From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 17/27] drm/omap: connector-analog-tv: Support only Composite type in legacy boot
Date: Fri, 3 Jun 2016 13:53:11 +0300
Message-ID: <20160603105321.7980-18-peter.ujfalusi@ti.com>
References: <20160603105321.7980-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160603105321.7980-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, robdclark@gmail.com, airlied@linux.ie, tony@atomide.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com, jsarha@ti.com, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

In legacy mode (non DT mode) support only composite connector type. The
only user for this is rx51, using composite type.
Dropping the connector_type selection via pdata will allow cleanups in
omapdss (drm vs fbdev).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/gpu/drm/omapdrm/displays/connector-analog-tv.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/displays/connector-analog-tv.c b/drivers/gpu/drm/omapdrm/displays/connector-analog-tv.c
index 8511c648a15c..d963b4a9cfc0 100644
--- a/drivers/gpu/drm/omapdrm/displays/connector-analog-tv.c
+++ b/drivers/gpu/drm/omapdrm/displays/connector-analog-tv.c
@@ -25,7 +25,6 @@ struct panel_drv_data {
 
 	struct omap_video_timings timings;
 
-	enum omap_dss_venc_type connector_type;
 	bool invert_polarity;
 };
 
@@ -45,10 +44,6 @@ static const struct omap_video_timings tvc_pal_timings = {
 
 static const struct of_device_id tvc_of_match[];
 
-struct tvc_of_data {
-	enum omap_dss_venc_type connector_type;
-};
-
 #define to_panel_data(x) container_of(x, struct panel_drv_data, dssdev)
 
 static int tvc_connect(struct omap_dss_device *dssdev)
@@ -99,7 +94,7 @@ static int tvc_enable(struct omap_dss_device *dssdev)
 	in->ops.atv->set_timings(in, &ddata->timings);
 
 	if (!ddata->dev->of_node) {
-		in->ops.atv->set_type(in, ddata->connector_type);
+		in->ops.atv->set_type(in, OMAP_DSS_VENC_TYPE_COMPOSITE);
 
 		in->ops.atv->invert_vid_out_polarity(in,
 			ddata->invert_polarity);
@@ -207,7 +202,6 @@ static int tvc_probe_pdata(struct platform_device *pdev)
 
 	ddata->in = in;
 
-	ddata->connector_type = pdata->connector_type;
 	ddata->invert_polarity = pdata->invert_polarity;
 
 	dssdev = &ddata->dssdev;
-- 
2.8.3
