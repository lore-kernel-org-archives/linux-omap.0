From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 26/26] OMAPDSS: connector-analog-tv: Add DT support
Date: Wed, 4 Dec 2013 14:28:53 +0200
Message-ID: <1386160133-24026-27-git-send-email-tomi.valkeinen@ti.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52617 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932285Ab3LDMap (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Dec 2013 07:30:45 -0500
In-Reply-To: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 .../video/omap2/displays-new/connector-analog-tv.c | 66 +++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/displays-new/connector-analog-tv.c b/drivers/video/omap2/displays-new/connector-analog-tv.c
index ccd9073f706f..30598c26e354 100644
--- a/drivers/video/omap2/displays-new/connector-analog-tv.c
+++ b/drivers/video/omap2/displays-new/connector-analog-tv.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 
 #include <video/omapdss.h>
 #include <video/omap-panel-data.h>
@@ -42,6 +43,12 @@ static const struct omap_video_timings tvc_pal_timings = {
 	.interlace	= true,
 };
 
+static const struct of_device_id tvc_of_match[];
+
+struct tvc_of_data {
+	enum omap_dss_venc_type connector_type;
+};
+
 #define to_panel_data(x) container_of(x, struct panel_drv_data, dssdev)
 
 static int tvc_connect(struct omap_dss_device *dssdev)
@@ -92,7 +99,10 @@ static int tvc_enable(struct omap_dss_device *dssdev)
 	in->ops.atv->set_timings(in, &ddata->timings);
 
 	in->ops.atv->set_type(in, ddata->connector_type);
-	in->ops.atv->invert_vid_out_polarity(in, ddata->invert_polarity);
+
+	if (!ddata->dev->of_node)
+		in->ops.atv->invert_vid_out_polarity(in,
+			ddata->invert_polarity);
 
 	r = in->ops.atv->enable(in);
 	if (r)
@@ -205,6 +215,27 @@ static int tvc_probe_pdata(struct platform_device *pdev)
 	return 0;
 }
 
+static int tvc_probe_of(struct platform_device *pdev,
+		const struct tvc_of_data *data)
+{
+	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
+	struct device_node *node = pdev->dev.of_node;
+	struct omap_dss_device *in;
+
+	in = omapdss_of_find_source_for_first_ep(node);
+	if (IS_ERR(in)) {
+		dev_err(&pdev->dev, "failed to find video source\n");
+		return PTR_ERR(in);
+	}
+
+	ddata->in = in;
+
+	ddata->connector_type = data->connector_type;
+
+	return 0;
+}
+
+
 static int tvc_probe(struct platform_device *pdev)
 {
 	struct panel_drv_data *ddata;
@@ -222,6 +253,18 @@ static int tvc_probe(struct platform_device *pdev)
 		r = tvc_probe_pdata(pdev);
 		if (r)
 			return r;
+	} else if (pdev->dev.of_node) {
+		const struct of_device_id *match;
+
+		match = of_match_node(tvc_of_match, pdev->dev.of_node);
+		if (!match) {
+			dev_err(&pdev->dev, "unsupported device\n");
+			return -ENODEV;
+		}
+
+		r = tvc_probe_of(pdev, match->data);
+		if (r)
+			return r;
 	} else {
 		return -ENODEV;
 	}
@@ -263,12 +306,33 @@ static int __exit tvc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct tvc_of_data tv_svideo_data = {
+	.connector_type = OMAP_DSS_VENC_TYPE_SVIDEO,
+};
+
+static const struct tvc_of_data tv_composite_video_data = {
+	.connector_type = OMAP_DSS_VENC_TYPE_COMPOSITE,
+};
+
+static const struct of_device_id tvc_of_match[] = {
+	{
+		.compatible = "ti,svideo-connector",
+		.data = &tv_svideo_data,
+	},
+	{
+		.compatible = "ti,composite-video-connector",
+		.data = &tv_composite_video_data,
+	},
+	{},
+};
+
 static struct platform_driver tvc_connector_driver = {
 	.probe	= tvc_probe,
 	.remove	= __exit_p(tvc_remove),
 	.driver	= {
 		.name	= "connector-analog-tv",
 		.owner	= THIS_MODULE,
+		.of_match_table = tvc_of_match,
 	},
 };
 
-- 
1.8.3.2

